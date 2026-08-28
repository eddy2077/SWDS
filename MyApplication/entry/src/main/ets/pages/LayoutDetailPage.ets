import { router } from '@kit.ArkUI'
import { AppColors, FontSize, Radius, Spacing } from '../common/Constants'
import { LAYOUT_ITEMS, LAYOUT_CATEGORIES, LayoutItem, LayoutCategory } from '../layouts/LayoutTypes'
import { FavoritesManager, HistoryManager } from '../layouts/FavoritesManager'
import { L01, L02, L03, L04, L05, L06, L07, L08, L09, L10 } from '../layouts/Category1Navigation'
import { L11, L12, L13, L14, L15, L16, L17, L18, L19, L20 } from '../layouts/Category2Graph'
import { L21, L22, L23, L24, L25, L26, L27, L28, L29, L30 } from '../layouts/Category3Path'
import { L31, L32, L33, L34, L35, L36, L37, L38, L39, L40 } from '../layouts/Category4AI'
import { L41, L42, L43, L44, L45, L46, L47, L48, L49, L50 } from '../layouts/Category5Density'
import { L51, L52, L53, L54, L55, L56, L57, L58, L59, L60 } from '../layouts/Category6Card'
import { L61, L62, L63, L64, L65, L66, L67, L68, L69, L70 } from '../layouts/Category7Color'
import { L71, L72, L73, L74, L75, L76, L77, L78, L79, L80 } from '../layouts/Category8Animation'
import { L81, L82, L83, L84, L85, L86, L87, L88, L89, L90 } from '../layouts/Category9Personal'
import { L91, L92, L93, L94, L95, L96, L97, L98, L99, L100 } from '../layouts/Category10Extreme'

@Entry
@Component
struct LayoutDetailPage {
  @State layoutId: number = 1
  @State isFavorite: boolean = false

  aboutToAppear(): void {
    const params = router.getParams() as Record<string, number>
    if (params && params['id']) {
      this.layoutId = params['id']
    }
    HistoryManager.add(this.layoutId)
    this.isFavorite = FavoritesManager.isFavorite(this.layoutId)
  }

  getCurrentLayout(): LayoutItem {
    const item = LAYOUT_ITEMS.find(l => l.id === this.layoutId)
    if (item) {
      return item
    }
    return LAYOUT_ITEMS[0]
  }

  getCategory(): LayoutCategory {
    const layout = this.getCurrentLayout()
    const cat = LAYOUT_CATEGORIES.find(c => c.id === layout.catId)
    if (cat) {
      return cat
    }
    return LAYOUT_CATEGORIES[0]
  }

  goBack(): void {
    router.back()
  }

  toggleFavorite(): void {
    this.isFavorite = FavoritesManager.toggle(this.layoutId)
  }

  goPrev(): void {
    if (this.layoutId > 1) {
      this.layoutId = this.layoutId - 1
      this.isFavorite = FavoritesManager.isFavorite(this.layoutId)
    }
  }

  goNext(): void {
    if (this.layoutId < 100) {
      this.layoutId = this.layoutId + 1
      this.isFavorite = FavoritesManager.isFavorite(this.layoutId)
    }
  }

  build() {
    Column() {
      this.TopBar()
      this.InfoSection()
      this.PreviewArea()
      this.BottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.BG)
  }

  // ============ 顶部栏 ============
  @Builder
  TopBar() {
    Row() {
      // 返回按钮
      Text('←')
        .fontSize(FontSize.XXL)
        .fontColor(AppColors.FG)
        .width(40)
        .height(40)
        .textAlign(TextAlign.Center)
        .borderRadius(Radius.MD)
        .onClick(() => { this.goBack() })

      // 布局名称
      Text(this.getCurrentLayout().name)
        .fontSize(FontSize.XL)
        .fontColor(AppColors.FG)
        .fontWeight(FontWeight.Bold)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .maxLines(1)
        .textOverflow(TextOverflow.Ellipsis)

      // 收藏按钮
      Text(this.isFavorite ? '♥' : '♡')
        .fontSize(FontSize.XXL)
        .fontColor(this.isFavorite ? AppColors.RED : AppColors.FG_SECONDARY)
        .width(40)
        .height(40)
        .textAlign(TextAlign.Center)
        .borderRadius(Radius.MD)
        .onClick(() => { this.toggleFavorite() })
    }
    .width('100%')
    .height(56)
    .padding({ left: Spacing.BASE, right: Spacing.BASE })
    .alignItems(VerticalAlign.Center)
  }

