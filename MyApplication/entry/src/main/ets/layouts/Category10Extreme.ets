// 极端方向分类布局 - L91~L100
import { AppColors, FontSize, Radius, Spacing } from '../common/Constants'
import { KN_DATA, FeedEntry, AppItem, HoloNode } from './LayoutTypes'

// ============ L91 - 纯文字终端 ============
@Component
export struct L91 {
  @State history: string[] = [
    '$ init knowledge-base',
    '> 知识库已加载 [15 nodes]',
    '$ scan neural-network',
    '> 扫描完成: 4 个关联节点',
    '$ learn transformer',
    '> 正在学习 Transformer...',
    '> 注意力机制 ✓',
    '> 位置编码 ✓',
    '> 多头注意力 ✓',
    '$ _'
  ]
  @State inputText: string = ''

  build() {
    Column() {
      // 状态栏
      Row() {
        Text('9:41')
          .fontSize(FontSize.XS)
          .fontColor('#00ff41')
          .opacity(0.6)
        Blank()
        Text('●●●')
          .fontSize(FontSize.XS)
          .fontColor('#00ff41')
          .opacity(0.6)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 8, bottom: 4 })

      // 终端标题栏
      Row() {
        Row() {
          Circle().width(8).height(8).fill('#ff5f57')
          Circle().width(8).height(8).fill('#febc2e').margin({ left: 6 })
          Circle().width(8).height(8).fill('#28c840').margin({ left: 6 })
        }
        .margin({ right: Spacing.MD })

        Text('knowledge-terminal')
          .fontSize(FontSize.XS)
          .fontColor('#00ff41')
          .opacity(0.8)
          .fontFamily('monospace')
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 6, bottom: 6 })
      .border({ width: { bottom: 1 }, color: '#00ff4140', style: BorderStyle.Dashed })

      // 命令历史
      Scroll() {
        Column() {
          ForEach(this.history, (line: string, idx: number) => {
            Text(line)
              .fontSize(FontSize.SM)
              .fontColor(line.startsWith('$') ? '#00ff41' : '#00cc33')
              .fontFamily('monospace')
              .width('100%')
              .margin({ bottom: 2 })
              .opacity(line.startsWith('>') ? 0.8 : 1)
          }, (line: string, idx: number) => `${idx}`)
        }
        .width('100%')
        .padding(Spacing.BASE)
      }
      .layoutWeight(1)
      .width('100%')

      // 输入行
      Row() {
        Text('$ ')
          .fontSize(FontSize.SM)
          .fontColor('#00ff41')
          .fontFamily('monospace')
        Text(this.inputText.length > 0 ? this.inputText : '输入命令...')
          .fontSize(FontSize.SM)
          .fontColor(this.inputText.length > 0 ? '#00ff41' : '#005500')
          .fontFamily('monospace')
          .layoutWeight(1)
        Text('█')
          .fontSize(FontSize.SM)
          .fontColor('#00ff41')
          .fontFamily('monospace')
          .opacity(0.8)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 8, bottom: 8 })
      .border({ width: { top: 1 }, color: '#00ff4140' })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#050505')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ============ L92 - 纯视觉无文字 ============
@Component
export struct L92 {
  @State selectedIndex: number = -1

  private icons: string[] = ['🧠', '🔬', '🐍', '👁️', '🗣️', '📊']
  private colors: string[] = ['#C4A265', '#6A9EC4', '#4CAF50', '#9C27B0', '#FF7043', '#42A5F5']

