// 应用常量配置 - 墨金主题

// 颜色常量
export class AppColors {
  static readonly BG: string = '#0D0D0C'
  static readonly BG_SURFACE: string = '#161614'
  static readonly BG_ELEVATED: string = '#1E1E1B'
  static readonly BG_HOVER: string = '#262622'
  static readonly FG: string = '#E8E4D9'
  static readonly FG_SECONDARY: string = '#9A9688'
  static readonly FG_DIM: string = '#5C5A52'
  static readonly ACCENT: string = '#C4A265'
  static readonly ACCENT_DIM: string = '#8B7340'
  static readonly WARM: string = '#D4A04A'
  static readonly WARM_DIM: string = '#3D2E10'
  static readonly RED: string = '#C45A5A'
  static readonly RED_DIM: string = '#3D1515'
  static readonly BLUE: string = '#6A9EC4'
  static readonly BORDER: string = '#2A2820'
  static readonly BORDER_HOVER: string = '#3A3830'
  static readonly GOLD_GRADIENT_START: string = '#C4A265'
  static readonly GOLD_GRADIENT_END: string = '#8B7340'
  static readonly CARD_BG: string = '#1A1A17'
  static readonly TAB_BAR_BG: string = '#111110'
}

// 字体大小
export class FontSize {
  static readonly XS: number = 10
  static readonly SM: number = 12
  static readonly MD: number = 13
  static readonly BASE: number = 14
  static readonly LG: number = 16
  static readonly XL: number = 18
  static readonly XXL: number = 22
  static readonly XXXL: number = 28
}

// 圆角
export class Radius {
  static readonly SM: number = 6
  static readonly MD: number = 10
  static readonly LG: number = 14
  static readonly XL: number = 20
  static readonly PILL: number = 100
}

// 间距
export class Spacing {
  static readonly XS: number = 4
  static readonly SM: number = 8
  static readonly MD: number = 12
  static readonly BASE: number = 16
  static readonly LG: number = 20
  static readonly XL: number = 24
  static readonly XXL: number = 32
}

// 建议主题列表
export const SUGGESTION_TOPICS: string[] = [
  '机器学习', '中国历史', 'Python编程', '前端开发', '产品经理', '经济学', '心理学'
]

// 主题配色映射
export const TOPIC_THEMES: Record<string, string> = {
  '机器学习': '#C4A265',
  '中国历史': '#C47A5A',
  'Python编程': '#6A9EC4',
  '前端开发': '#C46AA0',
  '经济学': '#C4B46A',
  '心理学': '#8A6AC4',
  '区块链': '#6AC4B4',
  '产品经理': '#C45A7A',
  '数学': '#C4C46A',
  '物理': '#6AB4C4',
  '英语': '#6AC48A',
  '设计': '#C46A8A',
  '数据库': '#6AC4C4',
  '算法': '#9A6AC4',
}
