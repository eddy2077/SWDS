import { router } from '@kit.ArkUI'
import { AppColors, FontSize, Radius, Spacing, TOPIC_THEMES } from '../common/Constants'
import { TopicData, GraphNode, GraphEdge, CanvasNode, LearningStatus, VideoItem } from '../common/DataModels'
import { getOrGenerateTopicData } from '../common/TopicDB'
import { videoDB } from '../common/VideoDB'

@Entry
@Component
struct GraphPage {
  @State topic: string = ''
  @State topicData: TopicData | null = null
  @State selectedNode: GraphNode | null = null
  @State showNodePanel: boolean = false
  @State showAIChat: boolean = false
  @State showEditPanel: boolean = false
  @State accentColor: string = AppColors.ACCENT
  @State isEditMode: boolean = false
  @State editMode: string = 'none'
  @State aiMessages: string[] = ['你好！我可以帮你优化知识图谱。试试下面的快捷指令吧。']
  @State aiInput: string = ''
  @State canvasWidth: number = 360
  @State canvasHeight: number = 600
  @State editLabel: string = ''
  @State editDesc: string = ''
  @State editStatus: number = 0
  @State editRelated: string = ''
  @State showDeleteConfirm: boolean = false
  @State deleteTargetId: string = ''
  @State showAddDialog: boolean = false
  @State addLabel: string = ''
  @State addDesc: string = ''
  @State addType: number = 0
  @State connectFrom: string = ''
  @State toastMsg: string = ''
  @State showToast: boolean = false

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  aboutToAppear() {
    const params = router.getParams() as Record<string, Object>
    if (params && params['topic']) {
      this.topic = params['topic'] as string
      this.accentColor = TOPIC_THEMES[this.topic] || AppColors.ACCENT
      this.loadTopicData()
    }
  }

  private loadTopicData() {
    const data = getOrGenerateTopicData(this.topic)
    if (data) {
      this.topicData = data
    }
  }

  private getStatusColor(status: LearningStatus): string {
    switch (status) {
      case 'completed': return AppColors.ACCENT
      case 'in-progress': return AppColors.WARM
      case 'not-started': return '#5C5A52'
      case 'locked': return '#3A3830'
      default: return '#5C5A52'
    }
  }

  private getStatusText(status: LearningStatus): string {
    switch (status) {
      case 'completed': return '已掌握'
      case 'in-progress': return '学习中'
      case 'not-started': return '未开始'
      case 'locked': return '待解锁'
      default: return '未知'
    }
  }

  private getCompletedCount(): number {
    if (!this.topicData) return 0
    return this.topicData.nodes.filter(n => n.status === 'completed').length
  }

  private getProgressPercent(): number {
    if (!this.topicData || this.topicData.nodes.length === 0) return 0
    return Math.round(this.getCompletedCount() / this.topicData.nodes.length * 100)
  }

  private getVideosForNode(nodeLabel: string): VideoItem[] {
    const topicVideos = videoDB[this.topic]
    if (topicVideos) {
      for (const key of Object.keys(topicVideos)) {
        if (nodeLabel.includes(key) || key.includes(nodeLabel)) {
          return topicVideos[key]
        }
      }
    }
    return []
  }

  private calcNodePositions(): Map<string, number[]> {
    const positions = new Map<string, number[]>()
    if (!this.topicData) return positions

    const w = this.canvasWidth
    const h = this.canvasHeight
    const cx = w / 2
    const cy = h / 2

    const centerNodes = this.topicData.nodes.filter(n => n.type === 'center')
    const l1Nodes = this.topicData.nodes.filter(n => n.type === 'l1')
    const l2Nodes = this.topicData.nodes.filter(n => n.type === 'l2')

    for (const node of centerNodes) {
      positions.set(node.id, [cx, cy])
    }

    const l1R = Math.min(w, h) * 0.22
    for (let i = 0; i < l1Nodes.length; i++) {
      const angle = (i / l1Nodes.length) * Math.PI * 2 - Math.PI / 2
      positions.set(l1Nodes[i].id, [cx + Math.cos(angle) * l1R, cy + Math.sin(angle) * l1R])
    }

    const l2R = Math.min(w, h) * 0.38
    for (let i = 0; i < l2Nodes.length; i++) {
      const angle = (i / l2Nodes.length) * Math.PI * 2 - Math.PI / 6
      positions.set(l2Nodes[i].id, [cx + Math.cos(angle) * l2R, cy + Math.sin(angle) * l2R])
    }

    return positions
  }