  build() {
    Column() {
      // 状态栏
      Row() {
        Text('9:41')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_SECONDARY)
        Blank()
        Text('●●●')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_SECONDARY)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 8, bottom: 4 })

      Blank().height(Spacing.LG)

      // 3x2 图标网格
      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceEvenly }) {
        ForEach(this.icons, (icon: string, idx: number) => {
          Stack() {
            Circle()
              .width(this.selectedIndex === idx ? 88 : 76)
              .height(this.selectedIndex === idx ? 88 : 76)
              .fill(this.colors[idx] + '20')
            Circle()
              .width(this.selectedIndex === idx ? 88 : 76)
              .height(this.selectedIndex === idx ? 88 : 76)
              .fill(Color.Transparent)
              .stroke(this.selectedIndex === idx ? this.colors[idx] : this.colors[idx] + '30')
              .strokeWidth(this.selectedIndex === idx ? 3 : 1)
            Text(icon)
              .fontSize(this.selectedIndex === idx ? 36 : 30)
          }
          .width('30%')
          .height(100)
          .alignContent(Alignment.Center)
          .margin({ bottom: Spacing.MD })
          .scale({
            x: this.selectedIndex === idx ? 1.1 : 1,
            y: this.selectedIndex === idx ? 1.1 : 1
          })
          .animation({ duration: 200 })
          .onClick(() => {
            this.selectedIndex = this.selectedIndex === idx ? -1 : idx
          })
        }, (icon: string, idx: number) => `${idx}`)
      }
      .width('92%')

      Blank().layoutWeight(1)

      // 底部指示点
      Row() {
        ForEach([0, 1, 2, 3, 4, 5], (idx: number) => {
          Circle()
            .width(this.selectedIndex === idx ? 10 : 6)
            .height(this.selectedIndex === idx ? 10 : 6)
            .fill(this.selectedIndex === idx ? this.colors[idx] : AppColors.FG_DIM)
            .margin({ left: 4, right: 4 })
        }, (idx: number) => `${idx}`)
      }
      .margin({ bottom: Spacing.XL })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ============ L93 - 游戏化RPG ============
@Component
export struct L93 {
  @State xp: number = 65
  @State level: number = 3
  @State questComplete: boolean = false

  private xpMax: number = 100

