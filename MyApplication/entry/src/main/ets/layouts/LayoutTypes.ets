// 布局画廊共享类型和数据

// 布局分类
export interface LayoutCategory {
  id: string
  name: string
  range: string
}

// 布局项
export interface LayoutItem {
  id: number
  catId: string
  name: string
  desc: string
  tags: string[]
}

// 知识节点数据（布局内部使用）
export interface KnowledgeNode {
  id: number
  name: string
  cat: string
  lv: number
}

// 树节点
export interface TreeNode {
  name: string
  children: string[]
}

// 分支节点（思维导图等）
export interface BranchNode {
  name: string
  subs: string[]
}

// 位置节点（地图、星座等）
export interface PositionNode {
  name: string
  x: number
  y: number
}

// 区域节点（地图探索）
export interface RegionNode {
  name: string
  x: number
  y: number
  w: number
  h: number
}

// 时间线节点
export interface TimelineNode {
  year: number
  desc: string
}

// 位置索引节点（Canvas绘制用）
export interface IndexedNode {
  x: number
  y: number
  name: string
  idx: number
}

// 聊天消息
export interface ChatMessage {
  role: string
  text: string
}

// 建议卡片
export interface SuggestCard {
  icon: string
  question: string
  tag: string
}

// 成就项
export interface AchievementItem {
  icon: string
  name: string
  done: boolean
}

// 习惯项
export interface HabitItem {
  name: string
  done: boolean
}

// 社交动态项
export interface FeedItem {
  text: string
  time: string
}

// 应用图标项
export interface AppItem {
  icon: string
  name: string
}

// 粒子
export interface Particle {
  x: number
  y: number
  vx: number
  vy: number
  life: number
}

// 技能数据
export interface SkillData {
  name: string
  val: number
}

// DNA数据
export interface DnaData {
  name: string
  pct: number
}

// 问答项
export interface QuizItem {
  question: string
  answer: string
}

// 单色系项
export interface MonoItem {
  name: string
  cat: string
  opacity: number
}

// 互补色项
export interface CompItem {
  name: string
  cat: string
  theme: string
}

// 类似色项
export interface AnalogItem {
  name: string
  cat: string
  borderColor: string
  bgColor: string
}

// 亮色卡片项
export interface LightItem {
  name: string
  cat: string
  icon: string
}

// 自然色项
export interface NatureItem {
  name: string
  cat: string
  color: string
}

// 彩虹分类项
export interface RainbowItem {
  name: string
  color: string
}

// 页面转场项
export interface PageItem {
  title: string
  desc: string
  icon: string
}

// 粒子（动画用，含扩展字段）
export interface AnimParticle {
  x: number
  y: number
  vx: number
  vy: number
  life: number
  maxLife: number
  size: number
}

// 技能雷达项
export interface RadarSkill {
  name: string
  value: number
}

// 成就项（含 unlocked 字段）
export interface AchievementEntry {
  icon: string
  name: string
  unlocked: boolean
}

// DNA特质项
export interface TraitItem {
  name: string
  value: number
  color: string
}

// 星座节点
export interface StarNode {
  x: number
  y: number
  r: number
  name: string
}

// 社交动态条目
export interface FeedEntry {
  id: number
  user: string
  action: string
  emoji: string
  time: string
}

// 全息节点
export interface HoloNode {
  label: string
  color: string
}

// 电路板节点
export interface CircuitNode {
  x: number
  y: number
  label: string
  w: number
  h: number
}

// 生命树可视化节点
export interface TreeVisNode {
  x: number
  y: number
  label: string
  size: number
}

// 剧本章节项
export interface ChapterItem {
  title: string
  desc: string
  status: string
}

// 聊天消息（含content字段）
export interface ChatMsg {
  role: string
  content: string
}

// 关键词信息
export interface KeywordInfo {
  word: string
  detail: string
}

// 命令行条目
export interface CmdLineItem {
  text: string
  isOutput: boolean
}

// 建议卡片项（含标题描述）
export interface SuggestCardItem {
  icon: string
  title: string
  desc: string
}

