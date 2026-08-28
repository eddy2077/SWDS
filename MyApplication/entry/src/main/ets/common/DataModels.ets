// 知识图谱节点类型
export type NodeType = 'center' | 'l1' | 'l2'

// 学习状态
export type LearningStatus = 'completed' | 'in-progress' | 'not-started' | 'locked'

// 知识图谱节点
export interface GraphNode {
  id: string
  label: string
  type: NodeType
  desc: string
  status: LearningStatus
  related: string[]
}

// 知识图谱边
export interface GraphEdge {
  from: string
  to: string
}

// 学习路径步骤
export interface PathStep {
  id: string
  title: string
  desc: string
  topics: string[]
  status: LearningStatus
}

// 测验题目
export interface QuizItem {
  topic: string
  question: string
  options: string[]
  answer: number
  explain: string
}

// 主题数据
export interface TopicData {
  nodes: GraphNode[]
  edges: GraphEdge[]
  path: PathStep[]
  quizzes: QuizItem[]
}

// 视频推荐
export interface VideoItem {
  title: string
  platform: string
  duration: string
  author: string
  level: string
  url: string
}

// 画布上的节点（含位置信息）
export interface CanvasNode {
  id: string
  label: string
  type: NodeType
  desc: string
  status: LearningStatus
  related: string[]
  x: number
  y: number
  r: number
  alpha: number
}

// 历史记录
export interface HistoryItem {
  topic: string
  timestamp: number
}

// 主题配色
export interface ThemeConfig {
  accent: string
  accentDim: string
  warm: string
  warmDim: string
}

// L1项目辅助类型
export interface L1Item {
  label: string
  desc: string
  related: string[]
}

// L2项目辅助类型
export interface L2Item {
  label: string
  desc: string
  related: string[]
}

// AI消息辅助类型
export interface AIMessage {
  role: string
  content: string
}

// 加载阶段辅助类型
export interface LoadingStage {
  progress: number
  text: string
}
