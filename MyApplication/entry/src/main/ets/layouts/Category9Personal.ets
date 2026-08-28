// 个性化分类布局 - L81~L90
import { AppColors, FontSize, Radius, Spacing } from '../common/Constants'
import { KN_DATA, RadarSkill, AchievementEntry, TraitItem, StarNode } from './LayoutTypes'

// ============ L81 - 技能雷达 ============
@Component
export struct L81 {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private skills: RadarSkill[] = [
    { name: '编程', value: 85 },
    { name: '数学', value: 60 },
    { name: 'AI', value: 90 },
    { name: 'NLP', value: 70 },
    { name: 'CV', value: 55 },
    { name: '框架', value: 75 }
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
        Text('←')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
        Text('技能雷达')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
          .margin({ left: Spacing.SM })
        Blank()
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 雷达图
      Column() {
        Canvas(this.context)
          .width('100%')
          .height(260)
          .onReady(() => {
            this.drawRadar()
          })
      }
      .width('92%')
      .padding(Spacing.MD)
      .borderRadius(Radius.LG)
      .backgroundColor(AppColors.BG_ELEVATED)
      .border({ width: 1, color: AppColors.BORDER })

      // 技能标签
      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Center }) {
        ForEach(this.skills, (item: RadarSkill) => {
          Row() {
            Circle()
              .width(6)
              .height(6)
              .fill(AppColors.ACCENT)
              .margin({ right: Spacing.XS })
            Text(`${item.name} ${item.value}`)
              .fontSize(FontSize.XS)
              .fontColor(AppColors.FG_SECONDARY)
          }
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(Radius.PILL)
          .backgroundColor(AppColors.BG_HOVER)
          .margin({ left: 4, right: 4, top: 4, bottom: 4 })
        }, (item: RadarSkill) => item.name)
      }
      .width('92%')
      .margin({ top: Spacing.MD })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }

  private drawRadar() {
    const ctx = this.context
    const cx = 150
    const cy = 130
    const maxR = 90
    const n = this.skills.length
    const angleStep = Math.PI * 2 / n
    const startAngle = -Math.PI / 2

    // 绘制网格层
    for (let level = 1; level <= 4; level++) {
      const r = maxR * level / 4
      ctx.beginPath()
      for (let i = 0; i <= n; i++) {
        const angle = startAngle + i * angleStep
        const x = cx + r * Math.cos(angle)
        const y = cy + r * Math.sin(angle)
        if (i === 0) {
          ctx.moveTo(x, y)
        } else {
          ctx.lineTo(x, y)
        }
      }
      ctx.closePath()
      ctx.strokeStyle = '#2A2820'
      ctx.lineWidth = 1
      ctx.stroke()
    }

    // 绘制轴线
    for (let i = 0; i < n; i++) {
      const angle = startAngle + i * angleStep
      ctx.beginPath()
      ctx.moveTo(cx, cy)
      ctx.lineTo(cx + maxR * Math.cos(angle), cy + maxR * Math.sin(angle))
      ctx.strokeStyle = '#2A2820'
      ctx.lineWidth = 1
      ctx.stroke()
    }

    // 绘制数据多边形
    ctx.beginPath()
    for (let i = 0; i <= n; i++) {
      const idx = i % n
      const angle = startAngle + idx * angleStep
      const r = maxR * this.skills[idx].value / 100
      const x = cx + r * Math.cos(angle)
      const y = cy + r * Math.sin(angle)
      if (i === 0) {
        ctx.moveTo(x, y)
      } else {
        ctx.lineTo(x, y)
      }
    }
    ctx.closePath()
    ctx.fillStyle = '#C4A26530'
    ctx.fill()
    ctx.strokeStyle = '#C4A265'
    ctx.lineWidth = 2
    ctx.stroke()

    // 绘制数据点和标签
    for (let i = 0; i < n; i++) {
      const angle = startAngle + i * angleStep
      const r = maxR * this.skills[i].value / 100
      const x = cx + r * Math.cos(angle)
      const y = cy + r * Math.sin(angle)

      // 数据点
      ctx.beginPath()
      ctx.arc(x, y, 4, 0, Math.PI * 2)
      ctx.fillStyle = '#C4A265'
      ctx.fill()

      // 标签
      const labelR = maxR + 20
      const lx = cx + labelR * Math.cos(angle)
      const ly = cy + labelR * Math.sin(angle)
      ctx.font = '10px sans-serif'
      ctx.fillStyle = '#9A9688'
      ctx.textAlign = 'center'
      ctx.textBaseline = 'middle'
      ctx.fillText(this.skills[i].name, lx, ly)
    }
  }
}

