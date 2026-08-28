// 卡片样式分类布局 - L51~L60
import { AppColors, FontSize, Radius, Spacing } from '../common/Constants'
import { KN_DATA, KnowledgeNode, AppItem, DnaData, CardDescItem, IconCatItem, NameCatLvItem, ColorBarItem, GroupItem } from './LayoutTypes'

// ============ L51 - 圆角大卡 ============
@Component
export struct L51 {
  @State expandedIndex: number = -1

  private cards: CardDescItem[] = [
    { name: '机器学习', cat: 'AI基础', desc: '让计算机从数据中自动学习规律与模式的核心技术' },
    { name: '深度学习', cat: 'AI基础', desc: '多层神经网络驱动的表示学习方法' },
    { name: '自然语言处理', cat: 'NLP', desc: '让计算机理解和生成人类语言的技术' },
    { name: '计算机视觉', cat: 'CV', desc: '让机器理解图像和视频内容的技术' },
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
        Text('圆角大卡')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 卡片列表
      Column({ space: Spacing.SM }) {
        ForEach(this.cards, (item: CardDescItem, idx: number) => {
          Column() {
            Row() {
              Column() {
                Text(item.name)
                  .fontSize(FontSize.LG)
                  .fontColor(AppColors.FG)
                  .fontWeight(FontWeight.Bold)
                Text(item.cat)
                  .fontSize(FontSize.XS)
                  .fontColor(AppColors.ACCENT)
                  .margin({ top: 2 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Text(this.expandedIndex === idx ? '▲' : '▼')
                .fontSize(FontSize.XS)
                .fontColor(AppColors.FG_DIM)
            }
            .width('100%')

            if (this.expandedIndex === idx) {
              Text(item.desc)
                .fontSize(FontSize.SM)
                .fontColor(AppColors.FG_SECONDARY)
                .margin({ top: Spacing.SM })
                .width('100%')
            }
          }
          .width('100%')
          .padding(Spacing.BASE)
          .borderRadius(16)
          .backgroundColor(AppColors.BG_ELEVATED)
          .border({ width: 1, color: this.expandedIndex === idx ? AppColors.ACCENT + '40' : AppColors.BORDER })
          .onClick(() => {
            this.expandedIndex = this.expandedIndex === idx ? -1 : idx
          })
        }, (item: CardDescItem) => item.name)
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

// ============ L52 - 扁平列表 ============
@Component
export struct L52 {
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
        Text('扁平列表')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 列表
      Column() {
        ForEach(KN_DATA.slice(0, 7), (item: KnowledgeNode) => {
          Row() {
            Text(item.name)
              .fontSize(FontSize.BASE)
              .fontColor(AppColors.FG)
              .layoutWeight(1)

            Text(item.cat)
              .fontSize(FontSize.XS)
              .fontColor(AppColors.FG_SECONDARY)
              .margin({ right: Spacing.SM })

            Text('›')
              .fontSize(FontSize.LG)
              .fontColor(AppColors.FG_DIM)
          }
          .width('100%')
          .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 12, bottom: 12 })
          .border({ width: { bottom: 1 }, color: AppColors.BORDER })
        }, (item: KnowledgeNode) => item.id.toString())
      }
      .width('92%')
      .borderRadius(Radius.MD)
      .backgroundColor(AppColors.BG_ELEVATED)
      .border({ width: 1, color: AppColors.BORDER })
      .clip(true)
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ============ L53 - 玻璃拟态 ============
@Component
export struct L53 {
  private glassCards: IconCatItem[] = [
    { icon: '🧠', name: '神经网络', cat: 'AI基础' },
    { icon: '🔬', name: '深度学习', cat: 'AI基础' },
    { icon: '🐍', name: 'Python编程', cat: '编程' },
    { icon: '📊', name: '概率统计', cat: '数学' },
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
        Text('玻璃拟态')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 渐变背景 + 玻璃卡片
      Stack() {
        // 渐变背景装饰
        Column() {
          Row() {
            Circle()
              .width(80)
              .height(80)
              .fill(AppColors.ACCENT + '20')
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)
          .padding({ left: 20, top: 10 })

          Blank()

          Row() {
            Circle()
              .width(60)
              .height(60)
              .fill(AppColors.BLUE + '15')
          }
          .width('100%')
          .justifyContent(FlexAlign.End)
          .padding({ right: 30, bottom: 20 })
        }
        .width('100%')
        .height('100%')

        // 玻璃卡片
        Column({ space: Spacing.SM }) {
          ForEach(this.glassCards, (item: IconCatItem) => {
            Row() {
              Text(item.icon)
                .fontSize(20)
                .margin({ right: Spacing.MD })

              Column() {
                Text(item.name)
                  .fontSize(FontSize.BASE)
                  .fontColor(AppColors.FG)
                  .fontWeight(FontWeight.Medium)
                Text(item.cat)
                  .fontSize(FontSize.XS)
                  .fontColor(AppColors.FG_SECONDARY)
                  .margin({ top: 2 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
            }
            .width('100%')
            .padding(Spacing.MD)
            .borderRadius(Radius.MD)
            .backgroundColor('#0DFFFFFF')
            .border({ width: 1, color: '#14FFFFFF' })
          }, (item: IconCatItem) => item.name)
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

// ============ L54 - 阴影浮起 ============
@Component
export struct L54 {
  private shadowCards: NameCatLvItem[] = [
    { name: '机器学习', cat: 'AI基础', lv: 3 },
    { name: '深度学习', cat: 'AI基础', lv: 4 },
    { name: 'Python编程', cat: '编程', lv: 2 },
    { name: '线性代数', cat: '数学', lv: 1 },
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
        Text('阴影浮起')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 浮起卡片
      Column({ space: Spacing.MD }) {
        ForEach(this.shadowCards, (item: NameCatLvItem) => {
          Row() {
            Column() {
              Text(item.name)
                .fontSize(FontSize.LG)
                .fontColor(AppColors.FG)
                .fontWeight(FontWeight.Bold)
              Text(item.cat)
                .fontSize(FontSize.XS)
                .fontColor(AppColors.ACCENT)
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            // 等级指示
            Row() {
              ForEach([1, 2, 3, 4, 5], (i: number) => {
                Circle()
                  .width(6)
                  .height(6)
                  .fill(i <= item.lv ? AppColors.ACCENT : AppColors.BORDER)
                  .margin({ right: 3 })
              }, (i: number) => i.toString())
            }
          }
          .width('100%')
          .padding(Spacing.BASE)
          .borderRadius(Radius.LG)
          .backgroundColor(AppColors.BG_ELEVATED)
          .border({ width: 1, color: AppColors.BORDER })
          .shadow({ radius: 12, color: '#00000066', offsetY: 4, offsetX: 0 })
        }, (item: NameCatLvItem) => item.name)
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

// ============ L55 - 左色条 ============
@Component
export struct L55 {
  private colorBarItems: ColorBarItem[] = [
    { name: '机器学习', cat: 'AI基础', barColor: '#C4A265' },
    { name: 'Python编程', cat: '编程', barColor: '#6A9EC4' },
    { name: '深度学习', cat: 'AI基础', barColor: '#C4A265' },
    { name: '概率统计', cat: '数学', barColor: '#C45A5A' },
    { name: '自然语言处理', cat: 'NLP', barColor: '#6A9EC4' },
    { name: '计算机视觉', cat: 'CV', barColor: '#C45A5A' },
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
        Text('左色条')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 色条卡片
      Column({ space: Spacing.XS }) {
        ForEach(this.colorBarItems, (item: ColorBarItem) => {
          Row() {
            // 左色条
            Column()
              .width(4)
              .height('100%')
              .borderRadius(2)
              .backgroundColor(item.barColor)

            Row() {
              Text(item.name)
                .fontSize(FontSize.BASE)
                .fontColor(AppColors.FG)
                .fontWeight(FontWeight.Medium)
                .layoutWeight(1)

              Text(item.cat)
                .fontSize(FontSize.XS)
                .fontColor(AppColors.FG_SECONDARY)
                .padding({ left: 8, right: 8, top: 3, bottom: 3 })
                .borderRadius(Radius.SM)
                .backgroundColor(AppColors.BG_HOVER)
            }
            .width('100%')
            .padding({ left: Spacing.MD, right: Spacing.MD, top: 12, bottom: 12 })
            .layoutWeight(1)
          }
          .width('100%')
          .borderRadius(Radius.MD)
          .backgroundColor(AppColors.BG_ELEVATED)
          .border({ width: 1, color: AppColors.BORDER })
        }, (item: ColorBarItem) => item.name)
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

// ============ L56 - 图标标题 ============
@Component
export struct L56 {
  private iconItems: IconCatItem[] = [
    { icon: '🧠', name: '神经网络', cat: 'AI基础' },
    { icon: '🔬', name: '深度学习', cat: 'AI基础' },
    { icon: '🐍', name: 'Python编程', cat: '编程' },
    { icon: '🗣️', name: '自然语言处理', cat: 'NLP' },
    { icon: '👁️', name: '计算机视觉', cat: 'CV' },
    { icon: '📊', name: '概率统计', cat: '数学' },
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
        Text('图标标题')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 图标标题卡片
      Column({ space: Spacing.XS }) {
        ForEach(this.iconItems, (item: IconCatItem) => {
          Row() {
            // 图标圆
            Stack() {
              Text(item.icon)
                .fontSize(18)
            }
            .width(40)
            .height(40)
            .borderRadius(20)
            .backgroundColor(AppColors.ACCENT + '12')
            .alignContent(Alignment.Center)
            .margin({ right: Spacing.MD })

            Column() {
              Text(item.name)
                .fontSize(FontSize.BASE)
                .fontColor(AppColors.FG)
                .fontWeight(FontWeight.Medium)
              Text(item.cat)
                .fontSize(FontSize.XS)
                .fontColor(AppColors.FG_SECONDARY)
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Text('›')
              .fontSize(FontSize.LG)
              .fontColor(AppColors.FG_DIM)
          }
          .width('100%')
          .padding({ left: Spacing.MD, right: Spacing.MD, top: 10, bottom: 10 })
          .borderRadius(Radius.MD)
          .backgroundColor(AppColors.BG_ELEVATED)
          .border({ width: 1, color: AppColors.BORDER })
        }, (item: IconCatItem) => item.name)
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

// ============ L57 - 嵌套折叠 ============
@Component
export struct L57 {
  @State openGroup: number = -1

  private groups: GroupItem[] = [
    { title: 'AI基础', icon: '🤖', items: ['机器学习', '深度学习', '神经网络', '强化学习'] },
    { title: '编程', icon: '💻', items: ['Python编程', '数据结构'] },
    { title: '数学', icon: '📐', items: ['线性代数', '概率统计'] },
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
        Text('嵌套折叠')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 折叠组
      Column({ space: Spacing.XS }) {
        ForEach(this.groups, (group: GroupItem, gIdx: number) => {
          Column() {
            // 组头
            Row() {
              Text(group.icon)
                .fontSize(16)
                .margin({ right: Spacing.SM })

              Text(group.title)
                .fontSize(FontSize.BASE)
                .fontColor(AppColors.FG)
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)

              Text(`${group.items.length}`)
                .fontSize(FontSize.XS)
                .fontColor(AppColors.FG_DIM)
                .margin({ right: Spacing.SM })

              Text(this.openGroup === gIdx ? '▲' : '▼')
                .fontSize(FontSize.XS)
                .fontColor(AppColors.FG_DIM)
            }
            .width('100%')
            .padding(Spacing.MD)
            .borderRadius(Radius.MD)
            .backgroundColor(AppColors.BG_ELEVATED)
            .border({ width: 1, color: this.openGroup === gIdx ? AppColors.ACCENT + '40' : AppColors.BORDER })
            .onClick(() => {
              this.openGroup = this.openGroup === gIdx ? -1 : gIdx
            })

            // 展开子项
            if (this.openGroup === gIdx) {
              Column() {
                ForEach(group.items, (child: string, cIdx: number) => {
                  Row() {
                    Column()
                      .width(2)
                      .height(16)
                      .backgroundColor(AppColors.ACCENT + '40')
                      .margin({ right: Spacing.MD })

                    Text(child)
                      .fontSize(FontSize.SM)
                      .fontColor(AppColors.FG_SECONDARY)
                      .layoutWeight(1)

                    Text('›')
                      .fontSize(FontSize.SM)
                      .fontColor(AppColors.FG_DIM)
                  }
                  .width('100%')
                  .padding({ left: Spacing.MD, right: Spacing.MD, top: 8, bottom: 8 })
                }, (child: string) => child)
              }
              .width('100%')
              .padding({ left: Spacing.MD })
              .borderRadius(Radius.SM)
              .backgroundColor(AppColors.BG_ELEVATED + '80')
            }
          }
          .width('100%')
        }, (group: GroupItem) => group.title)
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

// ============ L58 - 横向滑动 ============
@Component
export struct L58 {
  private scrollCards: AppItem[] = [
    { icon: '🧠', name: '神经网络' },
    { icon: '🔬', name: '深度学习' },
    { icon: '🐍', name: 'Python' },
    { icon: '🗣️', name: 'NLP' },
    { icon: '👁️', name: 'CV' },
    { icon: '📊', name: '统计' },
    { icon: '🎮', name: '强化学习' },
    { icon: '🔗', name: 'Transformer' },
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
        Text('横向滑动')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 标题区
      Text('知识领域')
        .fontSize(FontSize.LG)
        .fontColor(AppColors.FG)
        .fontWeight(FontWeight.Bold)
        .width('92%')
        .margin({ bottom: Spacing.MD })

      // 横向滚动卡片
      Scroll() {
        Row({ space: Spacing.SM }) {
          ForEach(this.scrollCards, (item: AppItem) => {
            Column() {
              Text(item.icon)
                .fontSize(24)
                .margin({ bottom: Spacing.XS })
              Text(item.name)
                .fontSize(FontSize.XS)
                .fontColor(AppColors.FG_SECONDARY)
            }
            .width(72)
            .height(80)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .borderRadius(Radius.MD)
            .backgroundColor(AppColors.BG_ELEVATED)
            .border({ width: 1, color: AppColors.BORDER })
          }, (item: AppItem) => item.name)
        }
        .padding({ left: Spacing.BASE, right: Spacing.BASE })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
      .margin({ bottom: Spacing.MD })

      // 下方补充内容
      Column() {
        Row() {
          Text('推荐学习')
            .fontSize(FontSize.BASE)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Medium)
            .layoutWeight(1)
          Text('更多 ›')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.ACCENT)
        }
        .width('100%')
        .margin({ bottom: Spacing.SM })

        Row() {
          Column() {
            Text('机器学习')
              .fontSize(FontSize.SM)
              .fontColor(AppColors.FG)
              .fontWeight(FontWeight.Medium)
            Text('AI基础 · Lv.3')
              .fontSize(FontSize.XS)
              .fontColor(AppColors.FG_DIM)
              .margin({ top: 2 })
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Text('→')
            .fontSize(FontSize.BASE)
            .fontColor(AppColors.ACCENT)
        }
        .width('100%')
        .padding(Spacing.MD)
        .borderRadius(Radius.MD)
        .backgroundColor(AppColors.BG_ELEVATED)
        .border({ width: 1, color: AppColors.BORDER })
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

// ============ L59 - 封面大图 ============
@Component
export struct L59 {
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
        Text('封面大图')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 封面大卡
      Stack() {
        // 渐变背景
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            direction: 135,
            colors: [['#C4A26530', 0], ['#6A9EC420', 0.5], ['#0D0D0C', 1]]
          })
          .borderRadius(Radius.LG)

        // 内容
        Column() {
          Blank().layoutWeight(1)

          Text('🤖')
            .fontSize(48)
            .margin({ bottom: Spacing.LG })

          Text('机器学习')
            .fontSize(FontSize.XXL)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Bold)

          Text('从理论到实践，系统掌握ML核心')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.FG_SECONDARY)
            .margin({ top: Spacing.XS })

          Button('开始探索')
            .height(36)
            .fontSize(FontSize.SM)
            .fontWeight(FontWeight.Bold)
            .backgroundColor(AppColors.ACCENT)
            .fontColor(AppColors.BG)
            .borderRadius(Radius.PILL)
            .padding({ left: 28, right: 28 })
            .margin({ top: Spacing.LG })
        }
        .width('100%')
        .height('100%')
        .padding(Spacing.XL)
        .alignItems(HorizontalAlign.Center)
      }
      .width('92%')
      .height(280)
      .borderRadius(Radius.LG)
      .border({ width: 1, color: AppColors.BORDER })
      .clip(true)
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ============ L60 - 极简线框 ============
@Component
export struct L60 {
  private lineItems: DnaData[] = [
    { name: '机器学习', pct: 85 },
    { name: '深度学习', pct: 62 },
    { name: 'Python编程', pct: 78 },
    { name: '自然语言处理', pct: 45 },
    { name: '计算机视觉', pct: 70 },
    { name: '线性代数', pct: 90 },
    { name: '概率统计', pct: 55 },
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
        Text('极简线框')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 极简列表
      Column() {
        ForEach(this.lineItems, (item: DnaData) => {
          Row() {
            Text(item.name)
              .fontSize(FontSize.SM)
              .fontColor(AppColors.FG)
              .layoutWeight(1)

            Text(`${item.pct}%`)
              .fontSize(FontSize.SM)
              .fontColor(AppColors.ACCENT)
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .padding({ top: 10, bottom: 10 })
          .border({ width: { bottom: 1 }, color: AppColors.BORDER + '60' })
        }, (item: DnaData) => item.name)

        // 查看全部
        Row() {
          Text('查看全部')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.ACCENT)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ top: Spacing.MD, bottom: Spacing.SM })
      }
      .width('92%')
      .padding({ left: Spacing.MD, right: Spacing.MD })
      .borderRadius(Radius.MD)
      .backgroundColor(AppColors.BG_ELEVATED)
      .border({ width: 1, color: AppColors.BORDER })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}
