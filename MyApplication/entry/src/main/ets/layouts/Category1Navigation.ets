// 导航范式 - Category1 布局组件 (L01-L10)
import { AppColors, FontSize, Radius, Spacing } from '../common/Constants'
import { KN_DATA, KnowledgeNode } from './LayoutTypes'

// ─── 通用状态栏组件 ───
@Component
struct StatusBar {
  build() {
    Row() {
      Text('9:41')
        .fontSize(FontSize.SM)
        .fontColor(AppColors.FG)
        .fontWeight(FontWeight.Medium)
      Blank()
      Row({ space: Spacing.XS }) {
        Text('📶')
          .fontSize(FontSize.XS)
        Text('🔋')
          .fontSize(FontSize.XS)
      }
    }
    .width('100%')
    .height(24)
    .padding({ left: Spacing.BASE, right: Spacing.BASE })
  }
}

// ─── L01 底部5Tab ───
@Component
export struct L01 {
  @State currentTab: number = 0
  private tabs: string[] = ['首页', '图谱', 'AI导师', '学习', '我的']
  private tabIcons: string[] = ['⌂', '◉', '◈', '▤', '☺']

  build() {
    Column() {
      StatusBar()
      // 导航栏
      Row() {
        Text('知识导师')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
        Blank()
        Text('⊙')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG_SECONDARY)
      }
      .width('100%')
      .height(36)
      .padding({ left: Spacing.BASE, right: Spacing.BASE })

      // 内容区域
      Column() {
        if (this.currentTab === 0) {
          // 首页 - 进度卡片
          Column({ space: Spacing.SM }) {
            Text('今日学习进度')
              .fontSize(FontSize.BASE)
              .fontColor(AppColors.FG_SECONDARY)
              .padding({ left: Spacing.BASE, top: Spacing.SM })
            Row({ space: Spacing.SM }) {
              ForEach(['机器学习', 'Python编程', '线性代数'], (item: string) => {
                Column() {
                  Text(item)
                    .fontSize(FontSize.SM)
                    .fontColor(AppColors.FG)
                  Text(`${Math.floor(Math.random() * 60 + 20)}%`)
                    .fontSize(FontSize.XXL)
                    .fontColor(AppColors.ACCENT)
                    .fontWeight(FontWeight.Bold)
                    .margin({ top: Spacing.XS })
                  // 进度条
                  Row() {
                    Row()
                      .width(`${Math.floor(Math.random() * 60 + 20)}%`)
                      .height('100%')
                      .backgroundColor(AppColors.ACCENT)
                      .borderRadius(Radius.PILL)
                  }
                  .width('100%')
                  .height(3)
                  .backgroundColor(AppColors.BG_HOVER)
                  .borderRadius(Radius.PILL)
                  .margin({ top: Spacing.XS })
                }
                .width('30%')
                .padding(Spacing.SM)
                .backgroundColor(AppColors.BG_ELEVATED)
                .borderRadius(Radius.MD)
                .alignItems(HorizontalAlign.Center)
              }, (item: string) => item)
            }
            .width('100%')
            .padding({ left: Spacing.BASE, right: Spacing.BASE })
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .width('100%')
          .layoutWeight(1)
        } else if (this.currentTab === 1) {
          // 图谱
          Column() {
            Text('知识图谱')
              .fontSize(FontSize.XXL)
              .fontColor(AppColors.FG)
              .fontWeight(FontWeight.Bold)
            Text('探索知识之间的关联')
              .fontSize(FontSize.SM)
              .fontColor(AppColors.FG_SECONDARY)
              .margin({ top: Spacing.XS })
          }
          .width('100%')
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        } else if (this.currentTab === 2) {
          // AI导师
          Column() {
            Text('◈')
              .fontSize(40)
              .fontColor(AppColors.ACCENT)
            Text('AI导师')
              .fontSize(FontSize.XXL)
              .fontColor(AppColors.FG)
              .fontWeight(FontWeight.Bold)
              .margin({ top: Spacing.SM })
            Text('随时为你解答疑惑')
              .fontSize(FontSize.SM)
              .fontColor(AppColors.FG_SECONDARY)
              .margin({ top: Spacing.XS })
          }
          .width('100%')
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        } else if (this.currentTab === 3) {
          // 学习
          Column() {
            Text('学习计划')
              .fontSize(FontSize.XXL)
              .fontColor(AppColors.FG)
              .fontWeight(FontWeight.Bold)
            Text('制定你的学习路径')
              .fontSize(FontSize.SM)
              .fontColor(AppColors.FG_SECONDARY)
              .margin({ top: Spacing.XS })
          }
          .width('100%')
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        } else {
          // 我的
          Column() {
            Text('☺')
              .fontSize(40)
            Text('个人中心')
              .fontSize(FontSize.XXL)
              .fontColor(AppColors.FG)
              .fontWeight(FontWeight.Bold)
              .margin({ top: Spacing.SM })
          }
          .width('100%')
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
      }
      .width('100%')
      .layoutWeight(1)

      // 底部Tab栏
      Row() {
        ForEach(this.tabs, (tab: string, index?: number) => {
          Column() {
            Text(this.tabIcons[index ?? 0])
              .fontSize(18)
              .fontColor((index ?? 0) === this.currentTab ? AppColors.ACCENT : AppColors.FG_DIM)
            Text(tab)
              .fontSize(FontSize.XS)
              .fontColor((index ?? 0) === this.currentTab ? AppColors.ACCENT : AppColors.FG_DIM)
              .margin({ top: 2 })
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => { this.currentTab = index ?? 0 })
        }, (tab: string, index?: number) => `${tab}_${index}`)
      }
      .width('100%')
      .height(48)
      .backgroundColor(AppColors.BG)
      .borderRadius(Radius.LG)
    }
    .width('100%')
    .height(444)
    .backgroundColor(AppColors.BG_SURFACE)
    .borderRadius(24)
    .border({ width: 2, color: AppColors.BORDER })
    .clip(true)
  }
}

// ─── L02 侧边抽屉 ───
@Component
export struct L02 {
  @State drawerOpen: boolean = false
  private menuItems: string[] = ['首页', '知识图谱', '学习路径', 'AI导师', '设置', '关于']