// ============ L82 - 学习热力图 ============
@Component
export struct L82 {
  private heatData: number[][] = [
    [2, 0, 3, 1, 4, 2, 0],
    [1, 3, 2, 0, 1, 3, 2],
    [3, 4, 1, 2, 0, 1, 3],
    [0, 2, 4, 3, 1, 0, 2],
    [2, 1, 0, 4, 3, 2, 1]
  ]
  private dayLabels: string[] = ['一', '二', '三', '四', '五', '六', '日']

  private heatColor(level: number): string {
    const colors: string[] = [
      '#1E1E1B', '#3D2E10', '#5C4A1A', '#8B7340', '#C4A265'
    ]
    return colors[level]
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
        Text('←')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
        Text('学习热力图')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
          .margin({ left: Spacing.SM })
        Blank()
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 月份标题
      Text('6月学习记录')
        .fontSize(FontSize.LG)
        .fontColor(AppColors.FG)
        .fontWeight(FontWeight.Bold)
        .width('92%')
        .margin({ bottom: Spacing.MD })

      // 热力图
      Column() {
        // 星期标签行
        Row() {
          ForEach(this.dayLabels, (label: string) => {
            Text(label)
              .fontSize(FontSize.XS)
              .fontColor(AppColors.FG_DIM)
              .width('12%')
              .textAlign(TextAlign.Center)
          }, (label: string) => label)
        }
        .width('100%')
        .margin({ bottom: Spacing.XS })

        // 热力格子
        Column() {
          ForEach(this.heatData, (row: number[], rowIdx: number) => {
            Row() {
              ForEach(row, (cell: number) => {
                Column()
                  .width('12%')
                  .height(24)
                  .borderRadius(4)
                  .backgroundColor(this.heatColor(cell))
                  .margin({ left: 1, right: 1 })
              }, (cell: number, colIdx: number) => `${rowIdx}-${colIdx}`)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ bottom: 3 })
          }, (row: number[], rowIdx: number) => rowIdx.toString())
        }
        .width('100%')
      }
      .width('92%')
      .padding(Spacing.MD)
      .borderRadius(Radius.LG)
      .backgroundColor(AppColors.BG_ELEVATED)
      .border({ width: 1, color: AppColors.BORDER })

      // 图例
      Row() {
        Text('少')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_DIM)
        ForEach([0, 1, 2, 3, 4], (level: number) => {
          Column()
            .width(14)
            .height(14)
            .borderRadius(3)
            .backgroundColor(this.heatColor(level))
            .margin({ left: 3, right: 3 })
        }, (level: number) => level.toString())
        Text('多')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_DIM)
      }
      .width('92%')
      .justifyContent(FlexAlign.Center)
      .margin({ top: Spacing.MD })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ============ L83 - 成就墙 ============
