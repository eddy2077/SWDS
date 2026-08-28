import { router } from '@kit.ArkUI'
import { AppColors, FontSize, Radius, Spacing, TOPIC_THEMES } from '../common/Constants'
import { TopicData, QuizItem, VideoItem } from '../common/DataModels'
import { getOrGenerateTopicData } from '../common/TopicDB'
import { videoDB } from '../common/VideoDB'

@Entry
@Component
struct QuizPage {
  @State topic: string = ''
  @State topicData: TopicData | null = null
  @State accentColor: string = AppColors.ACCENT
  @State currentIndex: number = 0
  @State correctCount: number = 0
  @State wrongCount: number = 0
  @State answeredSet: Set<number> = new Set()
  @State selectedAnswer: number = -1
  @State showResult: boolean = false
  @State showSummary: boolean = false

  aboutToAppear() {
    const params = router.getParams() as Record<string, Object>
    if (params && params['topic']) {
      this.topic = params['topic'] as string
      this.accentColor = TOPIC_THEMES[this.topic] || AppColors.ACCENT
      this.topicData = getOrGenerateTopicData(this.topic)
    }
  }

  private get currentQuiz(): QuizItem | null {
    if (!this.topicData || this.currentIndex >= this.topicData.quizzes.length) return null
    return this.topicData.quizzes[this.currentIndex]
  }

  private get totalQuizzes(): number {
    return this.topicData?.quizzes.length ?? 0
  }

  private get correctRate(): string {
    const total = this.correctCount + this.wrongCount
    if (total === 0) return '0%'
    return Math.round(this.correctCount / total * 100) + '%'
  }

  private getOptionLetter(index: number): string {
    return String.fromCharCode(65 + index)
  }