  build() {
    Stack() {
      Column() {
        StatusBar()
        // 导航栏
        Row() {
          Text('☰')
            .fontSize(FontSize.XXL)
            .fontColor(AppColors.FG)
            .onClick(() => { this.drawerOpen = !this.drawerOpen })
            .padding(Spacing.XS)
          Text('侧边抽屉')
            .fontSize(FontSize.LG)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Bold)
            .margin({ left: Spacing.SM })
          Blank()
        }
        .width('100%')
        .height(36)
        .padding({ left: Spacing.BASE, right: Spacing.BASE })

        // 主内容
        Column({ space: Spacing.SM }) {
          ForEach(KN_DATA.slice(0, 4), (item: KnowledgeNode) => {
            Row() {
              Column() {
                Text(item.name)
                  .fontSize(FontSize.BASE)
                  .fontColor(AppColors.FG)
                Text(item.cat)
                  .fontSize(FontSize.XS)
                  .fontColor(AppColors.FG_SECONDARY)
                  .margin({ top: 2 })
              }
              .alignItems(HorizontalAlign.Start)
              Blank()
              Text(`Lv.${item.lv}`)
                .fontSize(FontSize.XS)
                .fontColor(AppColors.ACCENT)
                .backgroundColor(AppColors.ACCENT_DIM)
                .padding({ left: Spacing.SM, right: Spacing.SM, top: 2, bottom: 2 })
                .borderRadius(Radius.SM)
            }
            .width('100%')
            .padding(Spacing.BASE)
            .backgroundColor(AppColors.BG_ELEVATED)
            .borderRadius(Radius.MD)
          }, (item: KnowledgeNode) => `${item.id}`)
        }
        .width('100%')
        .padding(Spacing.BASE)
        .layoutWeight(1)
      }
      .width('100%')
      .height(444)
      .backgroundColor(AppColors.BG_SURFACE)
      .borderRadius(24)
      .border({ width: 2, color: AppColors.BORDER })
      .clip(true)

      // 抽屉遮罩
      if (this.drawerOpen) {
        Column() {
          // 抽屉面板
          Column() {
            Row() {
              Text('☰')
                .fontSize(FontSize.XXL)
                .fontColor(AppColors.FG)
                .onClick(() => { this.drawerOpen = false })
                .padding(Spacing.XS)
              Text('导航菜单')
                .fontSize(FontSize.LG)
                .fontColor(AppColors.FG)
                .fontWeight(FontWeight.Bold)
                .margin({ left: Spacing.SM })
            }
            .width('100%')
            .height(48)
            .padding({ left: Spacing.BASE, right: Spacing.BASE })
            .alignItems(VerticalAlign.Center)

            Column({ space: Spacing.XS }) {
              ForEach(this.menuItems, (item: string, index?: number) => {
                Row() {
                  Text(`${(index ?? 0) + 1}`)
                    .fontSize(FontSize.XS)
                    .fontColor(AppColors.ACCENT)
                    .width(20)
                    .textAlign(TextAlign.Center)
                  Text(item)
                    .fontSize(FontSize.BASE)
                    .fontColor(AppColors.FG)
                    .margin({ left: Spacing.SM })
                  Blank()
                  Text('›')
                    .fontSize(FontSize.LG)
                    .fontColor(AppColors.FG_DIM)
                }
                .width('100%')
                .padding({ left: Spacing.BASE, right: Spacing.BASE, top: Spacing.SM, bottom: Spacing.SM })
                .borderRadius(Radius.SM)
                .backgroundColor(AppColors.BG_ELEVATED)
              }, (item: string, index?: number) => `${item}_${index}`)
            }
            .width('100%')
            .padding(Spacing.BASE)
          }
          .width('65%')
          .height('100%')
          .backgroundColor(AppColors.BG)
          .borderRadius({ topRight: Radius.XL, bottomRight: Radius.XL })
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .height(444)
        .alignItems(HorizontalAlign.Start)
        .onClick(() => { this.drawerOpen = false })
      }
    }
    .width('100%')
    .height(444)
    .borderRadius(24)
    .clip(true)
  }
}

// ─── L03 顶部Tab ───
@Component
export struct L03 {
  @State currentTab: number = 0
  private tabs: string[] = ['推荐', '进行中', '已完成']