@Component
export struct L83 {
  private achievements: AchievementEntry[] = [
    { icon: '🏆', name: '初学者', unlocked: true },
    { icon: '⭐', name: '连续5天', unlocked: true },
    { icon: '🎯', name: '满分通关', unlocked: true },
    { icon: '🔥', name: '学习达人', unlocked: false },
    { icon: '💎', name: '知识大师', unlocked: false },
    { icon: '👑', name: '全知全能', unlocked: false }
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
        Text('←')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
        Text('成就墙')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
          .margin({ left: Spacing.SM })
        Blank()
        Text('3/6')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.ACCENT)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 成就网格 3x2
      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
        ForEach(this.achievements, (item: AchievementEntry, idx: number) => {
          Column() {
            Text(item.icon)
              .fontSize(28)
              .opacity(item.unlocked ? 1 : 0.3)
              .margin({ bottom: Spacing.XS })
            Text(item.name)
              .fontSize(FontSize.XS)
              .fontColor(item.unlocked ? AppColors.ACCENT : AppColors.FG_DIM)
              .fontWeight(item.unlocked ? FontWeight.Bold : FontWeight.Normal)
            if (!item.unlocked) {
              Text('🔒')
                .fontSize(FontSize.XS)
                .margin({ top: 2 })
            }
          }
          .width('30%')
          .padding({ top: Spacing.MD, bottom: Spacing.MD })
          .borderRadius(Radius.MD)
          .backgroundColor(item.unlocked ? AppColors.ACCENT + '12' : AppColors.BG_ELEVATED)
          .border({
            width: 1,
            color: item.unlocked ? AppColors.ACCENT + '40' : AppColors.BORDER
          })
          .margin({ bottom: Spacing.SM })
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }, (item: AchievementEntry, idx: number) => idx.toString())
      }
      .width('92%')

      // 进度条
      Column() {
        Row() {
          Text('成就进度')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.FG_SECONDARY)
          Blank()
          Text('50%')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.ACCENT)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .margin({ bottom: Spacing.XS })
        Progress({ value: 3, total: 6, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color(AppColors.ACCENT)
          .backgroundColor(AppColors.BG_HOVER)
          .borderRadius(3)
      }
      .width('92%')
      .padding(Spacing.MD)
      .borderRadius(Radius.MD)
      .backgroundColor(AppColors.BG_ELEVATED)
      .border({ width: 1, color: AppColors.BORDER })
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

// ============ L84 - 学习DNA ============
@Component
export struct L84 {
  private traits: TraitItem[] = [
    { name: '逻辑', value: 85, color: '#C4A265' },
    { name: '创造', value: 60, color: '#D4A04A' },
    { name: '记忆', value: 70, color: '#C47A5A' },
    { name: '分析', value: 90, color: '#6A9EC4' },
    { name: '直觉', value: 45, color: '#C4B46A' }
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
        Text('←')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
        Text('学习DNA')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
          .margin({ left: Spacing.SM })
        Blank()
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 标题
      Text('你的学习特质')
        .fontSize(FontSize.LG)
        .fontColor(AppColors.FG)
        .fontWeight(FontWeight.Bold)
        .width('92%')
        .margin({ bottom: Spacing.LG })

      // 条形图
      Column() {
        ForEach(this.traits, (item: TraitItem) => {
          Column() {
            Row() {
              Text(item.name)
                .fontSize(FontSize.SM)
                .fontColor(AppColors.FG)
                .width(36)
              Stack() {
                Row()
                  .width('100%')
                  .height(20)
                  .borderRadius(10)
                  .backgroundColor(AppColors.BG_HOVER)
                Row()
                  .width(`${item.value}%`)
                  .height(20)
                  .borderRadius(10)
                  .backgroundColor(item.color + '60')
              }
              .layoutWeight(1)
              .margin({ left: Spacing.SM, right: Spacing.SM })
              Text(`${item.value}%`)
                .fontSize(FontSize.SM)
                .fontColor(item.color)
                .fontWeight(FontWeight.Bold)
                .width(36)
                .textAlign(TextAlign.End)
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .margin({ bottom: Spacing.MD })
        }, (item: TraitItem) => item.name)
      }
      .width('92%')
      .padding(Spacing.LG)
      .borderRadius(Radius.LG)
      .backgroundColor(AppColors.BG_ELEVATED)
      .border({ width: 1, color: AppColors.BORDER })

      // 底部提示
      Text('分析型学习者 — 善于逻辑推理与深度思考')
        .fontSize(FontSize.XS)
        .fontColor(AppColors.ACCENT)
        .width('92%')
        .textAlign(TextAlign.Center)
        .margin({ top: Spacing.MD })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ============ L85 - 知识星座 ============
@Component
export struct L85 {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  // 星座节点数据
  private stars: StarNode[] = [
    { x: 80, y: 60, r: 8, name: '机器学习' },
    { x: 160, y: 40, r: 6, name: '深度学习' },
    { x: 230, y: 70, r: 10, name: 'NLP' },
    { x: 50, y: 130, r: 5, name: '数学' },
    { x: 130, y: 110, r: 7, name: 'Python' },
    { x: 200, y: 140, r: 9, name: 'Transformer' },
    { x: 260, y: 120, r: 6, name: 'CNN' },
    { x: 90, y: 190, r: 4, name: '概率统计' },
    { x: 170, y: 180, r: 7, name: '神经网络' },
    { x: 240, y: 200, r: 5, name: 'CV' },
    { x: 120, y: 230, r: 6, name: '框架' },
    { x: 200, y: 240, r: 8, name: '强化学习' }
  ]

  // 连线关系
  private links: number[][] = [
    [0, 1], [1, 2], [0, 4], [1, 5], [2, 5],
    [2, 6], [3, 0], [4, 1], [5, 8], [6, 9],
    [7, 3], [8, 4], [8, 10], [9, 6], [10, 11],
    [11, 8], [0, 8], [3, 7]
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
        Text('←')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
        Text('知识星座')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
          .margin({ left: Spacing.SM })
        Blank()
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 星座画布
      Column() {
        Canvas(this.context)
          .width('100%')
          .height(280)
          .onReady(() => {
            this.drawConstellation()
          })
      }
      .width('92%')
      .borderRadius(Radius.LG)
      .backgroundColor(AppColors.BG_ELEVATED)
      .border({ width: 1, color: AppColors.BORDER })
      .clip(true)

      // 图例
      Row() {
        Circle().width(8).height(8).fill(AppColors.ACCENT).margin({ right: Spacing.XS })
        Text('精通')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_SECONDARY)
          .margin({ right: Spacing.MD })
        Circle().width(6).height(6).fill(AppColors.ACCENT_DIM).margin({ right: Spacing.XS })
        Text('学习中')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_SECONDARY)
          .margin({ right: Spacing.MD })
        Circle().width(4).height(4).fill(AppColors.FG_DIM).margin({ right: Spacing.XS })
        Text('入门')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_SECONDARY)
      }
      .width('92%')
      .justifyContent(FlexAlign.Center)
      .margin({ top: Spacing.MD })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }

  private drawConstellation() {
    const ctx = this.context

    // 绘制连线
    for (const link of this.links) {
      const a = this.stars[link[0]]
      const b = this.stars[link[1]]
      ctx.beginPath()
      ctx.moveTo(a.x, a.y)
      ctx.lineTo(b.x, b.y)
      ctx.strokeStyle = '#2A282080'
      ctx.lineWidth = 1
      ctx.stroke()
    }

    // 绘制节点和标签
    for (const star of this.stars) {
      // 光晕
      ctx.beginPath()
      ctx.arc(star.x, star.y, star.r + 4, 0, Math.PI * 2)
      ctx.fillStyle = '#C4A26515'
      ctx.fill()

      // 节点
      ctx.beginPath()
      ctx.arc(star.x, star.y, star.r, 0, Math.PI * 2)
      const fillColor = star.r >= 8 ? '#C4A265' : (star.r >= 6 ? '#8B7340' : '#5C5A52')
      ctx.fillStyle = fillColor
      ctx.fill()

      // 标签
      ctx.font = '9px sans-serif'
      ctx.fillStyle = '#9A9688'
      ctx.textAlign = 'center'
      ctx.fillText(star.name, star.x, star.y + star.r + 12)
    }
  }
}

// ============ L86 - 成长曲线 ============
@Component
export struct L86 {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private weekData: number[] = [30, 45, 60, 55, 70, 80, 90]
  private weekLabels: string[] = ['周一', '周二', '周三', '周四', '周五', '周六', '周日']

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
        Text('←')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
        Text('成长曲线')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
          .margin({ left: Spacing.SM })
        Blank()
        Text('+60')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.ACCENT)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 曲线图
      Column() {
        Canvas(this.context)
          .width('100%')
          .height(240)
          .onReady(() => {
            this.drawGrowthCurve()
          })
      }
      .width('92%')
      .borderRadius(Radius.LG)
      .backgroundColor(AppColors.BG_ELEVATED)
      .border({ width: 1, color: AppColors.BORDER })
      .clip(true)

      // 统计摘要
      Row() {
        Column() {
          Text('本周')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.FG_DIM)
          Text('90')
            .fontSize(FontSize.XXL)
            .fontColor(AppColors.ACCENT)
            .fontWeight(FontWeight.Bold)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Column() {
          Text('平均')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.FG_DIM)
          Text('61')
            .fontSize(FontSize.XXL)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Bold)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Column() {
          Text('增长')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.FG_DIM)
          Text('+200%')
            .fontSize(FontSize.XXL)
            .fontColor('#C4A265')
            .fontWeight(FontWeight.Bold)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
      }
      .width('92%')
      .padding(Spacing.MD)
      .borderRadius(Radius.MD)
      .backgroundColor(AppColors.BG_ELEVATED)
      .border({ width: 1, color: AppColors.BORDER })
      .margin({ top: Spacing.SM })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }

  private drawGrowthCurve() {
    const ctx = this.context
    const padL = 30
    const padR = 20
    const padT = 20
    const padB = 30
    const w = 280
    const h = 200
    const maxVal = 100

    // 绘制水平网格线
    for (let i = 0; i <= 4; i++) {
      const y = padT + (h - padT - padB) * i / 4
      ctx.beginPath()
      ctx.moveTo(padL, y)
      ctx.lineTo(w - padR, y)
      ctx.strokeStyle = '#2A2820'
      ctx.lineWidth = 0.5
      ctx.stroke()

      // Y轴标签
      ctx.font = '9px sans-serif'
      ctx.fillStyle = '#5C5A52'
      ctx.textAlign = 'right'
      ctx.fillText(`${maxVal - maxVal * i / 4}`, padL - 5, y + 3)
    }

    // 计算数据点
    const points: number[][] = []
    const stepX = (w - padL - padR) / (this.weekData.length - 1)
    for (let i = 0; i < this.weekData.length; i++) {
      const x = padL + i * stepX
      const y = padT + (h - padT - padB) * (1 - this.weekData[i] / maxVal)
      points.push([x, y])
    }

    // 绘制填充区域
    ctx.beginPath()
    ctx.moveTo(points[0][0], h - padB)
    for (const p of points) {
      ctx.lineTo(p[0], p[1])
    }
    ctx.lineTo(points[points.length - 1][0], h - padB)
    ctx.closePath()
    ctx.fillStyle = '#C4A26515'
    ctx.fill()

    // 绘制折线
    ctx.beginPath()
    for (let i = 0; i < points.length; i++) {
      if (i === 0) {
        ctx.moveTo(points[i][0], points[i][1])
      } else {
        ctx.lineTo(points[i][0], points[i][1])
      }
    }
    ctx.strokeStyle = '#C4A265'
    ctx.lineWidth = 2
    ctx.stroke()

    // 绘制数据点和X轴标签
    for (let i = 0; i < points.length; i++) {
      ctx.beginPath()
      ctx.arc(points[i][0], points[i][1], 4, 0, Math.PI * 2)
      ctx.fillStyle = '#C4A265'
      ctx.fill()
      ctx.beginPath()
      ctx.arc(points[i][0], points[i][1], 2, 0, Math.PI * 2)
      ctx.fillStyle = '#161614'
      ctx.fill()

      // X轴标签
      ctx.font = '9px sans-serif'
      ctx.fillStyle = '#5C5A52'
      ctx.textAlign = 'center'
      ctx.fillText(this.weekLabels[i], points[i][0], h - padB + 15)
    }
  }
}

