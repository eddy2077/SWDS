import { AppColors, FontSize, Radius, Spacing } from '../common/Constants'
import { LAYOUT_CATEGORIES, LAYOUT_ITEMS, LayoutCategory, LayoutItem } from '../layouts/LayoutTypes'
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
struct LayoutGalleryPage {
  @State selectedCat: string = 'c1'
  @State searchQuery: string = ''
  @State viewMode: string = 'grid'
  @State showFavoritesOnly: boolean = false
  @State favoritesCount: number = 0
  @State refreshKey: number = 0

  aboutToAppear() {
    this.favoritesCount = FavoritesManager.getCount()
  }

  onPageShow() {
    this.favoritesCount = FavoritesManager.getCount()
    this.refreshKey++
  }

  // 过滤布局列表
  getFilteredLayouts(): LayoutItem[] {
    let result: LayoutItem[] = LAYOUT_ITEMS

    if (this.searchQuery.length > 0) {
      const q: string = this.searchQuery.toLowerCase()
      result = result.filter((item: LayoutItem) => {
        const nameMatch: boolean = item.name.toLowerCase().includes(q)
        const descMatch: boolean = item.desc.toLowerCase().includes(q)
        const tagsMatch: boolean = item.tags.join(',').toLowerCase().includes(q)
        return nameMatch || descMatch || tagsMatch
      })
    } else {
      result = result.filter((item: LayoutItem) => item.catId === this.selectedCat)
    }

    if (this.showFavoritesOnly) {
      result = result.filter((item: LayoutItem) => FavoritesManager.isFavorite(item.id))
    }

    return result
  }

  // 切换收藏
  toggleFavorite(id: number) {
    FavoritesManager.toggleFavorite(id)
    this.favoritesCount = FavoritesManager.getCount()
    this.refreshKey++
  }

  // 导航到详情页
  navigateToDetail(item: LayoutItem) {
    try {
      router.pushUrl({ url: 'pages/LayoutDetailPage', params: { id: item.id } })
    } catch (_e) {
    }
  }

  // 获取当前内容标题
  getContentTitle(): string {
    if (this.searchQuery.length > 0) {
      return '搜索结果'
    }
    if (this.showFavoritesOnly) {
      return '我的收藏'
    }
    const cat: LayoutCategory | undefined = LAYOUT_CATEGORIES.find((c: LayoutCategory) => c.id === this.selectedCat)
    return cat ? cat.name : '全部布局'
  }

  build() {
    Column() {
      this.TopBar()
      this.SearchBar()
      this.StatsRow()
      this.CategoryTabs()
      this.Toolbar()
      this.ContentArea()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.BG)
  }