  build() {
    Column() {
      StatusBar()
      // 导航栏
      Row() {
        Text('顶部Tab')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
        Blank()
        Text('⋮')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG_SECONDARY)
      }
      .width('100%')
      .height(36)
      .padding({ left: Spacing.BASE, right: Spacing.BASE })

      // Tab栏
      Row() {
        ForEach(this.tabs, (tab: string, index?: number) => {
          Column() {
            Text(tab)
              .fontSize(FontSize.BASE)
              .fontColor((index ?? 0) === this.currentTab ? AppColors.ACCENT : AppColors.FG_SECONDARY)
              .fontWeight((index ?? 0) === this.currentTab ? FontWeight.Bold : FontWeight.Normal)
            Row()
              .width(20)
              .height(2)
              .backgroundColor((index ?? 0) === this.currentTab ? AppColors.ACCENT : 'transparent')
              .borderRadius(1)
              .margin({ top: Spacing.XS })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
          .padding({ top: Spacing.SM, bottom: Spacing.SM })
          .onClick(() => { this.currentTab = index ?? 0 })
        }, (tab: string, index?: number) => `${tab}_${index}`)
      }
      .width('100%')
      .backgroundColor(AppColors.BG_ELEVATED)
      .borderRadius(Radius.MD)
      .margin({ left: Spacing.BASE, right: Spacing.BASE })

      // 内容
      Scroll() {
        Column({ space: Spacing.SM }) {
          if (this.currentTab === 0) {
            ForEach(KN_DATA.slice(0, 5), (item: KnowledgeNode) => {
              Row() {
                Column() {
                  Text(item.name)
                    .fontSize(FontSize.BASE)
                    .fontColor(AppColors.FG)
                  Text(item.cat)
                    .fontSize(FontSize.XS)
                    .fontColor(AppColors.FG_SECONDARY)
                    .margin({ top: 2 })
                }
                .alignItems(HorizontalAlign.Start)
                Blank()
                Text(`Lv.${item.lv}`)
                  .fontSize(FontSize.XS)
                  .fontColor(AppColors.ACCENT)
              }
              .width('100%')
              .padding(Spacing.BASE)
              .backgroundColor(AppColors.BG_ELEVATED)
              .borderRadius(Radius.MD)
            }, (item: KnowledgeNode) => `${item.id}`)
          } else if (this.currentTab === 1) {
            ForEach(KN_DATA.slice(3, 8), (item: KnowledgeNode) => {
              Row() {
                Row()
                  .width(8)
                  .height(8)
                  .borderRadius(4)
                  .backgroundColor(AppColors.ACCENT)
                Column() {
                  Text(item.name)
                    .fontSize(FontSize.BASE)
                    .fontColor(AppColors.FG)
                  Text('学习中...')
                    .fontSize(FontSize.XS)
                    .fontColor(AppColors.ACCENT)
                    .margin({ top: 2 })
                }
                .alignItems(HorizontalAlign.Start)
                .margin({ left: Spacing.SM })
                Blank()
                Text(`${item.lv * 20}%`)
                  .fontSize(FontSize.XS)
                  .fontColor(AppColors.FG_SECONDARY)
              }
              .width('100%')
              .padding(Spacing.BASE)
              .backgroundColor(AppColors.BG_ELEVATED)
              .borderRadius(Radius.MD)
            }, (item: KnowledgeNode) => `${item.id}`)
          } else {
            ForEach(KN_DATA.slice(6, 10), (item: KnowledgeNode) => {
              Row() {
                Text('✓')
                  .fontSize(FontSize.BASE)
                  .fontColor('#6AC48A')
                Column() {
                  Text(item.name)
                    .fontSize(FontSize.BASE)
                    .fontColor(AppColors.FG)
                  Text('已完成')
                    .fontSize(FontSize.XS)
                    .fontColor('#6AC48A')
                    .margin({ top: 2 })
                }
                .alignItems(HorizontalAlign.Start)
                .margin({ left: Spacing.SM })
                Blank()
              }
              .width('100%')
              .padding(Spacing.BASE)
              .backgroundColor(AppColors.BG_ELEVATED)
              .borderRadius(Radius.MD)
            }, (item: KnowledgeNode) => `${item.id}`)
          }
        }
        .padding(Spacing.BASE)
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height(444)
    .backgroundColor(AppColors.BG_SURFACE)
    .borderRadius(24)
    .border({ width: 2, color: AppColors.BORDER })
    .clip(true)
  }
}

// ─── L04 浮动球 ───
@Component
export struct L04 {
  @State fabExpanded: boolean = false

  build() {
    Stack() {
      Column() {
        StatusBar()
        // 导航栏
        Row() {
          Text('浮动球')
            .fontSize(FontSize.LG)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Bold)
          Blank()
          Text('⋮')
            .fontSize(FontSize.LG)
            .fontColor(AppColors.FG_SECONDARY)
        }
        .width('100%')
        .height(36)
        .padding({ left: Spacing.BASE, right: Spacing.BASE })

        // 主内容
        Column({ space: Spacing.SM }) {
          ForEach(KN_DATA.slice(0, 3), (item: KnowledgeNode) => {
            Row() {
              Column() {
                Text(item.name)
                  .fontSize(FontSize.BASE)
                  .fontColor(AppColors.FG)
                Text(item.cat)
                  .fontSize(FontSize.XS)
                  .fontColor(AppColors.FG_SECONDARY)
                  .margin({ top: 2 })
              }
              .alignItems(HorizontalAlign.Start)
              Blank()
              Text(`Lv.${item.lv}`)
                .fontSize(FontSize.XS)
                .fontColor(AppColors.ACCENT)
            }
            .width('100%')
            .padding(Spacing.BASE)
            .backgroundColor(AppColors.BG_ELEVATED)
            .borderRadius(Radius.MD)
          }, (item: KnowledgeNode) => `${item.id}`)
        }
        .width('100%')
        .padding(Spacing.BASE)
        .layoutWeight(1)
      }
      .width('100%')
      .height(444)
      .backgroundColor(AppColors.BG_SURFACE)
      .borderRadius(24)
      .border({ width: 2, color: AppColors.BORDER })
      .clip(true)

      // FAB 浮动按钮
      if (this.fabExpanded) {
        // 展开菜单
        Column({ space: Spacing.SM }) {
          ForEach(['新建学习', 'AI提问', '扫描导入'], (item: string, index?: number) => {
            Row() {
              Text(item)
                .fontSize(FontSize.SM)
                .fontColor(AppColors.FG)
                .margin({ right: Spacing.SM })
              Text(['✦', '◈', '⊞'][index ?? 0])
                .fontSize(FontSize.BASE)
                .fontColor(AppColors.ACCENT)
            }
            .padding({ left: Spacing.BASE, right: Spacing.BASE, top: Spacing.SM, bottom: Spacing.SM })
            .backgroundColor(AppColors.BG_ELEVATED)
            .borderRadius(Radius.MD)
            .border({ width: 1, color: AppColors.BORDER })
          }, (item: string, index?: number) => `${item}_${index}`)
        }
        .position({ x: '50%', y: 310 })
        .translate({ x: '-50%' })
        .zIndex(2)
      }

      // FAB主按钮
      Column() {
        Text(this.fabExpanded ? '✕' : '＋')
          .fontSize(22)
          .fontColor(AppColors.BG)
          .fontWeight(FontWeight.Bold)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor(AppColors.ACCENT)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .position({ x: '80%', y: 380 })
      .zIndex(3)
      .onClick(() => { this.fabExpanded = !this.fabExpanded })
      .shadow({ radius: 8, color: '#80C4A265', offsetY: 4 })
    }
    .width('100%')
    .height(444)
    .borderRadius(24)
    .clip(true)
  }
}

// ─── L05 手势滑动 ───
@Component
export struct L05 {
  @State currentCard: number = 0
  private cards: string[] = ['机器学习', '深度学习', '自然语言处理', '计算机视觉', '强化学习']

  build() {
    Column() {
      StatusBar()
      // 导航栏
      Row() {
        Text('手势滑动')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
        Blank()
        Text(`${this.currentCard + 1}/${this.cards.length}`)
          .fontSize(FontSize.SM)
          .fontColor(AppColors.FG_SECONDARY)
      }
      .width('100%')
      .height(36)
      .padding({ left: Spacing.BASE, right: Spacing.BASE })

      // 滑动卡片区域
      Stack() {
        ForEach(this.cards, (card: string, index?: number) => {
          Column() {
            Text(card)
              .fontSize(FontSize.XXL)
              .fontColor(AppColors.FG)
              .fontWeight(FontWeight.Bold)
            Text(KN_DATA[index ?? 0]?.cat ?? '')
              .fontSize(FontSize.SM)
              .fontColor(AppColors.FG_SECONDARY)
              .margin({ top: Spacing.XS })
            Row() {
              Text(`难度 Lv.${KN_DATA[index ?? 0]?.lv ?? 1}`)
                .fontSize(FontSize.XS)
                .fontColor(AppColors.ACCENT)
                .backgroundColor(AppColors.ACCENT_DIM)
                .padding({ left: Spacing.SM, right: Spacing.SM, top: 2, bottom: 2 })
                .borderRadius(Radius.SM)
            }
            .margin({ top: Spacing.BASE })
          }
          .width('80%')
          .height(240)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(AppColors.BG_ELEVATED)
          .borderRadius(Radius.XL)
          .border({ width: 1, color: AppColors.BORDER })
          .translate({ x: ((index ?? 0) - this.currentCard) * 260 })
          .opacity((index ?? 0) === this.currentCard ? 1 : 0.4)
          .scale({ x: (index ?? 0) === this.currentCard ? 1 : 0.9, y: (index ?? 0) === this.currentCard ? 1 : 0.9 })
          .animation({ duration: 300 })
        }, (card: string, index?: number) => `${card}_${index}`)
      }
      .width('100%')
      .layoutWeight(1)
      .alignContent(Alignment.Center)

      // 指示点
      Row({ space: Spacing.SM }) {
        ForEach(this.cards, (_: string, index?: number) => {
          Row()
            .width((index ?? 0) === this.currentCard ? 20 : 8)
            .height(8)
            .borderRadius(4)
            .backgroundColor((index ?? 0) === this.currentCard ? AppColors.ACCENT : AppColors.FG_DIM)
            .onClick(() => { this.currentCard = index ?? 0 })
        }, (_: string, index?: number) => `dot_${index}`)
      }
      .margin({ top: Spacing.BASE, bottom: Spacing.LG })

      // 左右切换按钮
      Row() {
        Row() {
          Text('‹')
            .fontSize(FontSize.XXL)
            .fontColor(AppColors.FG)
        }
        .width(36)
        .height(36)
        .borderRadius(18)
        .backgroundColor(AppColors.BG_ELEVATED)
        .justifyContent(FlexAlign.Center)
        .border({ width: 1, color: AppColors.BORDER })
        .onClick(() => { if (this.currentCard > 0) this.currentCard-- })

        Blank()

        Row() {
          Text('›')
            .fontSize(FontSize.XXL)
            .fontColor(AppColors.FG)
        }
        .width(36)
        .height(36)
        .borderRadius(18)
        .backgroundColor(AppColors.BG_ELEVATED)
        .justifyContent(FlexAlign.Center)
        .border({ width: 1, color: AppColors.BORDER })
        .onClick(() => { if (this.currentCard < this.cards.length - 1) this.currentCard++ })
      }
      .width('60%')
      .padding({ bottom: Spacing.BASE })
    }
    .width('100%')
    .height(444)
    .backgroundColor(AppColors.BG_SURFACE)
    .borderRadius(24)
    .border({ width: 2, color: AppColors.BORDER })
    .clip(true)
  }
}

// ─── L06 底部滚轮 ───
@Component
export struct L06 {
  @State selectedLevel: number = 2
  private levels: string[] = ['基础', '入门', '进阶', '高级', '专家']
  private levelColors: string[] = ['#6AC48A', '#6A9EC4', AppColors.ACCENT, '#C47A5A', AppColors.RED]

  build() {
    Column() {
      StatusBar()
      // 导航栏
      Row() {
        Text('底部滚轮')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
        Blank()
        Text('确认')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.ACCENT)
      }
      .width('100%')
      .height(36)
      .padding({ left: Spacing.BASE, right: Spacing.BASE })

      // 当前选择展示
      Column() {
        Text('选择难度等级')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.FG_SECONDARY)
        Text(this.levels[this.selectedLevel])
          .fontSize(FontSize.XXXL)
          .fontColor(this.levelColors[this.selectedLevel])
          .fontWeight(FontWeight.Bold)
          .margin({ top: Spacing.SM })
        Text(`适合 ${['初学者', '有基础', '有经验', '资深者', '大师'][this.selectedLevel]}`)
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_DIM)
          .margin({ top: Spacing.XS })
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      // 滚轮选择器
      Column() {
        Row() {
          ForEach(this.levels, (level: string, index?: number) => {
            Column() {
              Text(level)
                .fontSize((index ?? 0) === this.selectedLevel ? FontSize.LG : FontSize.SM)
                .fontColor((index ?? 0) === this.selectedLevel ? this.levelColors[index ?? 0] : AppColors.FG_DIM)
                .fontWeight((index ?? 0) === this.selectedLevel ? FontWeight.Bold : FontWeight.Normal)
              if ((index ?? 0) === this.selectedLevel) {
                Row()
                  .width(24)
                  .height(2)
                  .backgroundColor(this.levelColors[index ?? 0])
                  .borderRadius(1)
                  .margin({ top: Spacing.XS })
              }
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .padding({ top: Spacing.SM, bottom: Spacing.SM })
            .onClick(() => { this.selectedLevel = index ?? 0 })
          }, (level: string, index?: number) => `${level}_${index}`)
        }
        .width('100%')
        .height(60)
        .backgroundColor(AppColors.BG_ELEVATED)
        .borderRadius(Radius.LG)
        .padding({ left: Spacing.XS, right: Spacing.XS })
      }
      .width('100%')
      .padding(Spacing.BASE)
    }
    .width('100%')
    .height(444)
    .backgroundColor(AppColors.BG_SURFACE)
    .borderRadius(24)
    .border({ width: 2, color: AppColors.BORDER })
    .clip(true)
  }
}

// ─── L07 双栏分屏 ───
@Component
export struct L07 {
  @State selectedCat: number = 0
  private categories: string[] = ['AI基础', '编程', '数学', 'NLP', 'CV', '框架']

