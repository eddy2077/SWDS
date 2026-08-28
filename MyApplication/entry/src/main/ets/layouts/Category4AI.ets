// AI交互分类布局 L31-L40
import { AppColors, FontSize, Radius, Spacing } from '../common/Constants'
import { KN_DATA, KnowledgeNode, ChatMsg, KeywordInfo, CmdLineItem, SuggestCardItem, QuizOptionItem } from './LayoutTypes'

// ─── 通用状态栏 ───
@Builder
function StatusBar() {
  Row() {
    Text('9:41')
      .fontSize(FontSize.XS)
      .fontColor(AppColors.FG_SECONDARY)
      .fontWeight(FontWeight.Medium)
    Blank()
    Text('●●● ◗ ▊')
      .fontSize(FontSize.XS)
      .fontColor(AppColors.FG_SECONDARY)
  }
  .width('100%')
  .height(24)
  .padding({ left: Spacing.BASE, right: Spacing.BASE })
  .justifyContent(FlexAlign.SpaceBetween)
  .alignItems(VerticalAlign.Center)
}

// ═══════════════════════════════════════════
// L31 - 全屏对话
// ═══════════════════════════════════════════

@Component
export struct L31 {
  @State messages: ChatMsg[] = [
    { role: 'assistant', content: '你好！我是AI知识导师，有什么可以帮你的吗？' }
  ]
  @State inputText: string = ''

  build() {
    Column() {
      StatusBar()

      // 导航栏
      Row() {
        Text('←')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG_SECONDARY)
          .margin({ right: Spacing.SM })
        Text('AI 对话')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
        Text('⋯')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG_SECONDARY)
      }
      .width('100%')
      .height(40)
      .padding({ left: Spacing.BASE, right: Spacing.BASE })
      .alignItems(VerticalAlign.Center)

      Divider().color(AppColors.BORDER).height(0.5)

      // 消息列表
      List() {
        ForEach(this.messages, (msg: ChatMsg, index: number) => {
          ListItem() {
            Row() {
              if (msg.role === 'user') {
                Blank().layoutWeight(1)
              }
              if (msg.role === 'assistant') {
                Stack() {
                  Text('AI')
                    .fontSize(FontSize.XS)
                    .fontColor(AppColors.ACCENT)
                    .fontWeight(FontWeight.Bold)
                }
                .width(22)
                .height(22)
                .borderRadius(11)
                .backgroundColor(AppColors.ACCENT + '18')
                .alignContent(Alignment.Center)
                .margin({ right: Spacing.SM, top: 2 })
              }
              Text(msg.content)
                .fontSize(FontSize.SM)
                .fontColor(msg.role === 'user' ? AppColors.BG : AppColors.FG)
                .lineHeight(20)
                .padding({ left: Spacing.SM, right: Spacing.SM, top: 8, bottom: 8 })
                .borderRadius(Radius.MD)
                .backgroundColor(msg.role === 'user' ? AppColors.ACCENT : AppColors.BG_ELEVATED)
                .maxLines(4)
              if (msg.role === 'assistant') {
                Blank().layoutWeight(1)
              }
            }
            .width('100%')
            .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: 4 })
            .alignItems(VerticalAlign.Top)
          }
        }, (msg: ChatMsg, index: number) => `${msg.role}_${index}`)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .margin({ top: Spacing.XS })

      // 输入栏
      Row() {
        TextInput({ placeholder: '输入消息...', text: this.inputText })
          .layoutWeight(1)
          .height(36)
          .fontSize(FontSize.SM)
          .fontColor(AppColors.FG)
          .placeholderColor(AppColors.FG_DIM)
          .backgroundColor(AppColors.BG_ELEVATED)
          .borderRadius(Radius.MD)
          .border({ width: 1, color: AppColors.BORDER })
          .padding({ left: Spacing.SM })
          .onChange((v: string) => { this.inputText = v })

        Button('发送')
          .height(36)
          .fontSize(FontSize.SM)
          .fontWeight(FontWeight.Bold)
          .backgroundColor(AppColors.ACCENT)
          .fontColor(AppColors.BG)
          .borderRadius(Radius.MD)
          .margin({ left: Spacing.SM })
          .onClick(() => {
            if (this.inputText.trim().length > 0) {
              this.messages.push({ role: 'user', content: this.inputText.trim() })
              this.inputText = ''
            }
          })
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: Spacing.SM, bottom: Spacing.SM })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ═══════════════════════════════════════════
// L32 - 侧边面板
// ═══════════════════════════════════════════
@Component
export struct L32 {
  @State showPanel: boolean = false