// ============ L87 - 习惯追踪 ============
@Component
export struct L87 {
  @State checkedItems: boolean[] = [true, true, false, false, true]
  private habits: string[] = ['阅读30分钟', '完成练习', 'AI对话', '复习笔记', '代码实践']
  private habitIcons: string[] = ['📖', '✏️', '🤖', '📝', '💻']

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
        Text('←')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
        Text('习惯追踪')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
          .margin({ left: Spacing.SM })
        Blank()
        Text('3/5')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.ACCENT)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 日期
      Text('今日习惯')
        .fontSize(FontSize.LG)
        .fontColor(AppColors.FG)
        .fontWeight(FontWeight.Bold)
        .width('92%')
        .margin({ bottom: Spacing.MD })

      // 习惯列表
      Column() {
        ForEach(this.habits, (habit: string, idx: number) => {
          Row() {
            // 复选框
            Stack() {
              Column()
                .width(22)
                .height(22)
                .borderRadius(6)
                .backgroundColor(this.checkedItems[idx] ? AppColors.ACCENT : Color.Transparent)
                .border({
                  width: this.checkedItems[idx] ? 0 : 2,
                  color: this.checkedItems[idx] ? Color.Transparent : AppColors.BORDER
                })
              if (this.checkedItems[idx]) {
                Text('✓')
                  .fontSize(FontSize.XS)
                  .fontColor(AppColors.BG)
                  .fontWeight(FontWeight.Bold)
              }
            }
            .width(22)
            .height(22)
            .margin({ right: Spacing.MD })

            // 图标
            Text(this.habitIcons[idx])
              .fontSize(18)
              .margin({ right: Spacing.SM })

            // 名称
            Text(habit)
              .fontSize(FontSize.BASE)
              .fontColor(this.checkedItems[idx] ? AppColors.ACCENT : AppColors.FG)
              .fontWeight(this.checkedItems[idx] ? FontWeight.Bold : FontWeight.Normal)
              .decoration({
                type: this.checkedItems[idx] ? TextDecorationType.LineThrough : TextDecorationType.None,
                color: AppColors.ACCENT
              })
              .layoutWeight(1)

            // 状态标签
            if (this.checkedItems[idx]) {
              Text('已完成')
                .fontSize(FontSize.XS)
                .fontColor(AppColors.ACCENT)
            }
          }
          .width('100%')
          .padding({ left: Spacing.MD, right: Spacing.MD, top: 12, bottom: 12 })
          .borderRadius(Radius.MD)
          .backgroundColor(this.checkedItems[idx] ? AppColors.ACCENT + '0A' : AppColors.BG_HOVER)
          .margin({ bottom: Spacing.XS })
          .onClick(() => {
            const newItems: boolean[] = [...this.checkedItems]
            newItems[idx] = !newItems[idx]
            this.checkedItems = newItems
          })
        }, (habit: string, idx: number) => idx.toString())
      }
      .width('92%')
      .padding(Spacing.SM)
      .borderRadius(Radius.LG)
      .backgroundColor(AppColors.BG_ELEVATED)
      .border({ width: 1, color: AppColors.BORDER })

      // 进度
      Row() {
        Text('今日完成度')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_SECONDARY)
        Blank()
        Text(`${this.checkedItems.filter(v => v).length}/5`)
          .fontSize(FontSize.XS)
          .fontColor(AppColors.ACCENT)
          .fontWeight(FontWeight.Bold)
      }
      .width('92%')
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