  build() {
    Column() {
      StatusBar()
      // 导航栏
      Row() {
        Text('双栏分屏')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
        Blank()
      }
      .width('100%')
      .height(36)
      .padding({ left: Spacing.BASE, right: Spacing.BASE })

      // 双栏内容
      Row() {
        // 左侧分类列表
        Column({ space: 2 }) {
          ForEach(this.categories, (cat: string, index?: number) => {
            Row() {
              if ((index ?? 0) === this.selectedCat) {
                Row()
                  .width(3)
                  .height(16)
                  .backgroundColor(AppColors.ACCENT)
                  .borderRadius(2)
                  .margin({ right: Spacing.SM })
              }
              Text(cat)
                .fontSize(FontSize.SM)
                .fontColor((index ?? 0) === this.selectedCat ? AppColors.ACCENT : AppColors.FG_SECONDARY)
                .fontWeight((index ?? 0) === this.selectedCat ? FontWeight.Bold : FontWeight.Normal)
            }
            .width('100%')
            .padding({ left: Spacing.SM, right: Spacing.SM, top: Spacing.SM, bottom: Spacing.SM })
            .backgroundColor((index ?? 0) === this.selectedCat ? AppColors.BG_ELEVATED : 'transparent')
            .borderRadius(Radius.SM)
            .onClick(() => { this.selectedCat = index ?? 0 })
          }, (cat: string, index?: number) => `${cat}_${index}`)
        }
        .width('35%')
        .height('100%')
        .backgroundColor(AppColors.BG)
        .padding({ top: Spacing.SM })
        .borderRadius(Radius.MD)

        // 右侧详情
        Column({ space: Spacing.SM }) {
          Text(this.categories[this.selectedCat])
            .fontSize(FontSize.LG)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Bold)
            .width('100%')

          ForEach(
            KN_DATA.filter((item: KnowledgeNode) => item.cat === this.categories[this.selectedCat]),
            (item: KnowledgeNode) => {
              Row() {
                Column() {
                  Text(item.name)
                    .fontSize(FontSize.BASE)
                    .fontColor(AppColors.FG)
                  Text(`等级 ${item.lv}`)
                    .fontSize(FontSize.XS)
                    .fontColor(AppColors.FG_SECONDARY)
                    .margin({ top: 2 })
                }
                .alignItems(HorizontalAlign.Start)
                Blank()
                Row()
                  .width(6)
                  .height(6)
                  .borderRadius(3)
                  .backgroundColor(AppColors.ACCENT)
              }
              .width('100%')
              .padding(Spacing.SM)
              .backgroundColor(AppColors.BG_ELEVATED)
              .borderRadius(Radius.SM)
            },
            (item: KnowledgeNode) => `${item.id}`
          )
        }
        .layoutWeight(1)
        .height('100%')
        .padding(Spacing.SM)
      }
      .layoutWeight(1)
      .padding({ left: Spacing.BASE, right: Spacing.BASE, bottom: Spacing.BASE })
    }
    .width('100%')
    .height(444)
    .backgroundColor(AppColors.BG_SURFACE)
    .borderRadius(24)
    .border({ width: 2, color: AppColors.BORDER })
    .clip(true)
  }
}

// ─── L08 环形菜单 ───
@Component
export struct L08 {
  @State menuOpen: boolean = false
  @State selectedItem: number = -1
  private menuItems: string[] = ['学习', '图谱', 'AI', '设置', '统计', '收藏']