  build() {
    Column() {
      // 状态栏
      Row() {
        Text('9:41')
          .fontSize(FontSize.XS)
          .fontColor('#E0D0FF')
        Blank()
        Text('●●●')
          .fontSize(FontSize.XS)
          .fontColor('#E0D0FF')
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 8, bottom: 4 })

      // 角色信息
      Row() {
        Stack() {
          Circle()
            .width(48)
            .height(48)
            .fill('#C4A265')
          Text('⚔️')
            .fontSize(24)
        }
        .margin({ right: Spacing.MD })

        Column() {
          Text('知识骑士')
            .fontSize(FontSize.LG)
            .fontColor('#E8D8FF')
            .fontWeight(FontWeight.Bold)
          Text(`Lv.${this.level} · 智慧之路`)
            .fontSize(FontSize.XS)
            .fontColor('#A090C0')
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        // 金币
        Row() {
          Text('🪙')
            .fontSize(FontSize.SM)
          Text('128')
            .fontSize(FontSize.SM)
            .fontColor('#C4A265')
            .fontWeight(FontWeight.Bold)
            .margin({ left: 4 })
        }
      }
      .width('92%')
      .margin({ top: Spacing.MD, bottom: Spacing.MD })

      // 经验条
      Column() {
        Row() {
          Text('EXP')
            .fontSize(FontSize.XS)
            .fontColor('#A090C0')
            .fontWeight(FontWeight.Bold)
          Blank()
          Text(`${this.xp}/${this.xpMax}`)
            .fontSize(FontSize.XS)
            .fontColor('#A090C0')
        }
        .width('100%')
        .margin({ bottom: 4 })

        Stack() {
          Row()
            .width('100%')
            .height(12)
            .borderRadius(6)
            .backgroundColor('#1A1030')
          Row()
            .width(`${this.xp}%`)
            .height(12)
            .borderRadius(6)
            .backgroundColor('#8B5CF6')
        }
        .width('100%')
        .alignContent(Alignment.Start)
      }
      .width('92%')
      .margin({ bottom: Spacing.LG })

      // 任务卡片
      Column() {
        Row() {
          Text('📋 当前任务')
            .fontSize(FontSize.BASE)
            .fontColor('#E8D8FF')
            .fontWeight(FontWeight.Bold)
          Blank()
          Text('日常')
            .fontSize(FontSize.XS)
            .fontColor('#8B5CF6')
            .padding({ left: 8, right: 8, top: 2, bottom: 2 })
            .borderRadius(Radius.PILL)
            .backgroundColor('#8B5CF620')
        }
        .width('100%')
        .margin({ bottom: Spacing.MD })

        Text('完成3个神经网络知识点的学习')
          .fontSize(FontSize.SM)
          .fontColor('#C0B0D8')
          .margin({ bottom: Spacing.SM })

        Row() {
          Text('进度 2/3')
            .fontSize(FontSize.XS)
            .fontColor('#A090C0')
          Blank()
          Text('奖励 +30 XP')
            .fontSize(FontSize.XS)
            .fontColor('#C4A265')
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .margin({ bottom: Spacing.MD })

        Button(this.questComplete ? '✓ 已完成' : '完成任务')
          .width('100%')
          .height(40)
          .fontSize(FontSize.BASE)
          .fontWeight(FontWeight.Bold)
          .backgroundColor(this.questComplete ? '#8B5CF640' : '#8B5CF6')
          .fontColor(this.questComplete ? '#A090C0' : '#FFFFFF')
          .borderRadius(Radius.MD)
          .onClick(() => {
            if (!this.questComplete) {
              this.questComplete = true
              this.xp = Math.min(this.xp + 30, this.xpMax)
              if (this.xp >= this.xpMax) {
                this.level += 1
                this.xp = this.xp - this.xpMax
              }
            }
          })
      }
      .width('92%')
      .padding(Spacing.LG)
      .borderRadius(Radius.LG)
      .backgroundColor('#1A1030')
      .border({ width: 1, color: '#8B5CF630' })

      Blank().layoutWeight(1)
    }
    .width('100%')
    .height(444)
    .backgroundColor('#0D0820')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ============ L94 - 社交信息流 ============
@Component
export struct L94 {
  @State likedItems: number[] = []

  private feedItems: FeedEntry[] = [
    { id: 1, user: '小明', action: '完成了机器学习', emoji: '🎉', time: '3分钟前' },
    { id: 2, user: '小红', action: '获得了深度学习徽章', emoji: '⭐', time: '15分钟前' },
    { id: 3, user: '阿杰', action: '解锁了CNN章节', emoji: '🏆', time: '1小时前' },
    { id: 4, user: '小雨', action: '连续学习7天', emoji: '🔥', time: '2小时前' },
    { id: 5, user: '小华', action: '完成了NLP测验', emoji: '📝', time: '3小时前' },
    { id: 6, user: '小芳', action: '升级到Lv.5', emoji: '⬆️', time: '5小时前' }
  ]

  build() {
    Column() {
      // 状态栏
      Row() {
        Text('9:41')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_SECONDARY)
        Blank()
        Text('●●●')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_SECONDARY)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 8, bottom: 4 })

      // 导航栏
      Row() {
        Text('动态')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
        Blank()
        Text('🔔')
          .fontSize(FontSize.LG)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 信息流
      Scroll() {
        Column() {
          ForEach(this.feedItems, (item: FeedEntry) => {
            Row() {
              // 头像
              Stack() {
                Circle()
                  .width(36)
                  .height(36)
                  .fill(AppColors.ACCENT + '20')
                Text(item.emoji)
                  .fontSize(16)
              }
              .margin({ right: Spacing.MD })

              // 内容
              Column() {
                Row() {
                  Text(item.user)
                    .fontSize(FontSize.BASE)
                    .fontColor(AppColors.FG)
                    .fontWeight(FontWeight.Medium)
                  Text(item.action)
                    .fontSize(FontSize.BASE)
                    .fontColor(AppColors.FG_SECONDARY)
                    .margin({ left: 4 })
                }
                .width('100%')

                Text(item.time)
                  .fontSize(FontSize.XS)
                  .fontColor(AppColors.FG_DIM)
                  .margin({ top: 2 })
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              // 点赞
              Text(this.likedItems.includes(item.id) ? '❤️' : '🤍')
                .fontSize(18)
                .onClick(() => {
                  const idx = this.likedItems.indexOf(item.id)
                  if (idx >= 0) {
                    this.likedItems.splice(idx, 1)
                  } else {
                    this.likedItems.push(item.id)
                  }
                })
            }
            .width('100%')
            .padding({ left: Spacing.BASE, right: Spacing.BASE, top: Spacing.MD, bottom: Spacing.MD })
            .borderRadius(Radius.MD)
            .backgroundColor(AppColors.BG_ELEVATED)
            .border({ width: 1, color: AppColors.BORDER })
            .margin({ bottom: Spacing.SM })
            .alignItems(VerticalAlign.Center)
          }, (item: FeedEntry) => item.id.toString())
        }
        .width('92%')
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

// ============ L95 - 操作系统桌面 ============
@Component
export struct L95 {
  @State selectedIndex: number = -1

  private apps: AppItem[] = [
    { name: '图谱', icon: '🗺️' },
    { name: 'AI', icon: '🤖' },
    { name: '学习', icon: '📖' },
    { name: '数据', icon: '📊' },
    { name: '设置', icon: '⚙️' },
    { name: '笔记', icon: '📝' },
    { name: '练习', icon: '✏️' },
    { name: '计划', icon: '📅' }
  ]

  build() {
    Column() {
      // 状态栏 - 桌面风格
      Row() {
        Text('9:41')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_SECONDARY)
        Blank()
        Text('WiFi ●●●')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_SECONDARY)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 8, bottom: 4 })

      Blank().height(Spacing.LG)

      // 4x2 应用网格
      Column() {
        // 第一行
        Row() {
          ForEach(this.apps.slice(0, 4), (app: AppItem, idx: number) => {
            Column() {
              Stack() {
                Column()
                  .width(48)
                  .height(48)
                  .borderRadius(12)
                  .backgroundColor(this.selectedIndex === idx ? '#C4A26530' : AppColors.BG_ELEVATED)
                Text(app.icon)
                  .fontSize(24)
              }
              Text(app.name)
                .fontSize(FontSize.XS)
                .fontColor(this.selectedIndex === idx ? AppColors.ACCENT : AppColors.FG_SECONDARY)
                .margin({ top: Spacing.XS })
            }
            .width('25%')
            .padding({ top: Spacing.SM, bottom: Spacing.SM })
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .onClick(() => {
              this.selectedIndex = this.selectedIndex === idx ? -1 : idx
            })
          }, (app: AppItem, idx: number) => `${idx}`)

          // 填充空白使4列对齐
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        // 第二行
        Row() {
          ForEach(this.apps.slice(4, 8), (app: AppItem, idx: number) => {
            Column() {
              Stack() {
                Column()
                  .width(48)
                  .height(48)
                  .borderRadius(12)
                  .backgroundColor(this.selectedIndex === idx + 4 ? '#C4A26530' : AppColors.BG_ELEVATED)
                Text(app.icon)
                  .fontSize(24)
              }
              Text(app.name)
                .fontSize(FontSize.XS)
                .fontColor(this.selectedIndex === idx + 4 ? AppColors.ACCENT : AppColors.FG_SECONDARY)
                .margin({ top: Spacing.XS })
            }
            .width('25%')
            .padding({ top: Spacing.SM, bottom: Spacing.SM })
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .onClick(() => {
              this.selectedIndex = this.selectedIndex === idx + 4 ? -1 : idx + 4
            })
          }, (app: AppItem, idx: number) => `${idx + 4}`)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width('92%')

      Blank().layoutWeight(1)

      // 底部搜索栏
      Row() {
        Text('🔍')
          .fontSize(FontSize.BASE)
          .margin({ right: Spacing.SM })
        Text('搜索知识...')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.FG_DIM)
          .layoutWeight(1)
      }
      .width('92%')
      .height(40)
      .padding({ left: Spacing.MD, right: Spacing.MD })
      .borderRadius(Radius.PILL)
      .backgroundColor(AppColors.BG_ELEVATED)
      .border({ width: 1, color: AppColors.BORDER })
      .margin({ bottom: Spacing.LG })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#0D0D0C')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ============ L96 - 报纸排版 ============
@Component
export struct L96 {
  build() {
    Column() {
      // 状态栏
      Row() {
        Text('9:41')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_SECONDARY)
        Blank()
        Text('●●●')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_SECONDARY)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 8, bottom: 4 })

      // 报头
      Column() {
        Text('THE AI KNOWLEDGE DAILY')
          .fontSize(FontSize.XXL)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(3)

        Row() {
          Text('Vol.42')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.FG_DIM)
          Blank()
          Text('2026年6月21日')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.FG_DIM)
          Blank()
          Text('No.100')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.FG_DIM)
        }
        .width('100%')
        .margin({ top: 4 })
      }
      .width('92%')
      .padding({ top: Spacing.MD, bottom: Spacing.MD })
      .border({ width: { bottom: 2 }, color: AppColors.FG })

      // 头条
      Column() {
        Text('Transformer架构深度解析')
          .fontSize(FontSize.XXL)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text('自注意力机制如何革新自然语言处理，从Seq2Seq到并行计算范式的跃迁')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.FG_SECONDARY)
          .margin({ top: Spacing.XS })
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row() {
          Text('By AI编辑部')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.ACCENT)
          Text('·')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.FG_DIM)
            .margin({ left: 4, right: 4 })
          Text('头版')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.RED)
        }
        .margin({ top: Spacing.XS })
      }
      .width('92%')
      .padding(Spacing.MD)
      .border({ width: { bottom: 1 }, color: AppColors.BORDER })

