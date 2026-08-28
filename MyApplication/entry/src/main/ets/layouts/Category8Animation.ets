// 动效层次分类布局 - L71~L80
import { AppColors, FontSize, Radius, Spacing } from '../common/Constants'
import { KN_DATA, KnowledgeNode, PageItem, AnimParticle } from './LayoutTypes'

// ============ L71 - 入场动画 ============
@Component
export struct L71 {
  @State showItems: boolean[] = [false, false, false, false]
  private timers: number[] = []

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
        Text('入场动画')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 播放按钮
      Button('播放动画')
        .height(32)
        .fontSize(FontSize.SM)
        .fontWeight(FontWeight.Bold)
        .backgroundColor(AppColors.ACCENT)
        .fontColor(AppColors.BG)
        .borderRadius(Radius.PILL)
        .padding({ left: 20, right: 20 })
        .margin({ bottom: Spacing.MD })
        .onClick(() => {
          this.playAnimation()
        })

      // 卡片列表
      Column({ space: Spacing.SM }) {
        ForEach([0, 1, 2, 3], (idx: number) => {
          Row() {
            Column() {
              Text(KN_DATA[idx].name)
                .fontSize(FontSize.BASE)
                .fontColor(AppColors.FG)
                .fontWeight(FontWeight.Medium)
              Text(KN_DATA[idx].cat)
                .fontSize(FontSize.XS)
                .fontColor(AppColors.ACCENT)
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Text(`Lv.${KN_DATA[idx].lv}`)
              .fontSize(FontSize.XS)
              .fontColor(AppColors.FG_DIM)
          }
          .width('92%')
          .padding(Spacing.MD)
          .borderRadius(Radius.MD)
          .backgroundColor(AppColors.BG_ELEVATED)
          .border({ width: 1, color: AppColors.BORDER })
          .opacity(this.showItems[idx] ? 1 : 0)
          .translate({ y: this.showItems[idx] ? 0 : 20 })
          .animation({ duration: 400, curve: Curve.EaseOut })
        }, (idx: number) => idx.toString())
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Start)
      .padding({ top: Spacing.XS })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }

  private playAnimation() {
    // 重置
    this.showItems = [false, false, false, false]
    this.clearTimers()

    for (let i = 0; i < 4; i++) {
      const timerId = setTimeout(() => {
        const newItems: boolean[] = [...this.showItems]
        newItems[i] = true
        this.showItems = newItems
      }, i * 200 + 100)
      this.timers.push(timerId)
    }
  }

  private clearTimers() {
    this.timers.forEach((t: number) => clearTimeout(t))
    this.timers = []
  }

  aboutToDisappear() {
    this.clearTimers()
  }
}

// ============ L72 - 滚动视差 ============
@Component
export struct L72 {
  @State scrollOffset: number = 0

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
        Text('滚动视差')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 视差区域
      Stack() {
        // 背景层 - 移动较慢
        Column() {
          Text('🧠')
            .fontSize(48)
            .opacity(0.15)
          Text('知识图谱')
            .fontSize(FontSize.XXL)
            .fontColor(AppColors.FG_DIM)
            .opacity(0.3)
        }
        .translate({ y: this.scrollOffset * 0.3 })

        // 前景层 - 移动较快
        Column({ space: Spacing.SM }) {
          ForEach(KN_DATA.slice(0, 4), (item: KnowledgeNode, idx: number) => {
            Row() {
              Text(item.name)
                .fontSize(FontSize.BASE)
                .fontColor(AppColors.FG)
                .fontWeight(FontWeight.Medium)
                .layoutWeight(1)
              Text(item.cat)
                .fontSize(FontSize.XS)
                .fontColor(AppColors.ACCENT)
            }
            .width('100%')
            .padding(Spacing.MD)
            .borderRadius(Radius.MD)
            .backgroundColor(AppColors.BG_ELEVATED)
            .border({ width: 1, color: AppColors.BORDER })
          }, (item: KnowledgeNode) => item.id.toString())
        }
        .width('88%')
        .translate({ y: this.scrollOffset * 0.8 })
      }
      .layoutWeight(1)
      .clip(true)