  build() {
    Column() {
      StatusBar()

      // 导航栏
      Row() {
        Text('←')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG_SECONDARY)
          .margin({ right: Spacing.SM })
        Text('深度学习')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
        Text('AI')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.ACCENT)
          .fontWeight(FontWeight.Bold)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(Radius.PILL)
          .backgroundColor(AppColors.ACCENT + '18')
          .border({ width: 1, color: AppColors.ACCENT + '30' })
          .onClick(() => { this.showPanel = !this.showPanel })
      }
      .width('100%')
      .height(40)
      .padding({ left: Spacing.BASE, right: Spacing.BASE })
      .alignItems(VerticalAlign.Center)

      // 主内容区
      Stack() {
        // 底层内容
        Column() {
          Text('神经网络基础')
            .fontSize(FontSize.LG)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Bold)
            .margin({ top: Spacing.BASE, bottom: Spacing.SM })
            .padding({ left: Spacing.BASE, right: Spacing.BASE })

          Text('神经网络是一种模仿生物神经系统的计算模型，由大量的人工神经元相互连接组成。每个神经元接收输入信号，经过加权求和和激活函数处理后输出结果。')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.FG_SECONDARY)
            .lineHeight(20)
            .padding({ left: Spacing.BASE, right: Spacing.BASE })

          Row() {
            Text('前向传播')
              .fontSize(FontSize.XS)
              .fontColor(AppColors.ACCENT)
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .borderRadius(Radius.PILL)
              .backgroundColor(AppColors.ACCENT + '10')
            Text('反向传播')
              .fontSize(FontSize.XS)
              .fontColor(AppColors.BLUE)
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .borderRadius(Radius.PILL)
              .backgroundColor(AppColors.BLUE + '10')
            Text('梯度下降')
              .fontSize(FontSize.XS)
              .fontColor(AppColors.RED)
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .borderRadius(Radius.PILL)
              .backgroundColor(AppColors.RED + '10')
          }
          .margin({ top: Spacing.SM, left: Spacing.BASE })
        }
        .width('100%')
        .layoutWeight(1)

        // 侧边面板
        if (this.showPanel) {
          Column() {
            Row() {
              Text('AI 助手')
                .fontSize(FontSize.BASE)
                .fontColor(AppColors.FG)
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text('✕')
                .fontSize(FontSize.LG)
                .fontColor(AppColors.FG_SECONDARY)
                .onClick(() => { this.showPanel = false })
            }
            .width('100%')
            .padding({ left: Spacing.BASE, right: Spacing.BASE, top: Spacing.BASE })

            Divider().color(AppColors.BORDER).height(0.5).margin({ top: Spacing.SM })

            // 简单解释
            Row() {
              Column() {
                Text('简单解释')
                  .fontSize(FontSize.BASE)
                  .fontColor(AppColors.FG)
                  .fontWeight(FontWeight.Medium)
                Text('用通俗语言解释当前内容')
                  .fontSize(FontSize.XS)
                  .fontColor(AppColors.FG_DIM)
                  .margin({ top: 2 })
              }
              .layoutWeight(1)
              Text('→')
                .fontSize(FontSize.BASE)
                .fontColor(AppColors.ACCENT)
            }
            .width('100%')
            .padding(Spacing.BASE)
            .borderRadius(Radius.MD)
            .backgroundColor(AppColors.BG_ELEVATED)
            .margin({ top: Spacing.SM, left: Spacing.BASE, right: Spacing.BASE })

            // 详细说明
            Row() {
              Column() {
                Text('详细说明')
                  .fontSize(FontSize.BASE)
                  .fontColor(AppColors.FG)
                  .fontWeight(FontWeight.Medium)
                Text('深入展开技术细节和原理')
                  .fontSize(FontSize.XS)
                  .fontColor(AppColors.FG_DIM)
                  .margin({ top: 2 })
              }
              .layoutWeight(1)
              Text('→')
                .fontSize(FontSize.BASE)
                .fontColor(AppColors.ACCENT)
            }
            .width('100%')
            .padding(Spacing.BASE)
            .borderRadius(Radius.MD)
            .backgroundColor(AppColors.BG_ELEVATED)
            .margin({ top: Spacing.SM, left: Spacing.BASE, right: Spacing.BASE })
          }
          .width('65%')
          .height('100%')
          .backgroundColor(AppColors.BG_SURFACE)
          .border({ width: 1, color: AppColors.BORDER })
          .alignItems(HorizontalAlign.Start)
        }
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ═══════════════════════════════════════════
// L33 - 浮动气泡
// ═══════════════════════════════════════════
@Component
export struct L33 {
  @State showBubble: boolean = false

