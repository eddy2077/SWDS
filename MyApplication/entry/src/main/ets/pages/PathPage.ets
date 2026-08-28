import { router } from '@kit.ArkUI'
import { AppColors, FontSize, Radius, Spacing, TOPIC_THEMES } from '../common/Constants'
import { TopicData, PathStep, LearningStatus, VideoItem } from '../common/DataModels'
import { getOrGenerateTopicData } from '../common/TopicDB'
import { videoDB } from '../common/VideoDB'

@Entry
@Component
struct PathPage {
  @State topic: string = ''
  @State topicData: TopicData | null = null
  @State accentColor: string = AppColors.ACCENT
  @State expandedStep: number = -1

  aboutToAppear() {
    const params = router.getParams() as Record<string, Object>
    if (params && params['topic']) {
      this.topic = params['topic'] as string
      this.accentColor = TOPIC_THEMES[this.topic] || AppColors.ACCENT
      this.topicData = getOrGenerateTopicData(this.topic)
    }
  }

  private getCompletedCount(): number {
    if (!this.topicData) return 0
    return this.topicData.path.filter(p => p.status === 'completed').length
  }

  private getProgressPercent(): number {
    if (!this.topicData || this.topicData.path.length === 0) return 0
    return Math.round(this.getCompletedCount() / this.topicData.path.length * 100)
  }

  private getStatusColor(status: LearningStatus): string {
    switch (status) {
      case 'completed': return AppColors.ACCENT
      case 'in-progress': return AppColors.WARM
      case 'not-started': return AppColors.FG_DIM
      case 'locked': return AppColors.FG_DIM
      default: return AppColors.FG_DIM
    }
  }

  private getStatusText(status: LearningStatus): string {
    switch (status) {
      case 'completed': return '已掌握'
      case 'in-progress': return '学习中'
      case 'not-started': return '未开始'
      case 'locked': return '待解锁'
      default: return '未知'
    }
  }

  private getVideosForStep(stepTitle: string): VideoItem[] {
    const topicVideos = videoDB[this.topic]
    if (topicVideos) {
      for (const key of Object.keys(topicVideos)) {
        if (stepTitle.includes(key) || key.includes(stepTitle)) {
          return topicVideos[key]
        }
      }
    }
    return []
  }

  private toggleStepComplete(index: number) {
    if (!this.topicData) return
    const step = this.topicData.path[index]
    if (step.status === 'locked') return

    if (step.status === 'completed') {
      step.status = 'not-started'
    } else {
      step.status = 'completed'
      if (index + 1 < this.topicData.path.length && this.topicData.path[index + 1].status === 'locked') {
        this.topicData.path[index + 1].status = 'not-started'
      }
    }
  }

  build() {
    Column() {
      // 顶部栏
      Row() {
        Text('←')
          .fontSize(20)
          .fontColor(AppColors.FG_SECONDARY)
          .padding(8)
          .onClick(() => { try { router.back() } catch (_e) {} })

        Text('学习路径')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 8 })
          .layoutWeight(1)

        Text(this.topic)
          .fontSize(FontSize.SM)
          .fontColor(this.accentColor)
      }
      .width('100%')
      .height(56)
      .padding({ left: Spacing.MD, right: Spacing.BASE })
      .backgroundColor(AppColors.BG_SURFACE)

      Divider().color(AppColors.BORDER).height(0.5)

      if (this.topicData) {
        Scroll() {
          Column() {
            // 标题区域
            Column() {
              Text(this.topic + ' 学习路径')
                .fontSize(FontSize.XXL)
                .fontColor(AppColors.FG)
                .fontWeight(FontWeight.Bold)
                .margin({ bottom: Spacing.XS })

              Text('AI 根据知识依赖关系为你规划的最优学习顺序')
                .fontSize(FontSize.SM)
                .fontColor(AppColors.FG_SECONDARY)
            }
            .width('100%')
            .padding({ left: Spacing.LG, right: Spacing.LG, top: Spacing.XL, bottom: Spacing.BASE })
            .alignItems(HorizontalAlign.Start)

            // 进度条
            Column() {
              Progress({ value: this.getCompletedCount(), total: this.topicData.path.length, type: ProgressType.Linear })
                .width('100%')
                .height(6)
                .color(this.accentColor)
                .backgroundColor(AppColors.BG_HOVER)
                .borderRadius(3)

              Text(`${this.getCompletedCount()}/${this.topicData.path.length} 已完成 · ${this.getProgressPercent()}%`)
                .fontSize(FontSize.XS)
                .fontColor(AppColors.FG_DIM)
                .margin({ top: Spacing.SM })
            }
            .width('100%')
            .padding({ left: Spacing.LG, right: Spacing.LG, bottom: Spacing.XL })

            // 时间线
            Column() {
              ForEach(this.topicData.path, (step: PathStep, index: number) => {
                this.PathStepCard(step, index)
              }, (step: PathStep) => step.id)
            }
            .width('100%')
            .padding({ left: Spacing.LG, right: Spacing.LG })

            Blank().height(80)
          }
        }
        .layoutWeight(1)
      } else {
        Column() {
          Text('🗺')
            .fontSize(48)
            .margin({ bottom: Spacing.BASE })
          Text('请先从首页输入学习主题')
            .fontSize(FontSize.BASE)
            .fontColor(AppColors.FG_SECONDARY)
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.BG)
  }