      // 滑块控制
      Row() {
        Text('慢')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_DIM)
        Slider({ value: this.scrollOffset, min: -60, max: 60, step: 1 })
          .layoutWeight(1)
          .trackColor(AppColors.BG_HOVER)
          .selectedColor(AppColors.ACCENT)
          .blockColor(AppColors.ACCENT)
          .onChange((value: number) => {
            this.scrollOffset = value
          })
        Text('快')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_DIM)
      }
      .width('92%')
      .padding({ top: Spacing.SM, bottom: Spacing.SM })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ============ L73 - 页面转场 ============
@Component
export struct L73 {
  @State currentPage: number = 0
  private pages: PageItem[] = [
    { title: '欢迎', desc: '开启你的知识之旅', icon: '🌟' },
    { title: '探索', desc: '发现无限学习可能', icon: '🔍' },
    { title: '学习', desc: '让知识为你赋能', icon: '📚' }
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
        Text('页面转场')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 页面内容
      Stack() {
        ForEach([0, 1, 2], (idx: number) => {
          Column() {
            Text(this.pages[idx].icon)
              .fontSize(48)
              .margin({ bottom: Spacing.LG })
            Text(this.pages[idx].title)
              .fontSize(FontSize.XXL)
              .fontColor(AppColors.FG)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: Spacing.SM })
            Text(this.pages[idx].desc)
              .fontSize(FontSize.BASE)
              .fontColor(AppColors.FG_SECONDARY)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .opacity(this.currentPage === idx ? 1 : 0)
          .translate({ x: (idx - this.currentPage) * 120 })
          .animation({ duration: 350, curve: Curve.EaseInOut })
        }, (idx: number) => idx.toString())
      }
      .layoutWeight(1)