  build() {
    Column() {
      StatusBar()

      // 导航栏
      Row() {
        Text('←')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG_SECONDARY)
          .margin({ right: Spacing.SM })
        Text('池化层')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
      }
      .width('100%')
      .height(40)
      .padding({ left: Spacing.BASE, right: Spacing.BASE })
      .alignItems(VerticalAlign.Center)

      // 学习内容
      Scroll() {
        Column() {
          Text('池化层 (Pooling Layer)')
            .fontSize(FontSize.LG)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: Spacing.SM })

          Text('池化层是卷积神经网络中常用的降采样操作，用于减少特征图的空间维度，降低计算量，同时保留最重要的特征信息。')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.FG_SECONDARY)
            .lineHeight(20)
            .margin({ bottom: Spacing.SM })

          Text('常见类型')
            .fontSize(FontSize.BASE)
            .fontColor(AppColors.ACCENT)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: Spacing.XS })

          Text('• 最大池化 (Max Pooling)：取窗口内最大值\n• 平均池化 (Avg Pooling)：取窗口内平均值\n• 全局池化 (Global Pooling)：对整个特征图操作')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.FG_SECONDARY)
            .lineHeight(20)
        }
        .padding({ left: Spacing.BASE, right: Spacing.BASE, top: Spacing.SM })
      }
      .layoutWeight(1)

      // 底部按钮行
      Row() {
        Text('AI提示')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.ACCENT)
          .fontWeight(FontWeight.Medium)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .borderRadius(Radius.PILL)
          .backgroundColor(AppColors.ACCENT + '15')
          .border({ width: 1, color: AppColors.ACCENT + '30' })
          .onClick(() => { this.showBubble = !this.showBubble })
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, bottom: Spacing.SM })
      .justifyContent(FlexAlign.End)

      // 浮动气泡
      if (this.showBubble) {
        Row() {
          Column() {
            Row() {
              Text('💡')
                .fontSize(FontSize.SM)
                .margin({ right: Spacing.XS })
              Text('AI 提示')
                .fontSize(FontSize.SM)
                .fontColor(AppColors.ACCENT)
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text('✕')
                .fontSize(FontSize.XS)
                .fontColor(AppColors.FG_DIM)
                .onClick(() => { this.showBubble = false })
            }
            .width('100%')
            Text('池化层通过降采样减少参数量，防止过拟合。最大池化保留最显著特征，适合检测任务；平均池化保留整体信息，适合风格迁移。')
              .fontSize(FontSize.XS)
              .fontColor(AppColors.FG_SECONDARY)
              .lineHeight(18)
              .margin({ top: Spacing.XS })
          }
          .padding(Spacing.SM)
          .borderRadius(Radius.MD)
          .backgroundColor(AppColors.BG_ELEVATED)
          .border({ width: 1, color: AppColors.ACCENT + '30' })
        }
        .width('100%')
        .padding({ left: Spacing.BASE, right: Spacing.BASE, bottom: Spacing.SM })
        .justifyContent(FlexAlign.End)
      }
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ═══════════════════════════════════════════
// L34 - 分屏对话
// ═══════════════════════════════════════════
@Component
export struct L34 {
  @State chatMessages: ChatMsg[] = []

  build() {
    Column() {
      StatusBar()

      // 导航栏
      Row() {
        Text('←')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG_SECONDARY)
          .margin({ right: Spacing.SM })
        Text('知识对话')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
      }
      .width('100%')
      .height(40)
      .padding({ left: Spacing.BASE, right: Spacing.BASE })
      .alignItems(VerticalAlign.Center)

      // 分屏区域
      Row() {
        // 左侧 - 知识图谱主题列表
        Column() {
          Text('知识主题')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.FG_DIM)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: Spacing.XS })

          List() {
            ForEach(KN_DATA.slice(0, 8), (node: KnowledgeNode) => {
              ListItem() {
                Text(node.name)
                  .fontSize(FontSize.XS)
                  .fontColor(AppColors.FG_SECONDARY)
                  .padding({ left: 6, right: 6, top: 5, bottom: 5 })
                  .borderRadius(Radius.SM)
                  .backgroundColor(AppColors.BG_ELEVATED)
                  .width('100%')
                  .textAlign(TextAlign.Start)
                  .onClick(() => {
                    this.chatMessages.push({ role: 'user', content: `请讲解「${node.name}」` })
                  })
              }
              .margin({ bottom: 4 })
            }, (node: KnowledgeNode) => `kn_${node.id}`)
          }
          .layoutWeight(1)
          .scrollBar(BarState.Off)
        }
        .width('35%')
        .height('100%')
        .padding(Spacing.SM)
        .backgroundColor(AppColors.BG)

        // 分割线
        Divider()
          .vertical(true)
          .height('100%')
          .color(AppColors.BORDER)
          .width(1)

        // 右侧 - 对话区
        Column() {
          if (this.chatMessages.length === 0) {
            Column() {
              Text('👆')
                .fontSize(FontSize.XXL)
                .margin({ bottom: Spacing.XS })
              Text('点击左侧主题开始对话')
                .fontSize(FontSize.XS)
                .fontColor(AppColors.FG_DIM)
            }
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .layoutWeight(1)
          } else {
            List() {
              ForEach(this.chatMessages, (msg: ChatMsg, index: number) => {
                ListItem() {
                  Row() {
                    if (msg.role === 'user') {
                      Blank().layoutWeight(1)
                    }
                    Text(msg.content)
                      .fontSize(FontSize.XS)
                      .fontColor(msg.role === 'user' ? AppColors.BG : AppColors.FG)
                      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
                      .borderRadius(Radius.SM)
                      .backgroundColor(msg.role === 'user' ? AppColors.ACCENT : AppColors.BG_ELEVATED)
                      .maxLines(3)
                    if (msg.role === 'assistant') {
                      Blank().layoutWeight(1)
                    }
                  }
                  .width('100%')
                  .padding({ top: 3, bottom: 3 })
                }
              }, (msg: ChatMsg, index: number) => `${msg.role}_${index}`)
            }
            .layoutWeight(1)
            .scrollBar(BarState.Off)
            .padding({ left: Spacing.XS, right: Spacing.XS })
          }
        }
        .layoutWeight(1)
        .height('100%')
        .padding(Spacing.SM)
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ═══════════════════════════════════════════
// L35 - 语音优先
// ═══════════════════════════════════════════
@Component
export struct L35 {
  @State isRecording: boolean = false

