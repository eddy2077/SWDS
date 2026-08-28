import { AppColors, FontSize, Radius, Spacing, SUGGESTION_TOPICS, TOPIC_THEMES } from '../common/Constants'
import { TopicData, HistoryItem, LoadingStage } from '../common/DataModels'
import { getOrGenerateTopicData } from '../common/TopicDB'
import { loadHistory, addToHistory, removeHistory } from '../common/LocalStorage'
import { generateTopicDataWithAI } from '../common/AIHelper'
import { router } from '@kit.ArkUI'

type TabIndex = 0 | 1 | 2 | 3 | 4

@Entry
@Component
struct Index {
  @State currentTab: TabIndex = 0
  @State currentTopic: string = ''
  @State topicData: TopicData | null = null
  @State inputTopic: string = ''
  @State historyList: HistoryItem[] = []
  @State isLoading: boolean = false
  @State loadingText: string = '正在搜索相关信息...'
  @State loadingProgress: number = 0
  @State accentColor: string = AppColors.ACCENT
  @State toastMsg: string = ''
  @State showToast: boolean = false

  aboutToAppear() {
    this.historyList = loadHistory()
  }

  build() {
    Column() {
      // 主内容区
      Stack() {
        if (this.currentTab === 0) {
          this.HomeTab()
        } else if (this.currentTab === 1) {
          this.GraphTab()
        } else if (this.currentTab === 2) {
          this.AITab()
        } else if (this.currentTab === 3) {
          this.PathTab()
        } else {
          this.ProfileTab()
        }

        // 加载遮罩
        if (this.isLoading) {
          this.LoadingOverlay()
        }

        // Toast
        if (this.showToast) {
          Text(this.toastMsg)
            .fontSize(FontSize.SM)
            .fontColor(this.toastMsg.includes('错误') || this.toastMsg.includes('失败') ? AppColors.RED : AppColors.ACCENT)
            .padding({ left: 20, right: 20, top: 10, bottom: 10 })
            .borderRadius(Radius.MD)
            .backgroundColor(AppColors.BG_ELEVATED)
            .border({ width: 1, color: AppColors.ACCENT + '30' })
            .position({ x: '50%', y: 60 })
            .translate({ x: '-50%' })
            .zIndex(1000)
        }
      }
      .layoutWeight(1)

      // 底部导航栏
      this.BottomNavBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.BG)
  }