      // 副文章
      Row() {
        Column() {
          Text('CNN在视觉识别中的突破')
            .fontSize(FontSize.BASE)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Medium)
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          Text('卷积核如何捕捉空间特征...')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.FG_SECONDARY)
            .margin({ top: 4 })
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .width('47%')
        .padding(Spacing.MD)
        .border({ width: { right: 1 }, color: AppColors.BORDER })
        .alignItems(HorizontalAlign.Start)

        Column() {
          Text('RNN与LSTM的演进之路')
            .fontSize(FontSize.BASE)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Medium)
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          Text('从梯度消失到门控机制...')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.FG_SECONDARY)
            .margin({ top: 4 })
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .width('47%')
        .padding(Spacing.MD)
        .alignItems(HorizontalAlign.Start)
      }
      .width('92%')
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ============ L97 - 太空控制台 ============
@Component
export struct L97 {
  @State showAlert: boolean = false

  build() {
    Column() {
      // 状态栏
      Row() {
        Text('9:41')
          .fontSize(FontSize.XS)
          .fontColor('#6A9EC4')
        Blank()
        Text('●●●')
          .fontSize(FontSize.XS)
          .fontColor('#6A9EC4')
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 8, bottom: 4 })

      // 任务控制标题
      Row() {
        Text('⬡')
          .fontSize(FontSize.LG)
          .fontColor('#6A9EC4')
          .margin({ right: Spacing.XS })
        Text('MISSION CONTROL')
          .fontSize(FontSize.BASE)
          .fontColor('#6A9EC4')
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 统计面板
      Row() {
        this.StatPanel('知识节点', '15', '#6A9EC4')
        this.StatPanel('已探索', '73%', '#C4A265')
        this.StatPanel('信号强度', 'STRONG', '#4CAF50')
      }
      .width('92%')
      .justifyContent(FlexAlign.SpaceBetween)

      // 警告区域
      if (this.showAlert) {
        Row() {
          Text('⚠️')
            .fontSize(FontSize.LG)
            .margin({ right: Spacing.SM })
          Column() {
            Text('检测到知识盲区')
              .fontSize(FontSize.BASE)
              .fontColor('#FF7043')
              .fontWeight(FontWeight.Bold)
            Text('强化学习区域信号微弱，建议立即扫描')
              .fontSize(FontSize.XS)
              .fontColor('#FF704380')
              .margin({ top: 2 })
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)
        }
        .width('92%')
        .padding(Spacing.MD)
        .borderRadius(Radius.MD)
        .backgroundColor('#FF704310')
        .border({ width: 1, color: '#FF704340' })
        .margin({ top: Spacing.MD })
      }

      Blank().layoutWeight(1)

      // 扫描按钮
      Button('⬡ 扫描盲区')
        .width('92%')
        .height(44)
        .fontSize(FontSize.BASE)
        .fontWeight(FontWeight.Bold)
        .backgroundColor(Color.Transparent)
        .fontColor('#6A9EC4')
        .borderRadius(Radius.MD)
        .border({ width: 2, color: '#6A9EC4' })
        .margin({ bottom: Spacing.LG })
        .onClick(() => {
          this.showAlert = !this.showAlert
        })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#0A0E1A')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }

  @Builder
  StatPanel(label: string, value: string, color: string) {
    Column() {
      Text(label)
        .fontSize(FontSize.XS)
        .fontColor('#6A9EC480')
        .margin({ bottom: Spacing.XS })
      Text(value)
        .fontSize(FontSize.XXL)
        .fontColor(color)
        .fontWeight(FontWeight.Bold)
    }
    .width('30%')
    .padding(Spacing.MD)
    .borderRadius(Radius.MD)
    .backgroundColor('#0D1225')
    .border({ width: 1, color: color + '30' })
    .alignItems(HorizontalAlign.Center)
  }
}

// ============ L98 - 手账日记 ============
@Component
export struct L98 {
  @State selectedTab: number = 0

  private tabs: string[] = ['6/20', '6/19', '6/18']

  build() {
    Column() {
      // 状态栏
      Row() {
        Text('9:41')
          .fontSize(FontSize.XS)
          .fontColor('#6B5E4F')
        Blank()
        Text('●●●')
          .fontSize(FontSize.XS)
          .fontColor('#6B5E4F')
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 8, bottom: 4 })

      // 日期标签
      Row() {
        ForEach(this.tabs, (tab: string, idx: number) => {
          Text(tab)
            .fontSize(FontSize.SM)
            .fontColor(this.selectedTab === idx ? '#5C4A32' : '#9A8A72')
            .fontWeight(this.selectedTab === idx ? FontWeight.Bold : FontWeight.Normal)
            .padding({ left: 16, right: 16, top: 6, bottom: 6 })
            .borderRadius(Radius.PILL)
            .backgroundColor(this.selectedTab === idx ? '#E8DCC8' : Color.Transparent)
            .onClick(() => { this.selectedTab = idx })
        }, (tab: string) => tab)
      }
      .width('92%')
      .margin({ top: Spacing.SM, bottom: Spacing.MD })

      // 日记卡片
      Column() {
        // 日期标题
        Row() {
          Text('📝 6月20日 · 周六')
            .fontSize(FontSize.BASE)
            .fontColor('#5C4A32')
            .fontWeight(FontWeight.Bold)
          Blank()
          Text('☀️')
            .fontSize(FontSize.LG)
        }
        .width('100%')
        .margin({ bottom: Spacing.MD })

        // 学习笔记
        Column() {
          Text('今日学习笔记')
            .fontSize(FontSize.SM)
            .fontColor('#8B7A62')
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: Spacing.SM })

          Text('• 完成了Transformer的自注意力机制学习')
            .fontSize(FontSize.XS)
            .fontColor('#6B5E4F')
            .margin({ bottom: 4 })
          Text('• Q、K、V矩阵的计算方式理解了')
            .fontSize(FontSize.XS)
            .fontColor('#6B5E4F')
            .margin({ bottom: 4 })
          Text('• 多头注意力的并行计算很巧妙 ✨')
            .fontSize(FontSize.XS)
            .fontColor('#6B5E4F')
            .margin({ bottom: 4 })
          Text('• 明天继续学习位置编码部分')
            .fontSize(FontSize.XS)
            .fontColor('#6B5E4F')
        }
        .width('100%')
        .padding(Spacing.MD)
        .borderRadius(Radius.MD)
        .backgroundColor('#FEFCF5')
        .border({ width: 1, color: '#E0D4C0' })
        .alignItems(HorizontalAlign.Start)

        // 心情标签
        Row() {
          Text('心情: ')
            .fontSize(FontSize.XS)
            .fontColor('#9A8A72')
          Text('充实 😊')
            .fontSize(FontSize.XS)
            .fontColor('#5C4A32')
            .fontWeight(FontWeight.Medium)
        }
        .margin({ top: Spacing.SM })
      }
      .width('92%')
      .padding(Spacing.LG)
      .borderRadius(Radius.LG)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#E0D4C0' })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(444)
    .backgroundColor('#f5f0e0')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ============ L99 - 黑板教学 ============
@Component
export struct L99 {
  @State selectedQuestion: number = -1

  private questions: string[] = [
    '什么是梯度？',
    '梯度下降如何工作？',
    '学习率的影响？'
  ]

  build() {
    Column() {
      // 状态栏
      Row() {
        Text('9:41')
          .fontSize(FontSize.XS)
          .fontColor('#e0d8c0')
          .opacity(0.6)
        Blank()
        Text('●●●')
          .fontSize(FontSize.XS)
          .fontColor('#e0d8c0')
          .opacity(0.6)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 8, bottom: 4 })

      // 黑板标题
      Row() {
        Text('📐 梯度下降')
          .fontSize(FontSize.LG)
          .fontColor('#e0d8c0')
          .fontWeight(FontWeight.Bold)
        Blank()
        Text('数学基础')
          .fontSize(FontSize.XS)
          .fontColor('#e0d8c0')
          .opacity(0.5)
      }
      .width('92%')
      .margin({ top: Spacing.SM, bottom: Spacing.MD })

      // 公式区域
      Column() {
        Text('∇f(x) = [∂f/∂x₁, ∂f/∂x₂, ..., ∂f/∂xₙ]')
          .fontSize(FontSize.BASE)
          .fontColor('#e0d8c0')
          .fontFamily('monospace')
          .margin({ bottom: Spacing.MD })

        Text('xₙ₊₁ = xₙ - α∇f(xₙ)')
          .fontSize(FontSize.LG)
          .fontColor('#C4A265')
          .fontFamily('monospace')
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: Spacing.MD })

        Text('其中 α 为学习率')
          .fontSize(FontSize.SM)
          .fontColor('#e0d8c0')
          .opacity(0.7)
          .fontFamily('monospace')
      }
      .width('92%')
      .padding(Spacing.LG)
      .borderRadius(Radius.MD)
      .backgroundColor('#1a3020')
      .border({ width: 2, color: '#2a4a30' })
      .alignItems(HorizontalAlign.Center)

      // 问题卡片
      Column() {
        Text('课堂提问')
          .fontSize(FontSize.SM)
          .fontColor('#e0d8c0')
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: Spacing.SM })