  build() {
    Column() {
      StatusBar()

      // 导航栏
      Row() {
        Text('←')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG_SECONDARY)
          .margin({ right: Spacing.SM })
        Text('语音助手')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
      }
      .width('100%')
      .height(40)
      .padding({ left: Spacing.BASE, right: Spacing.BASE })
      .alignItems(VerticalAlign.Center)

      Column() {
        // 麦克风按钮
        Stack() {
          // 外圈
          Circle()
            .width(100)
            .height(100)
            .fill(this.isRecording ? AppColors.RED + '15' : AppColors.ACCENT + '10')
          // 内圈
          Circle()
            .width(72)
            .height(72)
            .fill(this.isRecording ? AppColors.RED + '30' : AppColors.ACCENT + '20')
          // 图标
          Text('🎤')
            .fontSize(32)
        }
        .width(100)
        .height(100)
        .onClick(() => { this.isRecording = !this.isRecording })

        // 状态文字
        Text(this.isRecording ? '正在聆听...' : '点击开始语音输入')
          .fontSize(FontSize.BASE)
          .fontColor(this.isRecording ? AppColors.RED : AppColors.FG_SECONDARY)
          .fontWeight(FontWeight.Medium)
          .margin({ top: Spacing.LG })

        // 示例查询
        Column() {
          Text('试试这样说：')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.FG_DIM)
            .margin({ bottom: Spacing.XS })

          Text('"什么是反向传播算法？"')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.FG_SECONDARY)
            .padding({ left: Spacing.SM, right: Spacing.SM, top: 6, bottom: 6 })
            .borderRadius(Radius.PILL)
            .backgroundColor(AppColors.BG_ELEVATED)
            .margin({ bottom: Spacing.XS })

          Text('"解释梯度消失问题"')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.FG_SECONDARY)
            .padding({ left: Spacing.SM, right: Spacing.SM, top: 6, bottom: 6 })
            .borderRadius(Radius.PILL)
            .backgroundColor(AppColors.BG_ELEVATED)
        }
        .margin({ top: Spacing.XXL })
        .alignItems(HorizontalAlign.Center)
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ═══════════════════════════════════════════
// L36 - 嵌入式标注
// ═══════════════════════════════════════════

@Component
export struct L36 {
  @State selectedKeyword: number = -1

  private keywords: KeywordInfo[] = [
    { word: '链式法则', detail: '链式法则是微积分中求复合函数导数的方法，在反向传播中用于逐层计算梯度，是神经网络训练的数学基础。' },
    { word: '权重参数', detail: '权重参数是神经网络中可学习的数值，决定了神经元之间连接的强度，通过训练过程不断优化调整。' },
    { word: '延伸资料', detail: '推荐阅读：《深度学习》第6章、3Blue1Brown反向传播可视化视频、Stanford CS231n课程笔记。' }
  ]

  build() {
    Column() {
      StatusBar()

      // 导航栏
      Row() {
        Text('←')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG_SECONDARY)
          .margin({ right: Spacing.SM })
        Text('反向传播')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
      }
      .width('100%')
      .height(40)
      .padding({ left: Spacing.BASE, right: Spacing.BASE })
      .alignItems(VerticalAlign.Center)

      // 正文内容（含标注关键词）
      Column() {
        Row() {
          Text('反向传播算法利用')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.FG_SECONDARY)
          Text('链式法则')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.ACCENT)
            .fontWeight(FontWeight.Bold)
            .decoration({ type: TextDecorationType.Underline, color: AppColors.ACCENT + '60' })
            .onClick(() => { this.selectedKeyword = this.selectedKeyword === 0 ? -1 : 0 })
        }
        .margin({ bottom: 4 })