  // 顶部应用栏
  @Builder
  TopBar() {
    Row() {
      Text('←')
        .fontSize(22)
        .fontColor(AppColors.FG_SECONDARY)
        .padding({ left: Spacing.SM, right: Spacing.SM, top: Spacing.XS, bottom: Spacing.XS })
        .onClick(() => { try { router.back() } catch (_e) {} })

      Text('100布局画廊')
        .fontSize(FontSize.XL)
        .fontColor(AppColors.FG)
        .fontWeight(FontWeight.Bold)
        .layoutWeight(1)
        .margin({ left: Spacing.XS })

      // 收藏数量徽章
      Row() {
        Text('♡')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.ACCENT)
        Text(this.favoritesCount.toString())
          .fontSize(FontSize.SM)
          .fontColor(AppColors.ACCENT)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 4 })
      }
      .padding({ left: Spacing.SM, right: Spacing.SM, top: Spacing.XS, bottom: Spacing.XS })
      .borderRadius(Radius.PILL)
      .backgroundColor(AppColors.ACCENT + '18')
      .border({ width: 1, color: AppColors.ACCENT_DIM })
    }
    .width('100%')
    .height(52)
    .padding({ left: Spacing.MD, right: Spacing.BASE })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.BG_SURFACE)
  }

  // 搜索栏
  @Builder
  SearchBar() {
    Row() {
      Text('🔍')
        .fontSize(FontSize.MD)
        .fontColor(AppColors.FG_DIM)
        .margin({ right: Spacing.SM })

      TextInput({ placeholder: '搜索布局名称、描述或标签...', text: this.searchQuery })
        .layoutWeight(1)
        .height(40)
        .fontSize(FontSize.BASE)
        .fontColor(AppColors.FG)
        .placeholderColor(AppColors.FG_DIM)
        .placeholderFont({ size: FontSize.BASE })
        .backgroundColor(Color.Transparent)
        .onChange((v: string) => { this.searchQuery = v })

      if (this.searchQuery.length > 0) {
        Text('✕')
          .fontSize(FontSize.MD)
          .fontColor(AppColors.FG_DIM)
          .padding({ left: Spacing.SM, right: Spacing.XS, top: Spacing.XS, bottom: Spacing.XS })
          .onClick(() => { this.searchQuery = '' })
      }
    }
    .width('100%')
    .padding({ left: Spacing.BASE, right: Spacing.BASE, top: Spacing.SM, bottom: Spacing.SM })
    .backgroundColor(AppColors.BG_SURFACE)
    .alignItems(VerticalAlign.Center)
  }

  // 统计行
  @Builder
  StatsRow() {
    Row() {
      // 总布局
      Column() {
        Text('100')
          .fontSize(FontSize.XL)
          .fontColor(AppColors.ACCENT)
          .fontWeight(FontWeight.Bold)
        Text('总布局')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_DIM)
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .padding({ top: Spacing.SM, bottom: Spacing.SM })
      .backgroundColor(AppColors.BG_SURFACE)
      .borderRadius(Radius.MD)
      .border({ width: 1, color: AppColors.BORDER })

      // 收藏数
      Column() {
        Text(this.favoritesCount.toString())
          .fontSize(FontSize.XL)
          .fontColor(AppColors.ACCENT)
          .fontWeight(FontWeight.Bold)
        Text('已收藏')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_DIM)
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .padding({ top: Spacing.SM, bottom: Spacing.SM })
      .backgroundColor(AppColors.BG_SURFACE)
      .borderRadius(Radius.MD)
      .border({ width: 1, color: AppColors.BORDER })
      .margin({ left: Spacing.SM })

      // 分类数
      Column() {
        Text('10')
          .fontSize(FontSize.XL)
          .fontColor(AppColors.ACCENT)
          .fontWeight(FontWeight.Bold)
        Text('分类')
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_DIM)
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .padding({ top: Spacing.SM, bottom: Spacing.SM })
      .backgroundColor(AppColors.BG_SURFACE)
      .borderRadius(Radius.MD)
      .border({ width: 1, color: AppColors.BORDER })
      .margin({ left: Spacing.SM })
    }
    .width('100%')
    .padding({ left: Spacing.BASE, right: Spacing.BASE, top: Spacing.SM, bottom: Spacing.SM })
  }

  // 分类标签栏
  @Builder
  CategoryTabs() {
    Scroll() {
      Row() {
        ForEach(LAYOUT_CATEGORIES, (cat: LayoutCategory) => {
          Text(`${cat.name} ${cat.range}`)
            .fontSize(FontSize.SM)
            .fontColor(this.selectedCat === cat.id ? AppColors.ACCENT : AppColors.FG_DIM)
            .fontWeight(this.selectedCat === cat.id ? FontWeight.Bold : FontWeight.Normal)
            .padding({ left: Spacing.MD, right: Spacing.MD, top: 6, bottom: 6 })
            .borderRadius(Radius.PILL)
            .border({
              width: 1,
              color: this.selectedCat === cat.id ? AppColors.ACCENT_DIM : AppColors.BORDER
            })
            .backgroundColor(this.selectedCat === cat.id ? AppColors.ACCENT + '15' : Color.Transparent)
            .margin({ right: Spacing.SM })
            .onClick(() => {
              this.selectedCat = cat.id
              this.showFavoritesOnly = false
            })
        }, (cat: LayoutCategory) => cat.id)
      }
      .padding({ left: Spacing.BASE, right: Spacing.BASE })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
    .padding({ top: Spacing.SM, bottom: Spacing.SM })
  }

  // 工具栏：视图切换 + 收藏过滤
  @Builder
  Toolbar() {
    Row() {
      // 当前内容标题
      Text(this.getContentTitle())
        .fontSize(FontSize.MD)
        .fontColor(AppColors.FG_SECONDARY)
        .fontWeight(FontWeight.Medium)
        .layoutWeight(1)

      // 收藏过滤按钮
      Row() {
        Text(this.showFavoritesOnly ? '♥' : '♡')
          .fontSize(FontSize.SM)
          .fontColor(this.showFavoritesOnly ? AppColors.ACCENT : AppColors.FG_DIM)
        Text(this.showFavoritesOnly ? '已收藏' : '仅看收藏')
          .fontSize(FontSize.XS)
          .fontColor(this.showFavoritesOnly ? AppColors.ACCENT : AppColors.FG_DIM)
          .margin({ left: 4 })
      }
      .padding({ left: Spacing.SM, right: Spacing.SM, top: 5, bottom: 5 })
      .borderRadius(Radius.PILL)
      .backgroundColor(this.showFavoritesOnly ? AppColors.ACCENT + '18' : Color.Transparent)
      .border({
        width: 1,
        color: this.showFavoritesOnly ? AppColors.ACCENT_DIM : AppColors.BORDER
      })
      .margin({ right: Spacing.SM })
      .onClick(() => { this.showFavoritesOnly = !this.showFavoritesOnly })

      // 视图切换
      Row() {
        Text('▦')
          .fontSize(FontSize.MD)
          .fontColor(this.viewMode === 'grid' ? AppColors.ACCENT : AppColors.FG_DIM)
          .padding({ left: Spacing.SM, right: Spacing.SM, top: 5, bottom: 5 })
          .backgroundColor(this.viewMode === 'grid' ? AppColors.ACCENT + '18' : Color.Transparent)
          .borderRadius(Radius.SM)
          .onClick(() => { this.viewMode = 'grid' })

        Text('☰')
          .fontSize(FontSize.MD)
          .fontColor(this.viewMode === 'list' ? AppColors.ACCENT : AppColors.FG_DIM)
          .padding({ left: Spacing.SM, right: Spacing.SM, top: 5, bottom: 5 })
          .backgroundColor(this.viewMode === 'list' ? AppColors.ACCENT + '18' : Color.Transparent)
          .borderRadius(Radius.SM)
          .onClick(() => { this.viewMode = 'list' })
      }
      .border({ width: 1, color: AppColors.BORDER })
      .borderRadius(Radius.SM)
    }
    .width('100%')
    .padding({ left: Spacing.BASE, right: Spacing.BASE, top: Spacing.XS, bottom: Spacing.SM })
    .alignItems(VerticalAlign.Center)
  }

  // 内容区域
  @Builder
  ContentArea() {
    Scroll() {
      Column() {
        if (this.getFilteredLayouts().length === 0) {
          // 空状态
          Column() {
            Text('🔍')
              .fontSize(40)
              .fontColor(AppColors.FG_DIM)
            Text('未找到匹配的布局')
              .fontSize(FontSize.BASE)
              .fontColor(AppColors.FG_SECONDARY)
              .margin({ top: Spacing.MD })
            if (this.searchQuery.length > 0) {
              Text('尝试其他关键词或清除搜索')
                .fontSize(FontSize.XS)
                .fontColor(AppColors.FG_DIM)
                .margin({ top: Spacing.XS })
            } else if (this.showFavoritesOnly) {
              Text('点击布局卡片上的 ♡ 收藏喜欢的布局')
                .fontSize(FontSize.XS)
                .fontColor(AppColors.FG_DIM)
                .margin({ top: Spacing.XS })
            }
          }
          .width('100%')
          .padding({ top: 80, bottom: 80 })
          .alignItems(HorizontalAlign.Center)
        } else {
          // 内容标题行
          Row() {
            Text(this.getContentTitle())
              .fontSize(FontSize.LG)
              .fontColor(AppColors.ACCENT)
              .fontWeight(FontWeight.Bold)

            Text(`${this.getFilteredLayouts().length} 个布局`)
              .fontSize(FontSize.XS)
              .fontColor(AppColors.FG_DIM)
              .margin({ left: Spacing.SM })
          }
          .width('100%')
          .padding({ left: Spacing.BASE, right: Spacing.BASE, top: Spacing.SM, bottom: Spacing.SM })

          // 网格或列表视图
          if (this.viewMode === 'grid') {
            Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
              ForEach(this.getFilteredLayouts(), (item: LayoutItem) => {
                this.GridCard(item)
              }, (item: LayoutItem) => `${item.id}_${this.refreshKey}`)
            }
            .width('100%')
            .padding({ left: Spacing.SM, right: Spacing.SM, bottom: Spacing.XXL })
          } else {
            Column() {
              ForEach(this.getFilteredLayouts(), (item: LayoutItem) => {
                this.ListCard(item)
              }, (item: LayoutItem) => `${item.id}_${this.refreshKey}`)
            }
            .width('100%')
            .padding({ left: Spacing.BASE, right: Spacing.BASE, bottom: Spacing.XXL })
          }
        }
      }
      .width('100%')
    }
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Auto)
    .layoutWeight(1)
  }

  // 网格卡片
  @Builder
  GridCard(item: LayoutItem) {
    Column() {
      // 布局预览
      Stack() {
        this.LayoutPreview(item.id)
      }
      .width('100%')
      .height(160)
      .clip(true)
      .alignContent(Alignment.Center)
      .backgroundColor(AppColors.BG_ELEVATED)

      // 信息区
      Column() {
        // 编号 + 收藏
        Row() {
          Text(`L${item.id.toString().padStart(2, '0')}`)
            .fontSize(FontSize.XS)
            .fontColor(AppColors.ACCENT_DIM)
            .fontWeight(FontWeight.Bold)

          Blank()

          Row() {
            Text(FavoritesManager.isFavorite(item.id) ? '♥' : '♡')
              .fontSize(FontSize.MD)
              .fontColor(FavoritesManager.isFavorite(item.id) ? AppColors.ACCENT : AppColors.FG_DIM)
          }
          .padding({ left: Spacing.SM, right: Spacing.SM, top: Spacing.XS, bottom: Spacing.XS })
          .hitTestBehavior(HitTestMode.Block)
          .onClick(() => this.toggleFavorite(item.id))
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        // 布局名称
        Text(item.name)
          .fontSize(FontSize.SM)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Medium)
          .maxLines(1)
          .textOverflow(TextOverflow.Ellipsis)
          .width('100%')
          .margin({ top: 2 })

        // 标签
        Flex({ wrap: FlexWrap.Wrap }) {
          ForEach(item.tags, (tag: string) => {
            Text(tag)
              .fontSize(FontSize.XS)
              .fontColor(AppColors.FG_DIM)
              .padding({ left: 5, right: 5, top: 2, bottom: 2 })
              .borderRadius(Radius.SM)
              .backgroundColor(AppColors.BG_ELEVATED)
              .margin({ right: 3, top: 3 })
          }, (tag: string, index: number) => `${tag}_${index}`)
        }
        .width('100%')
      }
      .padding(Spacing.SM)
      .alignItems(HorizontalAlign.Start)
    }
    .width('48%')
    .margin({ left: '1.3%', right: '1.3%', bottom: Spacing.MD })
    .borderRadius(Radius.LG)
    .backgroundColor(AppColors.BG_SURFACE)
    .border({ width: 1, color: AppColors.BORDER })
    .clip(true)
    .onClick(() => this.navigateToDetail(item))
  }

  // 列表卡片
  @Builder
  ListCard(item: LayoutItem) {
    Row() {
      // 布局预览
      Stack() {
        this.LayoutPreview(item.id)
      }
      .width(100)
      .height(100)
      .clip(true)
      .alignContent(Alignment.Center)
      .backgroundColor(AppColors.BG_ELEVATED)

      // 信息区
      Column() {
        // 编号 + 名称 + 收藏
        Row() {
          Text(`L${item.id.toString().padStart(2, '0')}`)
            .fontSize(FontSize.XS)
            .fontColor(AppColors.ACCENT_DIM)
            .fontWeight(FontWeight.Bold)

          Text(item.name)
            .fontSize(FontSize.BASE)
            .fontColor(AppColors.FG)
            .fontWeight(FontWeight.Medium)
            .maxLines(1)
            .textOverflow(TextOverflow.Ellipsis)
            .layoutWeight(1)
            .margin({ left: Spacing.SM })

          Row() {
            Text(FavoritesManager.isFavorite(item.id) ? '♥' : '♡')
              .fontSize(FontSize.MD)
              .fontColor(FavoritesManager.isFavorite(item.id) ? AppColors.ACCENT : AppColors.FG_DIM)
          }
          .padding({ left: Spacing.XS, right: Spacing.XS, top: Spacing.XS, bottom: Spacing.XS })
          .hitTestBehavior(HitTestMode.Block)
          .onClick(() => this.toggleFavorite(item.id))
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        // 描述
        Text(item.desc)
          .fontSize(FontSize.XS)
          .fontColor(AppColors.FG_SECONDARY)
          .maxLines(2)
          .textOverflow(TextOverflow.Ellipsis)
          .width('100%')
          .margin({ top: 4 })

        // 标签
        Flex({ wrap: FlexWrap.Wrap }) {
          ForEach(item.tags, (tag: string) => {
            Text(tag)
              .fontSize(FontSize.XS)
              .fontColor(AppColors.FG_DIM)
              .padding({ left: 5, right: 5, top: 2, bottom: 2 })
              .borderRadius(Radius.SM)
              .backgroundColor(AppColors.BG_ELEVATED)
              .margin({ right: 3, top: 3 })
          }, (tag: string, index: number) => `${tag}_${index}`)
        }
        .width('100%')
      }
      .layoutWeight(1)
      .padding(Spacing.SM)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .margin({ bottom: Spacing.SM })
    .borderRadius(Radius.LG)
    .backgroundColor(AppColors.BG_SURFACE)
    .border({ width: 1, color: AppColors.BORDER })
    .clip(true)
    .onClick(() => this.navigateToDetail(item))
  }

  // 根据布局ID渲染对应组件
  @Builder
  LayoutPreview(id: number) {
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