  @Builder
  PathStepCard(step: PathStep, index: number) {
    Row() {
      // 时间线指示器
      Column() {
        Circle()
          .width(14)
          .height(14)
          .fill(step.status === 'completed' ? this.accentColor :
                step.status === 'in-progress' ? AppColors.WARM : Color.Transparent)
          .stroke(step.status === 'locked' ? AppColors.BORDER : Color.Transparent)
          .strokeWidth(2)

        if (index < (this.topicData?.path.length ?? 0) - 1) {
          Row()
            .width(2)
            .height(20)
            .backgroundColor(AppColors.BORDER)
        }
      }
      .alignItems(HorizontalAlign.Center)
      .margin({ right: Spacing.MD })

      // 步骤内容
      Column() {
        Row() {
          Text(step.title)
            .fontSize(FontSize.BASE)
            .fontColor(step.status === 'locked' ? AppColors.FG_DIM : AppColors.FG)
            .fontWeight(FontWeight.Medium)
            .layoutWeight(1)

          if (step.status !== 'locked') {
            Checkbox()
              .select(step.status === 'completed')
              .selectedColor(this.accentColor)
              .width(18)
              .height(18)
              .onChange((checked: boolean) => {
                this.toggleStepComplete(index)
              })
          }

          Text(this.getStatusText(step.status))
            .fontSize(FontSize.XS)
            .fontColor(this.getStatusColor(step.status))
            .padding({ left: 8, right: 8, top: 2, bottom: 2 })
            .borderRadius(Radius.PILL)
            .backgroundColor(step.status === 'completed' ? AppColors.ACCENT_DIM + '20' :
                             step.status === 'in-progress' ? AppColors.WARM_DIM : AppColors.BG_HOVER)
            .margin({ left: 8 })
        }
        .width('100%')

        Text(step.desc)
          .fontSize(FontSize.SM)
          .fontColor(AppColors.FG_SECONDARY)
          .margin({ top: Spacing.XS })

        Flex({ wrap: FlexWrap.Wrap }) {
          ForEach(step.topics, (topic: string) => {
            Text(topic)
              .fontSize(FontSize.XS)
              .fontColor(AppColors.FG_DIM)
              .padding({ left: 6, right: 6, top: 2, bottom: 2 })
              .borderRadius(Radius.SM)
              .backgroundColor(AppColors.BG_HOVER)
              .margin({ right: Spacing.XS, top: Spacing.XS })
          }, (topic: string) => topic)
        }
        .margin({ top: Spacing.SM })

        // 视频
        if (this.getVideosForStep(step.title).length > 0) {
          Row() {
            Text('推荐视频')
              .fontSize(FontSize.XS)
              .fontColor(AppColors.FG_DIM)
              .layoutWeight(1)

            Text(this.expandedStep === index ? '收起 ▲' : '展开 ▼')
              .fontSize(FontSize.XS)
              .fontColor(this.accentColor)
              .padding({ left: 8, right: 8, top: 2, bottom: 2 })
              .borderRadius(Radius.SM)
              .border({ width: 1, color: AppColors.BORDER })
              .onClick(() => {
                this.expandedStep = this.expandedStep === index ? -1 : index
              })
          }
          .margin({ top: Spacing.MD })
          .padding({ top: Spacing.SM })
          .width('100%')

          if (this.expandedStep === index) {
            Column() {
              ForEach(this.getVideosForStep(step.title), (video: VideoItem) => {
                Row() {
                  Row() {
                    Text('▶')
                      .fontSize(12)
                      .fontColor('#E8E4D9b0')
                  }
                  .width(56)
                  .height(35)
                  .borderRadius(4)
                  .backgroundColor(AppColors.BG)
                  .justifyContent(FlexAlign.Center)
                  .margin({ right: Spacing.MD })

                  Column() {
                    Text(video.title)
                      .fontSize(FontSize.SM)
                      .fontColor(AppColors.FG)
                      .maxLines(2)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                      .lineHeight(18)
                    Text(`${video.platform} · ${video.duration} · ${video.author} · ${video.level}`)
                      .fontSize(FontSize.XS)
                      .fontColor(AppColors.FG_DIM)
                      .margin({ top: 2 })
                  }
                  .layoutWeight(1)
                  .alignItems(HorizontalAlign.Start)
                }
                .width('100%')
                .padding(Spacing.SM)
                .borderRadius(Radius.MD)
                .backgroundColor(AppColors.BG)
                .border({ width: 1, color: AppColors.BORDER })
                .margin({ bottom: Spacing.XS })
              }, (video: VideoItem) => video.title)
            }
            .margin({ top: Spacing.SM })
          }
        }
      }
      .layoutWeight(1)
      .padding(Spacing.MD)
      .borderRadius(Radius.LG)
      .backgroundColor(AppColors.BG_SURFACE)
      .border({ width: 1, color: AppColors.BORDER })
      .opacity(step.status === 'locked' ? 0.5 : 1.0)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
    .margin({ bottom: Spacing.XS })
  }
}