        Text('逐层计算损失函数对每个')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.FG_SECONDARY)
          .margin({ bottom: 4 })

        Row() {
          Text('权重参数')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.BLUE)
            .fontWeight(FontWeight.Bold)
            .decoration({ type: TextDecorationType.Underline, color: AppColors.BLUE + '60' })
            .onClick(() => { this.selectedKeyword = this.selectedKeyword === 1 ? -1 : 1 })
          Text('的梯度，从而指导参数更新。')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.FG_SECONDARY)
        }
        .margin({ bottom: 4 })

        Row() {
          Text('了解更多请查看')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.FG_SECONDARY)
          Text('延伸资料')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.RED)
            .fontWeight(FontWeight.Bold)
            .decoration({ type: TextDecorationType.Underline, color: AppColors.RED + '60' })
            .onClick(() => { this.selectedKeyword = this.selectedKeyword === 2 ? -1 : 2 })
        }
      }
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: Spacing.BASE })
      .alignItems(HorizontalAlign.Start)

      // 关键词详情卡片
      if (this.selectedKeyword >= 0) {
        Column() {
          Row() {
            Text(this.keywords[this.selectedKeyword].word)
              .fontSize(FontSize.BASE)
              .fontColor(AppColors.ACCENT)
              .fontWeight(FontWeight.Bold)
              .layoutWeight(1)
            Text('✕')
              .fontSize(FontSize.SM)
              .fontColor(AppColors.FG_DIM)
              .onClick(() => { this.selectedKeyword = -1 })
          }
          .width('100%')
          .margin({ bottom: Spacing.XS })

          Text(this.keywords[this.selectedKeyword].detail)
            .fontSize(FontSize.XS)
            .fontColor(AppColors.FG_SECONDARY)
            .lineHeight(18)
        }
        .width('100%')
        .padding(Spacing.BASE)
        .margin({ left: Spacing.BASE, right: Spacing.BASE, top: Spacing.BASE })
        .borderRadius(Radius.MD)
        .backgroundColor(AppColors.BG_ELEVATED)
        .border({ width: 1, color: AppColors.ACCENT + '30' })
      }

      Blank().layoutWeight(1)
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ═══════════════════════════════════════════
// L37 - 命令行
// ═══════════════════════════════════════════

@Component
export struct L37 {
  @State cmdHistory: CmdLineItem[] = [
    { text: '$ help', isOutput: false },
    { text: '可用命令: learn, explain, quiz, search, status', isOutput: true },
    { text: '$ learn 神经网络', isOutput: false },
    { text: '📖 正在加载「神经网络」学习模块...', isOutput: true },
    { text: '✅ 已加载 12 个知识点，3 个练习题', isOutput: true }
  ]
  @State cmdInput: string = ''