  build() {
    Column() {
      StatusBar()
      // 导航栏
      Row() {
        Text('环形菜单')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
        Blank()
      }
      .width('100%')
      .height(36)
      .padding({ left: Spacing.BASE, right: Spacing.BASE })

      // 环形菜单区域
      Stack() {
        // 环形菜单项
        if (this.menuOpen) {
          ForEach(this.menuItems, (item: string, index?: number) => {
            Column() {
              Text(['▤', '◉', '◈', '⚙', '▣', '★'][index ?? 0])
                .fontSize(16)
              Text(item)
                .fontSize(FontSize.XS)
                .fontColor((index ?? 0) === this.selectedItem ? AppColors.ACCENT : AppColors.FG)
                .margin({ top: 2 })
            }
            .width(56)
            .height(56)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .backgroundColor((index ?? 0) === this.selectedItem ? AppColors.ACCENT_DIM : AppColors.BG_ELEVATED)
            .borderRadius(28)
            .border({ width: 1, color: (index ?? 0) === this.selectedItem ? AppColors.ACCENT : AppColors.BORDER })
            .position({
              x: 120 + 90 * Math.cos(((index ?? 0) * 60 - 90) * Math.PI / 180) - 28,
              y: 100 + 90 * Math.sin(((index ?? 0) * 60 - 90) * Math.PI / 180) - 28
            })
            .onClick(() => { this.selectedItem = index ?? 0 })
          }, (item: string, index?: number) => `${item}_${index}`)
        }

        // 中心按钮
        Column() {
          Text(this.menuOpen ? '✕' : '◈')
            .fontSize(24)
            .fontColor(AppColors.BG)
        }
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor(AppColors.ACCENT)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .shadow({ radius: 12, color: '#80C4A265', offsetY: 4 })
        .position({ x: 120 - 28, y: 100 - 28 })
        .onClick(() => { this.menuOpen = !this.menuOpen })
      }
      .width('100%')
      .height(200)
      .alignContent(Alignment.Center)

      // 选中项信息
      Column() {
        if (this.selectedItem >= 0) {
          Text(this.menuItems[this.selectedItem])
            .fontSize(FontSize.XXL)
            .fontColor(AppColors.ACCENT)
            .fontWeight(FontWeight.Bold)
          Text(`已选择: ${this.menuItems[this.selectedItem]}功能模块`)
            .fontSize(FontSize.SM)
            .fontColor(AppColors.FG_SECONDARY)
            .margin({ top: Spacing.XS })
        } else {
          Text('点击中心按钮展开菜单')
            .fontSize(FontSize.BASE)
            .fontColor(AppColors.FG_DIM)
        }
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height(444)
    .backgroundColor(AppColors.BG_SURFACE)
    .borderRadius(24)
    .border({ width: 2, color: AppColors.BORDER })
    .clip(true)
  }
}

// ─── L09 卡片堆叠 ───
@Component
export struct L09 {
  @State topCard: number = 0

  build() {
    Column() {
      StatusBar()
      // 导航栏
      Row() {
        Text('卡片堆叠')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
        Blank()
        Text('重置')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.ACCENT)
          .onClick(() => { this.topCard = 0 })
      }
      .width('100%')
      .height(36)
      .padding({ left: Spacing.BASE, right: Spacing.BASE })

      // 堆叠卡片
      Stack() {
        ForEach(KN_DATA.slice(0, 5), (item: KnowledgeNode, index?: number) => {
          Column() {
            Text(item.name)
              .fontSize(FontSize.XXL)
              .fontColor(AppColors.FG)
              .fontWeight(FontWeight.Bold)
            Text(item.cat)
              .fontSize(FontSize.SM)
              .fontColor(AppColors.FG_SECONDARY)
              .margin({ top: Spacing.XS })
            Row() {
              ForEach([1, 2, 3, 4, 5], (star: number) => {
                Text(star <= item.lv ? '★' : '☆')
                  .fontSize(FontSize.SM)
                  .fontColor(star <= item.lv ? AppColors.ACCENT : AppColors.FG_DIM)
              }, (star: number) => `star_${star}`)
            }
            .margin({ top: Spacing.BASE })
          }
          .width('75%')
          .height(200)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(AppColors.BG_ELEVATED)
          .borderRadius(Radius.XL)
          .border({ width: 1, color: AppColors.BORDER })
          .translate({
            x: ((index ?? 0) - this.topCard) * 8,
            y: -((index ?? 0) < this.topCard ? 0 : ((index ?? 0) - this.topCard) * 8)
          })
          .zIndex(5 - (index ?? 0))
          .opacity((index ?? 0) < this.topCard ? 0 : 1)
          .onClick(() => { this.topCard = index ?? 0 })
          .animation({ duration: 300 })
        }, (item: KnowledgeNode) => `${item.id}`)
      }
      .width('100%')
      .layoutWeight(1)
      .alignContent(Alignment.Center)

      // 底部信息
      Row() {
        Text(`${this.topCard + 1} / ${KN_DATA.slice(0, 5).length}`)
          .fontSize(FontSize.SM)
          .fontColor(AppColors.FG_SECONDARY)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ bottom: Spacing.LG })
    }
    .width('100%')
    .height(444)
    .backgroundColor(AppColors.BG_SURFACE)
    .borderRadius(24)
    .border({ width: 2, color: AppColors.BORDER })
    .clip(true)
  }
}

// ─── L10 全屏沉浸 ───
@Component
export struct L10 {
  @State menuVisible: boolean = false
  @State currentNode: number = 0