// ============ L88 - AI画像 ============
@Component
export struct L88 {
  @State currentTab: number = 0
  private tabs: string[] = ['概览', '风格', '建议']

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
        Text('←')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
        Text('AI画像')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
          .margin({ left: Spacing.SM })
        Blank()
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 头像和名字
      Row() {
        Stack() {
          Column()
            .width(48)
            .height(48)
            .borderRadius(24)
            .backgroundColor(AppColors.ACCENT + '20')
          Text('🧑‍💻')
            .fontSize(24)
        }
        .width(48)
        .height(48)
        .margin({ right: Spacing.MD })

        Column() {
          Text('学习者 Alpha')
            .fontSize(FontSize.LG)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Bold)
          Text('AI分析 · 已学习42天')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.FG_SECONDARY)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
      }
      .width('92%')
      .margin({ bottom: Spacing.MD })

      // Tab 切换
      Row() {
        ForEach(this.tabs, (tab: string, idx: number) => {
          Column() {
            Text(tab)
              .fontSize(FontSize.SM)
              .fontColor(this.currentTab === idx ? AppColors.ACCENT : AppColors.FG_SECONDARY)
              .fontWeight(this.currentTab === idx ? FontWeight.Bold : FontWeight.Normal)
            Column()
              .width(20)
              .height(2)
              .borderRadius(1)
              .backgroundColor(this.currentTab === idx ? AppColors.ACCENT : Color.Transparent)
              .margin({ top: 4 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            this.currentTab = idx
          })
        }, (tab: string) => tab)
      }
      .width('92%')
      .padding({ bottom: Spacing.SM })
      .borderRadius({ topLeft: Radius.MD, topRight: Radius.MD })
      .backgroundColor(AppColors.BG_ELEVATED)

      // Tab 内容
      Column() {
        if (this.currentTab === 0) {
          // 概览
          this.OverviewContent()
        } else if (this.currentTab === 1) {
          // 风格
          this.StyleContent()
        } else {
          // 建议
          this.SuggestContent()
        }
      }
      .width('92%')
      .padding(Spacing.MD)
      .borderRadius({ bottomLeft: Radius.MD, bottomRight: Radius.MD })
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

  @Builder
  OverviewContent() {
    Column() {
      Row() {
        Text('学习类型')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_DIM)
        Blank()
        Text('分析型')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.ACCENT)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .margin({ bottom: Spacing.SM })

      Row() {
        Text('活跃时段')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_DIM)
        Blank()
        Text('晚间 20:00-23:00')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.FG)
      }
      .width('100%')
      .margin({ bottom: Spacing.SM })

      Row() {
        Text('偏好领域')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_DIM)
        Blank()
        Text('AI · 编程')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.FG)
      }
      .width('100%')
      .margin({ bottom: Spacing.SM })

      Row() {
        Text('专注时长')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_DIM)
        Blank()
        Text('平均45分钟')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.FG)
      }
      .width('100%')
    }
    .width('100%')
  }

  @Builder
  StyleContent() {
    Column() {
      Text('深度钻研型')
        .fontSize(FontSize.BASE)
        .fontColor(AppColors.ACCENT)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: Spacing.SM })

      Text('你喜欢深入理解概念的本质，善于建立知识之间的关联。面对新知识时，倾向于从底层原理出发，逐步构建完整的认知框架。')
        .fontSize(FontSize.XS)
        .fontColor(AppColors.FG_SECONDARY)
        .lineHeight(18)

      Row() {
        Text('逻辑性')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_DIM)
          .layoutWeight(1)
        Progress({ value: 90, total: 100, type: ProgressType.Linear })
          .width(100)
          .height(4)
          .color(AppColors.ACCENT)
          .backgroundColor(AppColors.BG_HOVER)
      }
      .width('100%')
      .margin({ top: Spacing.MD })

      Row() {
        Text('系统性')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_DIM)
          .layoutWeight(1)
        Progress({ value: 75, total: 100, type: ProgressType.Linear })
          .width(100)
          .height(4)
          .color(AppColors.BLUE)
          .backgroundColor(AppColors.BG_HOVER)
      }
      .width('100%')
      .margin({ top: Spacing.SM })
    }
    .width('100%')
  }

  @Builder
  SuggestContent() {
    Column() {
      this.SuggestItem('💡', '增加实践环节', '理论知识扎实，建议增加动手练习')
      this.SuggestItem('📚', '拓展相关领域', '可以尝试跨领域学习，如数学基础')
      this.SuggestItem('⏰', '优化学习节奏', '建议采用番茄工作法提升效率')
    }
    .width('100%')
  }

  @Builder
  SuggestItem(icon: string, title: string, desc: string) {
    Row() {
      Text(icon)
        .fontSize(18)
        .margin({ right: Spacing.SM })
      Column() {
        Text(title)
          .fontSize(FontSize.SM)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
        Text(desc)
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_SECONDARY)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .padding({ top: Spacing.SM, bottom: Spacing.SM })
  }
}

