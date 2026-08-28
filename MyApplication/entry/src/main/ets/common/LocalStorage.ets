import { HistoryItem } from './DataModels'

const HISTORY_KEY: string = 'kg_tutor_history'

export function loadHistory(): HistoryItem[] {
  try {
    const raw = AppStorage.get<string>(HISTORY_KEY)
    if (raw) {
      return JSON.parse(raw) as HistoryItem[]
    }
  } catch (_e) {
  }
  return []
}

export function saveHistory(history: HistoryItem[]): void {
  try {
    AppStorage.setOrCreate<string>(HISTORY_KEY, JSON.stringify(history))
  } catch (_e) {
  }
}

export function addToHistory(topic: string): void {
  const history = loadHistory()
  // 去重
  const filtered = history.filter(h => h.topic !== topic)
  filtered.unshift({ topic: topic, timestamp: Date.now() })
  // 最多保留20条
  if (filtered.length > 20) {
    filtered.splice(20)
  }
  saveHistory(filtered)
}

export function removeHistory(topic: string): void {
  const history = loadHistory()
  const filtered = history.filter(h => h.topic !== topic)
  saveHistory(filtered)
}