  build() {
    Column() {
      StatusBar()

      // 标题栏
      Row() {
        Row() {
          Circle().width(8).height(8).fill('#C45A5A')
          Circle().width(8).height(8).fill('#C4A265').margin({ left: 4 })
          Circle().width(8).height(8).fill('#6A9EC4').margin({ left: 4 })
        }
        .margin({ right: Spacing.SM })
        Text('知识终端 v1.0')
          .fontSize(FontSize.XS)
          .fontColor('#6A9EC4')
          .fontFamily('monospace')
          .layoutWeight(1)
      }
      .width('100%')
      .height(32)
      .padding({ left: Spacing.BASE, right: Spacing.BASE })
      .backgroundColor('#0A0A09')
      .alignItems(VerticalAlign.Center)

      // 命令历史
      List() {
        ForEach(this.cmdHistory, (line: CmdLineItem, index: number) => {
          ListItem() {
            Text(line.text)
              .fontSize(FontSize.XS)
              .fontColor(line.isOutput ? '#6AC47A' : '#C4A265')
              .fontFamily('monospace')
              .width('100%')
              .padding({ top: 2, bottom: 2 })
          }
        }, (line: CmdLineItem, index: number) => `cmd_${index}`)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: Spacing.SM })
      .backgroundColor('#0A0A09')

      // 输入行
      Row() {
        Text('$ ')
          .fontSize(FontSize.XS)
          .fontColor('#C4A265')
          .fontFamily('monospace')
        TextInput({ placeholder: '输入命令...', text: this.cmdInput })
          .layoutWeight(1)
          .height(28)
          .fontSize(FontSize.XS)
          .fontColor('#6AC47A')
          .placeholderColor('#3A3A30')
          .fontFamily('monospace')
          .backgroundColor(Color.Transparent)
          .border({ width: 0 })
          .padding({ left: 0 })
          .onChange((v: string) => { this.cmdInput = v })
          .onSubmit(() => {
            if (this.cmdInput.trim().length > 0) {
              this.cmdHistory.push({ text: `$ ${this.cmdInput.trim()}`, isOutput: false })
              this.cmdHistory.push({ text: `✅ 已执行: ${this.cmdInput.trim()}`, isOutput: true })
              this.cmdInput = ''
            }
          })
      }
      .width('100%')
      .height(36)
      .padding({ left: Spacing.BASE, right: Spacing.BASE })
      .backgroundColor('#0A0A09')
      .border({ width: 1, color: '#2A2820' })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(444)
    .backgroundColor('#0A0A09')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ═══════════════════════════════════════════
// L38 - 卡片建议
// ═══════════════════════════════════════════

@Component
export struct L38 {
  @State selectedIndex: number = -1

  private cards: SuggestCardItem[] = [
    { icon: '💡', title: '概念', desc: '解释当前知识点的核心概念与定义' },
    { icon: '🗺️', title: '路径', desc: '规划从基础到进阶的学习路线图' },
    { icon: '✏️', title: '练习', desc: '生成针对性练习题巩固理解' },
    { icon: '⚖️', title: '对比', desc: '与相关概念进行横向对比分析' }
  ]

  build() {
    Column() {
      StatusBar()

      // 导航栏
      Row() {
        Text('←')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG_SECONDARY)
          .margin({ right: Spacing.SM })
        Text('AI 建议')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
      }
      .width('100%')
      .height(40)
      .padding({ left: Spacing.BASE, right: Spacing.BASE })
      .alignItems(VerticalAlign.Center)

      Text('基于你当前的学习进度，AI为你推荐以下操作：')
        .fontSize(FontSize.XS)
        .fontColor(AppColors.FG_DIM)
        .padding({ left: Spacing.BASE, right: Spacing.BASE })
        .margin({ bottom: Spacing.SM })

      // 建议卡片列表
      List() {
        ForEach(this.cards, (card: SuggestCardItem, index: number) => {
          ListItem() {
            Row() {
              // 左侧色条
              Column()
                .width(3)
                .height('100%')
                .borderRadius(2)
                .backgroundColor(this.selectedIndex === index ? AppColors.ACCENT : Color.Transparent)

              Row() {
                Text(card.icon)
                  .fontSize(FontSize.LG)
                  .margin({ right: Spacing.SM })

                Column() {
                  Text(card.title)
                    .fontSize(FontSize.BASE)
                    .fontColor(AppColors.FG)
                    .fontWeight(FontWeight.Medium)
                  Text(card.desc)
                    .fontSize(FontSize.XS)
                    .fontColor(AppColors.FG_DIM)
                    .margin({ top: 2 })
                    .maxLines(1)
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)

                Text('→')
                  .fontSize(FontSize.BASE)
                  .fontColor(AppColors.ACCENT)
              }
              .layoutWeight(1)
              .padding(Spacing.BASE)
            }
            .width('100%')
            .borderRadius(Radius.MD)
            .backgroundColor(this.selectedIndex === index ? AppColors.ACCENT + '10' : AppColors.BG_ELEVATED)
            .border({ width: 1, color: this.selectedIndex === index ? AppColors.ACCENT + '30' : AppColors.BORDER })
            .margin({ bottom: Spacing.SM })
            .onClick(() => { this.selectedIndex = this.selectedIndex === index ? -1 : index })
          }
          .padding({ left: Spacing.BASE, right: Spacing.BASE })
        }, (card: SuggestCardItem, index: number) => `card_${index}`)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ═══════════════════════════════════════════
// L39 - 教练模式
// ═══════════════════════════════════════════
@Component
export struct L39 {
  @State currentMode: number = 0 // 0:教练 1:学生 2:观察

  build() {
    Column() {
      StatusBar()

      // 导航栏
      Row() {
        Text('←')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG_SECONDARY)
          .margin({ right: Spacing.SM })
        Text('教练模式')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
      }
      .width('100%')
      .height(40)
      .padding({ left: Spacing.BASE, right: Spacing.BASE })
      .alignItems(VerticalAlign.Center)

      // 模式切换按钮
      Row() {
        ForEach(['教练', '学生', '观察'], (mode: string, index: number) => {
          Text(mode)
            .fontSize(FontSize.SM)
            .fontColor(this.currentMode === index ? AppColors.BG : AppColors.FG_SECONDARY)
            .fontWeight(this.currentMode === index ? FontWeight.Bold : FontWeight.Normal)
            .padding({ left: 16, right: 16, top: 6, bottom: 6 })
            .borderRadius(Radius.PILL)
            .backgroundColor(this.currentMode === index ? AppColors.ACCENT : AppColors.BG_ELEVATED)
            .border({ width: 1, color: this.currentMode === index ? AppColors.ACCENT : AppColors.BORDER })
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
            .onClick(() => { this.currentMode = index })
        }, (mode: string, index: number) => `mode_${index}`)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE })
      .justifyContent(FlexAlign.SpaceEvenly)

      // 内容区域
      Column() {
        if (this.currentMode === 0) {
          // 教练模式 - 目标
          Text('🎯 学习目标')
            .fontSize(FontSize.BASE)
            .fontColor(AppColors.ACCENT)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: Spacing.SM })

          Column() {
            Row() {
              Text('✓')
                .fontSize(FontSize.XS)
                .fontColor('#6AC47A')
                .margin({ right: Spacing.XS })
              Text('理解反向传播原理')
                .fontSize(FontSize.SM)
                .fontColor(AppColors.FG)
                .layoutWeight(1)
              Text('已完成')
                .fontSize(FontSize.XS)
                .fontColor('#6AC47A')
            }
            .padding({ top: 6, bottom: 6 })

            Row() {
              Text('○')
                .fontSize(FontSize.XS)
                .fontColor(AppColors.ACCENT)
                .margin({ right: Spacing.XS })
              Text('掌握梯度下降优化')
                .fontSize(FontSize.SM)
                .fontColor(AppColors.FG)
                .layoutWeight(1)
              Text('进行中')
                .fontSize(FontSize.XS)
                .fontColor(AppColors.ACCENT)
            }
            .padding({ top: 6, bottom: 6 })

            Row() {
              Text('○')
                .fontSize(FontSize.XS)
                .fontColor(AppColors.FG_DIM)
                .margin({ right: Spacing.XS })
              Text('实现简单神经网络')
                .fontSize(FontSize.SM)
                .fontColor(AppColors.FG_SECONDARY)
                .layoutWeight(1)
              Text('未开始')
                .fontSize(FontSize.XS)
                .fontColor(AppColors.FG_DIM)
            }
            .padding({ top: 6, bottom: 6 })
          }
          .width('100%')
          .padding(Spacing.BASE)
          .borderRadius(Radius.MD)
          .backgroundColor(AppColors.BG_ELEVATED)
        } else if (this.currentMode === 1) {
          // 学生模式 - 提问
          Text('✏️ 提问区')
            .fontSize(FontSize.BASE)
            .fontColor(AppColors.BLUE)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: Spacing.SM })

          TextInput({ placeholder: '输入你的问题...' })
            .height(40)
            .fontSize(FontSize.SM)
            .fontColor(AppColors.FG)
            .placeholderColor(AppColors.FG_DIM)
            .backgroundColor(AppColors.BG_ELEVATED)
            .borderRadius(Radius.MD)
            .border({ width: 1, color: AppColors.BORDER })
            .padding({ left: Spacing.SM })

          Row() {
            Text('为什么需要激活函数？')
              .fontSize(FontSize.XS)
              .fontColor(AppColors.BLUE)
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .borderRadius(Radius.PILL)
              .backgroundColor(AppColors.BLUE + '10')
              .margin({ right: Spacing.XS })

            Text('梯度消失怎么解决？')
              .fontSize(FontSize.XS)
              .fontColor(AppColors.BLUE)
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .borderRadius(Radius.PILL)
              .backgroundColor(AppColors.BLUE + '10')
          }
          .margin({ top: Spacing.SM })
        } else {
          // 观察模式 - 数据分析
          Text('📊 学习分析')
            .fontSize(FontSize.BASE)
            .fontColor(AppColors.RED)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: Spacing.SM })

          Row() {
            Column() {
              Text('73%')
                .fontSize(FontSize.XXL)
                .fontColor(AppColors.ACCENT)
                .fontWeight(FontWeight.Bold)
              Text('掌握度')
                .fontSize(FontSize.XS)
                .fontColor(AppColors.FG_DIM)
            }
            .layoutWeight(1)

            Column() {
              Text('12')
                .fontSize(FontSize.XXL)
                .fontColor(AppColors.BLUE)
                .fontWeight(FontWeight.Bold)
              Text('已学概念')
                .fontSize(FontSize.XS)
                .fontColor(AppColors.FG_DIM)
            }
            .layoutWeight(1)

            Column() {
              Text('5')
                .fontSize(FontSize.XXL)
                .fontColor(AppColors.RED)
                .fontWeight(FontWeight.Bold)
              Text('薄弱点')
                .fontSize(FontSize.XS)
                .fontColor(AppColors.FG_DIM)
            }
            .layoutWeight(1)
          }
          .width('100%')
          .padding(Spacing.BASE)
          .borderRadius(Radius.MD)
          .backgroundColor(AppColors.BG_ELEVATED)
        }
      }
      .padding(Spacing.BASE)
      .layoutWeight(1)

      Blank().layoutWeight(1)
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ═══════════════════════════════════════════
// L40 - 沉浸问答
// ═══════════════════════════════════════════