      // 指示器 + 按钮
      Row() {
        // 圆点指示器
        Row({ space: 8 }) {
          ForEach([0, 1, 2], (idx: number) => {
            Circle()
              .width(this.currentPage === idx ? 20 : 8)
              .height(8)
              .fill(this.currentPage === idx ? AppColors.ACCENT : AppColors.BORDER)
              .borderRadius(4)
              .animation({ duration: 300, curve: Curve.EaseInOut })
          }, (idx: number) => idx.toString())
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)

        // 下一步按钮
        Button(this.currentPage === 2 ? '开始' : '下一步')
          .height(32)
          .fontSize(FontSize.SM)
          .fontWeight(FontWeight.Bold)
          .backgroundColor(AppColors.ACCENT)
          .fontColor(AppColors.BG)
          .borderRadius(Radius.PILL)
          .padding({ left: 20, right: 20 })
          .onClick(() => {
            animateTo({ duration: 350, curve: Curve.EaseInOut }, () => {
              this.currentPage = this.currentPage < 2 ? this.currentPage + 1 : 0
            })
          })
      }
      .width('92%')
      .padding({ bottom: Spacing.MD })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ============ L74 - 微交互 ============
@Component
export struct L74 {
  @State likedItems: Record<number, boolean> = {}
  @State scaleMap: Record<number, number> = {}

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
        Text('微交互')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 列表
      Column({ space: Spacing.SM }) {
        ForEach(KN_DATA.slice(0, 6), (item: KnowledgeNode, idx: number) => {
          Row() {
            // 心形图标
            Text(this.likedItems[idx] ? '♥' : '♡')
              .fontSize(22)
              .fontColor(this.likedItems[idx] ? '#C45A5A' : AppColors.FG_DIM)
              .margin({ right: Spacing.MD })
              .scale({ x: this.scaleMap[idx] ?? 1, y: this.scaleMap[idx] ?? 1 })
              .animation({ duration: 200, curve: Curve.FastOutSlowIn })
              .onClick(() => {
                const newLiked = !this.likedItems[idx]
                this.likedItems[idx] = newLiked
                // 弹性缩放动画
                this.scaleMap[idx] = 1.4
                setTimeout(() => {
                  this.scaleMap[idx] = 1
                }, 120)
              })

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

            Text(`Lv.${item.lv}`)
              .fontSize(FontSize.XS)
              .fontColor(AppColors.ACCENT_DIM)
          }
          .width('92%')
          .padding(Spacing.MD)
          .borderRadius(Radius.MD)
          .backgroundColor(AppColors.BG_ELEVATED)
          .border({ width: 1, color: AppColors.BORDER })
        }, (item: KnowledgeNode) => item.id.toString())
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

// ============ L75 - 骨架屏 ============
@Component
export struct L75 {
  @State loaded: boolean = false
  @State pulseOpacity: number = 0.4
  private loadTimer: number = -1
  private pulseTimer: number = -1

  aboutToAppear() {
    // 脉冲动画
    this.pulseTimer = setInterval(() => {
      this.pulseOpacity = this.pulseOpacity < 0.7 ? 0.8 : 0.3
    }, 800) as number

    // 2秒后加载完成
    this.loadTimer = setTimeout(() => {
      this.loaded = true
      if (this.pulseTimer !== -1) {
        clearInterval(this.pulseTimer)
      }
    }, 2000) as number
  }

  aboutToDisappear() {
    if (this.loadTimer !== -1) clearTimeout(this.loadTimer)
    if (this.pulseTimer !== -1) clearInterval(this.pulseTimer)
  }

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
        Text('骨架屏')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      if (!this.loaded) {
        // 骨架屏占位
        Column({ space: Spacing.MD }) {
          ForEach([0, 1, 2, 3], (idx: number) => {
            Row() {
              // 圆形占位
              Circle()
                .width(40)
                .height(40)
                .fill(AppColors.BG_HOVER)
                .opacity(this.pulseOpacity)
                .animation({ duration: 600, curve: Curve.EaseInOut })

              Column({ space: 6 }) {
                Row()
                  .width('70%')
                  .height(12)
                  .borderRadius(6)
                  .backgroundColor(AppColors.BG_HOVER)
                  .opacity(this.pulseOpacity)
                  .animation({ duration: 600, curve: Curve.EaseInOut })
                Row()
                  .width('45%')
                  .height(10)
                  .borderRadius(5)
                  .backgroundColor(AppColors.BG_HOVER)
                  .opacity(this.pulseOpacity)
                  .animation({ duration: 600, curve: Curve.EaseInOut })
              }
              .layoutWeight(1)
              .margin({ left: Spacing.MD })
              .alignItems(HorizontalAlign.Start)
            }
            .width('92%')
            .padding(Spacing.MD)
            .borderRadius(Radius.MD)
            .backgroundColor(AppColors.BG_ELEVATED)
            .border({ width: 1, color: AppColors.BORDER })
          }, (idx: number) => idx.toString())
        }
        .layoutWeight(1)
      } else {
        // 真实内容
        Column({ space: Spacing.SM }) {
          ForEach(KN_DATA.slice(0, 4), (item: KnowledgeNode, idx: number) => {
            Row() {
              Column() {
                Text(item.name)
                  .fontSize(FontSize.BASE)
                  .fontColor(AppColors.FG)
                  .fontWeight(FontWeight.Medium)
                Text(item.cat)
                  .fontSize(FontSize.XS)
                  .fontColor(AppColors.ACCENT)
                  .margin({ top: 2 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
              .margin({ left: Spacing.MD })

              Text(`Lv.${item.lv}`)
                .fontSize(FontSize.XS)
                .fontColor(AppColors.ACCENT_DIM)
            }
            .width('92%')
            .padding(Spacing.MD)
            .borderRadius(Radius.MD)
            .backgroundColor(AppColors.BG_ELEVATED)
            .border({ width: 1, color: AppColors.BORDER })
            .opacity(0)
            .translate({ y: 10 })
            .animation({ duration: 400, delay: idx * 100, curve: Curve.EaseOut })
          }, (item: KnowledgeNode) => item.id.toString())
        }
        .layoutWeight(1)
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

// ============ L76 - 进度动画 ============
@Component
export struct L76 {
  @State progress: number = 0
  @State isAnimating: boolean = false
  private intervalId: number = -1

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
        Text('进度动画')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 圆形进度
      Column() {
        Stack() {
          Canvas(this.progressContext)
            .width(160)
            .height(160)
            .onReady(() => {
              this.drawProgress()
            })

          Column() {
            Text(`${Math.round(this.progress)}%`)
              .fontSize(FontSize.XXL)
              .fontColor(AppColors.ACCENT)
              .fontWeight(FontWeight.Bold)
            Text('学习进度')
              .fontSize(FontSize.XS)
              .fontColor(AppColors.FG_SECONDARY)
              .margin({ top: 2 })
          }
        }

        // 标签
        Text('机器学习 · 深度学习')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.FG_SECONDARY)
          .margin({ top: Spacing.LG })

        // 控制按钮
        Row({ space: Spacing.MD }) {
          Button(this.isAnimating ? '暂停' : '播放')
            .height(32)
            .fontSize(FontSize.SM)
            .fontWeight(FontWeight.Bold)
            .backgroundColor(AppColors.ACCENT)
            .fontColor(AppColors.BG)
            .borderRadius(Radius.PILL)
            .padding({ left: 20, right: 20 })
            .onClick(() => {
              this.toggleAnimation()
            })

          Button('重置')
            .height(32)
            .fontSize(FontSize.SM)
            .fontWeight(FontWeight.Bold)
            .backgroundColor(Color.Transparent)
            .fontColor(AppColors.ACCENT)
            .borderRadius(Radius.PILL)
            .border({ width: 1, color: AppColors.ACCENT })
            .padding({ left: 20, right: 20 })
            .onClick(() => {
              this.progress = 0
              this.isAnimating = false
              if (this.intervalId !== -1) clearInterval(this.intervalId)
              this.intervalId = -1
              this.drawProgress()
            })
        }
        .margin({ top: Spacing.LG })
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

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private progressContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawProgress() {
    const ctx = this.progressContext
    const cx = 80
    const cy = 80
    const radius = 60
    const lineWidth = 10

    ctx.clearRect(0, 0, 160, 160)

    // 背景圆
    ctx.beginPath()
    ctx.arc(cx, cy, radius, 0, 2 * Math.PI)
    ctx.strokeStyle = '#262622'
    ctx.lineWidth = lineWidth
    ctx.lineCap = 'round'
    ctx.stroke()

    // 进度弧
    if (this.progress > 0) {
      const startAngle = -Math.PI / 2
      const endAngle = startAngle + (2 * Math.PI * this.progress / 100)
      ctx.beginPath()
      ctx.arc(cx, cy, radius, startAngle, endAngle)
      ctx.strokeStyle = '#C4A265'
      ctx.lineWidth = lineWidth
      ctx.lineCap = 'round'
      ctx.stroke()
    }
  }

  private toggleAnimation() {
    if (this.isAnimating) {
      this.isAnimating = false
      if (this.intervalId !== -1) clearInterval(this.intervalId)
      this.intervalId = -1
    } else {
      this.isAnimating = true
      this.intervalId = setInterval(() => {
        if (this.progress >= 100) {
          this.progress = 100
          this.isAnimating = false
          if (this.intervalId !== -1) clearInterval(this.intervalId)
          this.intervalId = -1
        } else {
          this.progress += 1
        }
        this.drawProgress()
      }, 30) as number
    }
  }

  aboutToDisappear() {
    if (this.intervalId !== -1) clearInterval(this.intervalId)
  }
}

// ============ L77 - 弹性物理 ============
@Component
export struct L77 {
  @State ballX: number = 150
  @State ballY: number = 200

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
        Text('弹性物理')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 弹性区域
      Stack() {
        // 提示文字
        Text('点击任意位置移动小球')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_DIM)
          .position({ x: '30%', y: 10 })

        // 小球
        Column() {
          Circle()
            .width(40)
            .height(40)
            .fill(AppColors.ACCENT)
            .shadow({ radius: 12, color: '#C4A26540', offsetX: 0, offsetY: 4 })
        }
        .position({ x: this.ballX - 20, y: this.ballY - 20 })
        .animation({ duration: 600, curve: Curve.FastOutSlowIn, delay: 0 })
      }
      .width('92%')
      .layoutWeight(1)
      .borderRadius(Radius.LG)
      .backgroundColor(AppColors.BG_ELEVATED)
      .border({ width: 1, color: AppColors.BORDER })
      .onClick((event: ClickEvent) => {
        animateTo({ duration: 600, curve: Curve.FastOutSlowIn }, () => {
          this.ballX = event.x
          this.ballY = event.y
        })
      })

      // 坐标显示
      Row() {
        Text(`X: ${Math.round(this.ballX)}`)
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_DIM)
        Text(`Y: ${Math.round(this.ballY)}`)
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_DIM)
          .margin({ left: Spacing.MD })
      }
      .margin({ top: Spacing.SM })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ============ L78 - 粒子效果 ============
@Component
export struct L78 {
  @State particles: AnimParticle[] = []
  private animTimer: number = -1

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
        Text('粒子效果')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 画布
      Stack() {
        Canvas(this.particleContext)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawAnimParticles()
          })
      }
      .width('92%')
      .layoutWeight(1)
      .borderRadius(Radius.LG)
      .backgroundColor(AppColors.BG_ELEVATED)
      .border({ width: 1, color: AppColors.BORDER })

      // 发射按钮
      Button('✨ 发射粒子')
        .height(36)
        .fontSize(FontSize.SM)
        .fontWeight(FontWeight.Bold)
        .backgroundColor(AppColors.ACCENT)
        .fontColor(AppColors.BG)
        .borderRadius(Radius.PILL)
        .padding({ left: 24, right: 24 })
        .margin({ top: Spacing.MD })
        .onClick(() => {
          this.emitAnimParticles()
        })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private particleContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private emitAnimParticles() {
    const centerX = 160
    const centerY = 120
    const newAnimParticles: AnimParticle[] = []

    for (let i = 0; i < 20; i++) {
      const angle = Math.random() * 2 * Math.PI
      const speed = 1.5 + Math.random() * 3
      newAnimParticles.push({
        x: centerX,
        y: centerY,
        vx: Math.cos(angle) * speed,
        vy: Math.sin(angle) * speed,
        life: 60,
        maxLife: 60,
        size: 2 + Math.random() * 4
      })
    }

    this.particles = [...this.particles, ...newAnimParticles]

    if (this.animTimer === -1) {
      this.animTimer = setInterval(() => {
        this.updateAnimParticles()
        this.drawAnimParticles()
      }, 16) as number
    }
  }

  private updateAnimParticles() {
    const alive: AnimParticle[] = []
    for (const p of this.particles) {
      p.x += p.vx
      p.y += p.vy
      p.vy += 0.05 // 重力
      p.life -= 1
      if (p.life > 0) {
        alive.push(p)
      }
    }
    this.particles = alive

    if (this.particles.length === 0 && this.animTimer !== -1) {
      clearInterval(this.animTimer)
      this.animTimer = -1
    }
  }

  private drawAnimParticles() {
    const ctx = this.particleContext
    const w = 320
    const h = 240
    ctx.clearRect(0, 0, w, h)

    for (const p of this.particles) {
      const alpha = p.life / p.maxLife
      ctx.beginPath()
      ctx.arc(p.x, p.y, p.size, 0, 2 * Math.PI)
      ctx.fillStyle = `rgba(196, 162, 101, ${alpha})`
      ctx.fill()
    }
  }

  aboutToDisappear() {
    if (this.animTimer !== -1) clearInterval(this.animTimer)
  }
}

// ============ L79 - 液态变形 ============
@Component
export struct L79 {
  @State currentShape: number = 0 // 0=circle, 1=diamond, 2=blob
  @State morphProgress: number = 0
  private morphTimer: number = -1

  private shapeNames: string[] = ['圆形', '菱形', '液态']

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
        Text('液态变形')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 画布
      Stack() {
        Canvas(this.morphContext)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawShape()
          })
      }
      .width('92%')
      .height(200)
      .borderRadius(Radius.LG)
      .backgroundColor(AppColors.BG_ELEVATED)
      .border({ width: 1, color: AppColors.BORDER })

      // 形状切换按钮
      Row({ space: Spacing.SM }) {
        ForEach([0, 1, 2], (idx: number) => {
          Button(this.shapeNames[idx])
            .height(32)
            .fontSize(FontSize.SM)
            .fontWeight(this.currentShape === idx ? FontWeight.Bold : FontWeight.Normal)
            .backgroundColor(this.currentShape === idx ? AppColors.ACCENT : AppColors.BG_HOVER)
            .fontColor(this.currentShape === idx ? AppColors.BG : AppColors.FG_SECONDARY)
            .borderRadius(Radius.PILL)
            .padding({ left: 16, right: 16 })
            .onClick(() => {
              this.currentShape = idx
              this.morphProgress = 0
              this.startMorphAnimation()
            })
        }, (idx: number) => idx.toString())
      }
      .margin({ top: Spacing.LG })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private morphContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private startMorphAnimation() {
    if (this.morphTimer !== -1) clearInterval(this.morphTimer)
    this.morphProgress = 0
    this.morphTimer = setInterval(() => {
      this.morphProgress = Math.min(1, this.morphProgress + 0.05)
      this.drawShape()
      if (this.morphProgress >= 1) {
        clearInterval(this.morphTimer)
        this.morphTimer = -1
      }
    }, 16) as number
  }

  private drawShape() {
    const ctx = this.morphContext
    const w = 320
    const h = 200
    const cx = w / 2
    const cy = h / 2
    const size = 60

    ctx.clearRect(0, 0, w, h)

    ctx.beginPath()

    if (this.currentShape === 0) {
      // 圆形
      ctx.arc(cx, cy, size, 0, 2 * Math.PI)
    } else if (this.currentShape === 1) {
      // 菱形
      const p = this.morphProgress
      const points = 64
      for (let i = 0; i <= points; i++) {
        const angle = (i / points) * 2 * Math.PI
        // 菱形半径公式
        const cosA = Math.cos(angle)
        const sinA = Math.sin(angle)
        const diamondR = size / Math.max(Math.abs(cosA), Math.abs(sinA))
        // 插值
        const r = size + (diamondR - size) * p
        const x = cx + r * cosA
        const y = cy + r * sinA
        if (i === 0) {
          ctx.moveTo(x, y)
        } else {
          ctx.lineTo(x, y)
        }
      }
      ctx.closePath()
    } else {
      // 液态blob
      const p = this.morphProgress
      const points = 64
      for (let i = 0; i <= points; i++) {
        const angle = (i / points) * 2 * Math.PI
        // blob变形
        const blobR = size + Math.sin(angle * 3 + Date.now() * 0.002) * 15 * p
          + Math.sin(angle * 5 - Date.now() * 0.003) * 8 * p
        const x = cx + blobR * Math.cos(angle)
        const y = cy + blobR * Math.sin(angle)
        if (i === 0) {
          ctx.moveTo(x, y)
        } else {
          ctx.lineTo(x, y)
        }
      }
      ctx.closePath()
    }

    // 渐变填充
    const gradient = ctx.createRadialGradient(cx, cy - 20, 10, cx, cy, size + 20)
    gradient.addColorStop(0, '#C4A265')
    gradient.addColorStop(1, '#8B7340')
    ctx.fillStyle = gradient
    ctx.fill()

    // 光泽
    ctx.beginPath()
    ctx.arc(cx - 15, cy - 20, size * 0.3, 0, 2 * Math.PI)
    ctx.fillStyle = 'rgba(255, 255, 255, 0.1)'
    ctx.fill()
  }

  aboutToDisappear() {
    if (this.morphTimer !== -1) clearInterval(this.morphTimer)
  }
}

// ============ L80 - 呼吸脉冲 ============
@Component
export struct L80 {
  @State isPlaying: boolean = false
  @State pulsePhase: number = 0
  private pulseTimer: number = -1

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
        Text('呼吸脉冲')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 脉冲画布
      Stack() {
        Canvas(this.pulseContext)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawPulse()
          })
      }
      .width('92%')
      .layoutWeight(1)
      .borderRadius(Radius.LG)
      .backgroundColor(AppColors.BG_ELEVATED)
      .border({ width: 1, color: AppColors.BORDER })

