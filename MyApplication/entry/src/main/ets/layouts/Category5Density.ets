// 信息密度分类布局 - L41~L50
import { AppColors, FontSize, Radius, Spacing } from '../common/Constants'
import { KN_DATA, KnowledgeNode, BarDataItem } from './LayoutTypes'

// ============ L41 - 极简一卡 ============
@Component
export struct L41 {
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
        Text('极简一卡')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 主体 - 居中单卡
      Column() {
        Blank().layoutWeight(1)

        Column() {
          // 图标
          Stack() {
            Text('🧠')
              .fontSize(32)
          }
          .width(64)
          .height(64)
          .borderRadius(32)
          .backgroundColor(AppColors.ACCENT + '15')
          .alignContent(Alignment.Center)
          .margin({ bottom: Spacing.LG })

          // 标题
          Text('神经网络')
            .fontSize(FontSize.XXL)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Bold)

          // 副标题
          Text('今日学习 · 15分钟')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.FG_SECONDARY)
            .margin({ top: Spacing.XS })

          // 按钮
          Button('开始学习')
            .height(40)
            .fontSize(FontSize.BASE)
            .fontWeight(FontWeight.Bold)
            .backgroundColor(AppColors.ACCENT)
            .fontColor(AppColors.BG)
            .borderRadius(Radius.PILL)
            .padding({ left: 32, right: 32 })
            .margin({ top: Spacing.XL })
        }
        .width('80%')
        .padding(Spacing.XL)
        .borderRadius(Radius.LG)
        .backgroundColor(AppColors.BG_ELEVATED)
        .border({ width: 1, color: AppColors.BORDER })
        .alignItems(HorizontalAlign.Center)

        Blank().layoutWeight(1)
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

// ============ L42 - 仪表盘 ============
@Component
export struct L42 {
  @State period: number = 0

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
        Text('仪表盘')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 周期选择器
      Row() {
        ForEach(['日', '周', '月'], (label: string, idx: number) => {
          Text(label)
            .fontSize(FontSize.SM)
            .fontColor(this.period === idx ? AppColors.BG : AppColors.FG_SECONDARY)
            .fontWeight(this.period === idx ? FontWeight.Bold : FontWeight.Normal)
            .padding({ left: 16, right: 16, top: 6, bottom: 6 })
            .borderRadius(Radius.PILL)
            .backgroundColor(this.period === idx ? AppColors.ACCENT : AppColors.BG_ELEVATED)
            .onClick(() => { this.period = idx })
        }, (label: string) => label)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ bottom: Spacing.MD })

      // 2x2 统计卡片
      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
        this.StatCard('学习小时', '12', 'h', AppColors.ACCENT)
        this.StatCard('正确率', '87', '%', AppColors.BLUE)
        this.StatCard('知识点', '24', '个', AppColors.ACCENT)
        this.StatCard('连续天', '5', '天', '#C4B46A')
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

  @Builder
  StatCard(title: string, value: string, unit: string, accent: string) {
    Column() {
      Text(title)
        .fontSize(FontSize.XS)
        .fontColor(AppColors.FG_SECONDARY)
        .margin({ bottom: Spacing.SM })
      Row() {
        Text(value)
          .fontSize(FontSize.XXL)
          .fontColor(accent)
          .fontWeight(FontWeight.Bold)
        Text(unit)
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_DIM)
          .margin({ left: 2 })
      }
    }
    .width('47%')
    .padding(Spacing.MD)
    .borderRadius(Radius.MD)
    .backgroundColor(AppColors.BG_ELEVATED)
    .border({ width: 1, color: AppColors.BORDER })
    .margin({ bottom: Spacing.SM })
    .alignItems(HorizontalAlign.Start)
  }
}

// ============ L43 - 杂志排版 ============
@Component
export struct L43 {
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
        Text('杂志排版')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 大封面卡片
      Column() {
        Text('封面故事')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.ACCENT)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
          .margin({ bottom: Spacing.XS })