        ForEach(this.questions, (q: string, idx: number) => {
          Row() {
            Text(`${idx + 1}.`)
              .fontSize(FontSize.SM)
              .fontColor('#e0d8c0')
              .margin({ right: Spacing.SM })
            Text(q)
              .fontSize(FontSize.SM)
              .fontColor(this.selectedQuestion === idx ? '#C4A265' : '#e0d8c0')
              .layoutWeight(1)
            Text(this.selectedQuestion === idx ? '✓' : '')
              .fontSize(FontSize.SM)
              .fontColor('#C4A265')
          }
          .width('100%')
          .padding({ top: Spacing.SM, bottom: Spacing.SM })
          .borderRadius(Radius.SM)
          .backgroundColor(this.selectedQuestion === idx ? '#2a4a30' : Color.Transparent)
          .onClick(() => {
            this.selectedQuestion = this.selectedQuestion === idx ? -1 : idx
          })
        }, (q: string, idx: number) => `${idx}`)
      }
      .width('92%')
      .padding(Spacing.MD)
      .borderRadius(Radius.MD)
      .backgroundColor('#1a3020')
      .border({ width: 1, color: '#2a4a30' })
      .margin({ top: Spacing.MD })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(444)
    .backgroundColor('#1a3020')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ============ L100 - 未来全息 ============