  build() {
    Stack() {
      // 全屏内容
      Column() {
        // 沉浸式顶部
        Column() {
          Text(KN_DATA[this.currentNode]?.name ?? '机器学习')
            .fontSize(FontSize.XXXL)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Bold)
          Text(KN_DATA[this.currentNode]?.cat ?? 'AI基础')
            .fontSize(FontSize.BASE)
            .fontColor(AppColors.ACCENT)
            .margin({ top: Spacing.XS })
          Text(`难度等级 ${'★'.repeat(KN_DATA[this.currentNode]?.lv ?? 1)}${'☆'.repeat(5 - (KN_DATA[this.currentNode]?.lv ?? 1))}`)
            .fontSize(FontSize.SM)
            .fontColor(AppColors.FG_SECONDARY)
            .margin({ top: Spacing.SM })
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        // 底部简洁导航
        Row() {
          Text('‹')
            .fontSize(FontSize.XXL)
            .fontColor(AppColors.FG_SECONDARY)
            .padding(Spacing.SM)
            .onClick(() => { if (this.currentNode > 0) this.currentNode-- })
          Row()
            .width(40)
            .height(3)
            .backgroundColor(AppColors.ACCENT)
            .borderRadius(2)
          Text('›')
            .fontSize(FontSize.XXL)
            .fontColor(AppColors.FG_SECONDARY)
            .padding(Spacing.SM)
            .onClick(() => { if (this.currentNode < KN_DATA.length - 1) this.currentNode++ })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .padding({ bottom: Spacing.XL })
      }
      .width('100%')
      .height(444)
      .backgroundColor(AppColors.BG_SURFACE)
      .borderRadius(24)
      .border({ width: 2, color: AppColors.BORDER })
      .clip(true)

      // 浮动菜单按钮
      Column() {
        Text('☰')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
      }
      .width(36)
      .height(36)
      .borderRadius(18)
      .backgroundColor(AppColors.BG_ELEVATED)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .border({ width: 1, color: AppColors.BORDER })
      .position({ x: 12, y: 32 })
      .zIndex(2)
      .onClick(() => { this.menuVisible = !this.menuVisible })

      // 浮动菜单
      if (this.menuVisible) {
        Column({ space: 2 }) {
          ForEach(['首页', '图谱', 'AI导师', '设置'], (item: string) => {
            Text(item)
              .fontSize(FontSize.SM)
              .fontColor(AppColors.FG)
              .padding({ left: Spacing.BASE, right: Spacing.LG, top: Spacing.SM, bottom: Spacing.SM })
              .width('100%')
              .backgroundColor(AppColors.BG_ELEVATED)
              .borderRadius(Radius.SM)
          }, (item: string) => item)
        }
        .width(100)
        .backgroundColor(AppColors.BG)
        .borderRadius(Radius.MD)
        .border({ width: 1, color: AppColors.BORDER })
        .position({ x: 12, y: 72 })
        .zIndex(3)
      }
    }
    .width('100%')
    .height(444)
    .borderRadius(24)
    .clip(true)
  }
}