@Component
export struct L40 {
  @State currentQ: number = 0
  @State selectedOpt: number = -1

  private quizzes: QuizOptionItem[] = [
    {
      question: '在机器学习中，以下哪种方法可以有效防止过拟合？',
      options: ['增加模型复杂度', '使用正则化', '减少训练数据', '增大学习率']
    },
    {
      question: '卷积神经网络中，池化层的主要作用是什么？',
      options: ['增加参数量', '提取边缘特征', '降低特征图维度', '增加非线性']
    },
    {
      question: '梯度消失问题通常出现在哪种网络结构中？',
      options: ['浅层网络', '深层网络', '卷积网络', '生成对抗网络']
    }
  ]

  build() {
    Column() {
      StatusBar()

      // 导航栏
      Row() {
        Text('←')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG_SECONDARY)
          .margin({ right: Spacing.SM })
        Text('沉浸问答')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
        Text(`${this.currentQ + 1}/${this.quizzes.length}`)
          .fontSize(FontSize.SM)
          .fontColor(AppColors.ACCENT)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .height(40)
      .padding({ left: Spacing.BASE, right: Spacing.BASE })
      .alignItems(VerticalAlign.Center)

      // 进度条
      Row() {
        ForEach(this.quizzes, (_q: QuizOptionItem, index: number) => {
          Row()
            .layoutWeight(1)
            .height(3)
            .borderRadius(2)
            .backgroundColor(index <= this.currentQ ? AppColors.ACCENT : AppColors.BG_ELEVATED)
            .margin({ right: index < this.quizzes.length - 1 ? 4 : 0 })
        }, (_q: QuizOptionItem, index: number) => `prog_${index}`)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE })
      .margin({ top: Spacing.SM, bottom: Spacing.LG })

      // 问题
      Column() {
        Text(`问题 ${this.currentQ + 1}`)
          .fontSize(FontSize.XS)
          .fontColor(AppColors.ACCENT)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: Spacing.XS })

