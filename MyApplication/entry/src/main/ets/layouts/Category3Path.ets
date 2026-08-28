// 学习路径布局组件 (L21-L30)
import { AppColors, FontSize, Radius, Spacing } from '../common/Constants'
import { KN_DATA, PositionNode, CircuitNode, TreeVisNode, ChapterItem } from './LayoutTypes'

// ─── 通用状态栏 ───
@Builder
function StatusBar() {
  Row() {
    Text('9:41')
      .fontSize(FontSize.SM)
      .fontColor(AppColors.FG_SECONDARY)
      .fontWeight(FontWeight.Medium)
    Blank()
    Text('●●● ◗ ▂')
      .fontSize(FontSize.XS)
      .fontColor(AppColors.FG_SECONDARY)
  }
  .width('100%')
  .height(28)
  .padding({ left: 16, right: 16 })
  .justifyContent(FlexAlign.SpaceBetween)
  .alignItems(VerticalAlign.Center)
}

// ─── 通用导航栏 ───
@Builder
function NavBar(title: string) {
  Row() {
    Text('←')
      .fontSize(18)
      .fontColor(AppColors.FG_SECONDARY)
      .padding({ left: 4, right: 8, top: 4, bottom: 4 })
    Text(title)
      .fontSize(FontSize.LG)
      .fontColor(AppColors.FG)
      .fontWeight(FontWeight.Bold)
      .layoutWeight(1)
      .margin({ left: 4 })
  }
  .width('100%')
  .height(44)
  .padding({ left: 12, right: 16 })
  .alignItems(VerticalAlign.Center)
}

// ═══════════════════════════════════════════════
// L21 - 垂直时间线
// ═══════════════════════════════════════════════
@Component
export struct L21 {
  @State currentStep: number = 3

  private steps: string[] = ['线性代数', '概率统计', 'Python基础', '机器学习', '深度学习', 'NLP']