      // 控制按钮
      Row({ space: Spacing.MD }) {
        Button(this.isPlaying ? '暂停' : '播放')
          .height(32)
          .fontSize(FontSize.SM)
          .fontWeight(FontWeight.Bold)
          .backgroundColor(this.isPlaying ? AppColors.RED : AppColors.ACCENT)
          .fontColor(AppColors.BG)
          .borderRadius(Radius.PILL)
          .padding({ left: 24, right: 24 })
          .onClick(() => {
            this.togglePulse()
          })

        Text('专注呼吸')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.FG_SECONDARY)
      }
      .margin({ top: Spacing.MD })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private pulseContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private togglePulse() {
    if (this.isPlaying) {
      this.isPlaying = false
      if (this.pulseTimer !== -1) {
        clearInterval(this.pulseTimer)
        this.pulseTimer = -1
      }
    } else {
      this.isPlaying = true
      this.pulseTimer = setInterval(() => {
        this.pulsePhase += 0.05
        if (this.pulsePhase > Math.PI * 2) {
          this.pulsePhase -= Math.PI * 2
        }
        this.drawPulse()
      }, 30) as number
    }
  }

  private drawPulse() {
    const ctx = this.pulseContext
    const w = 320
    const h = 280
    const cx = w / 2
    const cy = h / 2

    ctx.clearRect(0, 0, w, h)

    // 中心圆
    const baseRadius = 30
    const breathe = Math.sin(this.pulsePhase) * 8
    const mainRadius = baseRadius + breathe

    // 绘制脉冲环
    for (let i = 3; i >= 0; i--) {
      const ringPhase = this.pulsePhase - i * 0.8
      const ringProgress = ((ringPhase % (Math.PI * 2)) + Math.PI * 2) % (Math.PI * 2) / (Math.PI * 2)
      const ringRadius = mainRadius + ringProgress * 60
      const ringAlpha = Math.max(0, 1 - ringProgress) * 0.3

      ctx.beginPath()
      ctx.arc(cx, cy, ringRadius, 0, 2 * Math.PI)
      ctx.strokeStyle = `rgba(196, 162, 101, ${ringAlpha})`
      ctx.lineWidth = 2
      ctx.stroke()
    }

    // 中心圆 - 渐变
    const gradient = ctx.createRadialGradient(cx, cy - 10, 5, cx, cy, mainRadius)
    gradient.addColorStop(0, '#C4A265')
    gradient.addColorStop(1, '#8B7340')
    ctx.beginPath()
    ctx.arc(cx, cy, mainRadius, 0, 2 * Math.PI)
    ctx.fillStyle = gradient
    ctx.fill()

    // 光泽
    ctx.beginPath()
    ctx.arc(cx - 8, cy - 10, mainRadius * 0.3, 0, 2 * Math.PI)
    ctx.fillStyle = 'rgba(255, 255, 255, 0.15)'
    ctx.fill()

    // 呼吸提示文字
    const breathText = Math.sin(this.pulsePhase) > 0 ? '吸气' : '呼气'
    ctx.font = '12px sans-serif'
    ctx.fillStyle = '#9A9688'
    ctx.textAlign = 'center'
    ctx.fillText(breathText, cx, cy + mainRadius + 30)
  }

  aboutToDisappear() {
    if (this.pulseTimer !== -1) clearInterval(this.pulseTimer)
  }
}