// ============ L89 - 主题切换 ============
@Component
export struct L89 {
  @State isDark: boolean = true

  build() {
    Column() {
      // 状态栏
      Row() {
        Text('9:41')
          .fontSize(FontSize.XS)
          .fontColor(this.isDark ? '#9A9688' : '#666666')
        Blank()
        Text('●●●')
          .fontSize(FontSize.XS)
          .fontColor(this.isDark ? '#9A9688' : '#666666')
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 8, bottom: 4 })

      // 导航栏
      Row() {
        Text('←')
          .fontSize(FontSize.LG)
          .fontColor(this.isDark ? '#E8E4D9' : '#1A1A1A')
        Text('主题切换')
          .fontSize(FontSize.BASE)
          .fontColor(this.isDark ? '#E8E4D9' : '#1A1A1A')
          .fontWeight(FontWeight.Medium)
          .margin({ left: Spacing.SM })
        Blank()
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 主题切换按钮
      Row() {
        // 暗色按钮
        Column() {
          Text('🌙')
            .fontSize(20)
            .margin({ bottom: Spacing.XS })
          Text('暗色')
            .fontSize(FontSize.SM)
            .fontColor(this.isDark ? '#C4A265' : '#9A9688')
            .fontWeight(this.isDark ? FontWeight.Bold : FontWeight.Normal)
        }
        .layoutWeight(1)
        .padding({ top: Spacing.MD, bottom: Spacing.MD })
        .borderRadius(Radius.MD)
        .backgroundColor(this.isDark ? '#C4A26515' : '#1E1E1B')
        .border({
          width: this.isDark ? 2 : 1,
          color: this.isDark ? '#C4A265' : '#2A2820'
        })
        .onClick(() => {
          this.isDark = true
        })

        // 亮色按钮
        Column() {
          Text('☀️')
            .fontSize(20)
            .margin({ bottom: Spacing.XS })
          Text('亮色')
            .fontSize(FontSize.SM)
            .fontColor(!this.isDark ? '#C4A265' : '#9A9688')
            .fontWeight(!this.isDark ? FontWeight.Bold : FontWeight.Normal)
        }
        .layoutWeight(1)
        .padding({ top: Spacing.MD, bottom: Spacing.MD })
        .borderRadius(Radius.MD)
        .backgroundColor(!this.isDark ? '#C4A26515' : '#1E1E1B')
        .border({
          width: !this.isDark ? 2 : 1,
          color: !this.isDark ? '#C4A265' : '#2A2820'
        })
        .margin({ left: Spacing.SM })
        .onClick(() => {
          this.isDark = false
        })
      }
      .width('92%')
      .margin({ bottom: Spacing.MD })

      // 预览卡片
      Column() {
        Text('预览效果')
          .fontSize(FontSize.LG)
          .fontColor(this.isDark ? '#E8E4D9' : '#1A1A1A')
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: Spacing.SM })

        Text('当前主题将应用于全局界面，包括背景色、文字颜色和强调色等。')
          .fontSize(FontSize.XS)
          .fontColor(this.isDark ? '#9A9688' : '#666666')
          .lineHeight(18)

        // 示例卡片
        Row() {
          Column() {
            Text('知识点')
              .fontSize(FontSize.XS)
              .fontColor(this.isDark ? '#9A9688' : '#666666')
            Text('156')
              .fontSize(FontSize.XXL)
              .fontColor('#C4A265')
              .fontWeight(FontWeight.Bold)
          }
          .layoutWeight(1)
          .padding(Spacing.SM)
          .borderRadius(Radius.SM)
          .backgroundColor(this.isDark ? '#262622' : '#F0EDE4')

          Column() {
            Text('时长')
              .fontSize(FontSize.XS)
              .fontColor(this.isDark ? '#9A9688' : '#666666')
            Text('42h')
              .fontSize(FontSize.XXL)
              .fontColor('#C4A265')
              .fontWeight(FontWeight.Bold)
          }
          .layoutWeight(1)
          .padding(Spacing.SM)
          .borderRadius(Radius.SM)
          .backgroundColor(this.isDark ? '#262622' : '#F0EDE4')
          .margin({ left: Spacing.SM })
        }
        .width('100%')
        .margin({ top: Spacing.MD })
      }
      .width('92%')
      .padding(Spacing.LG)
      .borderRadius(Radius.LG)
      .backgroundColor(this.isDark ? '#1E1E1B' : '#FAFAF5')
      .border({ width: 1, color: this.isDark ? '#2A2820' : '#E0DDD0' })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ============ L90 - 数据仪表盘 ============
@Component
export struct L90 {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private weeklyTrend: number[] = [12, 18, 8, 22, 15, 25, 20]
  private weekLabels: string[] = ['一', '二', '三', '四', '五', '六', '日']

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
        Text('←')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
        Text('数据仪表盘')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
          .margin({ left: Spacing.SM })
        Blank()
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 3个统计卡片
      Row() {
        // 知识点
        Column() {
          Text('知识点')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.FG_SECONDARY)
            .margin({ bottom: Spacing.XS })
          Text('156')
            .fontSize(FontSize.XXL)
            .fontColor(AppColors.ACCENT)
            .fontWeight(FontWeight.Bold)
        }
        .layoutWeight(1)
        .padding(Spacing.MD)
        .borderRadius(Radius.MD)
        .backgroundColor(AppColors.BG_ELEVATED)
        .border({ width: 1, color: AppColors.ACCENT + '30' })
        .alignItems(HorizontalAlign.Center)