  // ============ 布局信息区 ============
  @Builder
  InfoSection() {
    Column() {
      // 编号 + 名称 + 分类
      Row() {
        Text(`L${this.layoutId.toString().padStart(2, '0')}`)
          .fontSize(FontSize.XXXL)
          .fontColor(AppColors.ACCENT)
          .fontWeight(FontWeight.Bold)

        Column() {
          Text(this.getCurrentLayout().name)
            .fontSize(FontSize.XL)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Bold)
          Text(`${this.getCategory().name} ${this.getCategory().range}`)
            .fontSize(FontSize.SM)
            .fontColor(AppColors.FG_SECONDARY)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: Spacing.MD })
        .layoutWeight(1)
      }
      .width('100%')

      // 描述
      Text(this.getCurrentLayout().desc)
        .fontSize(FontSize.SM)
        .fontColor(AppColors.FG_SECONDARY)
        .margin({ top: Spacing.SM })
        .maxLines(2)
        .textOverflow(TextOverflow.Ellipsis)

      // 标签
      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(this.getCurrentLayout().tags, (tag: string) => {
          Text(tag)
            .fontSize(FontSize.XS)
            .fontColor(AppColors.ACCENT)
            .padding({ left: 10, right: 10, top: 4, bottom: 4 })
            .borderRadius(Radius.PILL)
            .backgroundColor(AppColors.ACCENT + '12')
            .border({ width: 1, color: AppColors.ACCENT + '25' })
            .margin({ right: Spacing.SM, top: Spacing.SM })
        }, (tag: string) => tag)
      }
      .width('100%')
    }
    .width('100%')
    .padding({ left: Spacing.BASE, right: Spacing.BASE, bottom: Spacing.MD })
  }

  // ============ 全屏预览区 ============
  @Builder
  PreviewArea() {
    Stack() {
      this.LayoutRender(this.layoutId)
    }
    .width('100%')
    .layoutWeight(1)
    .alignContent(Alignment.Center)
    .backgroundColor(AppColors.BG_SURFACE)
    .border({ width: 1, color: AppColors.BORDER })
    .borderRadius(Radius.LG)
    .clip(true)
    .margin({ left: Spacing.BASE, right: Spacing.BASE, bottom: Spacing.SM })
  }

  // ============ 底部导航栏 ============
  @Builder
  BottomNav() {
    Row() {
      // 上一个按钮
      Text('← 上一个')
        .fontSize(FontSize.BASE)
        .fontColor(this.layoutId > 1 ? AppColors.FG : AppColors.FG_DIM)
        .padding({ left: Spacing.LG, right: Spacing.LG, top: 10, bottom: 10 })
        .borderRadius(Radius.MD)
        .backgroundColor(this.layoutId > 1 ? AppColors.BG_SURFACE : Color.Transparent)
        .border({ width: 1, color: this.layoutId > 1 ? AppColors.BORDER : AppColors.BG_HOVER })
        .onClick(() => { this.goPrev() })

      // 计数器
      Text(`${this.layoutId} / 100`)
        .fontSize(FontSize.BASE)
        .fontColor(AppColors.ACCENT)
        .fontWeight(FontWeight.Bold)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      // 下一个按钮
      Text('下一个 →')
        .fontSize(FontSize.BASE)
        .fontColor(this.layoutId < 100 ? AppColors.FG : AppColors.FG_DIM)
        .padding({ left: Spacing.LG, right: Spacing.LG, top: 10, bottom: 10 })
        .borderRadius(Radius.MD)
        .backgroundColor(this.layoutId < 100 ? AppColors.BG_SURFACE : Color.Transparent)
        .border({ width: 1, color: this.layoutId < 100 ? AppColors.BORDER : AppColors.BG_HOVER })
        .onClick(() => { this.goNext() })
    }
    .width('100%')
    .height(64)
    .padding({ left: Spacing.BASE, right: Spacing.BASE })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.TAB_BAR_BG)
    .border({ width: 1, color: AppColors.BORDER })
  }

  // ============ 布局组件渲染 ============
  @Builder
  LayoutRender(id: number) {
    if (id === 1) {
      L01()
    } else if (id === 2) {
      L02()
    } else if (id === 3) {
      L03()
    } else if (id === 4) {
      L04()
    } else if (id === 5) {
      L05()
    } else if (id === 6) {
      L06()
    } else if (id === 7) {
      L07()
    } else if (id === 8) {
      L08()
    } else if (id === 9) {
      L09()
    } else if (id === 10) {
      L10()
    } else if (id === 11) {
      L11()
    } else if (id === 12) {
      L12()
    } else if (id === 13) {
      L13()
    } else if (id === 14) {
      L14()
    } else if (id === 15) {
      L15()
    } else if (id === 16) {
      L16()
    } else if (id === 17) {
      L17()
    } else if (id === 18) {
      L18()
    } else if (id === 19) {
      L19()
    } else if (id === 20) {
      L20()
    } else if (id === 21) {
      L21()
    } else if (id === 22) {
      L22()
    } else if (id === 23) {
      L23()
    } else if (id === 24) {
      L24()
    } else if (id === 25) {
      L25()
    } else if (id === 26) {
      L26()
    } else if (id === 27) {
      L27()
    } else if (id === 28) {
      L28()
    } else if (id === 29) {
      L29()
    } else if (id === 30) {
      L30()
    } else if (id === 31) {
      L31()
    } else if (id === 32) {
      L32()
    } else if (id === 33) {
      L33()
    } else if (id === 34) {
      L34()
    } else if (id === 35) {
      L35()
    } else if (id === 36) {
      L36()
    } else if (id === 37) {
      L37()
    } else if (id === 38) {
      L38()
    } else if (id === 39) {
      L39()
    } else if (id === 40) {
      L40()
    } else if (id === 41) {
      L41()
    } else if (id === 42) {
      L42()
    } else if (id === 43) {
      L43()
    } else if (id === 44) {
      L44()
    } else if (id === 45) {
      L45()
    } else if (id === 46) {
      L46()
    } else if (id === 47) {
      L47()
    } else if (id === 48) {
      L48()
    } else if (id === 49) {
      L49()
    } else if (id === 50) {
      L50()
    } else if (id === 51) {
      L51()
    } else if (id === 52) {
      L52()
    } else if (id === 53) {
      L53()
    } else if (id === 54) {
      L54()
    } else if (id === 55) {
      L55()
    } else if (id === 56) {
      L56()
    } else if (id === 57) {
      L57()
    } else if (id === 58) {
      L58()
    } else if (id === 59) {
      L59()
    } else if (id === 60) {
      L60()
    } else if (id === 61) {
      L61()
    } else if (id === 62) {
      L62()
    } else if (id === 63) {
      L63()
    } else if (id === 64) {
      L64()
    } else if (id === 65) {
      L65()
    } else if (id === 66) {
      L66()
    } else if (id === 67) {
      L67()
    } else if (id === 68) {
      L68()
    } else if (id === 69) {
      L69()
    } else if (id === 70) {
      L70()
    } else if (id === 71) {
      L71()
    } else if (id === 72) {
      L72()
    } else if (id === 73) {
      L73()
    } else if (id === 74) {
      L74()
    } else if (id === 75) {
      L75()
    } else if (id === 76) {
      L76()
    } else if (id === 77) {
      L77()
    } else if (id === 78) {
      L78()
    } else if (id === 79) {
      L79()
    } else if (id === 80) {
      L80()
    } else if (id === 81) {
      L81()
    } else if (id === 82) {
      L82()
    } else if (id === 83) {
      L83()
    } else if (id === 84) {
      L84()
    } else if (id === 85) {
      L85()
    } else if (id === 86) {
      L86()
    } else if (id === 87) {
      L87()
    } else if (id === 88) {
      L88()
    } else if (id === 89) {
      L89()
    } else if (id === 90) {
      L90()
    } else if (id === 91) {
      L91()
    } else if (id === 92) {
      L92()
    } else if (id === 93) {
      L93()
    } else if (id === 94) {
      L94()
    } else if (id === 95) {
      L95()
    } else if (id === 96) {
      L96()
    } else if (id === 97) {
      L97()
    } else if (id === 98) {
      L98()
    } else if (id === 99) {
      L99()
    } else if (id === 100) {
      L100()
    }
  }
}