        Text(this.quizzes[this.currentQ].question)
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
          .lineHeight(26)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE })
      .alignItems(HorizontalAlign.Start)

      // 选项
      Column() {
        ForEach(this.quizzes[this.currentQ].options, (opt: string, index: number) => {
          Row() {
            Text(String.fromCharCode(65 + index))
              .fontSize(FontSize.SM)
              .fontColor(this.selectedOpt === index ? AppColors.BG : AppColors.FG_SECONDARY)
              .fontWeight(FontWeight.Bold)
              .width(24)
              .height(24)
              .borderRadius(12)
              .backgroundColor(this.selectedOpt === index ? AppColors.ACCENT : AppColors.BG_ELEVATED)
              .textAlign(TextAlign.Center)
              .margin({ right: Spacing.SM })

            Text(opt)
              .fontSize(FontSize.SM)
              .fontColor(this.selectedOpt === index ? AppColors.FG : AppColors.FG_SECONDARY)
              .layoutWeight(1)
          }
          .width('100%')
          .padding(Spacing.BASE)
          .borderRadius(Radius.MD)
          .backgroundColor(this.selectedOpt === index ? AppColors.ACCENT + '10' : AppColors.BG_ELEVATED)
          .border({ width: 1, color: this.selectedOpt === index ? AppColors.ACCENT + '30' : AppColors.BORDER })
          .margin({ bottom: Spacing.SM })
          .onClick(() => { this.selectedOpt = index })
        }, (opt: string, index: number) => `opt_${this.currentQ}_${index}`)
      }
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: Spacing.LG })

      Blank().layoutWeight(1)

      // 导航按钮
      Row() {
        Text('上一题')
          .fontSize(FontSize.SM)
          .fontColor(this.currentQ > 0 ? AppColors.FG_SECONDARY : AppColors.FG_DIM)
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .borderRadius(Radius.PILL)
          .backgroundColor(AppColors.BG_ELEVATED)
          .border({ width: 1, color: AppColors.BORDER })
          .onClick(() => {
            if (this.currentQ > 0) {
              this.currentQ--
              this.selectedOpt = -1
            }
          })

        Blank().layoutWeight(1)

        Text(this.currentQ < this.quizzes.length - 1 ? '下一题' : '完成')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.BG)
          .fontWeight(FontWeight.Bold)
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .borderRadius(Radius.PILL)
          .backgroundColor(AppColors.ACCENT)
          .onClick(() => {
            if (this.currentQ < this.quizzes.length - 1) {
              this.currentQ++
              this.selectedOpt = -1
            }
          })
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, bottom: Spacing.BASE })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}