// 问答选项项
export interface QuizOptionItem {
  question: string
  options: string[]
}

// 条形图数据项
export interface BarDataItem {
  name: string
  value: number
  color: string
}

// 卡片描述项
export interface CardDescItem {
  name: string
  cat: string
  desc: string
}

// 图标分类项
export interface IconCatItem {
  icon: string
  name: string
  cat: string
}

// 色条项
export interface ColorBarItem {
  name: string
  cat: string
  barColor: string
}

// 分组项
export interface GroupItem {
  title: string
  icon: string
  items: string[]
}

// 名称分类等级项
export interface NameCatLvItem {
  name: string
  cat: string
  lv: number
}

// 分类定义
export const LAYOUT_CATEGORIES: LayoutCategory[] = [
  { id: 'c1', name: '导航范式', range: '01-10' },
  { id: 'c2', name: '图谱可视化', range: '11-20' },
  { id: 'c3', name: '学习路径', range: '21-30' },
  { id: 'c4', name: 'AI交互', range: '31-40' },
  { id: 'c5', name: '信息密度', range: '41-50' },
  { id: 'c6', name: '卡片样式', range: '51-60' },
  { id: 'c7', name: '色彩策略', range: '61-70' },
  { id: 'c8', name: '动效层次', range: '71-80' },
  { id: 'c9', name: '个性化', range: '81-90' },
  { id: 'c10', name: '极端方向', range: '91-100' }
]

// 知识节点数据
export const KN_DATA: KnowledgeNode[] = [
  { id: 1, name: '机器学习', cat: 'AI基础', lv: 3 },
  { id: 2, name: '深度学习', cat: 'AI基础', lv: 4 },
  { id: 3, name: 'Python编程', cat: '编程', lv: 2 },
  { id: 4, name: '自然语言处理', cat: 'NLP', lv: 5 },
  { id: 5, name: '计算机视觉', cat: 'CV', lv: 5 },
  { id: 6, name: '数据结构', cat: '编程', lv: 2 },
  { id: 7, name: '线性代数', cat: '数学', lv: 1 },
  { id: 8, name: '概率统计', cat: '数学', lv: 1 },
  { id: 9, name: '神经网络', cat: 'AI基础', lv: 4 },
  { id: 10, name: '强化学习', cat: 'AI基础', lv: 3 },
  { id: 11, name: 'TensorFlow', cat: '框架', lv: 3 },
  { id: 12, name: 'PyTorch', cat: '框架', lv: 3 },
  { id: 13, name: 'Transformer', cat: 'NLP', lv: 5 },
  { id: 14, name: 'CNN', cat: 'CV', lv: 4 },
  { id: 15, name: 'RNN/LSTM', cat: 'NLP', lv: 4 }
]