  private drawGraph() {
    if (!this.topicData || this.canvasWidth <= 0 || this.canvasHeight <= 0) return

    const ctx = this.context
    const w = this.canvasWidth
    const h = this.canvasHeight

    ctx.clearRect(0, 0, w, h)

    // 网格背景
    ctx.strokeStyle = '#C4A26508'
    ctx.lineWidth = 0.5
    for (let x = 0; x < w; x += 40) {
      ctx.beginPath(); ctx.moveTo(x, 0); ctx.lineTo(x, h); ctx.stroke()
    }
    for (let y = 0; y < h; y += 40) {
      ctx.beginPath(); ctx.moveTo(0, y); ctx.lineTo(w, y); ctx.stroke()
    }

    const positions = this.calcNodePositions()

    // 绘制边
    for (const edge of this.topicData.edges) {
      const from = positions.get(edge.from)
      const to = positions.get(edge.to)
      if (from && to) {
        ctx.beginPath()
        ctx.moveTo(from[0], from[1])
        ctx.lineTo(to[0], to[1])
        ctx.strokeStyle = this.accentColor + '30'
        ctx.lineWidth = 1.5
        ctx.stroke()

        const mx = (from[0] + to[0]) / 2
        const my = (from[1] + to[1]) / 2
        ctx.beginPath()
        ctx.arc(mx, my, 2, 0, Math.PI * 2)
        ctx.fillStyle = this.accentColor + '40'
        ctx.fill()
      }
    }

    // 绘制节点
    for (const node of this.topicData.nodes) {
      const pos = positions.get(node.id)
      if (!pos) continue

      const x = pos[0]
      const y = pos[1]
      const r = node.type === 'center' ? 26 : node.type === 'l1' ? 17 : 11
      const color = this.getStatusColor(node.status)
      const isSelected = this.selectedNode !== null && this.selectedNode.id === node.id

      // 选中光晕
      if (isSelected) {
        ctx.beginPath()
        ctx.arc(x, y, r + 8, 0, Math.PI * 2)
        ctx.fillStyle = color + '20'
        ctx.fill()
        ctx.beginPath()
        ctx.arc(x, y, r + 4, 0, Math.PI * 2)
        ctx.fillStyle = color + '15'
        ctx.fill()
      }

      // 节点阴影
      ctx.beginPath()
      ctx.arc(x, y + 2, r, 0, Math.PI * 2)
      ctx.fillStyle = '#00000040'
      ctx.fill()

      // 节点主体
      ctx.beginPath()
      ctx.arc(x, y, r, 0, Math.PI * 2)
      const gradient = ctx.createRadialGradient(x - r * 0.3, y - r * 0.3, 0, x, y, r)
      gradient.addColorStop(0, color)
      gradient.addColorStop(1, color + 'cc')
      ctx.fillStyle = gradient
      ctx.fill()

      // 节点边框
      ctx.beginPath()
      ctx.arc(x, y, r, 0, Math.PI * 2)
      ctx.strokeStyle = isSelected ? '#E8E4D9' : color + '60'
      ctx.lineWidth = isSelected ? 2.5 : 1
      ctx.stroke()

      // 中心节点内部图标
      if (node.type === 'center') {
        ctx.font = 'bold 16px sans-serif'
        ctx.fillStyle = '#E8E4D9'
        ctx.textAlign = 'center'
        ctx.textBaseline = 'middle'
        ctx.fillText('🕸', x, y)
      }

      // 标签
      ctx.font = node.type === 'center' ? 'bold 14px sans-serif' : node.type === 'l1' ? '12px sans-serif' : '10px sans-serif'
      ctx.fillStyle = '#E8E4D9'
      ctx.textAlign = 'center'
      ctx.textBaseline = 'top'
      ctx.fillText(node.label, x, y + r + 6)

      // 状态小圆点
      if (node.status === 'completed') {
        ctx.beginPath()
        ctx.arc(x + r * 0.7, y - r * 0.7, 5, 0, Math.PI * 2)
        ctx.fillStyle = AppColors.ACCENT
        ctx.fill()
        ctx.font = 'bold 7px sans-serif'
        ctx.fillStyle = '#0D0D0C'
        ctx.textAlign = 'center'
        ctx.textBaseline = 'middle'
        ctx.fillText('✓', x + r * 0.7, y - r * 0.7)
      } else if (node.status === 'in-progress') {
        ctx.beginPath()
        ctx.arc(x + r * 0.7, y - r * 0.7, 5, 0, Math.PI * 2)
        ctx.fillStyle = AppColors.WARM
        ctx.fill()
      }
    }
  }