        Text('Transformer革命')
          .fontSize(FontSize.XXL)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text('从注意力机制到GPT，一场改变NLP格局的技术浪潮')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.FG_SECONDARY)
          .margin({ top: Spacing.XS })
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .width('92%')
      .padding(Spacing.LG)
      .borderRadius(Radius.LG)
      .backgroundColor(AppColors.BG_ELEVATED)
      .border({ width: 1, color: AppColors.BORDER })
      .margin({ bottom: Spacing.SM })

      // 两个小卡片
      Row() {
        Column() {
          Text('深度学习')
            .fontSize(FontSize.BASE)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Medium)
          Text('多层神经网络的前世今生')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.FG_SECONDARY)
            .margin({ top: 2 })
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .width('47%')
        .padding(Spacing.MD)
        .borderRadius(Radius.MD)
        .backgroundColor(AppColors.BG_ELEVATED)
        .border({ width: 1, color: AppColors.BORDER })
        .alignItems(HorizontalAlign.Start)

        Column() {
          Text('CNN')
            .fontSize(FontSize.BASE)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Medium)
          Text('卷积神经网络的视觉魔法')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.FG_SECONDARY)
            .margin({ top: 2 })
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .width('47%')
        .padding(Spacing.MD)
        .borderRadius(Radius.MD)
        .backgroundColor(AppColors.BG_ELEVATED)
        .border({ width: 1, color: AppColors.BORDER })
        .alignItems(HorizontalAlign.Start)
      }
      .width('92%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ============ L44 - 瀑布流 ============
@Component
export struct L44 {
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
        Text('瀑布流')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 双列瀑布流
      Row() {
        // 左列
        Column() {
          this.WaterfallCard('机器学习', 'AI基础', 3, true)
          this.WaterfallCard('线性代数', '数学', 1, false)
          this.WaterfallCard('Transformer', 'NLP', 5, true)
        }
        .width('48%')

        // 右列
        Column() {
          this.WaterfallCard('深度学习', 'AI基础', 4, false)
          this.WaterfallCard('Python编程', '编程', 2, true)
          this.WaterfallCard('CNN', 'CV', 4, false)
        }
        .width('48%')
      }
      .width('92%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }

  @Builder
  WaterfallCard(name: string, cat: string, lv: number, extended: boolean) {
    Column() {
      Text(name)
        .fontSize(FontSize.BASE)
        .fontColor(AppColors.FG)
        .fontWeight(FontWeight.Medium)

      Text(cat)
        .fontSize(FontSize.XS)
        .fontColor(AppColors.ACCENT)
        .margin({ top: 2 })

      if (extended) {
        Text('掌握核心概念，建立系统性认知框架，从基础到进阶全面覆盖。')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_DIM)
          .margin({ top: Spacing.XS })
          .maxLines(3)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }

      // 等级指示
      Row() {
        ForEach([1, 2, 3, 4, 5], (i: number) => {
          Circle()
            .width(6)
            .height(6)
            .fill(i <= lv ? AppColors.ACCENT : AppColors.BORDER)
            .margin({ right: 3 })
        }, (i: number) => i.toString())
      }
      .margin({ top: Spacing.XS })
    }
    .width('100%')
    .padding(Spacing.MD)
    .borderRadius(Radius.MD)
    .backgroundColor(AppColors.BG_ELEVATED)
    .border({ width: 1, color: AppColors.BORDER })
    .margin({ bottom: Spacing.SM })
    .alignItems(HorizontalAlign.Start)
  }
}

// ============ L45 - 列表流 ============
@Component
export struct L45 {
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
        Text('列表流')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 列表
      Column() {
        ForEach(KN_DATA.slice(0, 8), (item: KnowledgeNode, idx: number) => {
          Row() {
            // 序号
            Text(`${idx + 1}`)
              .fontSize(FontSize.SM)
              .fontColor(AppColors.ACCENT)
              .fontWeight(FontWeight.Bold)
              .width(24)
              .textAlign(TextAlign.Center)

            // 名称
            Text(item.name)
              .fontSize(FontSize.BASE)
              .fontColor(AppColors.FG)
              .layoutWeight(1)
              .margin({ left: Spacing.SM })

            // 分类
            Text(item.cat)
              .fontSize(FontSize.XS)
              .fontColor(AppColors.FG_SECONDARY)
              .padding({ left: 6, right: 6, top: 2, bottom: 2 })
              .borderRadius(Radius.SM)
              .backgroundColor(AppColors.BG_HOVER)

            // 等级
            Text(`Lv.${item.lv}`)
              .fontSize(FontSize.XS)
              .fontColor(AppColors.ACCENT_DIM)
              .margin({ left: Spacing.SM })
          }
          .width('100%')
          .padding({ left: Spacing.MD, right: Spacing.MD, top: 10, bottom: 10 })
          .borderRadius(Radius.SM)
          .backgroundColor(idx % 2 === 0 ? AppColors.BG_ELEVATED : Color.Transparent)
          .margin({ bottom: 1 })
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

// ============ L46 - 双列对比 ============
@Component
export struct L46 {
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
        Text('双列对比')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 对比标题
      Row() {
        Text('CNN')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.BLUE)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('VS')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_DIM)
          .width(30)
          .textAlign(TextAlign.Center)

        Text('RNN')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.ACCENT)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('92%')
      .margin({ bottom: Spacing.MD })

      // 对比内容
      Row() {
        // CNN 列
        Column() {
          this.ComparePoint('擅长图像处理')
          this.ComparePoint('空间特征提取')
          this.ComparePoint('局部感知')
          this.ComparePoint('参数共享')
          this.ComparePoint('并行计算友好')
        }
        .width('47%')
        .padding(Spacing.MD)
        .borderRadius(Radius.MD)
        .backgroundColor(AppColors.BG_ELEVATED)
        .border({ width: 1, color: AppColors.BLUE + '30' })
        .alignItems(HorizontalAlign.Start)

        // RNN 列
        Column() {
          this.ComparePoint('擅长序列处理')
          this.ComparePoint('时序特征提取')
          this.ComparePoint('上下文依赖')
          this.ComparePoint('参数复用')
          this.ComparePoint('串行计算为主')
        }
        .width('47%')
        .padding(Spacing.MD)
        .borderRadius(Radius.MD)
        .backgroundColor(AppColors.BG_ELEVATED)
        .border({ width: 1, color: AppColors.ACCENT + '30' })
        .alignItems(HorizontalAlign.Start)
      }
      .width('92%')
      .justifyContent(FlexAlign.SpaceBetween)

      // 详细对比按钮
      Button('详细对比')
        .width('92%')
        .height(36)
        .fontSize(FontSize.SM)
        .fontWeight(FontWeight.Bold)
        .backgroundColor(Color.Transparent)
        .fontColor(AppColors.ACCENT)
        .borderRadius(Radius.MD)
        .border({ width: 1, color: AppColors.ACCENT + '40' })
        .margin({ top: Spacing.MD })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }

  @Builder
  ComparePoint(text: string) {
    Row() {
      Text('·')
        .fontSize(FontSize.MD)
        .fontColor(AppColors.FG_DIM)
        .margin({ right: Spacing.XS })
      Text(text)
        .fontSize(FontSize.XS)
        .fontColor(AppColors.FG_SECONDARY)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
  }
}

// ============ L47 - 时间线流 ============
@Component
export struct L47 {
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
        Text('时间线流')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 时间线
      Column() {
        this.TimelineItem('09:00', '学习机器学习基础', true)
        this.TimelineConnector()
        this.TimelineItem('10:30', '完成神经网络测验', false)
        this.TimelineConnector()
        this.TimelineItem('14:00', '复习深度学习笔记', true)
        this.TimelineConnector()
        this.TimelineItem('15:30', 'CNN实战练习', false)
        this.TimelineConnector()
        this.TimelineItem('17:00', '整理知识图谱', true)
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

  @Builder
  TimelineItem(time: string, desc: string, active: boolean) {
    Row() {
      // 时间
      Text(time)
        .fontSize(FontSize.XS)
        .fontColor(active ? AppColors.ACCENT : AppColors.FG_DIM)
        .fontWeight(active ? FontWeight.Bold : FontWeight.Normal)
        .width(40)

      // 圆点
      Stack() {
        Circle()
          .width(active ? 12 : 8)
          .height(active ? 12 : 8)
          .fill(active ? AppColors.ACCENT : AppColors.BORDER)
      }
      .width(16)
      .alignContent(Alignment.Center)
      .margin({ left: Spacing.SM, right: Spacing.SM })

      // 描述
      Text(desc)
        .fontSize(FontSize.SM)
        .fontColor(active ? AppColors.FG : AppColors.FG_SECONDARY)
        .layoutWeight(1)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TimelineConnector() {
    Row() {
      Blank().width(40)
      Column()
        .width(2)
        .height(20)
        .backgroundColor(AppColors.BORDER)
        .margin({ left: Spacing.SM + 7 })
    }
    .width('100%')
  }
}

// ============ L48 - 网格缩略 ============
@Component
export struct L48 {
  @State selectedIndex: number = -1

  private gridItems: string[] = [
    '机器学习', '深度学习', 'NLP',
    '计算机视觉', '强化学习', '数学',
    'Python', '框架', '神经网络'
  ]
  private gridIcons: string[] = [
    '🤖', '🧠', '💬',
    '👁', '🎮', '📐',
    '🐍', '🔧', '🔗'
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
        Text('网格缩略')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 3x3 网格
      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
        ForEach(this.gridItems, (item: string, idx: number) => {
          Column() {
            Text(this.gridIcons[idx])
              .fontSize(22)
              .margin({ bottom: Spacing.XS })
            Text(item)
              .fontSize(FontSize.XS)
              .fontColor(this.selectedIndex === idx ? AppColors.ACCENT : AppColors.FG_SECONDARY)
              .fontWeight(this.selectedIndex === idx ? FontWeight.Bold : FontWeight.Normal)
          }
          .width('30%')
          .padding({ top: Spacing.MD, bottom: Spacing.MD })
          .borderRadius(Radius.MD)
          .backgroundColor(this.selectedIndex === idx ? AppColors.ACCENT + '15' : AppColors.BG_ELEVATED)
          .border({
            width: this.selectedIndex === idx ? 2 : 1,
            color: this.selectedIndex === idx ? AppColors.ACCENT : AppColors.BORDER
          })
          .margin({ bottom: Spacing.SM })
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            this.selectedIndex = this.selectedIndex === idx ? -1 : idx
          })
        }, (item: string) => item)
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

// ============ L49 - 混合密度 ============
@Component
export struct L49 {
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
        Text('混合密度')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 标题
      Text('学习概览')
        .fontSize(FontSize.XXL)
        .fontColor(AppColors.FG)
        .fontWeight(FontWeight.Bold)
        .width('92%')
        .margin({ bottom: Spacing.MD })

      // 两个统计胶囊
      Row() {
        Row() {
          Circle()
            .width(8)
            .height(8)
            .fill(AppColors.ACCENT)
            .margin({ right: Spacing.XS })
          Text('已掌握 18')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.ACCENT)
        }
        .padding({ left: 12, right: 12, top: 6, bottom: 6 })
        .borderRadius(Radius.PILL)
        .backgroundColor(AppColors.ACCENT + '15')
        .border({ width: 1, color: AppColors.ACCENT + '30' })

        Row() {
          Circle()
            .width(8)
            .height(8)
            .fill(AppColors.BLUE)
            .margin({ right: Spacing.XS })
          Text('学习中 7')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.BLUE)
        }
        .padding({ left: 12, right: 12, top: 6, bottom: 6 })
        .borderRadius(Radius.PILL)
        .backgroundColor(AppColors.BLUE + '15')
        .border({ width: 1, color: AppColors.BLUE + '30' })
        .margin({ left: Spacing.SM })
      }
      .width('92%')
      .margin({ bottom: Spacing.LG })

      // 进度卡片
      Column() {
        Row() {
          Text('机器学习')
            .fontSize(FontSize.BASE)
            .fontColor(AppColors.FG)
            .layoutWeight(1)
          Text('72%')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.ACCENT)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .margin({ bottom: Spacing.XS })

        Progress({ value: 72, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color(AppColors.ACCENT)
          .backgroundColor(AppColors.BG_HOVER)
          .borderRadius(3)

        Row() {
          Text('深度学习')
            .fontSize(FontSize.BASE)
            .fontColor(AppColors.FG)
            .layoutWeight(1)
          Text('45%')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.BLUE)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .margin({ top: Spacing.MD, bottom: Spacing.XS })

        Progress({ value: 45, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color(AppColors.BLUE)
          .backgroundColor(AppColors.BG_HOVER)
          .borderRadius(3)
      }
      .width('92%')
      .padding(Spacing.LG)
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
}

// ============ L50 - 全屏数据 ============
@Component
export struct L50 {
  private barData: BarDataItem[] = [
    { name: '机器学习', value: 85, color: AppColors.ACCENT },
    { name: '深度学习', value: 62, color: AppColors.ACCENT },
    { name: 'NLP', value: 48, color: AppColors.BLUE },
    { name: '计算机视觉', value: 73, color: AppColors.ACCENT },
    { name: '强化学习', value: 35, color: AppColors.BLUE },
    { name: '数学', value: 90, color: AppColors.ACCENT },
    { name: 'Python', value: 78, color: AppColors.ACCENT },
    { name: '框架', value: 55, color: AppColors.BLUE },
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
        Text('全屏数据')
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 4, bottom: Spacing.MD })

      // 标题
      Text('知识掌握度')
        .fontSize(FontSize.LG)
        .fontColor(AppColors.FG)
        .fontWeight(FontWeight.Bold)
        .width('92%')
        .margin({ bottom: Spacing.MD })

      // 横向条形图
      Column() {
        ForEach(this.barData, (item: BarDataItem) => {
          Column() {
            Row() {
              Text(item.name)
                .fontSize(FontSize.XS)
                .fontColor(AppColors.FG_SECONDARY)
                .width(60)
              Stack() {
                Row()
                  .width('100%')
                  .height(14)
                  .borderRadius(7)
                  .backgroundColor(AppColors.BG_HOVER)
                Row()
                  .width(`${item.value}%`)
                  .height(14)
                  .borderRadius(7)
                  .backgroundColor(item.color)
              }
              .layoutWeight(1)
              .margin({ left: Spacing.XS, right: Spacing.XS })
              Text(`${item.value}%`)
                .fontSize(FontSize.XS)
                .fontColor(item.color)
                .fontWeight(FontWeight.Bold)
                .width(32)
                .textAlign(TextAlign.End)
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .margin({ bottom: Spacing.SM })
        }, (item: BarDataItem) => item.name)
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
}
