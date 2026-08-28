// 布局收藏与浏览历史管理

const FAVORITES_KEY: string = 'kg_layout_favorites'
const HISTORY_KEY: string = 'kg_layout_history'

// 收藏管理器
export class FavoritesManager {
  // 获取收藏列表
  static getFavorites(): number[] {
    try {
      const raw = AppStorage.get<string>(FAVORITES_KEY)
      if (raw) {
        return JSON.parse(raw) as number[]
      }
    } catch (_e) {
    }
    return []
  }

  // 获取收藏列表（别名）
  static getList(): number[] {
    return FavoritesManager.getFavorites()
  }

  // 检查是否已收藏
  static isFavorite(id: number): boolean {
    return FavoritesManager.getFavorites().indexOf(id) >= 0
  }

  // 切换收藏状态
  static toggleFavorite(id: number): boolean {
    const list = FavoritesManager.getFavorites()
    const idx = list.indexOf(id)
    if (idx >= 0) {
      list.splice(idx, 1)
      FavoritesManager.save(list)
      return false
    } else {
      list.unshift(id)
      FavoritesManager.save(list)
      return true
    }
  }

  // 切换收藏（别名）
  static toggle(id: number): boolean {
    return FavoritesManager.toggleFavorite(id)
  }

  // 获取收藏数量
  static getCount(): number {
    return FavoritesManager.getFavorites().length
  }

  // 保存收藏列表
  static save(list: number[]): void {
    try {
      AppStorage.setOrCreate<string>(FAVORITES_KEY, JSON.stringify(list))
    } catch (_e) {
    }
  }
}

// 浏览历史管理器
export class HistoryManager {
  // 添加浏览记录
  static addHistory(id: number): void {
    const list = HistoryManager.getHistory()
    const filtered = list.filter(i => i !== id)
    filtered.unshift(id)
    if (filtered.length > 50) {
      filtered.splice(50)
    }
    HistoryManager.save(filtered)
  }

  // 添加浏览记录（别名）
  static add(id: number): void {
    HistoryManager.addHistory(id)
  }

  // 获取浏览历史
  static getHistory(): number[] {
    try {
      const raw = AppStorage.get<string>(HISTORY_KEY)
      if (raw) {
        return JSON.parse(raw) as number[]
      }
    } catch (_e) {
    }
    return []
  }

  // 获取浏览历史（别名）
  static getList(): number[] {
    return HistoryManager.getHistory()
  }

  // 清空浏览历史
  static clearHistory(): void {
    HistoryManager.save([])
  }

  // 保存浏览历史
  static save(list: number[]): void {
    try {
      AppStorage.setOrCreate<string>(HISTORY_KEY, JSON.stringify(list))
    } catch (_e) {
    }
  }
}