  private findNodeAt(x: number, y: number): GraphNode | null {
    if (!this.topicData) return null
    const positions = this.calcNodePositions()

    for (const node of this.topicData.nodes) {
      const pos = positions.get(node.id)
      if (!pos) continue
      const r = node.type === 'center' ? 26 : node.type === 'l1' ? 17 : 11
      const dx = x - pos[0]
      const dy = y - pos[1]
      if (dx * dx + dy * dy <= (r + 10) * (r + 10)) {
        return node
      }
    }
    return null
  }

  build() {
    Column() {
      this.Toolbar()

      Stack() {
        if (this.topicData) {
          Canvas(this.context)
            .width('100%')
            .layoutWeight(1)
            .backgroundColor(AppColors.BG)
            .onReady(() => { this.drawGraph() })
            .onAreaChange((oldArea: Area, newArea: Area) => {
              const w = Number(newArea.width)
              const h = Number(newArea.height)
              if (w > 0 && h > 0) {
                this.canvasWidth = w
                this.canvasHeight = h
                this.drawGraph()
              }
            })
            .onTouch((event: TouchEvent) => {
              if (event.type === TouchType.Up) {
                const x = event.touches[0].x
                const y = event.touches[0].y
                const node = this.findNodeAt(x, y)

                if (this.isEditMode && this.editMode === 'delete' && node) {
                  this.deleteTargetId = node.id
                  this.showDeleteConfirm = true
                  return
                }

                if (this.isEditMode && this.editMode === 'connect') {
                  if (node) {
                    if (this.connectFrom.length === 0) {
                      this.connectFrom = node.id
                      this.toast('已选择起点: ' + node.label + '，请点击终点')
                    } else if (this.connectFrom !== node.id) {
                      this.addEdge(this.connectFrom, node.id)
                      this.connectFrom = ''
                      this.toast('连线已添加')
                    }
                  }
                  return
                }

                if (node) {
                  this.selectedNode = node
                  this.showNodePanel = true
                  this.showAIChat = false
                  this.showEditPanel = false
                  this.drawGraph()
                } else {
                  this.showNodePanel = false
                  this.selectedNode = null
                  this.drawGraph()
                }
              }
            })
        } else {
          Column() {
            Text('🕸').fontSize(48).margin({ bottom: Spacing.BASE })
            Text('未找到主题数据').fontSize(FontSize.BASE).fontColor(AppColors.FG_SECONDARY)
          }
          .width('100%')
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }

        if (this.showNodePanel && this.selectedNode) {
          this.NodeDetailPanel()
        }
        if (this.showEditPanel && this.selectedNode) {
          this.EditPanel()
        }
        if (this.showAIChat) {
          this.AIChatPanel()
        }
        if (this.showDeleteConfirm) {
          this.DeleteConfirmDialog()
        }
        if (this.showAddDialog) {
          this.AddNodeDialog()
        }
        if (this.showToast) {
          Text(this.toastMsg)
            .fontSize(FontSize.SM)
            .fontColor(AppColors.ACCENT)
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .borderRadius(Radius.MD)
            .backgroundColor(AppColors.BG_ELEVATED)
            .border({ width: 1, color: AppColors.ACCENT + '30' })
            .position({ x: '50%', y: 80 })
            .translate({ x: '-50%' })
            .zIndex(100)
        }
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.BG)
  }

  @Builder
  Toolbar() {
    Column() {
      Row() {
        Text('←').fontSize(20).fontColor(AppColors.FG_SECONDARY).padding(8)
          .onClick(() => { try { router.back() } catch (_e) {} })

        Text(this.topic).fontSize(FontSize.LG).fontColor(AppColors.FG).fontWeight(FontWeight.Bold)
          .margin({ left: 4 }).layoutWeight(1)

        Row() {
          Row() { Circle().width(6).height(6).fill(AppColors.ACCENT); Text('已掌握').fontSize(9).fontColor(AppColors.FG_DIM).margin({ left: 2 }) }
          Row() { Circle().width(6).height(6).fill(AppColors.WARM).margin({ left: 8 }); Text('学习中').fontSize(9).fontColor(AppColors.FG_DIM).margin({ left: 2 }) }
          Row() { Circle().width(6).height(6).fill('#5C5A52').margin({ left: 8 }); Text('未开始').fontSize(9).fontColor(AppColors.FG_DIM).margin({ left: 2 }) }
        }
        .margin({ right: 8 })

        Text(this.isEditMode ? '✅' : '✏️')
          .fontSize(FontSize.MD).fontColor(this.isEditMode ? this.accentColor : AppColors.FG_SECONDARY)
          .padding({ left: 6, right: 6, top: 3, bottom: 3 }).borderRadius(Radius.SM)
          .backgroundColor(this.isEditMode ? AppColors.ACCENT_DIM + '20' : Color.Transparent)
          .border({ width: 1, color: this.isEditMode ? this.accentColor + '40' : AppColors.BORDER })
          .margin({ right: 4 })
          .onClick(() => { this.isEditMode = !this.isEditMode; this.editMode = 'none'; this.connectFrom = '' })

        Text('🤖').fontSize(FontSize.MD).fontColor(AppColors.FG_SECONDARY)
          .padding({ left: 6, right: 6, top: 3, bottom: 3 }).borderRadius(Radius.SM)
          .border({ width: 1, color: AppColors.BORDER }).margin({ right: 4 })
          .onClick(() => { this.showAIChat = !this.showAIChat; this.showNodePanel = false; this.showEditPanel = false })

        Text(`${this.topicData?.nodes.length || 0}节点 ${this.getProgressPercent()}%`)
          .fontSize(FontSize.XS).fontColor(AppColors.FG_DIM)
      }
      .width('100%').height(48).padding({ left: 8, right: 10 })
      .backgroundColor(AppColors.BG_SURFACE).alignItems(VerticalAlign.Center)

      if (this.isEditMode) {
        Row() {
          Text('➕ 添加').fontSize(FontSize.XS)
            .fontColor(this.editMode === 'add' ? this.accentColor : AppColors.FG_SECONDARY)
            .padding({ left: 8, right: 8, top: 5, bottom: 5 }).borderRadius(Radius.SM)
            .backgroundColor(this.editMode === 'add' ? AppColors.ACCENT_DIM + '20' : Color.Transparent)
            .border({ width: 1, color: this.editMode === 'add' ? this.accentColor + '40' : AppColors.BORDER })
            .margin({ right: 4 })
            .onClick(() => {
              if (this.editMode === 'add') { this.editMode = 'none' } else {
                this.editMode = 'add'; this.showAddDialog = true
              }
            })

          Text('🔗 连线').fontSize(FontSize.XS)
            .fontColor(this.editMode === 'connect' ? this.accentColor : AppColors.FG_SECONDARY)
            .padding({ left: 8, right: 8, top: 5, bottom: 5 }).borderRadius(Radius.SM)
            .backgroundColor(this.editMode === 'connect' ? AppColors.ACCENT_DIM + '20' : Color.Transparent)
            .border({ width: 1, color: this.editMode === 'connect' ? this.accentColor + '40' : AppColors.BORDER })
            .margin({ right: 4 })
            .onClick(() => {
              this.editMode = this.editMode === 'connect' ? 'none' : 'connect'
              this.connectFrom = ''
              if (this.editMode === 'connect') { this.toast('点击选择连线起点') }
            })

          Text('🗑️ 删除').fontSize(FontSize.XS)
            .fontColor(AppColors.RED)
            .padding({ left: 8, right: 8, top: 5, bottom: 5 }).borderRadius(Radius.SM)
            .backgroundColor(this.editMode === 'delete' ? AppColors.RED_DIM + '20' : Color.Transparent)
            .border({ width: 1, color: this.editMode === 'delete' ? AppColors.RED + '40' : AppColors.BORDER })
            .margin({ right: 4 })
            .onClick(() => {
              this.editMode = this.editMode === 'delete' ? 'none' : 'delete'
              if (this.editMode === 'delete') { this.toast('点击要删除的节点') }
            })

          if (this.connectFrom.length > 0) {
            Text('连线中...').fontSize(FontSize.XS).fontColor(this.accentColor).margin({ left: 8 })
          }
        }
        .width('100%').padding({ left: 10, right: 10, top: 5, bottom: 5 })
        .backgroundColor(AppColors.BG_SURFACE)
      }
    }
  }

  @Builder
  NodeDetailPanel() {
    Scroll() {
      Column() {
        Row() {
          Text(this.selectedNode!.label).fontSize(FontSize.LG).fontColor(AppColors.FG)
            .fontWeight(FontWeight.Bold).layoutWeight(1)
          Text('✏️').fontSize(14).fontColor(AppColors.FG_DIM).padding(6)
            .onClick(() => {
              this.editLabel = this.selectedNode!.label
              this.editDesc = this.selectedNode!.desc
              this.editStatus = this.statusToIndex(this.selectedNode!.status)
              this.editRelated = this.selectedNode!.related.join('、')
              this.showEditPanel = true; this.showNodePanel = false
            })
          Text('✕').fontSize(16).fontColor(AppColors.FG_DIM).padding(6)
            .onClick(() => { this.showNodePanel = false; this.selectedNode = null; this.drawGraph() })
        }.width('100%')

        Row() {
          Circle().width(6).height(6).fill(this.getStatusColor(this.selectedNode!.status)).margin({ right: 6 })
          Text(this.getStatusText(this.selectedNode!.status))
            .fontSize(FontSize.SM).fontColor(this.getStatusColor(this.selectedNode!.status))
        }.margin({ top: 10 })

        Text(this.selectedNode!.desc).fontSize(FontSize.MD).fontColor(AppColors.FG_SECONDARY)
          .margin({ top: 10 }).lineHeight(22)

        Text('关联知识点').fontSize(FontSize.XS).fontColor(AppColors.FG_DIM).margin({ top: 14, bottom: 4 })
        Flex({ wrap: FlexWrap.Wrap }) {
          ForEach(this.selectedNode!.related, (tag: string) => {
            Text(tag).fontSize(FontSize.SM).fontColor(this.accentColor)
              .padding({ left: 8, right: 8, top: 3, bottom: 3 }).borderRadius(Radius.SM)
              .backgroundColor(AppColors.ACCENT_DIM + '20').border({ width: 1, color: this.accentColor + '30' })
              .margin({ right: 4, bottom: 4 })
          }, (tag: string) => tag)
        }

        if (this.getVideosForNode(this.selectedNode!.label).length > 0) {
          Text('推荐视频').fontSize(FontSize.XS).fontColor(AppColors.FG_DIM).margin({ top: 14, bottom: 4 })
          ForEach(this.getVideosForNode(this.selectedNode!.label), (video: VideoItem) => {
            Row() {
              Row() { Text('▶').fontSize(10).fontColor('#E8E4D9a0') }
                .width(44).height(28).borderRadius(4).backgroundColor(AppColors.BG_HOVER)
                .justifyContent(FlexAlign.Center).margin({ right: 8 })
              Column() {
                Text(video.title).fontSize(FontSize.SM).fontColor(AppColors.FG)
                  .maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis })
                Text(`${video.platform} · ${video.duration} · ${video.level}`)
                  .fontSize(FontSize.XS).fontColor(AppColors.FG_DIM).margin({ top: 2 })
              }.layoutWeight(1).alignItems(HorizontalAlign.Start)
            }.width('100%').padding(6).borderRadius(Radius.MD)
            .backgroundColor(AppColors.BG_HOVER).margin({ bottom: 4 })
          }, (video: VideoItem) => video.title)
        }

        Row() {
          Button('标记已学').height(36).fontSize(FontSize.SM)
            .backgroundColor(this.accentColor).fontColor(AppColors.BG).borderRadius(Radius.MD).layoutWeight(1)
            .onClick(() => { this.markNodeComplete() })
          Button('测验').height(36).fontSize(FontSize.SM)
            .backgroundColor(Color.Transparent).fontColor(AppColors.FG_SECONDARY)
            .borderRadius(Radius.MD).border({ width: 1, color: AppColors.BORDER }).layoutWeight(1).margin({ left: 8 })
            .onClick(() => {
              try { router.pushUrl({ url: 'pages/QuizPage', params: { topic: this.topic } }) } catch (_e) {}
            })
        }.margin({ top: 16 })
      }
      .width('100%').padding(18)
    }
    .width('100%').height(380)
    .borderRadius({ topLeft: Radius.XL, topRight: Radius.XL })
    .backgroundColor(AppColors.BG_ELEVATED).border({ width: 1, color: AppColors.BORDER })
  }

  @Builder
  EditPanel() {
    Scroll() {
      Column() {
        Row() {
          Text('编辑节点').fontSize(FontSize.LG).fontColor(AppColors.FG).fontWeight(FontWeight.Bold).layoutWeight(1)
          Text('✕').fontSize(16).fontColor(AppColors.FG_DIM).padding(6)
            .onClick(() => { this.showEditPanel = false })
        }.width('100%')

        Text('名称').fontSize(FontSize.XS).fontColor(AppColors.FG_DIM).margin({ top: 14, bottom: 4 })
        TextInput({ text: this.editLabel }).height(36).fontSize(FontSize.SM).fontColor(AppColors.FG)
          .placeholderColor(AppColors.FG_DIM).backgroundColor(AppColors.BG_HOVER).borderRadius(Radius.MD)
          .border({ width: 1, color: AppColors.BORDER }).padding({ left: 10 })
          .onChange((v: string) => { this.editLabel = v })

        Text('描述').fontSize(FontSize.XS).fontColor(AppColors.FG_DIM).margin({ top: 10, bottom: 4 })
        TextInput({ text: this.editDesc }).height(36).fontSize(FontSize.SM).fontColor(AppColors.FG)
          .placeholderColor(AppColors.FG_DIM).backgroundColor(AppColors.BG_HOVER).borderRadius(Radius.MD)
          .border({ width: 1, color: AppColors.BORDER }).padding({ left: 10 })
          .onChange((v: string) => { this.editDesc = v })

        Text('状态').fontSize(FontSize.XS).fontColor(AppColors.FG_DIM).margin({ top: 10, bottom: 4 })
        Row() {
          ForEach(['学习中', '已掌握', '未开始', '待解锁'], (s: string, i: number) => {
            Text(s).fontSize(FontSize.XS)
              .fontColor(this.editStatus === i ? this.accentColor : AppColors.FG_DIM)
              .padding({ left: 8, right: 8, top: 4, bottom: 4 }).borderRadius(Radius.SM)
              .backgroundColor(this.editStatus === i ? AppColors.ACCENT_DIM + '20' : AppColors.BG_HOVER)
              .border({ width: 1, color: this.editStatus === i ? this.accentColor + '40' : AppColors.BORDER })
              .margin({ right: 4 })
              .onClick(() => { this.editStatus = i as number })
          }, (s: string) => s)
        }

        Text('关联（用顿号分隔）').fontSize(FontSize.XS).fontColor(AppColors.FG_DIM).margin({ top: 10, bottom: 4 })
        TextInput({ text: this.editRelated }).height(36).fontSize(FontSize.SM).fontColor(AppColors.FG)
          .placeholderColor(AppColors.FG_DIM).backgroundColor(AppColors.BG_HOVER).borderRadius(Radius.MD)
          .border({ width: 1, color: AppColors.BORDER }).padding({ left: 10 })
          .onChange((v: string) => { this.editRelated = v })

        Button('保存修改').height(40).fontSize(FontSize.SM).width('100%')
          .backgroundColor(this.accentColor).fontColor(AppColors.BG).borderRadius(Radius.MD).margin({ top: 16 })
          .onClick(() => { this.saveNodeEdit() })
      }
      .width('100%').padding(18)
    }
    .width('100%').height(420)
    .borderRadius({ topLeft: Radius.XL, topRight: Radius.XL })
    .backgroundColor(AppColors.BG_ELEVATED).border({ width: 1, color: AppColors.BORDER })
  }

  @Builder
  AIChatPanel() {
    Column() {
      Row() {
        Text('🤖 AI 图谱优化').fontSize(FontSize.MD).fontColor(AppColors.FG).fontWeight(FontWeight.Bold).layoutWeight(1)
        Text('✕').fontSize(16).fontColor(AppColors.FG_DIM).padding(8)
          .onClick(() => { this.showAIChat = false })
      }.width('100%').padding({ left: 16, right: 8, top: 12, bottom: 8 })

      Divider().color(AppColors.BORDER)

      Scroll() {
        Column() {
          ForEach(this.aiMessages, (msg: string, index: number) => {
            Row() {
              Text(msg).fontSize(FontSize.SM).fontColor(AppColors.FG_SECONDARY)
                .padding({ left: 12, right: 12, top: 8, bottom: 8 }).borderRadius(Radius.MD)
                .backgroundColor(AppColors.BG_HOVER).width('90%')
            }
            .width('100%').margin({ bottom: 4 })
            .justifyContent(index % 2 === 0 ? FlexAlign.Start : FlexAlign.End)
          }, (msg: string, index: number) => msg + index)
        }.width('100%').padding({ left: 12, right: 12, top: 4, bottom: 4 })
      }
      .layoutWeight(1).scrollBar(BarState.Off)

      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(['展开这个主题', '添加前置知识', '简化图谱', '聚焦核心路径'], (cmd: string) => {
          Text(cmd).fontSize(FontSize.XS).fontColor(AppColors.FG_SECONDARY)
            .padding({ left: 8, right: 8, top: 3, bottom: 3 }).borderRadius(Radius.PILL)
            .backgroundColor(AppColors.BG_HOVER).border({ width: 1, color: AppColors.BORDER })
            .margin({ right: 4, bottom: 4 })
            .onClick(() => { this.aiMessages.push(cmd); this.aiMessages.push('功能开发中，敬请期待！') })
        }, (cmd: string) => cmd)
      }.width('100%').padding({ left: 12, right: 12, top: 6, bottom: 6 })

      Divider().color(AppColors.BORDER)

      Row() {
        TextInput({ placeholder: '输入优化指令...', text: this.aiInput }).layoutWeight(1).height(36)
          .fontSize(FontSize.SM).fontColor(AppColors.FG).placeholderColor(AppColors.FG_DIM)
          .backgroundColor(AppColors.BG_HOVER).borderRadius(Radius.MD)
          .border({ width: 1, color: AppColors.BORDER }).padding({ left: 10 })
          .onChange((v: string) => { this.aiInput = v })
          .onSubmit(() => { this.sendAIMessage() })
        Button('发送').height(36).fontSize(FontSize.SM).backgroundColor(this.accentColor)
          .fontColor(AppColors.BG).borderRadius(Radius.MD).margin({ left: 6 })
          .onClick(() => { this.sendAIMessage() })
      }.width('100%').padding({ left: 12, right: 12, top: 6, bottom: 10 })
    }
    .width('100%').height(380)
    .borderRadius({ topLeft: Radius.XL, topRight: Radius.XL })
    .backgroundColor(AppColors.BG_ELEVATED).border({ width: 1, color: AppColors.BORDER })
  }

  @Builder
  DeleteConfirmDialog() {
    Column() {
      Text('确认删除').fontSize(FontSize.LG).fontColor(AppColors.FG).fontWeight(FontWeight.Bold).margin({ bottom: 8 })
      Text('确定要删除这个节点及其所有连线吗？此操作不可撤销。')
        .fontSize(FontSize.SM).fontColor(AppColors.FG_SECONDARY).margin({ bottom: 16 })
      Row() {
        Button('取消').height(36).layoutWeight(1).fontSize(FontSize.SM)
          .backgroundColor(Color.Transparent).fontColor(AppColors.FG_SECONDARY)
          .borderRadius(Radius.MD).border({ width: 1, color: AppColors.BORDER })
          .onClick(() => { this.showDeleteConfirm = false })
        Button('删除').height(36).layoutWeight(1).fontSize(FontSize.SM)
          .backgroundColor(AppColors.RED).fontColor('#E8E4D9').borderRadius(Radius.MD).margin({ left: 8 })
          .onClick(() => { this.deleteNode(this.deleteTargetId); this.showDeleteConfirm = false })
      }
    }
    .width('80%').padding(24).borderRadius(Radius.LG)
    .backgroundColor(AppColors.BG_ELEVATED).border({ width: 1, color: AppColors.BORDER })
  }

  @Builder
  AddNodeDialog() {
    Column() {
      Text('添加节点').fontSize(FontSize.LG).fontColor(AppColors.FG).fontWeight(FontWeight.Bold).margin({ bottom: 12 })

      Text('名称').fontSize(FontSize.XS).fontColor(AppColors.FG_DIM).margin({ bottom: 4 })
      TextInput({ text: this.addLabel, placeholder: '输入节点名称' }).height(36).fontSize(FontSize.SM)
        .fontColor(AppColors.FG).placeholderColor(AppColors.FG_DIM).backgroundColor(AppColors.BG_HOVER)
        .borderRadius(Radius.MD).border({ width: 1, color: AppColors.BORDER }).padding({ left: 10 })
        .onChange((v: string) => { this.addLabel = v })

      Text('描述').fontSize(FontSize.XS).fontColor(AppColors.FG_DIM).margin({ top: 8, bottom: 4 })
      TextInput({ text: this.addDesc, placeholder: '输入节点描述' }).height(36).fontSize(FontSize.SM)
        .fontColor(AppColors.FG).placeholderColor(AppColors.FG_DIM).backgroundColor(AppColors.BG_HOVER)
        .borderRadius(Radius.MD).border({ width: 1, color: AppColors.BORDER }).padding({ left: 10 })
        .onChange((v: string) => { this.addDesc = v })

      Text('类型').fontSize(FontSize.XS).fontColor(AppColors.FG_DIM).margin({ top: 8, bottom: 4 })
      Row() {
        ForEach(['核心领域', '知识点'], (t: string, i: number) => {
          Text(t).fontSize(FontSize.XS)
            .fontColor(this.addType === i ? this.accentColor : AppColors.FG_DIM)
            .padding({ left: 8, right: 8, top: 4, bottom: 4 }).borderRadius(Radius.SM)
            .backgroundColor(this.addType === i ? AppColors.ACCENT_DIM + '20' : AppColors.BG_HOVER)
            .border({ width: 1, color: this.addType === i ? this.accentColor + '40' : AppColors.BORDER })
            .margin({ right: 4 })
            .onClick(() => { this.addType = i as number })
        }, (t: string) => t)
      }

      Row() {
        Button('取消').height(36).layoutWeight(1).fontSize(FontSize.SM)
          .backgroundColor(Color.Transparent).fontColor(AppColors.FG_SECONDARY)
          .borderRadius(Radius.MD).border({ width: 1, color: AppColors.BORDER })
          .onClick(() => { this.showAddDialog = false; this.addLabel = ''; this.addDesc = ''; this.addType = 0 })
        Button('添加').height(36).layoutWeight(1).fontSize(FontSize.SM)
          .backgroundColor(this.accentColor).fontColor(AppColors.BG).borderRadius(Radius.MD).margin({ left: 8 })
          .onClick(() => { this.addNode(); this.showAddDialog = false })
      }.margin({ top: 16 })
    }
    .width('85%').padding(20).borderRadius(Radius.LG)
    .backgroundColor(AppColors.BG_ELEVATED).border({ width: 1, color: AppColors.BORDER })
  }

  private statusToIndex(status: LearningStatus): number {
    switch (status) {
      case 'in-progress': return 0
      case 'completed': return 1
      case 'not-started': return 2
      case 'locked': return 3
      default: return 2
    }
  }

  private indexToStatus(index: number): LearningStatus {
    switch (index) {
      case 0: return 'in-progress'
      case 1: return 'completed'
      case 2: return 'not-started'
      case 3: return 'locked'
      default: return 'not-started'
    }
  }

  private markNodeComplete() {
    if (!this.selectedNode || !this.topicData) return
    const nodeId = this.selectedNode.id
    for (let i = 0; i < this.topicData.nodes.length; i++) {
      if (this.topicData.nodes[i].id === nodeId) {
        this.topicData.nodes[i].status = 'completed'
        this.selectedNode = this.topicData.nodes[i]
        break
      }
    }
    for (let i = 0; i < this.topicData.path.length; i++) {
      if (this.topicData.path[i].id === nodeId) {
        this.topicData.path[i].status = 'completed'
        if (i + 1 < this.topicData.path.length && this.topicData.path[i + 1].status === 'locked') {
          this.topicData.path[i + 1].status = 'not-started'
        }
        break
      }
    }
    this.drawGraph()
  }

  private saveNodeEdit() {
    if (!this.selectedNode || !this.topicData) return
    const nodeId = this.selectedNode.id
    for (let i = 0; i < this.topicData.nodes.length; i++) {
      if (this.topicData.nodes[i].id === nodeId) {
        this.topicData.nodes[i].label = this.editLabel
        this.topicData.nodes[i].desc = this.editDesc
        this.topicData.nodes[i].status = this.indexToStatus(this.editStatus)
        this.topicData.nodes[i].related = this.editRelated.split(/[、,，]/).filter(s => s.trim().length > 0)
        this.selectedNode = this.topicData.nodes[i]
        break
      }
    }
    this.showEditPanel = false
    this.showNodePanel = true
    this.drawGraph()
    this.toast('节点已更新')
  }

  private addNode() {
    if (!this.topicData || this.addLabel.trim().length === 0) return
    const newId = 'custom_' + Date.now()
    const nodeType = this.addType === 0 ? 'l1' : 'l2'
    this.topicData.nodes.push({
      id: newId, label: this.addLabel.trim(), type: nodeType,
      desc: this.addDesc.trim() || this.addLabel.trim(),
      status: 'not-started', related: []
    })
    this.addLabel = ''
    this.addDesc = ''
    this.addType = 0
    this.drawGraph()
    this.toast('节点已添加')
  }

  private addEdge(fromId: string, toId: string) {
    if (!this.topicData) return
    const exists = this.topicData.edges.some(e =>
      (e.from === fromId && e.to === toId) || (e.from === toId && e.to === fromId))
    if (!exists) {
      this.topicData.edges.push({ from: fromId, to: toId })
      this.drawGraph()
    }
  }

  private deleteNode(nodeId: string) {
    if (!this.topicData) return
    this.topicData.nodes = this.topicData.nodes.filter(n => n.id !== nodeId)
    this.topicData.edges = this.topicData.edges.filter(e => e.from !== nodeId && e.to !== nodeId)
    this.topicData.path = this.topicData.path.filter(p => p.id !== nodeId)
    if (this.selectedNode && this.selectedNode.id === nodeId) {
      this.selectedNode = null
      this.showNodePanel = false
    }
    this.drawGraph()
    this.toast('节点已删除')
  }

  private sendAIMessage() {
    if (this.aiInput.trim().length === 0) return
    this.aiMessages.push(this.aiInput)
    this.aiMessages.push('功能开发中，敬请期待！')
    this.aiInput = ''
  }

  private toast(msg: string) {
    this.toastMsg = msg
    this.showToast = true
    setTimeout(() => { this.showToast = false }, 2000)
  }
}