// 布局列表
export const LAYOUT_ITEMS: LayoutItem[] = [
  { id: 1, catId: 'c1', name: '底部5Tab', desc: '经典的底部5标签导航，适合核心功能切换。每个Tab对应一个主功能页面，用户可快速在功能间切换。', tags: ['经典', '导航', 'Tab'] },
  { id: 2, catId: 'c1', name: '侧边抽屉', desc: '汉堡菜单触发的侧边抽屉导航，节省屏幕空间，适合功能较多的应用。', tags: ['汉堡菜单', '抽屉', '侧滑'] },
  { id: 3, catId: 'c1', name: '顶部Tab', desc: '顶部标签栏导航，适合内容分类切换，常见于资讯类应用。', tags: ['顶部', 'Tab', '分类'] },
  { id: 4, catId: 'c1', name: '浮动球', desc: '浮动操作按钮展开的快捷菜单，提供快速访问入口。', tags: ['FAB', '浮动', '快捷'] },
  { id: 5, catId: 'c1', name: '手势滑动', desc: '左右滑动的卡片导航，配合指示点，适合引导或展示。', tags: ['手势', '滑动', '卡片'] },
  { id: 6, catId: 'c1', name: '底部滚轮', desc: '底部滚轮选择器，适合等级或类型选择场景。', tags: ['滚轮', '选择器', '底部'] },
  { id: 7, catId: 'c1', name: '双栏分屏', desc: '左侧分类列表+右侧详情的双栏布局，适合平板或横屏。', tags: ['双栏', '分屏', '主从'] },
  { id: 8, catId: 'c1', name: '环形菜单', desc: '中心按钮展开的环形菜单，视觉冲击力强，适合创意应用。', tags: ['环形', '创意', '展开'] },
  { id: 9, catId: 'c1', name: '卡片堆叠', desc: '堆叠式卡片导航，点击置顶，适合浏览类场景。', tags: ['堆叠', '卡片', '层叠'] },
  { id: 10, catId: 'c1', name: '全屏沉浸', desc: '全屏沉浸式导航，最小化UI干扰，专注内容体验。', tags: ['沉浸', '全屏', '极简'] },
  { id: 11, catId: 'c2', name: '中心放射', desc: '中心节点向外放射的知识图谱，展示知识关联关系。', tags: ['放射', '图谱', '中心'] },
  { id: 12, catId: 'c2', name: '树状层级', desc: '树状层级结构展示知识体系，清晰呈现父子关系。', tags: ['树状', '层级', '结构'] },
  { id: 13, catId: 'c2', name: '力导向', desc: '力导向布局的知识网络，节点自由分布，展示复杂关系。', tags: ['力导向', '网络', '动态'] },
  { id: 14, catId: 'c2', name: '矩阵格子', desc: '矩阵格子式知识地图，每个格子代表一个知识领域。', tags: ['矩阵', '格子', '网格'] },
  { id: 15, catId: 'c2', name: '3D星球', desc: '3D星球轨道式知识可视化，节点围绕中心旋转。', tags: ['3D', '星球', '轨道'] },
  { id: 16, catId: 'c2', name: '思维导图', desc: '思维导图式知识展开，左右分支扩展思维。', tags: ['导图', '分支', '思维'] },
  { id: 17, catId: 'c2', name: '地图探索', desc: '地图式知识探索，区域划分知识领地。', tags: ['地图', '探索', '区域'] },
  { id: 18, catId: 'c2', name: '时间轴', desc: '时间轴展示知识发展历程，按年份排列事件。', tags: ['时间轴', '历史', '历程'] },
  { id: 19, catId: 'c2', name: '卡片流', desc: '卡片流式知识浏览，左色条标记当前选中。', tags: ['卡片', '流式', '浏览'] },
  { id: 20, catId: 'c2', name: '星座连线', desc: '星座连线式知识图谱，节点如星辰连线成图。', tags: ['星座', '连线', '星空'] },
  { id: 21, catId: 'c3', name: '垂直时间线', desc: '垂直时间线展示学习路径，已完成步骤打勾。', tags: ['垂直', '时间线', '路径'] },
  { id: 22, catId: 'c3', name: '水平进度', desc: '水平进度指示器，展示学习阶段和当前位置。', tags: ['水平', '进度', '阶段'] },
  { id: 23, catId: 'c3', name: '地图路线', desc: '曲线路线图展示学习路径，航点可点击。', tags: ['路线', '曲线', '航点'] },
  { id: 24, catId: 'c3', name: '棋盘格', desc: '棋盘格路径，完成格子打勾，锁定格子显示等级。', tags: ['棋盘', '格子', '解锁'] },
  { id: 25, catId: 'c3', name: '阶梯上升', desc: '阶梯式上升布局，视觉化学习成长过程。', tags: ['阶梯', '上升', '成长'] },
  { id: 26, catId: 'c3', name: '河流分支', desc: '河流分支式路径，中心分出多条支流。', tags: ['河流', '分支', '支流'] },
  { id: 27, catId: 'c3', name: '电路板', desc: '电路板风格路径，节点用直角线连接。', tags: ['电路', '直角', '科技'] },
  { id: 28, catId: 'c3', name: '生命树', desc: '生命树向上生长，分支承载知识节点。', tags: ['生命树', '生长', '分支'] },
  { id: 29, catId: 'c3', name: '铁路线图', desc: '铁路线图式路径，站点可点击，当前站高亮。', tags: ['铁路', '站点', '地铁'] },
  { id: 30, catId: 'c3', name: '剧本章节', desc: '剧本章节式路径，可展开查看描述。', tags: ['剧本', '章节', '故事'] },
  { id: 31, catId: 'c4', name: '全屏对话', desc: '全屏聊天界面，AI与用户消息左右分布。', tags: ['对话', '聊天', '全屏'] },
  { id: 32, catId: 'c4', name: '侧边面板', desc: '侧边滑入的AI助手面板，不遮挡主内容。', tags: ['侧边', '面板', '滑入'] },
  { id: 33, catId: 'c4', name: '浮动气泡', desc: '浮动AI提示气泡，按需出现不干扰。', tags: ['气泡', '浮动', '提示'] },
  { id: 34, catId: 'c4', name: '分屏对话', desc: '左知识列表右对话的分屏布局。', tags: ['分屏', '列表', '对话'] },
  { id: 35, catId: 'c4', name: '语音优先', desc: '语音优先的AI交互，大麦克风按钮居中。', tags: ['语音', '麦克风', '录音'] },
  { id: 36, catId: 'c4', name: '嵌入式标注', desc: '正文中嵌入可点击关键词标注，展开详情。', tags: ['标注', '嵌入', '关键词'] },
  { id: 37, catId: 'c4', name: '命令行', desc: '终端命令行风格交互，极客向设计。', tags: ['终端', '命令行', '极客'] },
  { id: 38, catId: 'c4', name: '卡片建议', desc: 'AI建议卡片列表，图标+问题+标签。', tags: ['建议', '卡片', '列表'] },
  { id: 39, catId: 'c4', name: '教练模式', desc: '教练/学生/观察三模式切换的AI交互。', tags: ['教练', '模式', '切换'] },
  { id: 40, catId: 'c4', name: '沉浸问答', desc: '沉浸式问答界面，居中题目+选项+导航。', tags: ['问答', '沉浸', '测试'] },
  { id: 41, catId: 'c5', name: '极简一卡', desc: '极简单卡片，聚焦单一学习任务。', tags: ['极简', '单卡', '聚焦'] },
  { id: 42, catId: 'c5', name: '仪表盘', desc: '数据仪表盘，2x2统计卡片展示关键指标。', tags: ['仪表盘', '统计', '数据'] },
  { id: 43, catId: 'c5', name: '杂志排版', desc: '杂志式排版，大封面+小卡片混排。', tags: ['杂志', '排版', '封面'] },
  { id: 44, catId: 'c5', name: '瀑布流', desc: '双列瀑布流布局，卡片高度不一。', tags: ['瀑布流', '双列', '卡片'] },
  { id: 45, catId: 'c5', name: '列表流', desc: '编号列表流，简洁展示知识条目。', tags: ['列表', '编号', '简洁'] },
  { id: 46, catId: 'c5', name: '双列对比', desc: '双列并排对比，适合概念辨析。', tags: ['对比', '双列', '辨析'] },
  { id: 47, catId: 'c5', name: '时间线流', desc: '时间线流式布局，按时间排列活动。', tags: ['时间线', '活动', '日程'] },
  { id: 48, catId: 'c5', name: '网格缩略', desc: '3x3网格缩略图，快速浏览知识点。', tags: ['网格', '缩略', '3x3'] },
  { id: 49, catId: 'c5', name: '混合密度', desc: '混合密度布局，标题+统计+进度组合。', tags: ['混合', '密度', '组合'] },
  { id: 50, catId: 'c5', name: '全屏数据', desc: '全屏数据展示，横向条形图呈现掌握度。', tags: ['全屏', '数据', '条形图'] },
  { id: 51, catId: 'c6', name: '圆角大卡', desc: '大圆角卡片，点击展开详情。', tags: ['圆角', '大卡', '展开'] },
  { id: 52, catId: 'c6', name: '扁平列表', desc: '扁平化列表，简洁的行间分隔。', tags: ['扁平', '列表', '简洁'] },
  { id: 53, catId: 'c6', name: '玻璃拟态', desc: '毛玻璃拟态效果，半透明+模糊背景。', tags: ['玻璃', '拟态', '模糊'] },
  { id: 54, catId: 'c6', name: '阴影浮起', desc: '强阴影浮起卡片，立体感强。', tags: ['阴影', '浮起', '立体'] },
  { id: 55, catId: 'c6', name: '左色条', desc: '左侧色条卡片，颜色区分分类。', tags: ['色条', '分类', '彩色'] },
  { id: 56, catId: 'c6', name: '图标标题', desc: '图标+标题卡片，视觉识别度高。', tags: ['图标', '标题', '识别'] },
  { id: 57, catId: 'c6', name: '嵌套折叠', desc: '手风琴式折叠分组，展开显示子项。', tags: ['折叠', '手风琴', '分组'] },
  { id: 58, catId: 'c6', name: '横向滑动', desc: '横向滑动卡片行，节省垂直空间。', tags: ['横向', '滑动', '滚动'] },
  { id: 59, catId: 'c6', name: '封面大图', desc: '封面大图卡片，渐变背景+CTA。', tags: ['封面', '大图', '渐变'] },
  { id: 60, catId: 'c6', name: '极简线框', desc: '极简线框列表，仅名称+百分比。', tags: ['极简', '线框', '百分比'] },
  { id: 61, catId: 'c7', name: '单色系', desc: '单色系配色，金色不同透明度层次。', tags: ['单色', '金色', '层次'] },
  { id: 62, catId: 'c7', name: '互补色', desc: '互补色配色，金色与蓝色对比。', tags: ['互补', '对比', '双色'] },
  { id: 63, catId: 'c7', name: '类似色', desc: '类似色配色，暖色调渐变和谐。', tags: ['类似', '暖色', '和谐'] },
  { id: 64, catId: 'c7', name: '渐变流动', desc: '渐变流动配色，Slider调节色相。', tags: ['渐变', '流动', '可调'] },
  { id: 65, catId: 'c7', name: '暗色极简', desc: '纯黑极简暗色主题，极致克制。', tags: ['暗色', '极简', '纯黑'] },
  { id: 66, catId: 'c7', name: '亮色清新', desc: '亮色清新主题，白底深字。', tags: ['亮色', '清新', '白色'] },
  { id: 67, catId: 'c7', name: '霓虹赛博', desc: '霓虹赛博朋克风，紫底绿字发光。', tags: ['霓虹', '赛博', '发光'] },
  { id: 68, catId: 'c7', name: '自然色系', desc: '自然色系，绿棕蓝琥珀柔和搭配。', tags: ['自然', '柔和', '大地'] },
  { id: 69, catId: 'c7', name: '品牌金', desc: '品牌金主题，全面强调金色识别。', tags: ['品牌', '金色', '识别'] },
  { id: 70, catId: 'c7', name: '彩虹分类', desc: '彩虹分类配色，每个类别独有色彩。', tags: ['彩虹', '分类', '多彩'] },
  { id: 71, catId: 'c8', name: '入场动画', desc: '卡片逐个淡入入场动画效果。', tags: ['入场', '淡入', '逐个'] },
  { id: 72, catId: 'c8', name: '滚动视差', desc: '滚动视差效果，前后层不同速度。', tags: ['视差', '滚动', '分层'] },
  { id: 73, catId: 'c8', name: '页面转场', desc: '页面滑动转场，圆点指示器。', tags: ['转场', '滑动', '引导'] },
  { id: 74, catId: 'c8', name: '微交互', desc: '心形点赞微交互，弹性缩放。', tags: ['微交互', '点赞', '弹性'] },
  { id: 75, catId: 'c8', name: '骨架屏', desc: '骨架屏加载占位，脉冲动画。', tags: ['骨架', '加载', '占位'] },
  { id: 76, catId: 'c8', name: '进度动画', desc: '环形进度动画，Canvas绘制。', tags: ['进度', '环形', 'Canvas'] },
  { id: 77, catId: 'c8', name: '弹性物理', desc: '弹性物理动画，小球跟随点击。', tags: ['弹性', '物理', '跟随'] },
  { id: 78, catId: 'c8', name: '粒子效果', desc: '粒子飞散效果，Canvas粒子系统。', tags: ['粒子', '飞散', 'Canvas'] },
  { id: 79, catId: 'c8', name: '液态变形', desc: '液态变形动画，形状切换。', tags: ['液态', '变形', '形状'] },
  { id: 80, catId: 'c8', name: '呼吸脉冲', desc: '呼吸脉冲动画，同心圆扩散。', tags: ['呼吸', '脉冲', '扩散'] },
  { id: 81, catId: 'c9', name: '技能雷达', desc: '技能雷达图，六维度能力展示。', tags: ['雷达', '技能', '六维'] },
  { id: 82, catId: 'c9', name: '学习热力图', desc: '学习热力图，GitHub风格贡献图。', tags: ['热力图', '贡献', '网格'] },
  { id: 83, catId: 'c9', name: '成就墙', desc: '成就徽章墙，已解锁与锁定展示。', tags: ['成就', '徽章', '解锁'] },
  { id: 84, catId: 'c9', name: '学习DNA', desc: '学习DNA条形图，五项特质分析。', tags: ['DNA', '特质', '条形图'] },
  { id: 85, catId: 'c9', name: '知识星座', desc: '知识星座图，散点连线呈现掌握度。', tags: ['星座', '散点', '掌握'] },
  { id: 86, catId: 'c9', name: '成长曲线', desc: '成长曲线折线图，展示周趋势。', tags: ['曲线', '折线', '趋势'] },
  { id: 87, catId: 'c9', name: '习惯追踪', desc: '习惯追踪清单，可勾选打勾。', tags: ['习惯', '追踪', '清单'] },
  { id: 88, catId: 'c9', name: 'AI画像', desc: 'AI学习画像，三标签切换内容。', tags: ['画像', 'AI', '标签'] },
  { id: 89, catId: 'c9', name: '主题切换', desc: '暗色/亮色主题实时切换。', tags: ['主题', '切换', '暗亮'] },
  { id: 90, catId: 'c9', name: '数据仪表盘', desc: '个人数据仪表盘，统计+趋势图。', tags: ['仪表盘', '统计', '趋势'] },
  { id: 91, catId: 'c10', name: '纯文字终端', desc: '纯文字终端风格，绿字黑底极客向。', tags: ['终端', '纯文字', '极客'] },
  { id: 92, catId: 'c10', name: '纯视觉无文字', desc: '纯视觉无文字，图标卡片纯图形交流。', tags: ['纯视觉', '无文字', '图标'] },
  { id: 93, catId: 'c10', name: '游戏化RPG', desc: 'RPG游戏化UI，角色+经验+任务。', tags: ['RPG', '游戏化', '任务'] },
  { id: 94, catId: 'c10', name: '社交信息流', desc: '社交动态信息流，点赞+时间戳。', tags: ['社交', '信息流', '动态'] },
  { id: 95, catId: 'c10', name: '操作系统桌面', desc: '操作系统桌面隐喻，图标网格+搜索。', tags: ['桌面', 'OS', '图标'] },
  { id: 96, catId: 'c10', name: '报纸排版', desc: '报纸排版风格，刊头+标题+正文。', tags: ['报纸', '排版', '刊头'] },
  { id: 97, catId: 'c10', name: '太空控制台', desc: '太空控制台风格，六边形+警示。', tags: ['太空', '控制台', '六边形'] },
  { id: 98, catId: 'c10', name: '手账日记', desc: '手账日记风格，暖色纸感+手写体。', tags: ['手账', '日记', '纸感'] },
  { id: 99, catId: 'c10', name: '黑板教学', desc: '黑板教学风格，粉笔字+数学公式。', tags: ['黑板', '教学', '粉笔'] },
  { id: 100, catId: 'c10', name: '未来全息', desc: '未来全息UI，发光球体+轨道节点。', tags: ['全息', '未来', '轨道'] }
]
