// 色彩策略分类布局 - L61~L70
import { AppColors, FontSize, Radius, Spacing } from '../common/Constants'
import { MonoItem, CompItem, AnalogItem, LightItem, NatureItem, RainbowItem } from './LayoutTypes'

// ============ L61 - 单色系 ============
@Component
export struct L61 {
  private monoItems: MonoItem[] = [
    { name: '机器学习', cat: 'AI基础', opacity: 0.25 },
    { name: '深度学习', cat: 'AI基础', opacity: 0.20 },
    { name: '神经网络', cat: 'AI基础', opacity: 0.15 },
    { name: '强化学习', cat: 'AI基础', opacity: 0.10 },
    { name: '线性代数', cat: '数学', opacity: 0.05 }
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
        Text('单色系')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 说明
      Text('仅用金色透明度变化建立层次')
        .fontSize(FontSize.XS)
        .fontColor(AppColors.FG_DIM)
        .width('92%')
        .margin({ bottom: Spacing.MD })

      // 单色系卡片
      Column() {
        ForEach(this.monoItems, (item: MonoItem) => {
          Row() {
            // 左侧金色边条
            Column()
              .width(3)
              .height('100%')
              .backgroundColor('#C4A265')

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
            .margin({ left: Spacing.MD })

            // 透明度指示
            Text(`${Math.round(item.opacity * 100)}%`)
              .fontSize(FontSize.XS)
              .fontColor('#C4A265')
              .fontWeight(FontWeight.Bold)
          }
          .width('100%')
          .height(52)
          .padding({ right: Spacing.MD })
          .borderRadius(Radius.MD)
          .backgroundColor(`rgba(196,162,101,${item.opacity})`)
          .border({ width: 1, color: AppColors.BORDER })
          .margin({ bottom: Spacing.SM })
          .alignItems(VerticalAlign.Center)
        }, (item: MonoItem) => item.name)
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

// ============ L62 - 互补色 ============
@Component
export struct L62 {
  private compItems: CompItem[] = [
    { name: '机器学习', cat: 'AI基础', theme: 'gold' },
    { name: 'NLP', cat: '自然语言', theme: 'blue' },
    { name: '深度学习', cat: 'AI基础', theme: 'gold' },
    { name: '计算机视觉', cat: 'CV', theme: 'blue' },
    { name: '强化学习', cat: 'AI基础', theme: 'gold' },
    { name: '数据结构', cat: '编程', theme: 'blue' }
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
        Text('互补色')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 色彩图例
      Row() {
        Row() {
          Circle().width(8).height(8).fill('#C4A265').margin({ right: Spacing.XS })
          Text('金色系')
            .fontSize(FontSize.XS)
            .fontColor('#C4A265')
        }
        Row() {
          Circle().width(8).height(8).fill('#6A9EC4').margin({ right: Spacing.XS })
          Text('蓝色系')
            .fontSize(FontSize.XS)
            .fontColor('#6A9EC4')
        }
        .margin({ left: Spacing.LG })
      }
      .width('92%')
      .margin({ bottom: Spacing.MD })

      // 2列互补色网格
      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
        ForEach(this.compItems, (item: CompItem) => {
          Row() {
            Column()
              .width(3)
              .height('100%')
              .backgroundColor(item.theme === 'gold' ? '#C4A265' : '#6A9EC4')

            Column() {
              Text(item.name)
                .fontSize(FontSize.SM)
                .fontColor(AppColors.FG)
                .fontWeight(FontWeight.Medium)
              Text(item.cat)
                .fontSize(FontSize.XS)
                .fontColor(item.theme === 'gold' ? '#C4A265' : '#6A9EC4')
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)
            .margin({ left: Spacing.SM })
          }
          .width('47%')
          .height(56)
          .padding({ right: Spacing.SM })
          .borderRadius(Radius.MD)
          .backgroundColor(AppColors.BG_ELEVATED)
          .border({ width: 1, color: item.theme === 'gold' ? '#C4A26530' : '#6A9EC430' })
          .margin({ bottom: Spacing.SM })
          .alignItems(VerticalAlign.Center)
        }, (item: CompItem) => item.name)
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

// ============ L63 - 类似色 ============
@Component
export struct L63 {
  private analogItems: AnalogItem[] = [
    { name: '机器学习', cat: 'AI基础', borderColor: '#C4A265', bgColor: '#C4A26510' },
    { name: '深度学习', cat: 'AI基础', borderColor: '#D4A84A', bgColor: '#D4A84A10' },
    { name: '神经网络', cat: 'AI基础', borderColor: '#B8923A', bgColor: '#B8923A10' },
    { name: '强化学习', cat: 'AI基础', borderColor: '#A88430', bgColor: '#A8843010' },
    { name: '线性代数', cat: '数学', borderColor: '#8B7340', bgColor: '#8B734010' }
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
        Text('类似色')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 渐变色带展示
      Row() {
        ForEach(this.analogItems, (item: AnalogItem, idx: number) => {
          Column()
            .layoutWeight(1)
            .height(6)
            .backgroundColor(item.borderColor)
            .borderRadius(idx === 0 ? { topLeft: 3, bottomLeft: 3 } :
              idx === this.analogItems.length - 1 ? { topRight: 3, bottomRight: 3 } : 0)
        }, (item: AnalogItem) => item.borderColor)
      }
      .width('92%')
      .margin({ bottom: Spacing.LG })

      // 类似色卡片
      Column() {
        ForEach(this.analogItems, (item: AnalogItem) => {
          Row() {
            Column()
              .width(3)
              .height('100%')
              .backgroundColor(item.borderColor)

            Column() {
              Text(item.name)
                .fontSize(FontSize.BASE)
                .fontColor(AppColors.FG)
                .fontWeight(FontWeight.Medium)
              Text(item.cat)
                .fontSize(FontSize.XS)
                .fontColor(item.borderColor)
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
            .margin({ left: Spacing.MD })

            Circle().width(10).height(10).fill(item.borderColor)
          }
          .width('100%')
          .height(52)
          .padding({ right: Spacing.MD })
          .borderRadius(Radius.MD)
          .backgroundColor(item.bgColor)
          .border({ width: 1, color: item.borderColor + '30' })
          .margin({ bottom: Spacing.SM })
          .alignItems(VerticalAlign.Center)
        }, (item: AnalogItem) => item.name)
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

// ============ L64 - 渐变流动 ============
@Component
export struct L64 {
  @State hueValue: number = 40

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
        Text('渐变流动')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 大渐变卡片
      Column() {
        Text('知识图谱导师')
          .fontSize(FontSize.XXL)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)
          .textShadow({ radius: 8, color: '#000000', offsetX: 0, offsetY: 2 })

        Text('探索你的学习宇宙')
          .fontSize(FontSize.SM)
          .fontColor('#FFFFFFCC')
          .margin({ top: Spacing.XS })
          .textShadow({ radius: 4, color: '#000000', offsetX: 0, offsetY: 1 })
      }
      .width('92%')
      .height(160)
      .borderRadius(Radius.LG)
      .linearGradient({
        direction: GradientDirection.RightBottom,
        colors: [
          [`hsl(${this.hueValue}, 60%, 45%)`, 0.0],
          [`hsl(${this.hueValue + 40}, 50%, 35%)`, 0.5],
          [`hsl(${this.hueValue + 80}, 40%, 25%)`, 1.0]
        ]
      })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .margin({ bottom: Spacing.LG })

      // 色相滑块
      Column() {
        Text('调整色相')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_SECONDARY)
          .margin({ bottom: Spacing.XS })

        Slider({
          value: this.hueValue,
          min: 0,
          max: 360,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .trackColor(AppColors.BG_HOVER)
          .selectedColor('#C4A265')
          .blockColor('#C4A265')
          .onChange((value: number) => {
            this.hueValue = Math.round(value)
          })

        Row() {
          Text(`色相: ${this.hueValue}°`)
            .fontSize(FontSize.SM)
            .fontColor(AppColors.ACCENT)
            .fontWeight(FontWeight.Bold)
          Blank()
          Text(`HSL(${this.hueValue}, 60%, 45%)`)
            .fontSize(FontSize.XS)
            .fontColor(AppColors.FG_DIM)
        }
        .width('100%')
        .margin({ top: Spacing.XS })
      }
      .width('92%')
      .padding(Spacing.MD)
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

// ============ L65 - 暗色极简 ============
@Component
export struct L65 {
  build() {
    Column() {
      // 状态栏
      Row() {
        Text('9:41')
          .fontSize(FontSize.XS)
          .fontColor('#333333')
        Blank()
        Text('●●●')
          .fontSize(FontSize.XS)
          .fontColor('#333333')
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 8, bottom: 4 })

      Blank().layoutWeight(1)

      // 极简内容
      Column() {
        Text('AI')
          .fontSize(56)
          .fontColor('#1A1A18')
          .fontWeight(FontWeight.Lighter)
          .letterSpacing(8)

        // 细横线
        Column()
          .width(60)
          .height(1)
          .backgroundColor('#1A1A18')
          .margin({ top: Spacing.LG, bottom: Spacing.LG })

        Text('知识图谱导师')
          .fontSize(FontSize.SM)
          .fontColor('#1A1A18')
          .letterSpacing(4)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Blank().layoutWeight(1)
    }
    .width('100%')
    .height(444)
    .backgroundColor('#000000')
    .borderRadius(24)
    .border({ width: 2, color: '#1A1A18' })
    .clip(true)
  }
}

// ============ L66 - 亮色清新 ============
@Component
export struct L66 {
  private lightItems: LightItem[] = [
    { name: '机器学习', cat: 'AI基础', icon: '🤖' },
    { name: '深度学习', cat: 'AI基础', icon: '🧠' },
    { name: 'NLP', cat: '自然语言', icon: '💬' },
    { name: '计算机视觉', cat: 'CV', icon: '👁' }
  ]

  build() {
    Column() {
      // 状态栏
      Row() {
        Text('9:41')
          .fontSize(FontSize.XS)
          .fontColor('#9A9688')
        Blank()
        Text('●●●')
          .fontSize(FontSize.XS)
          .fontColor('#9A9688')
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 8, bottom: 4 })

      // 导航栏
      Row() {
        Text('亮色清新')
          .fontSize(FontSize.BASE)
          .fontColor('#1a1a18')
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 标题
      Text('学习概览')
        .fontSize(FontSize.XXL)
        .fontColor('#1a1a18')
        .fontWeight(FontWeight.Bold)
        .width('92%')
        .margin({ bottom: Spacing.LG })

      // 亮色卡片
      Column() {
        ForEach(this.lightItems, (item: LightItem) => {
          Row() {
            Text(item.icon)
              .fontSize(24)
              .margin({ right: Spacing.MD })

            Column() {
              Text(item.name)
                .fontSize(FontSize.BASE)
                .fontColor('#1a1a18')
                .fontWeight(FontWeight.Medium)
              Text(item.cat)
                .fontSize(FontSize.XS)
                .fontColor('#9A9688')
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Text('→')
              .fontSize(FontSize.BASE)
              .fontColor('#C4A265')
          }
          .width('100%')
          .padding(Spacing.MD)
          .borderRadius(Radius.MD)
          .backgroundColor('#FFFFFF')
          .shadow({ radius: 4, color: '#0000000A', offsetX: 0, offsetY: 2 })
          .margin({ bottom: Spacing.SM })
          .alignItems(VerticalAlign.Center)
        }, (item: LightItem) => item.name)
      }
      .width('92%')
    }
    .width('100%')
    .height(444)
    .backgroundColor('#f5f3ed')
    .borderRadius(24)
    .border({ width: 2, color: '#e0ddd4' })
    .clip(true)
  }
}

// ============ L67 - 霓虹赛博 ============
@Component
export struct L67 {
  private neonItems: string[] = ['机器学习', '深度学习', 'NLP', '计算机视觉', '强化学习']

  build() {
    Column() {
      // 状态栏
      Row() {
        Text('9:41')
          .fontSize(FontSize.XS)
          .fontColor('#00ff8880')
        Blank()
        Text('●●●')
          .fontSize(FontSize.XS)
          .fontColor('#00ff8880')
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 8, bottom: 4 })

      // 导航栏
      Row() {
        Text('霓虹赛博')
          .fontSize(FontSize.BASE)
          .fontColor('#00ff88')
          .fontWeight(FontWeight.Bold)
          .textShadow({ radius: 12, color: '#00ff8866', offsetX: 0, offsetY: 0 })
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 大标题
      Text('CYBER GRAPH')
        .fontSize(FontSize.XXL)
        .fontColor('#00ff88')
        .fontWeight(FontWeight.Bolder)
        .letterSpacing(4)
        .textShadow({ radius: 20, color: '#00ff8844', offsetX: 0, offsetY: 0 })
        .margin({ bottom: Spacing.LG })

      // 霓虹卡片
      Column() {
        ForEach(this.neonItems, (item: string, idx: number) => {
          Row() {
            Text('>')
              .fontSize(FontSize.BASE)
              .fontColor('#00ff88')
              .fontWeight(FontWeight.Bold)
              .textShadow({ radius: 8, color: '#00ff8866', offsetX: 0, offsetY: 0 })
              .margin({ right: Spacing.SM })

            Text(item)
              .fontSize(FontSize.BASE)
              .fontColor('#00ff88')
              .textShadow({ radius: 8, color: '#00ff8844', offsetX: 0, offsetY: 0 })
              .layoutWeight(1)

            Text(`0${idx + 1}`)
              .fontSize(FontSize.XS)
              .fontColor('#00ff8880')
          }
          .width('100%')
          .padding(Spacing.MD)
          .borderRadius(Radius.SM)
          .backgroundColor('#0a0014')
          .border({ width: 1, color: '#00ff8840' })
          .margin({ bottom: Spacing.SM })
          .alignItems(VerticalAlign.Center)
        }, (item: string) => item)
      }
      .width('92%')

      // 底部装饰线
      Row()
        .width('92%')
        .height(2)
        .backgroundColor('#00ff8830')
        .margin({ top: Spacing.MD })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#0a0014')
    .borderRadius(24)
    .border({ width: 2, color: '#00ff8840' })
    .clip(true)
  }
}

// ============ L68 - 自然色系 ============
@Component
export struct L68 {
  private natureItems: NatureItem[] = [
    { name: '机器学习', cat: 'AI基础', color: '#6B8E6B' },
    { name: '深度学习', cat: 'AI基础', color: '#8B7355' },
    { name: 'NLP', cat: '自然语言', color: '#6A9EC4' },
    { name: '计算机视觉', cat: 'CV', color: '#C4A265' },
    { name: '强化学习', cat: 'AI基础', color: '#8FA88F' }
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
        Text('自然色系')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 色板展示
      Row() {
        ForEach(this.natureItems, (item: NatureItem) => {
          Column() {
            Circle().width(20).height(20).fill(item.color)
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
        }, (item: NatureItem) => item.color)
      }
      .width('92%')
      .height(40)
      .borderRadius(Radius.MD)
      .backgroundColor(AppColors.BG_ELEVATED)
      .border({ width: 1, color: AppColors.BORDER })
      .margin({ bottom: Spacing.LG })

      // 自然色卡片
      Column() {
        ForEach(this.natureItems, (item: NatureItem) => {
          Row() {
            Column()
              .width(3)
              .height('100%')
              .backgroundColor(item.color)

            Column() {
              Text(item.name)
                .fontSize(FontSize.BASE)
                .fontColor(AppColors.FG)
                .fontWeight(FontWeight.Medium)
              Text(item.cat)
                .fontSize(FontSize.XS)
                .fontColor(item.color)
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
            .margin({ left: Spacing.MD })

            Circle().width(8).height(8).fill(item.color)
          }
          .width('100%')
          .height(48)
          .padding({ right: Spacing.MD })
          .borderRadius(Radius.MD)
          .backgroundColor(AppColors.BG_ELEVATED)
          .border({ width: 1, color: item.color + '30' })
          .margin({ bottom: Spacing.SM })
          .alignItems(VerticalAlign.Center)
        }, (item: NatureItem) => item.name)
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

// ============ L69 - 品牌金 ============
@Component
export struct L69 {
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
        Text('品牌金')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 大英雄卡片 - 金色渐变边框
      Column() {
        Text('知识图谱导师')
          .fontSize(FontSize.XXL)
          .fontColor('#C4A265')
          .fontWeight(FontWeight.Bold)
          .textShadow({ radius: 8, color: '#C4A26544', offsetX: 0, offsetY: 0 })

        Text('你的专属AI学习伙伴')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.FG_SECONDARY)
          .margin({ top: Spacing.XS })

        // 金色装饰线
        Row()
          .width(40)
          .height(2)
          .linearGradient({
            direction: GradientDirection.Right,
            colors: [['#C4A265', 0.0], ['#8B7340', 1.0]]
          })
          .margin({ top: Spacing.MD })
      }
      .width('92%')
      .height(120)
      .borderRadius(Radius.LG)
      .backgroundColor(AppColors.BG_ELEVATED)
      .border({
        width: 2,
        color: '#C4A265'
      })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .margin({ bottom: Spacing.MD })

      // 小品牌金卡片
      Row() {
        this.BrandCard('机器学习', 'Lv.3')
        this.BrandCard('深度学习', 'Lv.4')
      }
      .width('92%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
        this.BrandCard('NLP', 'Lv.5')
        this.BrandCard('CNN', 'Lv.4')
      }
      .width('92%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: Spacing.SM })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }

  @Builder
  BrandCard(name: string, level: string) {
    Column() {
      Text(name)
        .fontSize(FontSize.BASE)
        .fontColor(AppColors.FG)
        .fontWeight(FontWeight.Medium)
      Text(level)
        .fontSize(FontSize.XS)
        .fontColor('#C4A265')
        .margin({ top: 2 })
    }
    .width('47%')
    .padding(Spacing.MD)
    .borderRadius(Radius.MD)
    .backgroundColor(AppColors.BG_ELEVATED)
    .border({ width: 1, color: '#C4A26540' })
    .alignItems(HorizontalAlign.Start)
  }
}

// ============ L70 - 彩虹分类 ============
@Component
export struct L70 {
  private rainbowItems: RainbowItem[] = [
    { name: '机器学习', color: '#C4A265' },
    { name: '中国历史', color: '#C47A5A' },
    { name: 'Python编程', color: '#6A9EC4' },
    { name: '前端开发', color: '#C46AA0' },
    { name: '经济学', color: '#C4B46A' },
    { name: '心理学', color: '#8A6AC4' },
    { name: '区块链', color: '#6AC4B4' },
    { name: '产品经理', color: '#C45A7A' },
    { name: '数学', color: '#C4C46A' },
    { name: '物理', color: '#6AB4C4' }
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
        Text('彩虹分类')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 说明
      Text('每个知识领域拥有独特色彩标识')
        .fontSize(FontSize.XS)
        .fontColor(AppColors.FG_DIM)
        .width('92%')
        .margin({ bottom: Spacing.MD })

      // 5x2 彩虹网格
      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
        ForEach(this.rainbowItems, (item: RainbowItem) => {
          Row() {
            Circle()
              .width(8)
              .height(8)
              .fill(item.color)
              .margin({ right: Spacing.XS })

            Text(item.name)
              .fontSize(FontSize.XS)
              .fontColor(AppColors.FG_SECONDARY)
          }
          .width('47%')
          .padding({ top: 10, bottom: 10, left: Spacing.SM, right: Spacing.SM })
          .borderRadius(Radius.SM)
          .backgroundColor(AppColors.BG_ELEVATED)
          .border({ width: 1, color: item.color + '30' })
          .margin({ bottom: Spacing.SM })
          .alignItems(VerticalAlign.Center)
        }, (item: RainbowItem) => item.name)
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
