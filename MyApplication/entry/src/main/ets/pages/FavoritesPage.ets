import { AppColors, FontSize, Radius, Spacing } from '../common/Constants'
import { LAYOUT_ITEMS, LAYOUT_CATEGORIES, LayoutItem, LayoutCategory } from '../layouts/LayoutTypes'
import { FavoritesManager } from '../layouts/FavoritesManager'
import { router } from '@kit.ArkUI'
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
struct FavoritesPage {
  @State favoriteIds: number[] = []
  @State refreshKey: number = 0

  aboutToAppear() {
    this.loadFavorites()
  }

  onPageShow() {
    this.loadFavorites()
  }

  private loadFavorites() {
    this.favoriteIds = FavoritesManager.getFavorites()
    this.refreshKey++
  }

  private removeFavorite(id: number) {
    FavoritesManager.toggleFavorite(id)
    this.loadFavorites()
  }

  private getLayoutItem(id: number): LayoutItem | undefined {
    return LAYOUT_ITEMS.find((item: LayoutItem) => item.id === id)
  }

  private getCategoryName(catId: string): string {
    const cat = LAYOUT_CATEGORIES.find((c: LayoutCategory) => c.id === catId)
    return cat ? cat.name : ''
  }

  private navigateToDetail(id: number) {
    try {
      router.pushUrl({ url: 'pages/LayoutDetailPage', params: { id: id } })
    } catch (_e) {
    }
  }

  build() {
    Column() {
      // 顶部栏
      Row() {
        Text('←')
          .fontSize(20)
          .fontColor(AppColors.FG_SECONDARY)
          .padding(8)
          .onClick(() => { try { router.back() } catch (_e) {} })

        Text('我的收藏')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)

        // 数量徽标
        Text(this.favoriteIds.length.toString())
          .fontSize(FontSize.SM)
          .fontColor(AppColors.ACCENT)
          .padding({ left: 10, right: 10, top: 4, bottom: 4 })
          .borderRadius(Radius.PILL)
          .backgroundColor(AppColors.ACCENT + '15')
      }
      .width('100%')
      .height(56)
      .padding({ left: Spacing.MD, right: Spacing.BASE })
      .backgroundColor(AppColors.BG_SURFACE)

      if (this.favoriteIds.length === 0) {
        // 空状态
        Column() {
          Text('♡')
            .fontSize(80)
            .fontColor(AppColors.FG_DIM)
            .margin({ bottom: Spacing.LG })

          Text('还没有收藏的布局')
            .fontSize(FontSize.LG)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: Spacing.SM })

          Text('在布局画廊中点击 ♡ 即可收藏')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.FG_DIM)
            .margin({ bottom: Spacing.XL })

          Button('去逛逛')
            .width(160)
            .height(44)
            .fontSize(FontSize.BASE)
            .fontWeight(FontWeight.Bold)
            .backgroundColor(AppColors.ACCENT)
            .fontColor(AppColors.BG)
            .borderRadius(Radius.MD)
            .onClick(() => {
              try {
                router.pushUrl({ url: 'pages/LayoutGalleryPage' })
              } catch (_e) {
              }
            })
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      } else {
        // 统计
        Row() {
          Text(`共 ${this.favoriteIds.length} 个收藏布局`)
            .fontSize(FontSize.SM)
            .fontColor(AppColors.FG_SECONDARY)
        }
        .width('100%')
        .padding({ left: Spacing.BASE, top: Spacing.BASE, bottom: Spacing.SM })

        // 收藏网格
        Scroll() {
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
            ForEach(this.favoriteIds, (id: number) => {
              this.FavoriteCard(id)
            }, (id: number) => `${this.refreshKey}-${id}`)
          }
          .width('100%')
          .padding({ left: Spacing.SM, right: Spacing.SM, bottom: Spacing.XXL })
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Auto)
        .layoutWeight(1)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.BG)
  }

  @Builder
  FavoriteCard(id: number) {
    Column() {
      // 预览区 + 移除按钮
      Stack() {
        Column() {
          this.LayoutRender(id)
        }
        .width('100%')
        .height(160)
        .clip(true)

        Text('✕')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.FG)
          .padding(6)
          .borderRadius(Radius.PILL)
          .backgroundColor(AppColors.BG + 'CC')
          .margin({ top: Spacing.XS, right: Spacing.XS })
          .onClick(() => { this.removeFavorite(id) })
      }
      .width('100%')
      .height(160)
      .alignContent(Alignment.TopEnd)

      // 信息区
      Column() {
        Row() {
          Text(`L${id.toString().padStart(2, '0')}`)
            .fontSize(FontSize.XS)
            .fontColor(AppColors.ACCENT_DIM)
            .fontWeight(FontWeight.Bold)

          Text(this.getLayoutItem(id)?.name || '')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.FG_SECONDARY)
            .margin({ left: Spacing.SM })
            .layoutWeight(1)
            .maxLines(1)
            .textOverflow(TextOverflow.Ellipsis)
        }
        .width('100%')

        Text(this.getCategoryName(this.getLayoutItem(id)?.catId || ''))
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_DIM)
          .padding({ left: 0, top: 2 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding({ left: Spacing.SM, right: Spacing.SM, top: Spacing.SM, bottom: Spacing.SM })
    }
    .width('48%')
    .margin({ left: '1.3%', right: '1.3%', bottom: Spacing.LG })
    .borderRadius(Radius.LG)
    .backgroundColor(AppColors.BG_SURFACE)
    .border({ width: 1, color: AppColors.BORDER })
    .clip(true)
    .onClick(() => { this.navigateToDetail(id) })
  }

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