  build() {
    Column() {
      StatusBar()
      NavBar('垂直时间线')

      Scroll() {
        Column() {
          ForEach(this.steps, (step: string, index: number) => {
            Row() {
              // 时间线指示器
              Column() {
                if (index < this.currentStep) {
                  // 已完成
                  Circle()
                    .width(24)
                    .height(24)
                    .fill(AppColors.ACCENT)
                    .stroke(Color.Transparent)
                  Text('✓')
                    .fontSize(FontSize.XS)
                    .fontColor(AppColors.BG)
                    .fontWeight(FontWeight.Bold)
                    .position({ x: 6, y: 4 })
                } else if (index === this.currentStep) {
                  // 当前步骤
                  Circle()
                    .width(24)
                    .height(24)
                    .fill(Color.Transparent)
                    .stroke(AppColors.ACCENT)
                    .strokeWidth(2.5)
                  Circle()
                    .width(10)
                    .height(10)
                    .fill(AppColors.ACCENT)
                    .position({ x: 7, y: 7 })
                } else {
                  // 未完成
                  Circle()
                    .width(24)
                    .height(24)
                    .fill(Color.Transparent)
                    .stroke(AppColors.FG_DIM)
                    .strokeWidth(1.5)
                }

                if (index < this.steps.length - 1) {
                  Row()
                    .width(2)
                    .height(32)
                    .backgroundColor(index < this.currentStep ? AppColors.ACCENT : AppColors.BORDER)
                }
              }
              .alignItems(HorizontalAlign.Center)
              .margin({ right: Spacing.MD })

              // 步骤内容
              Column() {
                Text(step)
                  .fontSize(FontSize.BASE)
                  .fontColor(index <= this.currentStep ? AppColors.FG : AppColors.FG_DIM)
                  .fontWeight(index === this.currentStep ? FontWeight.Bold : FontWeight.Medium)

                Text(index < this.currentStep ? '已完成' : index === this.currentStep ? '学习中' : '待解锁')
                  .fontSize(FontSize.XS)
                  .fontColor(index < this.currentStep ? AppColors.ACCENT :
                             index === this.currentStep ? AppColors.WARM : AppColors.FG_DIM)
                  .margin({ top: 2 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)
            .onClick(() => {
              if (index <= this.currentStep + 1) {
                this.currentStep = index
              }
            })
          }, (step: string) => step)
        }
        .width('100%')
        .padding({ left: Spacing.LG, right: Spacing.LG, top: Spacing.BASE })
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

// ═══════════════════════════════════════════════
// L22 - 水平进度
// ═══════════════════════════════════════════════
@Component
export struct L22 {
  @State currentStep: number = 2

  private steps: string[] = ['基础', '入门', '进阶', '高级', '专家']

  build() {
    Column() {
      StatusBar()
      NavBar('水平进度')

      Column() {
        // 步骤指示器
        Row() {
          ForEach(this.steps, (step: string, index: number) => {
            Row() {
              // 连接线（左侧）
              if (index > 0) {
                Row()
                  .width(20)
                  .height(2)
                  .backgroundColor(index <= this.currentStep ? AppColors.ACCENT : AppColors.BORDER)
              }

              // 圆形节点
              Stack() {
                Circle()
                  .width(index === this.currentStep ? 28 : 22)
                  .height(index === this.currentStep ? 28 : 22)
                  .fill(index < this.currentStep ? AppColors.ACCENT :
                        index === this.currentStep ? Color.Transparent : Color.Transparent)
                  .stroke(index <= this.currentStep ? AppColors.ACCENT : AppColors.FG_DIM)
                  .strokeWidth(index === this.currentStep ? 2.5 : 1.5)

                if (index < this.currentStep) {
                  Text('✓')
                    .fontSize(FontSize.XS)
                    .fontColor(AppColors.BG)
                    .fontWeight(FontWeight.Bold)
                } else if (index === this.currentStep) {
                  Circle()
                    .width(10)
                    .height(10)
                    .fill(AppColors.ACCENT)
                }
              }
              .alignContent(Alignment.Center)

              // 连接线（右侧）
              if (index < this.steps.length - 1) {
                Row()
                  .width(20)
                  .height(2)
                  .backgroundColor(index < this.currentStep ? AppColors.ACCENT : AppColors.BORDER)
              }
            }
            .alignItems(VerticalAlign.Center)
          }, (step: string) => step)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ top: Spacing.XL })

        // 步骤标签
        Row() {
          ForEach(this.steps, (step: string, index: number) => {
            Text(step)
              .fontSize(FontSize.XS)
              .fontColor(index <= this.currentStep ? AppColors.FG : AppColors.FG_DIM)
              .fontWeight(index === this.currentStep ? FontWeight.Bold : FontWeight.Normal)
              .layoutWeight(1)
              .textAlign(TextAlign.Center)
          }, (step: string) => step)
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: Spacing.SM })

        // 当前步骤描述
        Column() {
          Text(this.steps[this.currentStep] + '阶段')
            .fontSize(FontSize.XL)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Bold)

          Text(`当前进度: ${this.currentStep + 1}/${this.steps.length}`)
            .fontSize(FontSize.SM)
            .fontColor(AppColors.FG_SECONDARY)
            .margin({ top: Spacing.XS })

          // 进度条
          Progress({ value: this.currentStep + 1, total: this.steps.length, type: ProgressType.Linear })
            .width('100%')
            .height(4)
            .color(AppColors.ACCENT)
            .backgroundColor(AppColors.BG_HOVER)
            .borderRadius(2)
            .margin({ top: Spacing.MD })
        }
        .width('100%')
        .padding({ left: Spacing.LG, right: Spacing.LG, top: Spacing.XL })
        .alignItems(HorizontalAlign.Start)
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

// ═══════════════════════════════════════════════
// L23 - 地图路线
// ═══════════════════════════════════════════════
@Component
export struct L23 {
  @State selectedWaypoint: number = -1

  private waypoints: PositionNode[] = [
    { x: 40, y: 280, name: '起点' },
    { x: 100, y: 220, name: '基础' },
    { x: 160, y: 180, name: '进阶' },
    { x: 220, y: 130, name: '高级' },
    { x: 290, y: 80, name: '专家' }
  ]

  build() {
    Column() {
      StatusBar()
      NavBar('地图路线')

      Stack() {
        Canvas(this.waypoints.length > 0 ? this.createCanvasContext() : undefined)
          .width('100%')
          .height(300)
          .onReady(() => {
            this.drawMapPath()
          })

        // 可点击的航点
        ForEach(this.waypoints, (wp: PositionNode, index: number) => {
          Column() {
            Circle()
              .width(this.selectedWaypoint === index ? 20 : 14)
              .height(this.selectedWaypoint === index ? 20 : 14)
              .fill(this.selectedWaypoint === index ? AppColors.ACCENT : AppColors.BG_ELEVATED)
              .stroke(AppColors.ACCENT)
              .strokeWidth(2)

            Text(wp.name)
              .fontSize(FontSize.XS)
              .fontColor(this.selectedWaypoint === index ? AppColors.ACCENT : AppColors.FG_SECONDARY)
              .margin({ top: 2 })
          }
          .position({ x: wp.x - 10, y: wp.y - 10 })
          .onClick(() => {
            this.selectedWaypoint = this.selectedWaypoint === index ? -1 : index
          })
        }, (wp: PositionNode, index: number) => `${index}`)
      }
      .width('100%')
      .layoutWeight(1)

      // 选中航点信息
      if (this.selectedWaypoint >= 0) {
        Row() {
          Text(this.waypoints[this.selectedWaypoint].name)
            .fontSize(FontSize.BASE)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Medium)

          Text('点击查看详情 →')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.ACCENT)
            .margin({ left: Spacing.SM })
        }
        .width('100%')
        .padding({ left: Spacing.LG, right: Spacing.LG, top: Spacing.SM, bottom: Spacing.MD })
        .backgroundColor(AppColors.BG_ELEVATED)
      }
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private createCanvasContext(): CanvasRenderingContext2D {
    return this.context
  }

  private drawMapPath() {
    const ctx = this.context
    ctx.clearRect(0, 0, 360, 300)

    // 绘制曲线路径
    ctx.beginPath()
    ctx.moveTo(40, 280)
    ctx.bezierCurveTo(60, 240, 80, 230, 100, 220)
    ctx.bezierCurveTo(120, 210, 140, 190, 160, 180)
    ctx.bezierCurveTo(180, 170, 200, 150, 220, 130)
    ctx.bezierCurveTo(240, 110, 270, 90, 290, 80)
    ctx.strokeStyle = AppColors.ACCENT
    ctx.lineWidth = 2.5
    ctx.setLineDash([8, 4])
    ctx.stroke()
    ctx.setLineDash([])

    // 绘制底部装饰点
    for (let i = 0; i < 8; i++) {
      ctx.beginPath()
      ctx.arc(30 + Math.random() * 300, 60 + Math.random() * 220, 1, 0, Math.PI * 2)
      ctx.fillStyle = AppColors.FG_DIM
      ctx.fill()
    }
  }
}

// ═══════════════════════════════════════════════
// L24 - 棋盘格路径
// ═══════════════════════════════════════════════
@Component
export struct L24 {
  @State completedCells: number = 5
  @State selectedCell: number = -1

  private gridLabels: string[] = [
    '1-1', '1-2', '1-3', '1-4',
    '2-1', '2-2', '2-3', '2-4',
    '3-1', '3-2', '3-3', '3-4',
    '4-1', '4-2', '4-3', '4-4'
  ]

  build() {
    Column() {
      StatusBar()
      NavBar('棋盘格路径')

      Text('完成学习解锁下一格')
        .fontSize(FontSize.XS)
        .fontColor(AppColors.FG_SECONDARY)
        .padding({ left: Spacing.LG, right: Spacing.LG, top: Spacing.SM })

      // 4x4 网格
      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Center }) {
        ForEach(this.gridLabels, (label: string, index: number) => {
          Column() {
            if (index < this.completedCells) {
              // 已完成
              Text('✓')
                .fontSize(FontSize.LG)
                .fontColor(AppColors.ACCENT)
                .fontWeight(FontWeight.Bold)
            } else if (index === this.completedCells) {
              // 当前
              Text('▶')
                .fontSize(FontSize.SM)
                .fontColor(AppColors.ACCENT)
            } else {
              // 锁定
              Text(`Lv${index + 1}`)
                .fontSize(FontSize.XS)
                .fontColor(AppColors.FG_DIM)
            }

            Text(label)
              .fontSize(FontSize.XS)
              .fontColor(index < this.completedCells ? AppColors.FG :
                         index === this.completedCells ? AppColors.ACCENT : AppColors.FG_DIM)
              .margin({ top: 2 })
          }
          .width(72)
          .height(72)
          .margin(4)
          .borderRadius(Radius.MD)
          .backgroundColor(this.selectedCell === index ? AppColors.BG_HOVER :
                           index < this.completedCells ? AppColors.BG_ELEVATED :
                           index === this.completedCells ? '#1E1E1B' : AppColors.BG_SURFACE)
          .border({
            width: this.selectedCell === index ? 2 : 1,
            color: this.selectedCell === index ? AppColors.ACCENT :
                   index === this.completedCells ? AppColors.ACCENT : AppColors.BORDER
          })
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            if (index <= this.completedCells) {
              this.selectedCell = this.selectedCell === index ? -1 : index
            }
          })
        }, (label: string) => label)
      }
      .width('100%')
      .padding({ left: Spacing.MD, right: Spacing.MD, top: Spacing.BASE })

      // 进度信息
      Row() {
        Text(`${this.completedCells}/16 已完成`)
          .fontSize(FontSize.SM)
          .fontColor(AppColors.FG_SECONDARY)
        Blank()
        Text('继续 →')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.ACCENT)
      }
      .width('100%')
      .padding({ left: Spacing.LG, right: Spacing.LG, top: Spacing.MD })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ═══════════════════════════════════════════════
// L25 - 阶梯上升
// ═══════════════════════════════════════════════
@Component
export struct L25 {
  @State currentStep: number = 2

  private steps: string[] = ['基础入门', '概念理解', '实践应用', '深入掌握', '融会贯通']

  build() {
    Column() {
      StatusBar()
      NavBar('阶梯上升')

      Scroll() {
        Column() {
          ForEach(this.steps, (step: string, index: number) => {
            Row() {
              // 缩进形成阶梯
              Row()
                .width(index * 32)
                .height(1)

              Column() {
                Row() {
                  // 步骤指示
                  Stack() {
                    Row()
                      .width(28)
                      .height(28)
                      .borderRadius(6)
                      .backgroundColor(index < this.currentStep ? AppColors.ACCENT :
                                       index === this.currentStep ? AppColors.BG_HOVER : AppColors.BG_ELEVATED)
                      .border({
                        width: index === this.currentStep ? 2 : 0,
                        color: index === this.currentStep ? AppColors.ACCENT : Color.Transparent
                      })

                    if (index < this.currentStep) {
                      Text('✓')
                        .fontSize(FontSize.XS)
                        .fontColor(AppColors.BG)
                        .fontWeight(FontWeight.Bold)
                    } else {
                      Text(`${index + 1}`)
                        .fontSize(FontSize.XS)
                        .fontColor(index === this.currentStep ? AppColors.ACCENT : AppColors.FG_DIM)
                        .fontWeight(FontWeight.Bold)
                    }
                  }
                  .width(28)
                  .height(28)
                  .alignContent(Alignment.Center)
                  .margin({ right: Spacing.MD })

                  Text(step)
                    .fontSize(FontSize.BASE)
                    .fontColor(index <= this.currentStep ? AppColors.FG : AppColors.FG_DIM)
                    .fontWeight(index === this.currentStep ? FontWeight.Bold : FontWeight.Medium)
                    .layoutWeight(1)
                }
                .width('100%')
                .alignItems(VerticalAlign.Center)
              }
              .layoutWeight(1)
              .padding(Spacing.MD)
              .borderRadius(Radius.LG)
              .backgroundColor(index === this.currentStep ? AppColors.BG_ELEVATED : AppColors.BG_SURFACE)
              .border({
                width: index === this.currentStep ? 1.5 : 0.5,
                color: index === this.currentStep ? AppColors.ACCENT : AppColors.BORDER
              })
            }
            .width('100%')
            .margin({ bottom: Spacing.XS })
            .onClick(() => {
              if (index <= this.currentStep + 1) {
                this.currentStep = index
              }
            })
          }, (step: string) => step)
        }
        .width('100%')
        .padding({ left: Spacing.LG, right: Spacing.LG, top: Spacing.BASE })
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

// ═══════════════════════════════════════════════
// L26 - 河流分支
// ═══════════════════════════════════════════════
@Component
export struct L26 {
  @State selectedBranch: number = -1

  private branches: string[] = ['机器学习', '深度学习', 'NLP', 'CV']

  build() {
    Column() {
      StatusBar()
      NavBar('河流分支')

      Stack() {
        Canvas(this.branches.length > 0 ? this.createCanvasContext() : undefined)
          .width('100%')
          .height(300)
          .onReady(() => {
            this.drawRiverBranch()
          })

        // 分支节点
        // 中心节点
        Column() {
          Text('AI基础')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Bold)
        }
        .width(56)
        .height(32)
        .borderRadius(Radius.MD)
        .backgroundColor(AppColors.BG_ELEVATED)
        .border({ width: 1.5, color: AppColors.ACCENT })
        .justifyContent(FlexAlign.Center)
        .position({ x: 130, y: 230 })

        // 左分支 - 机器学习
        Column() {
          Text('机器学习')
            .fontSize(FontSize.XS)
            .fontColor(this.selectedBranch === 0 ? AppColors.ACCENT : AppColors.FG_SECONDARY)
        }
        .width(56)
        .height(28)
        .borderRadius(Radius.SM)
        .backgroundColor(this.selectedBranch === 0 ? AppColors.BG_HOVER : AppColors.BG_ELEVATED)
        .border({ width: this.selectedBranch === 0 ? 1.5 : 1, color: this.selectedBranch === 0 ? AppColors.ACCENT : AppColors.BORDER })
        .justifyContent(FlexAlign.Center)
        .position({ x: 30, y: 130 })
        .onClick(() => { this.selectedBranch = this.selectedBranch === 0 ? -1 : 0 })

        // 右分支 - 深度学习
        Column() {
          Text('深度学习')
            .fontSize(FontSize.XS)
            .fontColor(this.selectedBranch === 1 ? AppColors.ACCENT : AppColors.FG_SECONDARY)
        }
        .width(56)
        .height(28)
        .borderRadius(Radius.SM)
        .backgroundColor(this.selectedBranch === 1 ? AppColors.BG_HOVER : AppColors.BG_ELEVATED)
        .border({ width: this.selectedBranch === 1 ? 1.5 : 1, color: this.selectedBranch === 1 ? AppColors.ACCENT : AppColors.BORDER })
        .justifyContent(FlexAlign.Center)
        .position({ x: 230, y: 130 })
        .onClick(() => { this.selectedBranch = this.selectedBranch === 1 ? -1 : 1 })

        // 左上 - NLP
        Column() {
          Text('NLP')
            .fontSize(FontSize.XS)
            .fontColor(this.selectedBranch === 2 ? AppColors.ACCENT : AppColors.FG_SECONDARY)
        }
        .width(44)
        .height(28)
        .borderRadius(Radius.SM)
        .backgroundColor(this.selectedBranch === 2 ? AppColors.BG_HOVER : AppColors.BG_ELEVATED)
        .border({ width: this.selectedBranch === 2 ? 1.5 : 1, color: this.selectedBranch === 2 ? AppColors.ACCENT : AppColors.BORDER })
        .justifyContent(FlexAlign.Center)
        .position({ x: 50, y: 40 })
        .onClick(() => { this.selectedBranch = this.selectedBranch === 2 ? -1 : 2 })

        // 右上 - CV
        Column() {
          Text('CV')
            .fontSize(FontSize.XS)
            .fontColor(this.selectedBranch === 3 ? AppColors.ACCENT : AppColors.FG_SECONDARY)
        }
        .width(44)
        .height(28)
        .borderRadius(Radius.SM)
        .backgroundColor(this.selectedBranch === 3 ? AppColors.BG_HOVER : AppColors.BG_ELEVATED)
        .border({ width: this.selectedBranch === 3 ? 1.5 : 1, color: this.selectedBranch === 3 ? AppColors.ACCENT : AppColors.BORDER })
        .justifyContent(FlexAlign.Center)
        .position({ x: 240, y: 40 })
        .onClick(() => { this.selectedBranch = this.selectedBranch === 3 ? -1 : 3 })
      }
      .width('100%')
      .layoutWeight(1)

      // 选中分支信息
      if (this.selectedBranch >= 0) {
        Row() {
          Text(this.branches[this.selectedBranch])
            .fontSize(FontSize.BASE)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Medium)
          Blank()
          Text('探索 →')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.ACCENT)
        }
        .width('100%')
        .padding({ left: Spacing.LG, right: Spacing.LG, top: Spacing.SM, bottom: Spacing.MD })
        .backgroundColor(AppColors.BG_ELEVATED)
      }
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private createCanvasContext(): CanvasRenderingContext2D {
    return this.context
  }

  private drawRiverBranch() {
    const ctx = this.context
    ctx.clearRect(0, 0, 360, 300)

    // 主干河流（底部到中心）
    ctx.beginPath()
    ctx.moveTo(158, 300)
    ctx.bezierCurveTo(158, 270, 158, 250, 158, 246)
    ctx.strokeStyle = AppColors.ACCENT
    ctx.lineWidth = 3
    ctx.stroke()

    // 左分支（中心到机器学习）
    ctx.beginPath()
    ctx.moveTo(130, 230)
    ctx.bezierCurveTo(110, 200, 80, 170, 58, 144)
    ctx.strokeStyle = this.selectedBranch === 0 ? AppColors.ACCENT : AppColors.ACCENT_DIM
    ctx.lineWidth = 2
    ctx.stroke()

    // 右分支（中心到深度学习）
    ctx.beginPath()
    ctx.moveTo(186, 230)
    ctx.bezierCurveTo(206, 200, 236, 170, 258, 144)
    ctx.strokeStyle = this.selectedBranch === 1 ? AppColors.ACCENT : AppColors.ACCENT_DIM
    ctx.lineWidth = 2
    ctx.stroke()

    // 机器学习到NLP
    ctx.beginPath()
    ctx.moveTo(58, 130)
    ctx.bezierCurveTo(58, 100, 65, 80, 72, 54)
    ctx.strokeStyle = this.selectedBranch === 2 ? AppColors.ACCENT : AppColors.ACCENT_DIM
    ctx.lineWidth = 1.5
    ctx.stroke()

    // 深度学习到CV
    ctx.beginPath()
    ctx.moveTo(258, 130)
    ctx.bezierCurveTo(258, 100, 258, 80, 262, 54)
    ctx.strokeStyle = this.selectedBranch === 3 ? AppColors.ACCENT : AppColors.ACCENT_DIM
    ctx.lineWidth = 1.5
    ctx.stroke()
  }
}

// ═══════════════════════════════════════════════
// L27 - 电路板
// ═══════════════════════════════════════════════
@Component
export struct L27 {
  @State selectedNode: number = -1

  private nodes: CircuitNode[] = [
    { x: 20, y: 20, label: '数学基础', w: 70, h: 28 },
    { x: 120, y: 20, label: '编程基础', w: 70, h: 28 },
    { x: 220, y: 20, label: '数据处理', w: 70, h: 28 },
    { x: 70, y: 90, label: '机器学习', w: 70, h: 28 },
    { x: 200, y: 90, label: '深度学习', w: 70, h: 28 },
    { x: 130, y: 160, label: 'NLP', w: 56, h: 28 },
    { x: 130, y: 220, label: '应用', w: 56, h: 28 }
  ]

  // 连线关系 [from, to]
  private connections: number[][] = [
    [0, 3], [1, 3], [1, 4], [2, 4], [3, 5], [4, 5], [5, 6]
  ]

  build() {
    Column() {
      StatusBar()
      NavBar('电路板')

      Stack() {
        Canvas(this.nodes.length > 0 ? this.createCanvasContext() : undefined)
          .width('100%')
          .height(300)
          .onReady(() => {
            this.drawCircuit()
          })

        // 电路节点
        ForEach(this.nodes, (node: CircuitNode, index: number) => {
          Column() {
            Text(node.label)
              .fontSize(FontSize.XS)
              .fontColor(this.selectedNode === index ? AppColors.ACCENT : AppColors.FG_SECONDARY)
              .fontWeight(this.selectedNode === index ? FontWeight.Bold : FontWeight.Normal)
          }
          .width(node.w)
          .height(node.h)
          .borderRadius(4)
          .backgroundColor(this.selectedNode === index ? AppColors.BG_HOVER : AppColors.BG_ELEVATED)
          .border({
            width: this.selectedNode === index ? 1.5 : 1,
            color: this.selectedNode === index ? AppColors.ACCENT : AppColors.BORDER
          })
          .justifyContent(FlexAlign.Center)
          .position({ x: node.x, y: node.y })
          .onClick(() => {
            this.selectedNode = this.selectedNode === index ? -1 : index
          })
        }, (node: CircuitNode, index: number) => `${index}`)
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private createCanvasContext(): CanvasRenderingContext2D {
    return this.context
  }

  private drawCircuit() {
    const ctx = this.context
    ctx.clearRect(0, 0, 360, 300)

    for (const conn of this.connections) {
      const from = this.nodes[conn[0]]
      const to = this.nodes[conn[1]]
      const fromCx = from.x + from.w / 2
      const fromCy = from.y + from.h / 2
      const toCx = to.x + to.w / 2
      const toCy = to.y + to.h / 2

      ctx.beginPath()
      // 电路板风格：先水平再垂直
      const midY = (fromCy + toCy) / 2
      ctx.moveTo(fromCx, fromCy + from.h / 2)
      ctx.lineTo(fromCx, midY)
      ctx.lineTo(toCx, midY)
      ctx.lineTo(toCx, toCy - to.h / 2)
      ctx.strokeStyle = (this.selectedNode === conn[0] || this.selectedNode === conn[1]) ?
        AppColors.ACCENT : AppColors.FG_DIM
      ctx.lineWidth = 1.5
      ctx.stroke()

      // 连接点
      ctx.beginPath()
      ctx.arc(fromCx, midY, 2, 0, Math.PI * 2)
      ctx.arc(toCx, midY, 2, 0, Math.PI * 2)
      ctx.fillStyle = AppColors.ACCENT_DIM
      ctx.fill()
    }
  }
}

// ═══════════════════════════════════════════════
// L28 - 生命树
// ═══════════════════════════════════════════════
@Component
export struct L28 {
  @State selectedNode: number = -1

  private treeNodes: TreeVisNode[] = [
    { x: 160, y: 250, label: 'AI', size: 32 },
    { x: 100, y: 190, label: 'ML', size: 26 },
    { x: 220, y: 190, label: 'DL', size: 26 },
    { x: 60, y: 130, label: '监督', size: 20 },
    { x: 140, y: 130, label: '无监督', size: 20 },
    { x: 190, y: 130, label: 'CNN', size: 20 },
    { x: 260, y: 130, label: 'RNN', size: 20 },
    { x: 40, y: 70, label: '分类', size: 16 },
    { x: 80, y: 70, label: '回归', size: 16 },
    { x: 170, y: 70, label: '检测', size: 16 },
    { x: 240, y: 70, label: '序列', size: 16 },
    { x: 290, y: 70, label: '生成', size: 16 }
  ]

  // 树枝连接 [parent, child]
  private treeEdges: number[][] = [
    [0, 1], [0, 2],
    [1, 3], [1, 4],
    [2, 5], [2, 6],
    [3, 7], [3, 8],
    [5, 9],
    [6, 10], [6, 11]
  ]

  build() {
    Column() {
      StatusBar()
      NavBar('生命树')

      Stack() {
        Canvas(this.treeNodes.length > 0 ? this.createCanvasContext() : undefined)
          .width('100%')
          .height(300)
          .onReady(() => {
            this.drawTree()
          })

        // 树节点
        ForEach(this.treeNodes, (node: TreeVisNode, index: number) => {
          Stack() {
            Circle()
              .width(node.size)
              .height(node.size)
              .fill(this.selectedNode === index ? AppColors.ACCENT : AppColors.BG_ELEVATED)
              .stroke(this.selectedNode === index ? AppColors.ACCENT : AppColors.ACCENT_DIM)
              .strokeWidth(1.5)

            Text(node.label)
              .fontSize(node.size > 24 ? FontSize.XS : FontSize.XS - 1)
              .fontColor(this.selectedNode === index ? AppColors.BG : AppColors.FG_SECONDARY)
              .fontWeight(FontWeight.Medium)
          }
          .width(node.size)
          .height(node.size)
          .alignContent(Alignment.Center)
          .position({ x: node.x - node.size / 2, y: node.y - node.size / 2 })
          .onClick(() => {
            this.selectedNode = this.selectedNode === index ? -1 : index
          })
        }, (node: TreeVisNode, index: number) => `${index}`)
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private createCanvasContext(): CanvasRenderingContext2D {
    return this.context
  }

  private drawTree() {
    const ctx = this.context
    ctx.clearRect(0, 0, 360, 300)

    for (const edge of this.treeEdges) {
      const parent = this.treeNodes[edge[0]]
      const child = this.treeNodes[edge[1]]

      ctx.beginPath()
      ctx.moveTo(parent.x, parent.y - parent.size / 2)
      // 曲线树枝
      const midY = (parent.y + child.y) / 2
      ctx.bezierCurveTo(
        parent.x, midY,
        child.x, midY,
        child.x, child.y + child.size / 2
      )
      ctx.strokeStyle = (this.selectedNode === edge[0] || this.selectedNode === edge[1]) ?
        AppColors.ACCENT : AppColors.ACCENT_DIM
      ctx.lineWidth = 1.5
      ctx.stroke()
    }
  }
}

// ═══════════════════════════════════════════════
// L29 - 铁路线图
// ═══════════════════════════════════════════════
@Component
export struct L29 {
  @State selectedStation: number = 2

  private stations: string[] = [
    '始发站', '基础站', '进阶站', '应用站', '高级站', '终点站'
  ]

  build() {
    Column() {
      StatusBar()
      NavBar('铁路线图')

      Scroll() {
        Column() {
          ForEach(this.stations, (station: string, index: number) => {
            Row() {
              // 站点指示器
              Column() {
                // 站点圆点
                Stack() {
                  if (index === this.selectedStation) {
                    Circle()
                      .width(18)
                      .height(18)
                      .fill(AppColors.ACCENT)
                  } else if (index < this.selectedStation) {
                    Circle()
                      .width(14)
                      .height(14)
                      .fill(AppColors.ACCENT_DIM)
                  } else {
                    Circle()
                      .width(14)
                      .height(14)
                      .fill(Color.Transparent)
                      .stroke(AppColors.FG_DIM)
                      .strokeWidth(1.5)
                  }

                  if (index < this.selectedStation) {
                    Text('✓')
                      .fontSize(8)
                      .fontColor(AppColors.BG)
                      .fontWeight(FontWeight.Bold)
                  }
                }
                .width(18)
                .height(18)
                .alignContent(Alignment.Center)

                // 连接线
                if (index < this.stations.length - 1) {
                  Row()
                    .width(3)
                    .height(28)
                    .borderRadius(1.5)
                    .backgroundColor(index < this.selectedStation ? AppColors.ACCENT : AppColors.BORDER)
                }
              }
              .alignItems(HorizontalAlign.Center)
              .margin({ right: Spacing.MD })

              // 站点内容
              Column() {
                Row() {
                  Text(station)
                    .fontSize(FontSize.BASE)
                    .fontColor(index <= this.selectedStation ? AppColors.FG : AppColors.FG_DIM)
                    .fontWeight(index === this.selectedStation ? FontWeight.Bold : FontWeight.Medium)

                  if (index === this.selectedStation) {
                    Text('当前')
                      .fontSize(FontSize.XS)
                      .fontColor(AppColors.ACCENT)
                      .padding({ left: 6, right: 6, top: 1, bottom: 1 })
                      .borderRadius(Radius.PILL)
                      .backgroundColor(AppColors.ACCENT + '20')
                      .margin({ left: Spacing.SM })
                  }
                }

                Text(`第 ${index + 1} 站 · ${index < this.selectedStation ? '已通过' : index === this.selectedStation ? '停靠中' : '未到达'}`)
                  .fontSize(FontSize.XS)
                  .fontColor(AppColors.FG_DIM)
                  .margin({ top: 2 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
              .padding(Spacing.SM)
              .borderRadius(Radius.MD)
              .backgroundColor(index === this.selectedStation ? AppColors.BG_ELEVATED : Color.Transparent)
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)
            .onClick(() => {
              this.selectedStation = index
            })
          }, (station: string) => station)
        }
        .width('100%')
        .padding({ left: Spacing.LG, right: Spacing.LG, top: Spacing.BASE })
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

// ═══════════════════════════════════════════════
// L30 - 剧本章节
// ═══════════════════════════════════════════════
@Component
export struct L30 {
  @State expandedChapter: number = 0

  private chapters: ChapterItem[] = [
    { title: '第一章：起源', desc: '了解AI的历史与基本概念，从图灵测试到现代AI的演变历程。', status: 'completed' },
    { title: '第二章：基石', desc: '掌握数学基础——线性代数、概率论与统计学，为后续学习打下根基。', status: 'completed' },
    { title: '第三章：工具', desc: '学习Python编程与数据处理工具，掌握NumPy、Pandas等核心库。', status: 'in-progress' },
    { title: '第四章：觉醒', desc: '进入机器学习世界，理解监督学习、无监督学习与强化学习。', status: 'locked' },
    { title: '第五章：深入', desc: '探索深度学习架构，从CNN到RNN再到Transformer。', status: 'locked' },
    { title: '第六章：应用', desc: '将所学知识应用于实际项目，完成从理论到实践的跨越。', status: 'locked' }
  ]

  build() {
    Column() {
      StatusBar()
      NavBar('剧本章节')

      Scroll() {
        Column() {
          ForEach(this.chapters, (chapter: ChapterItem, index: number) => {
            Column() {
              // 章节标题行
              Row() {
                // 章节序号
                Text(`${index + 1}`)
                  .fontSize(FontSize.XS)
                  .fontColor(chapter.status === 'completed' ? AppColors.BG : AppColors.FG_DIM)
                  .fontWeight(FontWeight.Bold)
                  .width(20)
                  .height(20)
                  .borderRadius(10)
                  .backgroundColor(chapter.status === 'completed' ? AppColors.ACCENT :
                                   chapter.status === 'in-progress' ? AppColors.BG_HOVER : AppColors.BG_ELEVATED)
                  .border({
                    width: chapter.status === 'in-progress' ? 1.5 : 0,
                    color: chapter.status === 'in-progress' ? AppColors.ACCENT : Color.Transparent
                  })
                  .textAlign(TextAlign.Center)
                  .margin({ right: Spacing.MD })

                Text(chapter.title)
                  .fontSize(FontSize.BASE)
                  .fontColor(chapter.status === 'locked' ? AppColors.FG_DIM : AppColors.FG)
                  .fontWeight(FontWeight.Medium)
                  .layoutWeight(1)

                // 状态标签
                Text(chapter.status === 'completed' ? '✓' :
                     chapter.status === 'in-progress' ? '▶' : '🔒')
                  .fontSize(FontSize.SM)
                  .fontColor(chapter.status === 'completed' ? AppColors.ACCENT :
                             chapter.status === 'in-progress' ? AppColors.WARM : AppColors.FG_DIM)
                  .margin({ right: Spacing.SM })

                Text(this.expandedChapter === index ? '▲' : '▼')
                  .fontSize(FontSize.XS)
                  .fontColor(AppColors.FG_DIM)
              }
              .width('100%')
              .padding(Spacing.MD)
              .onClick(() => {
                if (chapter.status !== 'locked') {
                  this.expandedChapter = this.expandedChapter === index ? -1 : index
                }
              })

              // 展开内容
              if (this.expandedChapter === index && chapter.status !== 'locked') {
                Column() {
                  Text(chapter.desc)
                    .fontSize(FontSize.SM)
                    .fontColor(AppColors.FG_SECONDARY)
                    .lineHeight(20)

                  Row() {
                    Text(chapter.status === 'completed' ? '已完成' : '继续学习')
                      .fontSize(FontSize.XS)
                      .fontColor(AppColors.ACCENT)
                      .padding({ left: 12, right: 12, top: 4, bottom: 4 })
                      .borderRadius(Radius.PILL)
                      .backgroundColor(AppColors.ACCENT + '15')
                      .border({ width: 1, color: AppColors.ACCENT + '40' })
                  }
                  .margin({ top: Spacing.MD })
                }
                .width('100%')
                .padding({ left: Spacing.BASE + 20 + Spacing.MD, right: Spacing.MD, bottom: Spacing.MD })
                .alignItems(HorizontalAlign.Start)
              }
            }
            .width('100%')
            .borderRadius(Radius.LG)
            .backgroundColor(this.expandedChapter === index ? AppColors.BG_ELEVATED : AppColors.BG_SURFACE)
            .border({
              width: this.expandedChapter === index ? 1.5 : 0.5,
              color: this.expandedChapter === index ? AppColors.ACCENT : AppColors.BORDER
            })
            .margin({ bottom: Spacing.XS })
          }, (chapter: ChapterItem) => chapter.title)
        }
        .width('100%')
        .padding({ left: Spacing.LG, right: Spacing.LG, top: Spacing.SM })
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