        // 学习时长
        Column() {
          Text('学习时长')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.FG_SECONDARY)
            .margin({ bottom: Spacing.XS })
          Text('42h')
            .fontSize(FontSize.XXL)
            .fontColor(AppColors.BLUE)
            .fontWeight(FontWeight.Bold)
        }
        .layoutWeight(1)
        .padding(Spacing.MD)
        .borderRadius(Radius.MD)
        .backgroundColor(AppColors.BG_ELEVATED)
        .border({ width: 1, color: AppColors.BLUE + '30' })
        .alignItems(HorizontalAlign.Center)
        .margin({ left: Spacing.XS, right: Spacing.XS })

        // 正确率
        Column() {
          Text('正确率')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.FG_SECONDARY)
            .margin({ bottom: Spacing.XS })
          Text('89%')
            .fontSize(FontSize.XXL)
            .fontColor('#C4B46A')
            .fontWeight(FontWeight.Bold)
        }
        .layoutWeight(1)
        .padding(Spacing.MD)
        .borderRadius(Radius.MD)
        .backgroundColor(AppColors.BG_ELEVATED)
        .border({ width: 1, color: '#C4B46A30' })
        .alignItems(HorizontalAlign.Center)
      }
      .width('92%')
      .margin({ bottom: Spacing.SM })

      // 周趋势柱状图
      Column() {
        Text('周趋势')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: Spacing.SM })

        Canvas(this.context)
          .width('100%')
          .height(140)
          .onReady(() => {
            this.drawBarChart()
          })
      }
      .width('92%')
      .padding(Spacing.MD)
      .borderRadius(Radius.LG)
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

  private drawBarChart() {
    const ctx = this.context
    const padL = 10
    const padR = 10
    const padT = 10
    const padB = 20
    const w = 280
    const h = 130
    const maxVal = 30
    const barCount = this.weeklyTrend.length
    const barGap = 8
    const totalBarWidth = w - padL - padR
    const barWidth = (totalBarWidth - barGap * (barCount - 1)) / barCount

    for (let i = 0; i < barCount; i++) {
      const barH = (h - padT - padB) * this.weeklyTrend[i] / maxVal
      const x = padL + i * (barWidth + barGap)
      const y = h - padB - barH

      // 柱体
      ctx.beginPath()
      ctx.roundRect(x, y, barWidth, barH, 4)
      ctx.fillStyle = i === 5 ? '#C4A265' : '#8B7340'
      ctx.fill()

      // X轴标签
      ctx.font = '9px sans-serif'
      ctx.fillStyle = '#5C5A52'
      ctx.textAlign = 'center'
      ctx.fillText(this.weekLabels[i], x + barWidth / 2, h - padB + 12)
    }
  }
}