  // ============ 底部导航栏 ============
  @Builder
  BottomNavBar() {
    Row() {
      // 首页
      this.TabItem('首页', 0)

      // 图谱
      this.TabItem('图谱', 1)

      // AI - 中间突出圆形
      Stack() {
        Column() {
          Text('AI')
            .fontSize(FontSize.BASE)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.BG)
        }
        .width(52)
        .height(52)
        .borderRadius(26)
        .backgroundColor(AppColors.ACCENT)
        .justifyContent(FlexAlign.Center)
        .shadow({ radius: 12, color: AppColors.ACCENT + '40', offsetY: 2 })
      }
      .offset({ y: -16 })
      .onClick(() => { this.currentTab = 2 })

      // 路径
      this.TabItem('路径', 3)

      // 我的
      this.TabItem('我的', 4)
    }
    .width('100%')
    .height(64)
    .backgroundColor(AppColors.TAB_BAR_BG)
    .border({ width: 1, color: AppColors.BORDER })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
    .padding({ left: 8, right: 8 })
  }

  @Builder
  TabItem(label: string, index: TabIndex) {
    Column() {
      Text(label)
        .fontSize(FontSize.XS)
        .fontColor(this.currentTab === index ? AppColors.ACCENT : AppColors.FG_DIM)
        .fontWeight(this.currentTab === index ? FontWeight.Medium : FontWeight.Normal)
    }
    .height(40)
    .justifyContent(FlexAlign.Center)
    .padding({ left: 12, right: 12 })
    .borderRadius(Radius.MD)
    .onClick(() => { this.currentTab = index })
  }

  // ============ 首页Tab ============
  @Builder
  HomeTab() {
    Column() {
      // 顶部标题栏
      Row() {
        Column() {
          Text('知识图谱导师')
            .fontSize(FontSize.LG)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Bold)
          Text('探索知识的无限可能')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.FG_DIM)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        // 用户头像
        Stack() {
          Text('U')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.ACCENT)
            .fontWeight(FontWeight.Bold)
        }
        .width(36)
        .height(36)
        .borderRadius(18)
        .backgroundColor(AppColors.ACCENT + '15')
        .border({ width: 1, color: AppColors.ACCENT + '30' })
        .alignContent(Alignment.Center)
        .onClick(() => { this.currentTab = 4 })
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: Spacing.LG, bottom: Spacing.BASE })

      // 搜索框
      Row() {
        Text('🔍')
          .fontSize(FontSize.MD)
          .margin({ right: Spacing.SM })
        TextInput({ placeholder: '输入学习主题...', text: this.inputTopic })
          .layoutWeight(1)
          .height(44)
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .placeholderColor(AppColors.FG_DIM)
          .backgroundColor(Color.Transparent)
          .border({ width: 0 })
          .onChange((v: string) => { this.inputTopic = v })
          .onSubmit(() => { this.loadTopic(this.inputTopic) })
      }
      .width('92%')
      .height(48)
      .padding({ left: Spacing.BASE, right: Spacing.BASE })
      .backgroundColor(AppColors.BG_SURFACE)
      .borderRadius(Radius.MD)
      .border({ width: 1, color: AppColors.BORDER })
      .margin({ bottom: Spacing.LG })

      // 推荐标签
      Column() {
        Text('热门主题')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.FG_SECONDARY)
          .margin({ bottom: Spacing.SM })
        Flex({ wrap: FlexWrap.Wrap }) {
          ForEach(SUGGESTION_TOPICS, (topic: string) => {
            Text(topic)
              .fontSize(FontSize.SM)
              .fontColor(AppColors.ACCENT)
              .padding({ left: 14, right: 14, top: 8, bottom: 8 })
              .borderRadius(Radius.PILL)
              .backgroundColor(AppColors.ACCENT + '10')
              .border({ width: 1, color: AppColors.ACCENT + '25' })
              .margin({ right: Spacing.SM, bottom: Spacing.SM })
              .onClick(() => {
                this.inputTopic = topic
                this.loadTopic(topic)
              })
          }, (topic: string) => topic)
        }
      }
      .width('92%')
      .margin({ bottom: Spacing.LG })

      // 学习历史
      if (this.historyList.length > 0) {
        Column() {
          Row() {
            Text('学习历史')
              .fontSize(FontSize.SM)
              .fontColor(AppColors.FG_SECONDARY)
              .layoutWeight(1)
          }
          .width('100%')
          .margin({ bottom: Spacing.SM })

          ForEach(this.historyList.slice(0, 5), (item: HistoryItem) => {
            Row() {
              Column() {
                Circle()
                  .width(8)
                  .height(8)
                  .fill(AppColors.ACCENT)
              }
              .margin({ right: Spacing.MD })

              Text(item.topic)
                .fontSize(FontSize.BASE)
                .fontColor(AppColors.FG)
                .layoutWeight(1)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })

              Text('→')
                .fontSize(FontSize.SM)
                .fontColor(AppColors.FG_DIM)
                .padding({ left: 8, right: 4, top: 4, bottom: 4 })
                .onClick(() => {
                  this.inputTopic = item.topic
                  this.loadTopic(item.topic)
                })
            }
            .width('100%')
            .padding({ left: Spacing.MD, right: Spacing.MD, top: 10, bottom: 10 })
            .borderRadius(Radius.MD)
            .backgroundColor(AppColors.BG_SURFACE)
            .border({ width: 1, color: AppColors.BORDER })
            .margin({ bottom: Spacing.XS })
          }, (item: HistoryItem) => item.topic + item.timestamp)
        }
        .width('92%')
      }

      Blank().layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
  }

  // ============ 图谱Tab ============
  @Builder
  GraphTab() {
    Column() {
      if (this.topicData) {
        // 图谱信息卡片
        Column() {
          Row() {
            Text(this.currentTopic)
              .fontSize(FontSize.XXL)
              .fontColor(AppColors.FG)
              .fontWeight(FontWeight.Bold)
              .layoutWeight(1)

            Text(`${this.topicData.nodes.length}节点`)
              .fontSize(FontSize.XS)
              .fontColor(AppColors.FG_DIM)
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .borderRadius(Radius.PILL)
              .backgroundColor(AppColors.BG_HOVER)
          }
          .width('100%')

          Text('点击下方按钮进入图谱详情')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.FG_SECONDARY)
            .margin({ top: Spacing.SM })
        }
        .width('92%')
        .padding(Spacing.LG)
        .borderRadius(Radius.LG)
        .backgroundColor(AppColors.BG_SURFACE)
        .border({ width: 1, color: AppColors.BORDER })
        .margin({ top: Spacing.LG })

        // 进度
        Row() {
          Progress({
            value: this.topicData.nodes.filter(n => n.status === 'completed').length,
            total: this.topicData.nodes.length,
            type: ProgressType.Linear
          })
            .layoutWeight(1)
            .height(6)
            .color(AppColors.ACCENT)
            .backgroundColor(AppColors.BG_HOVER)
            .borderRadius(3)

          Text(`${Math.round(this.topicData.nodes.filter(n => n.status === 'completed').length / this.topicData.nodes.length * 100)}%`)
            .fontSize(FontSize.XS)
            .fontColor(AppColors.ACCENT)
            .margin({ left: Spacing.SM })
        }
        .width('92%')
        .margin({ top: Spacing.MD })

        // 打开图谱按钮
        Button('打开知识图谱')
          .width('92%')
          .height(48)
          .fontSize(FontSize.BASE)
          .fontWeight(FontWeight.Bold)
          .backgroundColor(AppColors.ACCENT)
          .fontColor(AppColors.BG)
          .borderRadius(Radius.MD)
          .margin({ top: Spacing.XL })
          .onClick(() => {
            try {
              router.pushUrl({ url: 'pages/GraphPage', params: { topic: this.currentTopic } })
            } catch (_e) {
            }
          })
      } else {
        Blank().layoutWeight(1)
        Column() {
          Text('🕸')
            .fontSize(56)
            .margin({ bottom: Spacing.LG })
          Text('还没有图谱')
            .fontSize(FontSize.LG)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Bold)
          Text('从首页输入主题开始学习吧')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.FG_DIM)
            .margin({ top: Spacing.SM })
        }
        .alignItems(HorizontalAlign.Center)
        Blank().layoutWeight(1)
      }
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
  }

  // ============ AI Tab ============
  @Builder
  AITab() {
    Column() {
      // AI标题
      Column() {
        Text('AI 助手')
          .fontSize(FontSize.XXL)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
        Text('智能学习伙伴，随时为你解答')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.FG_SECONDARY)
          .margin({ top: Spacing.XS })
      }
      .margin({ top: Spacing.XXL, bottom: Spacing.XL })

      // AI功能卡片
      Column() {
        this.AIFeatureCard('生成知识图谱', '输入任意主题，AI自动生成完整的知识图谱', '🕸')
        this.AIFeatureCard('学习路径规划', '基于知识依赖关系，规划最优学习顺序', '🗺')
        this.AIFeatureCard('自适应测验', '根据学习进度生成个性化测验题目', '📝')
        this.AIFeatureCard('知识问答', '针对当前学习内容进行深度问答', '💬')
      }
      .width('92%')

      Blank().layoutWeight(1)

      // 快速输入
      Row() {
        TextInput({ placeholder: '输入学习主题...', text: this.inputTopic })
          .layoutWeight(1)
          .height(44)
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .placeholderColor(AppColors.FG_DIM)
          .backgroundColor(AppColors.BG_SURFACE)
          .borderRadius(Radius.MD)
          .border({ width: 1, color: AppColors.BORDER })
          .padding({ left: Spacing.BASE })
          .onChange((v: string) => { this.inputTopic = v })
          .onSubmit(() => { this.loadTopic(this.inputTopic) })

        Button('生成')
          .height(44)
          .fontSize(FontSize.BASE)
          .fontWeight(FontWeight.Bold)
          .backgroundColor(AppColors.ACCENT)
          .fontColor(AppColors.BG)
          .borderRadius(Radius.MD)
          .margin({ left: Spacing.SM })
          .onClick(() => { this.loadTopic(this.inputTopic) })
      }
      .width('92%')
      .margin({ bottom: Spacing.LG })
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  AIFeatureCard(title: string, desc: string, icon: string) {
    Row() {
      Stack() {
        Text(icon)
          .fontSize(20)
      }
      .width(44)
      .height(44)
      .borderRadius(12)
      .backgroundColor(AppColors.ACCENT + '12')
      .alignContent(Alignment.Center)
      .margin({ right: Spacing.MD })

      Column() {
        Text(title)
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
        Text(desc)
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_DIM)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('→')
        .fontSize(FontSize.MD)
        .fontColor(AppColors.FG_DIM)
    }
    .width('100%')
    .padding(Spacing.MD)
    .borderRadius(Radius.MD)
    .backgroundColor(AppColors.BG_SURFACE)
    .border({ width: 1, color: AppColors.BORDER })
    .margin({ bottom: Spacing.SM })
  }

  // ============ 路径Tab ============
  @Builder
  PathTab() {
    Column() {
      if (this.topicData) {
        Text(this.currentTopic + ' 学习路径')
          .fontSize(FontSize.XXL)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
          .margin({ top: Spacing.XL, bottom: Spacing.MD })

        Button('查看完整路径')
          .width('92%')
          .height(48)
          .fontSize(FontSize.BASE)
          .fontWeight(FontWeight.Bold)
          .backgroundColor(AppColors.ACCENT)
          .fontColor(AppColors.BG)
          .borderRadius(Radius.MD)
          .margin({ top: Spacing.MD })
          .onClick(() => {
            try {
              router.pushUrl({ url: 'pages/PathPage', params: { topic: this.currentTopic } })
            } catch (_e) {
            }
          })
      } else {
        Blank().layoutWeight(1)
        Column() {
          Text('🗺')
            .fontSize(56)
            .margin({ bottom: Spacing.LG })
          Text('还没有学习路径')
            .fontSize(FontSize.LG)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Bold)
          Text('从首页输入主题开始学习吧')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.FG_DIM)
            .margin({ top: Spacing.SM })
        }
        .alignItems(HorizontalAlign.Center)
        Blank().layoutWeight(1)
      }
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
  }

  // ============ 个人中心Tab ============
  @Builder
  ProfileTab() {
    Column() {
      // 用户信息
      Column() {
        Stack() {
          Text('U')
            .fontSize(24)
            .fontColor(AppColors.ACCENT)
            .fontWeight(FontWeight.Bold)
        }
        .width(64)
        .height(64)
        .borderRadius(32)
        .backgroundColor(AppColors.ACCENT + '15')
        .border({ width: 2, color: AppColors.ACCENT + '30' })
        .margin({ bottom: Spacing.MD })

        Text('学习者')
          .fontSize(FontSize.XL)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)

        Text('免费版')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_DIM)
          .padding({ left: 8, right: 8, top: 2, bottom: 2 })
          .borderRadius(Radius.PILL)
          .backgroundColor(AppColors.BG_HOVER)
          .margin({ top: Spacing.XS })
      }
      .margin({ top: Spacing.XXL, bottom: Spacing.XL })

      // 统计
      Row() {
        this.ProfileStat(this.historyList.length.toString(), '已学主题')
        this.ProfileStat('0', '完成节点')
        this.ProfileStat('0', '测验通过')
      }
      .width('92%')
      .justifyContent(FlexAlign.SpaceAround)
      .padding(Spacing.LG)
      .borderRadius(Radius.LG)
      .backgroundColor(AppColors.BG_SURFACE)
      .border({ width: 1, color: AppColors.BORDER })
      .margin({ bottom: Spacing.LG })

      // 布局画廊入口卡片
      Row() {
        Column() {
          Text('100 布局画廊')
            .fontSize(FontSize.LG)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Bold)
          Text('探索 10 大分类 · 100 种布局范式')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.FG_SECONDARY)
            .margin({ top: Spacing.XS })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Column() {
          Text('100')
            .fontSize(FontSize.XXL)
            .fontColor(AppColors.ACCENT)
            .fontWeight(FontWeight.Bold)
          Text('→')
            .fontSize(FontSize.LG)
            .fontColor(AppColors.ACCENT)
            .margin({ top: Spacing.XS })
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width('92%')
      .padding(Spacing.LG)
      .borderRadius(Radius.LG)
      .backgroundColor(AppColors.BG_ELEVATED)
      .border({ width: 1, color: AppColors.ACCENT_DIM })
      .margin({ bottom: Spacing.LG })
      .onClick(() => {
        try {
          router.pushUrl({ url: 'pages/LayoutGalleryPage' })
        } catch (_e) {
        }
      })

      // 收藏夹入口
      Row() {
        Text('♡')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.RED)
          .margin({ right: Spacing.SM })
        Text('我的收藏')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .layoutWeight(1)
        Text('→')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.FG_DIM)
      }
      .width('92%')
      .padding({ left: Spacing.LG, right: Spacing.LG, top: 14, bottom: 14 })
      .borderRadius(Radius.LG)
      .backgroundColor(AppColors.BG_SURFACE)
      .border({ width: 1, color: AppColors.BORDER })
      .margin({ bottom: Spacing.LG })
      .onClick(() => {
        try {
          router.pushUrl({ url: 'pages/FavoritesPage' })
        } catch (_e) {
        }
      })

      // 菜单
      Column() {
        this.ProfileMenuItem('学习历史', this.historyList.length.toString())
        this.ProfileMenuItem('AI 模型设置', '')
        this.ProfileMenuItem('关于应用', 'v1.0')
      }
      .width('92%')
      .borderRadius(Radius.LG)
      .backgroundColor(AppColors.BG_SURFACE)
      .border({ width: 1, color: AppColors.BORDER })

      Blank().layoutWeight(1)

      // 退出
      Button('退出登录')
        .width('92%')
        .height(44)
        .fontSize(FontSize.BASE)
        .backgroundColor(Color.Transparent)
        .fontColor(AppColors.RED)
        .borderRadius(Radius.MD)
        .border({ width: 1, color: AppColors.RED + '30' })
        .margin({ bottom: Spacing.XL })
        .onClick(() => {
          try {
            router.replaceUrl({ url: 'pages/LoginPage' })
          } catch (_e) {
          }
        })
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ProfileStat(value: string, label: string) {
    Column() {
      Text(value)
        .fontSize(FontSize.XXL)
        .fontColor(AppColors.ACCENT)
        .fontWeight(FontWeight.Bold)
      Text(label)
        .fontSize(FontSize.XS)
        .fontColor(AppColors.FG_DIM)
        .margin({ top: 2 })
    }
  }

  @Builder
  ProfileMenuItem(title: string, badge: string) {
    Row() {
      Text(title)
        .fontSize(FontSize.BASE)
        .fontColor(AppColors.FG)
        .layoutWeight(1)

      if (badge.length > 0) {
        Text(badge)
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_DIM)
      }

      Text('→')
        .fontSize(FontSize.SM)
        .fontColor(AppColors.FG_DIM)
        .margin({ left: Spacing.SM })
    }
    .width('100%')
    .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 14, bottom: 14 })
    .borderRadius(Radius.MD)
  }

  // ============ 加载遮罩 ============
  @Builder
  LoadingOverlay() {
    Column() {
      LoadingProgress()
        .width(48)
        .height(48)
        .color(AppColors.ACCENT)
        .margin({ bottom: Spacing.LG })

      Text(this.loadingText)
        .fontSize(FontSize.LG)
        .fontColor(AppColors.FG)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: Spacing.BASE })

      Progress({ value: this.loadingProgress, total: 100, type: ProgressType.Linear })
        .width(240)
        .height(4)
        .color(AppColors.ACCENT)
        .backgroundColor(AppColors.BG_HOVER)

      Row() {
        ForEach([0, 1, 2, 3, 4], (i: number) => {
          Circle()
            .width(8)
            .height(8)
            .fill(this.loadingProgress > i * 25 ? AppColors.ACCENT : AppColors.BORDER)
            .margin({ left: 4, right: 4 })
        }, (i: number) => i.toString())
      }
      .margin({ top: Spacing.MD })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#0D0D0Ce8')
  }

  // ============ 数据加载 ============
  private async loadTopic(topic: string) {
    const trimmed = topic.trim()
    if (!trimmed) return

    this.currentTopic = trimmed
    this.accentColor = TOPIC_THEMES[trimmed] || AppColors.ACCENT
    addToHistory(trimmed)
    this.historyList = loadHistory()

    const localData = getOrGenerateTopicData(trimmed)
    if (localData) {
      this.topicData = localData
      this.currentTab = 1
      return
    }

    this.isLoading = true
    this.loadingProgress = 0
    this.loadingText = '正在搜索相关信息...'
    this.simulateLoading()

    try {
      const aiData = await generateTopicDataWithAI(trimmed)
      if (aiData) {
        this.topicData = aiData
        this.currentTab = 1
        this.toast('图谱生成成功！')
      } else {
        this.toast('生成失败，请检查API设置')
      }
    } catch (_e) {
      this.toast('网络错误，请重试')
    }

    this.isLoading = false
  }

  private simulateLoading() {
    const stages: LoadingStage[] = [
      { progress: 20, text: '正在搜索相关信息...' },
      { progress: 45, text: '正在分析知识结构...' },
      { progress: 65, text: '正在生成知识图谱...' },
      { progress: 85, text: '正在规划学习路径...' },
      { progress: 95, text: '即将完成...' },
    ]

    let delay = 0
    for (const stage of stages) {
      delay += 800
      setTimeout(() => {
        this.loadingProgress = stage.progress
        this.loadingText = stage.text
      }, delay)
    }
  }

  private toast(msg: string) {
    this.toastMsg = msg
    this.showToast = true
    setTimeout(() => { this.showToast = false }, 2500)
  }
}