  private getVideosForQuiz(topic: string): VideoItem[] {
    const topicVideos = videoDB[this.topic]
    if (topicVideos) {
      for (const key of Object.keys(topicVideos)) {
        if (topic.includes(key) || key.includes(topic)) {
          return topicVideos[key].slice(0, 2)
        }
      }
    }
    return []
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

        Text('自适应测验')
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

      if (this.topicData && this.topicData.quizzes.length > 0 && !this.showSummary) {
        Scroll() {
          Column() {
            // 统计卡片
            Row() {
              this.StatCard(this.correctCount.toString(), '正确', AppColors.ACCENT)
              this.StatCard(this.wrongCount.toString(), '错误', AppColors.RED)
              this.StatCard(this.correctRate, '正确率', AppColors.WARM)
            }
            .width('100%')
            .padding({ left: Spacing.BASE, right: Spacing.BASE, top: Spacing.BASE })

            // 题目卡片
            if (this.currentQuiz) {
              Column() {
                Row() {
                  Text(this.currentQuiz.topic)
                    .fontSize(FontSize.SM)
                    .fontColor(this.accentColor)
                    .fontWeight(FontWeight.Medium)

                  Text(`${this.currentIndex + 1} / ${this.totalQuizzes}`)
                    .fontSize(FontSize.SM)
                    .fontColor(AppColors.FG_DIM)
                    .margin({ left: 'auto' })
                }
                .width('100%')
                .margin({ bottom: Spacing.BASE })

                Text(this.currentQuiz.question)
                  .fontSize(FontSize.LG)
                  .fontColor(AppColors.FG)
                  .fontWeight(FontWeight.Medium)
                  .lineHeight(24)
                  .margin({ bottom: Spacing.XL })

                Column() {
                  ForEach(this.currentQuiz.options, (option: string, index: number) => {
                    this.OptionItem(option, index as number)
                  }, (option: string, index: number) => option + index)
                }
              }
              .width('92%')
              .padding(Spacing.XL)
              .borderRadius(Radius.LG)
              .backgroundColor(AppColors.BG_SURFACE)
              .border({ width: 1, color: AppColors.BORDER })
              .margin({ top: Spacing.MD })
              .alignItems(HorizontalAlign.Start)
            }

            // 解析反馈
            if (this.showResult && this.currentQuiz) {
              Column() {
                Text(this.selectedAnswer === this.currentQuiz.answer ? '回答正确！' : '回答错误')
                  .fontSize(FontSize.MD)
                  .fontColor(this.selectedAnswer === this.currentQuiz.answer ? AppColors.ACCENT : AppColors.RED)
                  .fontWeight(FontWeight.Bold)
                  .margin({ bottom: Spacing.SM })

                Text(this.currentQuiz.explain)
                  .fontSize(FontSize.SM)
                  .fontColor(AppColors.FG_SECONDARY)
                  .lineHeight(20)

                if (this.selectedAnswer !== this.currentQuiz.answer) {
                  if (this.getVideosForQuiz(this.currentQuiz.topic).length > 0) {
                    Text('推荐学习视频')
                      .fontSize(FontSize.XS)
                      .fontColor(this.accentColor)
                      .margin({ top: Spacing.MD, bottom: Spacing.SM })

                    ForEach(this.getVideosForQuiz(this.currentQuiz.topic), (video: VideoItem) => {
                      Row() {
                        Row() {
                          Text('▶')
                            .fontSize(12)
                            .fontColor('#E8E4D9b0')
                        }
                        .width(48)
                        .height(30)
                        .borderRadius(4)
                        .backgroundColor(AppColors.BG)
                        .justifyContent(FlexAlign.Center)
                        .margin({ right: Spacing.MD })

                        Column() {
                          Text(video.title)
                            .fontSize(FontSize.SM)
                            .fontColor(AppColors.FG)
                            .maxLines(1)
                            .textOverflow({ overflow: TextOverflow.Ellipsis })
                          Text(`${video.platform} · ${video.duration}`)
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
                      .border({ width: 1, color: this.accentColor + '30' })
                      .margin({ bottom: Spacing.XS })
                    }, (video: VideoItem) => video.title)
                  }
                }
              }
              .width('92%')
              .padding(Spacing.BASE)
              .borderRadius(Radius.MD)
              .backgroundColor(this.selectedAnswer === this.currentQuiz.answer ? AppColors.ACCENT_DIM + '15' : AppColors.RED_DIM + '15')
              .border({
                width: 1,
                color: this.selectedAnswer === this.currentQuiz.answer ? this.accentColor + '30' : AppColors.RED + '30'
              })
              .margin({ top: Spacing.MD })
            }

            // 导航按钮
            Row() {
              Button('上一题')
                .height(40)
                .fontSize(FontSize.SM)
                .backgroundColor(Color.Transparent)
                .fontColor(AppColors.FG_SECONDARY)
                .borderRadius(Radius.MD)
                .border({ width: 1, color: AppColors.BORDER })
                .enabled(this.currentIndex > 0)
                .onClick(() => {
                  if (this.currentIndex > 0) {
                    this.currentIndex--
                    this.showResult = this.answeredSet.has(this.currentIndex)
                    this.selectedAnswer = -1
                  }
                })

              Button(this.currentIndex >= this.totalQuizzes - 1 && this.showResult ? '查看结果' : '下一题')
                .height(40)
                .fontSize(FontSize.SM)
                .backgroundColor(this.accentColor)
                .fontColor(AppColors.BG)
                .borderRadius(Radius.MD)
                .onClick(() => {
                  if (this.currentIndex >= this.totalQuizzes - 1 && this.showResult) {
                    this.showSummary = true
                  } else if (this.currentIndex < this.totalQuizzes - 1) {
                    this.currentIndex++
                    this.showResult = this.answeredSet.has(this.currentIndex)
                    this.selectedAnswer = -1
                  }
                })
            }
            .width('92%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: Spacing.XL })

            Blank().height(40)
          }
          .width('100%')
        }
        .layoutWeight(1)
      } else if (this.showSummary) {
        this.QuizSummary()
      } else {
        Column() {
          Text('📝')
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
  StatCard(value: string, label: string, color: string) {
    Column() {
      Text(value)
        .fontSize(FontSize.XXL)
        .fontColor(color)
        .fontWeight(FontWeight.Bold)
      Text(label)
        .fontSize(FontSize.XS)
        .fontColor(AppColors.FG_DIM)
        .margin({ top: 2 })
    }
    .layoutWeight(1)
    .padding(Spacing.BASE)
    .borderRadius(Radius.LG)
    .backgroundColor(AppColors.BG_SURFACE)
    .border({ width: 1, color: AppColors.BORDER })
    .margin({ left: Spacing.XS, right: Spacing.XS })
  }

  @Builder
  OptionItem(option: string, index: number) {
    Row() {
      Text(this.getOptionLetter(index))
        .fontSize(FontSize.SM)
        .fontColor(this.getOptionTextColor(index))
        .fontWeight(FontWeight.Bold)
        .width(26)
        .height(26)
        .textAlign(TextAlign.Center)
        .borderRadius(13)
        .backgroundColor(this.getOptionBgColor(index))

      Text(option)
        .fontSize(FontSize.MD)
        .fontColor(this.getOptionContentColor(index))
        .margin({ left: Spacing.MD })
        .layoutWeight(1)
    }
    .width('100%')
    .padding({ left: Spacing.MD, right: Spacing.MD, top: Spacing.MD, bottom: Spacing.MD })
    .borderRadius(Radius.MD)
    .backgroundColor(this.getOptionItemBg(index))
    .border({ width: 1, color: this.getOptionBorderColor(index) })
    .margin({ bottom: Spacing.SM })
    .onClick(() => { this.selectAnswer(index) })
  }

  @Builder
  QuizSummary() {
    Scroll() {
      Column() {
        Blank().height(40)

        Text(this.correctRate === '100%' ? '🏆' : this.correctRate === '0%' ? '💪' : '🎉')
          .fontSize(48)
          .margin({ bottom: Spacing.BASE })

        Text(this.correctRate === '100%' ? '完美通关！' : '测验完成！')
          .fontSize(FontSize.XXL)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: Spacing.SM })

        Text(`你已完成「${this.topic}」的所有题目`)
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG_SECONDARY)
          .margin({ bottom: Spacing.XL })

        Row() {
          Column() {
            Text(this.correctCount.toString())
              .fontSize(28)
              .fontColor(AppColors.ACCENT)
              .fontWeight(FontWeight.Bold)
            Text('正确')
              .fontSize(FontSize.XS)
              .fontColor(AppColors.FG_DIM)
              .margin({ top: 2 })
          }
          .margin({ left: 32, right: 32 })

          Column() {
            Text(this.wrongCount.toString())
              .fontSize(28)
              .fontColor(AppColors.RED)
              .fontWeight(FontWeight.Bold)
            Text('错误')
              .fontSize(FontSize.XS)
              .fontColor(AppColors.FG_DIM)
              .margin({ top: 2 })
          }
          .margin({ left: 32, right: 32 })

          Column() {
            Text(this.correctRate)
              .fontSize(28)
              .fontColor(AppColors.WARM)
              .fontWeight(FontWeight.Bold)
            Text('正确率')
              .fontSize(FontSize.XS)
              .fontColor(AppColors.FG_DIM)
              .margin({ top: 2 })
          }
          .margin({ left: 32, right: 32 })
        }
        .margin({ bottom: Spacing.XL })

        Button('重新测验')
          .height(44)
          .width('60%')
          .fontSize(FontSize.BASE)
          .backgroundColor(this.accentColor)
          .fontColor(AppColors.BG)
          .borderRadius(Radius.MD)
          .onClick(() => { this.resetQuiz() })

        Blank().height(40)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .layoutWeight(1)
  }

  private selectAnswer(index: number) {
    if (this.answeredSet.has(this.currentIndex)) return
    if (!this.currentQuiz) return
    this.selectedAnswer = index
    this.showResult = true
    this.answeredSet.add(this.currentIndex)
    if (index === this.currentQuiz.answer) {
      this.correctCount++
    } else {
      this.wrongCount++
    }
  }

  private resetQuiz() {
    this.currentIndex = 0
    this.correctCount = 0
    this.wrongCount = 0
    this.answeredSet = new Set<number>()
    this.selectedAnswer = -1
    this.showResult = false
    this.showSummary = false
  }

  private getOptionTextColor(index: number): ResourceColor {
    if (!this.showResult) return AppColors.FG_SECONDARY
    if (index === this.currentQuiz?.answer) return AppColors.BG
    if (index === this.selectedAnswer && index !== this.currentQuiz?.answer) return '#E8E4D9'
    return AppColors.FG_DIM
  }

  private getOptionBgColor(index: number): ResourceColor {
    if (!this.showResult) return AppColors.BG_HOVER
    if (index === this.currentQuiz?.answer) return this.accentColor
    if (index === this.selectedAnswer && index !== this.currentQuiz?.answer) return AppColors.RED
    return AppColors.BG_HOVER
  }

  private getOptionContentColor(index: number): ResourceColor {
    if (!this.showResult) return AppColors.FG
    if (index === this.currentQuiz?.answer) return AppColors.ACCENT
    if (index === this.selectedAnswer && index !== this.currentQuiz?.answer) return AppColors.RED
    return AppColors.FG_DIM
  }

  private getOptionItemBg(index: number): ResourceColor {
    if (!this.showResult) return AppColors.BG_ELEVATED
    if (index === this.currentQuiz?.answer) return AppColors.ACCENT_DIM + '15'
    if (index === this.selectedAnswer && index !== this.currentQuiz?.answer) return AppColors.RED_DIM + '15'
    return AppColors.BG_ELEVATED
  }

  private getOptionBorderColor(index: number): ResourceColor {
    if (!this.showResult) return AppColors.BORDER
    if (index === this.currentQuiz?.answer) return this.accentColor + '50'
    if (index === this.selectedAnswer && index !== this.currentQuiz?.answer) return AppColors.RED + '50'
    return AppColors.BORDER
  }
}