@Component
export struct L100 {
  @State mode: number = 0 // 0=静态, 1=展开, 2=旋转

  private nodes: HoloNode[] = [
    { label: '机器学习', color: '#C4A265' },
    { label: '深度学习', color: '#6A9EC4' },
    { label: 'NLP', color: '#9C27B0' },
    { label: '计算机视觉', color: '#4CAF50' },
    { label: '数学', color: '#FF7043' },
    { label: 'Python', color: '#42A5F5' }
  ]

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Column() {
      // 状态栏
      Row() {
        Text('9:41')
          .fontSize(FontSize.XS)
          .fontColor('#6A9EC4')
          .opacity(0.6)
        Blank()
        Text('●●●')
          .fontSize(FontSize.XS)
          .fontColor('#6A9EC4')
          .opacity(0.6)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 8, bottom: 4 })

      // 全息标题
      Row() {
        Text('◈')
          .fontSize(FontSize.LG)
          .fontColor('#C4A265')
          .margin({ right: Spacing.XS })
        Text('HOLOGRAPHIC CORE')
          .fontSize(FontSize.BASE)
          .fontColor('#6A9EC4')
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.SM })

      // Canvas 轨道可视化
      Canvas(this.context)
        .width('92%')
        .height(240)
        .onReady(() => {
          this.drawOrbital()
        })

      // 模式按钮
      Row() {
        ForEach(['静态', '展开', '旋转'], (label: string, idx: number) => {
          Text(label)
            .fontSize(FontSize.SM)
            .fontColor(this.mode === idx ? '#0D0D0C' : '#6A9EC4')
            .fontWeight(this.mode === idx ? FontWeight.Bold : FontWeight.Normal)
            .padding({ left: 20, right: 20, top: 8, bottom: 8 })
            .borderRadius(Radius.PILL)
            .backgroundColor(this.mode === idx ? '#6A9EC4' : Color.Transparent)
            .border({ width: 1, color: this.mode === idx ? '#6A9EC4' : '#6A9EC440' })
            .onClick(() => { this.mode = idx })
        }, (label: string) => label)
      }
      .width('92%')
      .justifyContent(FlexAlign.Center)
      .margin({ top: Spacing.MD })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#050510')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }

  private drawOrbital() {
    const ctx = this.context
    const w = 320
    const h = 240
    const cx = w / 2
    const cy = h / 2

    // 清除画布
    ctx.clearRect(0, 0, w, h)

    // 绘制轨道环
    ctx.strokeStyle = '#6A9EC420'
    ctx.lineWidth = 1
    ctx.beginPath()
    ctx.ellipse(cx, cy, 100, 60, 0, 0, Math.PI * 2)
    ctx.stroke()

    // 绘制中心光球
    const gradient = ctx.createRadialGradient(cx, cy, 0, cx, cy, 36)
    gradient.addColorStop(0, '#C4A265')
    gradient.addColorStop(0.5, '#C4A26560')
    gradient.addColorStop(1, '#C4A26500')
    ctx.fillStyle = gradient
    ctx.beginPath()
    ctx.arc(cx, cy, 36, 0, Math.PI * 2)
    ctx.fill()

    // 中心标签
    ctx.fillStyle = '#0D0D0C'
    ctx.font = '10px sans-serif'
    ctx.textAlign = 'center'
    ctx.textBaseline = 'middle'
    ctx.fillText('AI知识核心', cx, cy)

    // 绘制轨道节点
    const nodeCount = this.nodes.length
    const expandFactor = this.mode === 1 ? 1.3 : 1.0
    const rotationOffset = this.mode === 2 ? 0.5 : 0

    for (let i = 0; i < nodeCount; i++) {
      const angle = (Math.PI * 2 / nodeCount) * i + rotationOffset
      const rx = 100 * expandFactor
      const ry = 60 * expandFactor
      const nx = cx + rx * Math.cos(angle)
      const ny = cy + ry * Math.sin(angle)

      // 节点连线
      ctx.strokeStyle = this.nodes[i].color + '40'
      ctx.lineWidth = 1
      ctx.beginPath()
      ctx.moveTo(cx, cy)
      ctx.lineTo(nx, ny)
      ctx.stroke()

      // 节点光晕
      const nodeGradient = ctx.createRadialGradient(nx, ny, 0, nx, ny, 18)
      nodeGradient.addColorStop(0, this.nodes[i].color + '80')
      nodeGradient.addColorStop(1, this.nodes[i].color + '00')
      ctx.fillStyle = nodeGradient
      ctx.beginPath()
      ctx.arc(nx, ny, 18, 0, Math.PI * 2)
      ctx.fill()

      // 节点圆
      ctx.fillStyle = this.nodes[i].color + '40'
      ctx.beginPath()
      ctx.arc(nx, ny, 10, 0, Math.PI * 2)
      ctx.fill()
      ctx.strokeStyle = this.nodes[i].color
      ctx.lineWidth = 1.5
      ctx.stroke()

      // 节点标签
      ctx.fillStyle = this.nodes[i].color
      ctx.font = '9px sans-serif'
      ctx.textAlign = 'center'
      ctx.fillText(this.nodes[i].label, nx, ny + 22)
    }
  }
}
