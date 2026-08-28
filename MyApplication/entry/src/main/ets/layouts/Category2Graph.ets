// 图谱可视化布局组件 (L11-L20) - 墨金主题
import { AppColors, FontSize, Radius, Spacing } from '../common/Constants'
import { KN_DATA, KnowledgeNode, TreeNode, BranchNode, RegionNode, TimelineNode, PositionNode, IndexedNode } from './LayoutTypes'

// ─── L11 中心放射图 ────────────────────────────────────────
@Component
export struct L11 {
  @State selectedNode: number = -1
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Column() {
      // 状态栏
      Row() {
        Text('9:41').fontSize(FontSize.XS).fontColor(AppColors.FG_SECONDARY)
        Blank()
        Text('●●● ◗ ▮').fontSize(FontSize.XS).fontColor(AppColors.FG_SECONDARY)
      }.width('100%').padding({ left: Spacing.BASE, right: Spacing.BASE, top: 6, bottom: 4 })

      // 导航栏
      Row() {
        Text('←').fontSize(FontSize.LG).fontColor(AppColors.FG_SECONDARY).padding(Spacing.XS)
        Text('中心放射图').fontSize(FontSize.BASE).fontColor(AppColors.FG).fontWeight(FontWeight.Bold).layoutWeight(1)
        Text('⊕').fontSize(FontSize.LG).fontColor(AppColors.ACCENT).padding(Spacing.XS)
      }.width('100%').height(40).padding({ left: Spacing.SM, right: Spacing.SM })

      // 画布
      Canvas(this.ctx)
        .width('100%')
        .layoutWeight(1)
        .onReady(() => { this.drawRadial() })
        .onTouch((e: TouchEvent) => {
          if (e.type === TouchType.Up) {
            this.handleTouch(e.touches[0].x, e.touches[0].y)
          }
        })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }

  private drawRadial() {
    const ctx = this.ctx
    const w = 320
    const h = 340
    const cx = w / 2
    const cy = h / 2

    ctx.clearRect(0, 0, w, h)

    // 中心节点
    const centerR = 28
    ctx.beginPath()
    ctx.arc(cx, cy, centerR, 0, Math.PI * 2)
    ctx.fillStyle = AppColors.ACCENT
    ctx.fill()
    ctx.strokeStyle = '#E8E4D9'
    ctx.lineWidth = 2
    ctx.stroke()
    ctx.font = 'bold 12px sans-serif'
    ctx.fillStyle = '#0D0D0C'
    ctx.textAlign = 'center'
    ctx.textBaseline = 'middle'
    ctx.fillText('AI', cx, cy)

    // 周围节点
    const nodes = KN_DATA.slice(0, 8)
    const radius = 110
    for (let i = 0; i < nodes.length; i++) {
      const angle = (i / nodes.length) * Math.PI * 2 - Math.PI / 2
      const nx = cx + Math.cos(angle) * radius
      const ny = cy + Math.sin(angle) * radius

      // 连线
      ctx.beginPath()
      ctx.moveTo(cx, cy)
      ctx.lineTo(nx, ny)
      ctx.strokeStyle = '#C4A26540'
      ctx.lineWidth = 1.5
      ctx.stroke()

      // 节点
      const r = this.selectedNode === i ? 20 : 16
      ctx.beginPath()
      ctx.arc(nx, ny, r, 0, Math.PI * 2)
      ctx.fillStyle = this.selectedNode === i ? AppColors.ACCENT : '#1E1E1B'
      ctx.fill()
      ctx.strokeStyle = this.selectedNode === i ? '#E8E4D9' : '#C4A26560'
      ctx.lineWidth = this.selectedNode === i ? 2 : 1
      ctx.stroke()

      // 标签
      ctx.font = '10px sans-serif'
      ctx.fillStyle = this.selectedNode === i ? '#E8E4D9' : '#9A9688'
      ctx.textAlign = 'center'
      ctx.textBaseline = 'top'
      ctx.fillText(nodes[i].name, nx, ny + r + 4)
    }
  }

  private handleTouch(tx: number, ty: number) {
    const cx = 160
    const cy = 170
    const nodes = KN_DATA.slice(0, 8)
    const radius = 110
    for (let i = 0; i < nodes.length; i++) {
      const angle = (i / nodes.length) * Math.PI * 2 - Math.PI / 2
      const nx = cx + Math.cos(angle) * radius
      const ny = cy + Math.sin(angle) * radius
      const dx = tx - nx
      const dy = ty - ny
      if (dx * dx + dy * dy < 400) {
        this.selectedNode = this.selectedNode === i ? -1 : i
        this.drawRadial()
        return
      }
    }
    this.selectedNode = -1
    this.drawRadial()
  }
}

// ─── L12 树状层级图 ────────────────────────────────────────
@Component
export struct L12 {
  @State selectedNode: number = -1
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private treeData: TreeNode[] = [
    { name: 'AI', children: ['ML', 'DL', 'NLP'] },
    { name: 'ML', children: ['监督学习', '无监督'] },
    { name: 'DL', children: ['CNN', 'RNN'] },
    { name: 'NLP', children: ['Transformer', 'BERT'] }
  ]

  build() {
    Column() {
      Row() {
        Text('9:41').fontSize(FontSize.XS).fontColor(AppColors.FG_SECONDARY)
        Blank()
        Text('●●● ◗ ▮').fontSize(FontSize.XS).fontColor(AppColors.FG_SECONDARY)
      }.width('100%').padding({ left: Spacing.BASE, right: Spacing.BASE, top: 6, bottom: 4 })

      Row() {
        Text('←').fontSize(FontSize.LG).fontColor(AppColors.FG_SECONDARY).padding(Spacing.XS)
        Text('树状层级图').fontSize(FontSize.BASE).fontColor(AppColors.FG).fontWeight(FontWeight.Bold).layoutWeight(1)
      }.width('100%').height(40).padding({ left: Spacing.SM, right: Spacing.SM })

      Canvas(this.ctx)
        .width('100%')
        .layoutWeight(1)
        .onReady(() => { this.drawTree() })
        .onTouch((e: TouchEvent) => {
          if (e.type === TouchType.Up) {
            this.handleTreeTouch(e.touches[0].x, e.touches[0].y)
          }
        })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }

  private drawTree() {
    const ctx = this.ctx
    const w = 320
    const h = 340
    ctx.clearRect(0, 0, w, h)

    const levels: string[][] = [
      ['AI'],
      ['ML', 'DL', 'NLP'],
      ['监督学习', '无监督', 'CNN', 'RNN', 'Transformer', 'BERT']
    ]
    const yPositions = [50, 160, 270]
    const nodePositions: IndexedNode[] = []
    let idx = 0

    for (let lv = 0; lv < levels.length; lv++) {
      const row = levels[lv]
      const gap = w / (row.length + 1)
      for (let i = 0; i < row.length; i++) {
        const x = gap * (i + 1)
        const y = yPositions[lv]
        nodePositions.push({ x, y, name: row[i], idx })
        idx++
      }
    }

    // 连线: AI -> ML, DL, NLP
    const aiPos = nodePositions[0]
    for (let i = 1; i <= 3; i++) {
      const child = nodePositions[i]
      ctx.beginPath()
      ctx.moveTo(aiPos.x, aiPos.y + 14)
      ctx.lineTo(child.x, child.y - 14)
      ctx.strokeStyle = '#C4A26540'
      ctx.lineWidth = 1.5
      ctx.stroke()
    }

    // 连线: ML -> 监督学习, 无监督
    ctx.beginPath()
    ctx.moveTo(nodePositions[1].x, nodePositions[1].y + 14)
    ctx.lineTo(nodePositions[4].x, nodePositions[4].y - 14)
    ctx.strokeStyle = '#C4A26540'
    ctx.lineWidth = 1.5
    ctx.stroke()
    ctx.beginPath()
    ctx.moveTo(nodePositions[1].x, nodePositions[1].y + 14)
    ctx.lineTo(nodePositions[5].x, nodePositions[5].y - 14)
    ctx.stroke()

    // 连线: DL -> CNN, RNN
    ctx.beginPath()
    ctx.moveTo(nodePositions[2].x, nodePositions[2].y + 14)
    ctx.lineTo(nodePositions[6].x, nodePositions[6].y - 14)
    ctx.stroke()
    ctx.beginPath()
    ctx.moveTo(nodePositions[2].x, nodePositions[2].y + 14)
    ctx.lineTo(nodePositions[7].x, nodePositions[7].y - 14)
    ctx.stroke()

    // 连线: NLP -> Transformer, BERT
    ctx.beginPath()
    ctx.moveTo(nodePositions[3].x, nodePositions[3].y + 14)
    ctx.lineTo(nodePositions[8].x, nodePositions[8].y - 14)
    ctx.stroke()
    ctx.beginPath()
    ctx.moveTo(nodePositions[3].x, nodePositions[3].y + 14)
    ctx.lineTo(nodePositions[9].x, nodePositions[9].y - 14)
    ctx.stroke()

    // 绘制节点
    for (const np of nodePositions) {
      const isSelected = this.selectedNode === np.idx
      const r = np.idx === 0 ? 22 : np.idx <= 3 ? 16 : 13

      if (isSelected) {
        ctx.beginPath()
        ctx.arc(np.x, np.y, r + 6, 0, Math.PI * 2)
        ctx.fillStyle = '#C4A26520'
        ctx.fill()
      }

      ctx.beginPath()
      ctx.arc(np.x, np.y, r, 0, Math.PI * 2)
      ctx.fillStyle = isSelected ? AppColors.ACCENT : '#1E1E1B'
      ctx.fill()
      ctx.strokeStyle = isSelected ? '#E8E4D9' : '#C4A26560'
      ctx.lineWidth = isSelected ? 2 : 1
      ctx.stroke()

      ctx.font = np.idx === 0 ? 'bold 11px sans-serif' : '9px sans-serif'
      ctx.fillStyle = isSelected ? '#0D0D0C' : '#E8E4D9'
      ctx.textAlign = 'center'
      ctx.textBaseline = 'middle'
      ctx.fillText(np.name, np.x, np.y)
    }
  }

  private handleTreeTouch(tx: number, ty: number) {
    const levels: string[][] = [['AI'], ['ML', 'DL', 'NLP'], ['监督学习', '无监督', 'CNN', 'RNN', 'Transformer', 'BERT']]
    const yPositions = [50, 160, 270]
    let idx = 0
    for (let lv = 0; lv < levels.length; lv++) {
      const row = levels[lv]
      const gap = 320 / (row.length + 1)
      for (let i = 0; i < row.length; i++) {
        const x = gap * (i + 1)
        const y = yPositions[lv]
        const r = idx === 0 ? 22 : idx <= 3 ? 16 : 13
        const dx = tx - x
        const dy = ty - y
        if (dx * dx + dy * dy < (r + 8) * (r + 8)) {
          this.selectedNode = this.selectedNode === idx ? -1 : idx
          this.drawTree()
          return
        }
        idx++
      }
    }
    this.selectedNode = -1
    this.drawTree()
  }
}

// ─── L13 力导向图 ─────────────────────────────────────────
@Component
export struct L13 {
  @State selectedNode: number = -1
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private nodePositions: number[][] = [
    [80, 80], [200, 60], [280, 130], [60, 200], [160, 170],
    [260, 240], [100, 290], [200, 280], [50, 130], [300, 60]
  ]
  private edges: number[][] = [
    [0, 1], [1, 2], [0, 3], [3, 4], [4, 1],
    [4, 5], [5, 6], [6, 7], [7, 4], [8, 0], [8, 3], [2, 9]
  ]

  build() {
    Column() {
      Row() {
        Text('9:41').fontSize(FontSize.XS).fontColor(AppColors.FG_SECONDARY)
        Blank()
        Text('●●● ◗ ▮').fontSize(FontSize.XS).fontColor(AppColors.FG_SECONDARY)
      }.width('100%').padding({ left: Spacing.BASE, right: Spacing.BASE, top: 6, bottom: 4 })

      Row() {
        Text('←').fontSize(FontSize.LG).fontColor(AppColors.FG_SECONDARY).padding(Spacing.XS)
        Text('力导向图').fontSize(FontSize.BASE).fontColor(AppColors.FG).fontWeight(FontWeight.Bold).layoutWeight(1)
        Text('⟳').fontSize(FontSize.LG).fontColor(AppColors.ACCENT).padding(Spacing.XS)
      }.width('100%').height(40).padding({ left: Spacing.SM, right: Spacing.SM })

      Canvas(this.ctx)
        .width('100%')
        .layoutWeight(1)
        .onReady(() => { this.drawForce() })
        .onTouch((e: TouchEvent) => {
          if (e.type === TouchType.Up) {
            this.handleForceTouch(e.touches[0].x, e.touches[0].y)
          }
        })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }

  private drawForce() {
    const ctx = this.ctx
    const w = 320
    const h = 340
    ctx.clearRect(0, 0, w, h)

    // 绘制边
    for (const edge of this.edges) {
      const from = this.nodePositions[edge[0]]
      const to = this.nodePositions[edge[1]]
      ctx.beginPath()
      ctx.moveTo(from[0], from[1])
      ctx.lineTo(to[0], to[1])
      ctx.strokeStyle = '#C4A26530'
      ctx.lineWidth = 1
      ctx.stroke()
    }

    // 绘制节点
    const nodes = KN_DATA.slice(0, 10)
    for (let i = 0; i < nodes.length; i++) {
      const x = this.nodePositions[i][0]
      const y = this.nodePositions[i][1]
      const isSelected = this.selectedNode === i
      const r = nodes[i].lv >= 4 ? 18 : nodes[i].lv >= 3 ? 14 : 11

      if (isSelected) {
        ctx.beginPath()
        ctx.arc(x, y, r + 8, 0, Math.PI * 2)
        ctx.fillStyle = '#C4A26520'
        ctx.fill()
      }

      ctx.beginPath()
      ctx.arc(x, y, r, 0, Math.PI * 2)
      ctx.fillStyle = isSelected ? AppColors.ACCENT : '#1E1E1B'
      ctx.fill()
      ctx.strokeStyle = isSelected ? '#E8E4D9' : '#C4A26560'
      ctx.lineWidth = isSelected ? 2 : 1
      ctx.stroke()

      ctx.font = '9px sans-serif'
      ctx.fillStyle = isSelected ? '#0D0D0C' : '#9A9688'
      ctx.textAlign = 'center'
      ctx.textBaseline = 'top'
      ctx.fillText(nodes[i].name, x, y + r + 3)
    }

    // 选中信息
    if (this.selectedNode >= 0 && this.selectedNode < nodes.length) {
      const nd = nodes[this.selectedNode]
      ctx.fillStyle = '#1E1E1B'
      ctx.fillRect(10, h - 50, w - 20, 40)
      ctx.strokeStyle = '#2A2820'
      ctx.lineWidth = 1
      ctx.strokeRect(10, h - 50, w - 20, 40)
      ctx.font = 'bold 11px sans-serif'
      ctx.fillStyle = AppColors.ACCENT
      ctx.textAlign = 'left'
      ctx.textBaseline = 'middle'
      ctx.fillText(nd.name, 20, h - 35)
      ctx.font = '9px sans-serif'
      ctx.fillStyle = '#9A9688'
      ctx.fillText(`分类: ${nd.cat}  等级: Lv.${nd.lv}`, 20, h - 20)
    }
  }

  private handleForceTouch(tx: number, ty: number) {
    const nodes = KN_DATA.slice(0, 10)
    for (let i = 0; i < nodes.length; i++) {
      const x = this.nodePositions[i][0]
      const y = this.nodePositions[i][1]
      const r = nodes[i].lv >= 4 ? 18 : nodes[i].lv >= 3 ? 14 : 11
      const dx = tx - x
      const dy = ty - y
      if (dx * dx + dy * dy < (r + 10) * (r + 10)) {
        this.selectedNode = this.selectedNode === i ? -1 : i
        this.drawForce()
        return
      }
    }
    this.selectedNode = -1
    this.drawForce()
  }
}

// ─── L14 矩阵格子图 ───────────────────────────────────────
@Component
export struct L14 {
  @State selectedIndex: number = -1
  private gridLabels: string[] = [
    'ML', 'DL', 'NLP', 'CV',
    'Python', '数据结构', '线性代数', '概率统计',
    '神经网络', '强化学习', 'TF', 'PyTorch',
    'Transformer', 'CNN', 'RNN', 'GAN'
  ]

  build() {
    Column() {
      Row() {
        Text('9:41').fontSize(FontSize.XS).fontColor(AppColors.FG_SECONDARY)
        Blank()
        Text('●●● ◗ ▮').fontSize(FontSize.XS).fontColor(AppColors.FG_SECONDARY)
      }.width('100%').padding({ left: Spacing.BASE, right: Spacing.BASE, top: 6, bottom: 4 })

      Row() {
        Text('←').fontSize(FontSize.LG).fontColor(AppColors.FG_SECONDARY).padding(Spacing.XS)
        Text('矩阵格子图').fontSize(FontSize.BASE).fontColor(AppColors.FG).fontWeight(FontWeight.Bold).layoutWeight(1)
      }.width('100%').height(40).padding({ left: Spacing.SM, right: Spacing.SM })

      Column() {
        Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Center }) {
          ForEach(this.gridLabels, (label: string, index: number) => {
            Column() {
              Text(label)
                .fontSize(FontSize.XS)
                .fontColor(this.selectedIndex === index ? '#0D0D0C' : '#9A9688')
                .fontWeight(this.selectedIndex === index ? FontWeight.Bold : FontWeight.Normal)
            }
            .width(70)
            .height(60)
            .margin(4)
            .borderRadius(Radius.MD)
            .backgroundColor(this.selectedIndex === index ? AppColors.ACCENT : '#1E1E1B')
            .border({
              width: this.selectedIndex === index ? 2 : 1,
              color: this.selectedIndex === index ? '#E8E4D9' : '#2A2820'
            })
            .justifyContent(FlexAlign.Center)
            .onClick(() => {
              this.selectedIndex = this.selectedIndex === index ? -1 : index
            })
          }, (label: string, index: number) => label + index)
        }
        .padding({ left: Spacing.SM, right: Spacing.SM })

        if (this.selectedIndex >= 0) {
          Row() {
            Circle().width(8).height(8).fill(AppColors.ACCENT).margin({ right: Spacing.SM })
            Text(this.gridLabels[this.selectedIndex])
              .fontSize(FontSize.SM)
              .fontColor(AppColors.FG)
              .fontWeight(FontWeight.Bold)
            Text(` · 知识领域`)
              .fontSize(FontSize.SM)
              .fontColor(AppColors.FG_SECONDARY)
          }
          .padding({ left: Spacing.BASE, top: Spacing.SM, bottom: Spacing.SM })
        }
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ─── L15 3D星球 ────────────────────────────────────────────
@Component
export struct L15 {
  @State rotation: number = 0
  @State selectedOrbit: number = -1
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private orbitNodes: string[] = ['ML', 'DL', 'NLP', 'CV', 'RL', 'Math', 'Code', 'Data']

  build() {
    Column() {
      Row() {
        Text('9:41').fontSize(FontSize.XS).fontColor(AppColors.FG_SECONDARY)
        Blank()
        Text('●●● ◗ ▮').fontSize(FontSize.XS).fontColor(AppColors.FG_SECONDARY)
      }.width('100%').padding({ left: Spacing.BASE, right: Spacing.BASE, top: 6, bottom: 4 })

      Row() {
        Text('←').fontSize(FontSize.LG).fontColor(AppColors.FG_SECONDARY).padding(Spacing.XS)
        Text('3D星球').fontSize(FontSize.BASE).fontColor(AppColors.FG).fontWeight(FontWeight.Bold).layoutWeight(1)
        Text('⟳').fontSize(FontSize.LG).fontColor(AppColors.ACCENT).padding(Spacing.XS)
          .onClick(() => { this.rotation += 45; this.drawPlanet() })
      }.width('100%').height(40).padding({ left: Spacing.SM, right: Spacing.SM })

      Canvas(this.ctx)
        .width('100%')
        .layoutWeight(1)
        .onReady(() => { this.drawPlanet() })
        .onTouch((e: TouchEvent) => {
          if (e.type === TouchType.Up) {
            this.handlePlanetTouch(e.touches[0].x, e.touches[0].y)
          }
        })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }

  private drawPlanet() {
    const ctx = this.ctx
    const w = 320
    const h = 340
    const cx = w / 2
    const cy = h / 2
    ctx.clearRect(0, 0, w, h)

    // 中心球体
    const sphereR = 50
    const gradient = ctx.createRadialGradient(cx - 10, cy - 10, 5, cx, cy, sphereR)
    gradient.addColorStop(0, '#C4A265')
    gradient.addColorStop(0.7, '#8B7340')
    gradient.addColorStop(1, '#3D2E10')
    ctx.beginPath()
    ctx.arc(cx, cy, sphereR, 0, Math.PI * 2)
    ctx.fillStyle = gradient
    ctx.fill()
    ctx.strokeStyle = '#C4A26540'
    ctx.lineWidth = 1
    ctx.stroke()

    // 中心文字
    ctx.font = 'bold 16px sans-serif'
    ctx.fillStyle = '#E8E4D9'
    ctx.textAlign = 'center'
    ctx.textBaseline = 'middle'
    ctx.fillText('AI', cx, cy)

    // 轨道椭圆 (y-squish for perspective)
    const orbitRx = 120
    const orbitRy = 40

    ctx.beginPath()
    ctx.ellipse(cx, cy, orbitRx, orbitRy, 0, 0, Math.PI * 2)
    ctx.strokeStyle = '#C4A26520'
    ctx.lineWidth = 1
    ctx.stroke()

    // 轨道上的节点
    const rotRad = this.rotation * Math.PI / 180
    for (let i = 0; i < this.orbitNodes.length; i++) {
      const angle = (i / this.orbitNodes.length) * Math.PI * 2 + rotRad
      const nx = cx + Math.cos(angle) * orbitRx
      const ny = cy + Math.sin(angle) * orbitRy
      const isSelected = this.selectedOrbit === i
      const r = isSelected ? 16 : 12

      // 根据角度判断前后（sin值小的在前面，先绘制后面的）
      const depth = Math.sin(angle)

      // 连线到中心
      ctx.beginPath()
      ctx.moveTo(cx, cy)
      ctx.lineTo(nx, ny)
      ctx.strokeStyle = '#C4A26520'
      ctx.lineWidth = 0.5
      ctx.stroke()

      if (isSelected) {
        ctx.beginPath()
        ctx.arc(nx, ny, r + 6, 0, Math.PI * 2)
        ctx.fillStyle = '#C4A26520'
        ctx.fill()
      }

      ctx.beginPath()
      ctx.arc(nx, ny, r, 0, Math.PI * 2)
      ctx.fillStyle = isSelected ? AppColors.ACCENT : '#1E1E1B'
      ctx.globalAlpha = depth > 0 ? 0.5 : 1.0
      ctx.fill()
      ctx.strokeStyle = isSelected ? '#E8E4D9' : '#C4A26560'
      ctx.lineWidth = isSelected ? 2 : 1
      ctx.stroke()

      ctx.font = '9px sans-serif'
      ctx.fillStyle = isSelected ? '#0D0D0C' : '#9A9688'
      ctx.textAlign = 'center'
      ctx.textBaseline = 'top'
      ctx.fillText(this.orbitNodes[i], nx, ny + r + 3)
      ctx.globalAlpha = 1.0
    }
  }

  private handlePlanetTouch(tx: number, ty: number) {
    const cx = 160
    const cy = 170
    const orbitRx = 120
    const orbitRy = 40
    const rotRad = this.rotation * Math.PI / 180
    for (let i = 0; i < this.orbitNodes.length; i++) {
      const angle = (i / this.orbitNodes.length) * Math.PI * 2 + rotRad
      const nx = cx + Math.cos(angle) * orbitRx
      const ny = cy + Math.sin(angle) * orbitRy
      const dx = tx - nx
      const dy = ty - ny
      if (dx * dx + dy * dy < 400) {
        this.selectedOrbit = this.selectedOrbit === i ? -1 : i
        this.drawPlanet()
        return
      }
    }
    this.selectedOrbit = -1
    this.drawPlanet()
  }
}

// ─── L16 思维导图 ─────────────────────────────────────────
@Component
export struct L16 {
  @State selectedBranch: number = -1
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private branches: BranchNode[] = [
    { name: 'ML', subs: ['监督学习', '无监督', '强化学习'] },
    { name: 'DL', subs: ['CNN', 'RNN', 'Transformer'] }
  ]

  build() {
    Column() {
      Row() {
        Text('9:41').fontSize(FontSize.XS).fontColor(AppColors.FG_SECONDARY)
        Blank()
        Text('●●● ◗ ▮').fontSize(FontSize.XS).fontColor(AppColors.FG_SECONDARY)
      }.width('100%').padding({ left: Spacing.BASE, right: Spacing.BASE, top: 6, bottom: 4 })

      Row() {
        Text('←').fontSize(FontSize.LG).fontColor(AppColors.FG_SECONDARY).padding(Spacing.XS)
        Text('思维导图').fontSize(FontSize.BASE).fontColor(AppColors.FG).fontWeight(FontWeight.Bold).layoutWeight(1)
      }.width('100%').height(40).padding({ left: Spacing.SM, right: Spacing.SM })

      Canvas(this.ctx)
        .width('100%')
        .layoutWeight(1)
        .onReady(() => { this.drawMindMap() })
        .onTouch((e: TouchEvent) => {
          if (e.type === TouchType.Up) {
            this.handleMindTouch(e.touches[0].x, e.touches[0].y)
          }
        })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }

  private drawMindMap() {
    const ctx = this.ctx
    const w = 320
    const h = 340
    const cx = w / 2
    const cy = h / 2
    ctx.clearRect(0, 0, w, h)

    // 中心节点
    const cw = 60
    const ch = 30
    ctx.fillStyle = AppColors.ACCENT
    ctx.fillRect(cx - cw / 2, cy - ch / 2, cw, ch)
    ctx.strokeStyle = '#E8E4D9'
    ctx.lineWidth = 1.5
    ctx.strokeRect(cx - cw / 2, cy - ch / 2, cw, ch)
    ctx.font = 'bold 13px sans-serif'
    ctx.fillStyle = '#0D0D0C'
    ctx.textAlign = 'center'
    ctx.textBaseline = 'middle'
    ctx.fillText('AI', cx, cy)

    // 右侧分支 (ML)
    const mlX = cx + 100
    const mlY = cy - 60
    const isLeftSelected = this.selectedBranch === 0
    ctx.beginPath()
    ctx.moveTo(cx + cw / 2, cy)
    ctx.lineTo(mlX - 30, mlY)
    ctx.strokeStyle = isLeftSelected ? AppColors.ACCENT : '#C4A26540'
    ctx.lineWidth = isLeftSelected ? 2 : 1.5
    ctx.stroke()

    ctx.fillStyle = isLeftSelected ? AppColors.ACCENT : '#1E1E1B'
    ctx.fillRect(mlX - 30, mlY - 12, 60, 24)
    ctx.strokeStyle = isLeftSelected ? '#E8E4D9' : '#C4A26560'
    ctx.lineWidth = isLeftSelected ? 2 : 1
    ctx.strokeRect(mlX - 30, mlY - 12, 60, 24)
    ctx.font = '10px sans-serif'
    ctx.fillStyle = isLeftSelected ? '#0D0D0C' : '#E8E4D9'
    ctx.fillText('ML', mlX, mlY)

    // ML 子节点
    const mlSubs = this.branches[0].subs
    for (let i = 0; i < mlSubs.length; i++) {
      const sx = mlX + 80
      const sy = mlY - 30 + i * 30
      ctx.beginPath()
      ctx.moveTo(mlX + 30, mlY)
      ctx.lineTo(sx - 30, sy)
      ctx.strokeStyle = '#C4A26530'
      ctx.lineWidth = 1
      ctx.stroke()

      ctx.fillStyle = '#1E1E1B'
      ctx.fillRect(sx - 30, sy - 10, 60, 20)
      ctx.strokeStyle = '#2A2820'
      ctx.lineWidth = 1
      ctx.strokeRect(sx - 30, sy - 10, 60, 20)
      ctx.font = '9px sans-serif'
      ctx.fillStyle = '#9A9688'
      ctx.fillText(mlSubs[i], sx, sy)
    }

    // 左侧分支 (DL)
    const dlX = cx - 100
    const dlY = cy + 60
    const isRightSelected = this.selectedBranch === 1
    ctx.beginPath()
    ctx.moveTo(cx - cw / 2, cy)
    ctx.lineTo(dlX + 30, dlY)
    ctx.strokeStyle = isRightSelected ? AppColors.ACCENT : '#C4A26540'
    ctx.lineWidth = isRightSelected ? 2 : 1.5
    ctx.stroke()

    ctx.fillStyle = isRightSelected ? AppColors.ACCENT : '#1E1E1B'
    ctx.fillRect(dlX - 30, dlY - 12, 60, 24)
    ctx.strokeStyle = isRightSelected ? '#E8E4D9' : '#C4A26560'
    ctx.lineWidth = isRightSelected ? 2 : 1
    ctx.strokeRect(dlX - 30, dlY - 12, 60, 24)
    ctx.font = '10px sans-serif'
    ctx.fillStyle = isRightSelected ? '#0D0D0C' : '#E8E4D9'
    ctx.fillText('DL', dlX, dlY)

    // DL 子节点
    const dlSubs = this.branches[1].subs
    for (let i = 0; i < dlSubs.length; i++) {
      const sx = dlX - 80
      const sy = dlY - 30 + i * 30
      ctx.beginPath()
      ctx.moveTo(dlX - 30, dlY)
      ctx.lineTo(sx + 30, sy)
      ctx.strokeStyle = '#C4A26530'
      ctx.lineWidth = 1
      ctx.stroke()

      ctx.fillStyle = '#1E1E1B'
      ctx.fillRect(sx - 30, sy - 10, 60, 20)
      ctx.strokeStyle = '#2A2820'
      ctx.lineWidth = 1
      ctx.strokeRect(sx - 30, sy - 10, 60, 20)
      ctx.font = '9px sans-serif'
      ctx.fillStyle = '#9A9688'
      ctx.fillText(dlSubs[i], sx, sy)
    }
  }

  private handleMindTouch(tx: number, ty: number) {
    const cx = 160
    const cy = 170
    const mlX = cx + 100
    const mlY = cy - 60
    const dlX = cx - 100
    const dlY = cy + 60

    if (tx > mlX - 30 && tx < mlX + 30 && ty > mlY - 12 && ty < mlY + 12) {
      this.selectedBranch = this.selectedBranch === 0 ? -1 : 0
      this.drawMindMap()
      return
    }
    if (tx > dlX - 30 && tx < dlX + 30 && ty > dlY - 12 && ty < dlY + 12) {
      this.selectedBranch = this.selectedBranch === 1 ? -1 : 1
      this.drawMindMap()
      return
    }
    this.selectedBranch = -1
    this.drawMindMap()
  }
}

// ─── L17 地图探索 ─────────────────────────────────────────
@Component
export struct L17 {
  @State selectedRegion: number = -1
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private regions: RegionNode[] = [
    { name: 'AI基础', x: 20, y: 40, w: 90, h: 60 },
    { name: '编程', x: 130, y: 30, w: 80, h: 70 },
    { name: '数学', x: 230, y: 40, w: 70, h: 55 },
    { name: 'NLP', x: 30, y: 130, w: 85, h: 65 },
    { name: 'CV', x: 140, y: 120, w: 75, h: 60 },
    { name: '框架', x: 240, y: 120, w: 60, h: 70 },
    { name: '深度学习', x: 20, y: 220, w: 100, h: 55 },
    { name: '强化学习', x: 150, y: 210, w: 80, h: 60 },
    { name: '应用', x: 250, y: 210, w: 50, h: 65 }
  ]

  build() {
    Column() {
      Row() {
        Text('9:41').fontSize(FontSize.XS).fontColor(AppColors.FG_SECONDARY)
        Blank()
        Text('●●● ◗ ▮').fontSize(FontSize.XS).fontColor(AppColors.FG_SECONDARY)
      }.width('100%').padding({ left: Spacing.BASE, right: Spacing.BASE, top: 6, bottom: 4 })

      Row() {
        Text('←').fontSize(FontSize.LG).fontColor(AppColors.FG_SECONDARY).padding(Spacing.XS)
        Text('地图探索').fontSize(FontSize.BASE).fontColor(AppColors.FG).fontWeight(FontWeight.Bold).layoutWeight(1)
        Text('🗺').fontSize(FontSize.LG).fontColor(AppColors.ACCENT).padding(Spacing.XS)
      }.width('100%').height(40).padding({ left: Spacing.SM, right: Spacing.SM })

      Canvas(this.ctx)
        .width('100%')
        .layoutWeight(1)
        .onReady(() => { this.drawMap() })
        .onTouch((e: TouchEvent) => {
          if (e.type === TouchType.Up) {
            this.handleMapTouch(e.touches[0].x, e.touches[0].y)
          }
        })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }

  private drawMap() {
    const ctx = this.ctx
    const w = 320
    const h = 340
    ctx.clearRect(0, 0, w, h)

    // 背景网格
    ctx.strokeStyle = '#C4A26510'
    ctx.lineWidth = 0.5
    for (let x = 0; x < w; x += 30) {
      ctx.beginPath(); ctx.moveTo(x, 0); ctx.lineTo(x, h); ctx.stroke()
    }
    for (let y = 0; y < h; y += 30) {
      ctx.beginPath(); ctx.moveTo(0, y); ctx.lineTo(w, y); ctx.stroke()
    }

    // 绘制区域
    for (let i = 0; i < this.regions.length; i++) {
      const r = this.regions[i]
      const isSelected = this.selectedRegion === i

      ctx.fillStyle = isSelected ? '#C4A26530' : '#1E1E1B'
      ctx.fillRect(r.x, r.y, r.w, r.h)
      ctx.strokeStyle = isSelected ? AppColors.ACCENT : '#2A2820'
      ctx.lineWidth = isSelected ? 2 : 1
      ctx.strokeRect(r.x, r.y, r.w, r.h)

      ctx.font = isSelected ? 'bold 11px sans-serif' : '10px sans-serif'
      ctx.fillStyle = isSelected ? AppColors.ACCENT : '#9A9688'
      ctx.textAlign = 'center'
      ctx.textBaseline = 'middle'
      ctx.fillText(r.name, r.x + r.w / 2, r.y + r.h / 2)
    }

    // 选中信息
    if (this.selectedRegion >= 0) {
      const sr = this.regions[this.selectedRegion]
      ctx.fillStyle = '#1E1E1B'
      ctx.fillRect(10, h - 40, w - 20, 30)
      ctx.strokeStyle = '#2A2820'
      ctx.lineWidth = 1
      ctx.strokeRect(10, h - 40, w - 20, 30)
      ctx.font = '10px sans-serif'
      ctx.fillStyle = AppColors.ACCENT
      ctx.textAlign = 'left'
      ctx.textBaseline = 'middle'
      ctx.fillText(`📍 ${sr.name} - 点击探索更多`, 20, h - 25)
    }
  }

  private handleMapTouch(tx: number, ty: number) {
    for (let i = 0; i < this.regions.length; i++) {
      const r = this.regions[i]
      if (tx >= r.x && tx <= r.x + r.w && ty >= r.y && ty <= r.y + r.h) {
        this.selectedRegion = this.selectedRegion === i ? -1 : i
        this.drawMap()
        return
      }
    }
    this.selectedRegion = -1
    this.drawMap()
  }
}

// ─── L18 时间轴 ────────────────────────────────────────────
@Component
export struct L18 {
  @State selectedYear: number = -1
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private timeline: TimelineNode[] = [
    { year: 2018, desc: 'Transformer兴起' },
    { year: 2019, desc: 'BERT预训练时代' },
    { year: 2020, desc: 'GPT-3大模型' },
    { year: 2021, desc: '多模态突破' },
    { year: 2022, desc: 'ChatGPT发布' },
    { year: 2023, desc: '大模型生态爆发' },
    { year: 2024, desc: 'Agent智能体' },
    { year: 2025, desc: '通用AI探索' },
    { year: 2026, desc: '知识图谱融合' }
  ]

  build() {
    Column() {
      Row() {
        Text('9:41').fontSize(FontSize.XS).fontColor(AppColors.FG_SECONDARY)
        Blank()
        Text('●●● ◗ ▮').fontSize(FontSize.XS).fontColor(AppColors.FG_SECONDARY)
      }.width('100%').padding({ left: Spacing.BASE, right: Spacing.BASE, top: 6, bottom: 4 })

      Row() {
        Text('←').fontSize(FontSize.LG).fontColor(AppColors.FG_SECONDARY).padding(Spacing.XS)
        Text('时间轴').fontSize(FontSize.BASE).fontColor(AppColors.FG).fontWeight(FontWeight.Bold).layoutWeight(1)
      }.width('100%').height(40).padding({ left: Spacing.SM, right: Spacing.SM })

      Canvas(this.ctx)
        .width('100%')
        .layoutWeight(1)
        .onReady(() => { this.drawTimeline() })
        .onTouch((e: TouchEvent) => {
          if (e.type === TouchType.Up) {
            this.handleTimelineTouch(e.touches[0].x, e.touches[0].y)
          }
        })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }

  private drawTimeline() {
    const ctx = this.ctx
    const w = 320
    const h = 340
    ctx.clearRect(0, 0, w, h)

    const lineX = 60
    const startY = 20
    const gap = 32

    // 主线
    ctx.beginPath()
    ctx.moveTo(lineX, startY)
    ctx.lineTo(lineX, startY + (this.timeline.length - 1) * gap)
    ctx.strokeStyle = '#C4A26540'
    ctx.lineWidth = 2
    ctx.stroke()

    for (let i = 0; i < this.timeline.length; i++) {
      const item = this.timeline[i]
      const y = startY + i * gap
      const isSelected = this.selectedYear === i

      // 时间点
      ctx.beginPath()
      ctx.arc(lineX, y, isSelected ? 7 : 5, 0, Math.PI * 2)
      ctx.fillStyle = isSelected ? AppColors.ACCENT : '#1E1E1B'
      ctx.fill()
      ctx.strokeStyle = isSelected ? '#E8E4D9' : '#C4A26560'
      ctx.lineWidth = isSelected ? 2 : 1
      ctx.stroke()

      // 年份
      ctx.font = isSelected ? 'bold 11px sans-serif' : '10px sans-serif'
      ctx.fillStyle = isSelected ? AppColors.ACCENT : '#9A9688'
      ctx.textAlign = 'right'
      ctx.textBaseline = 'middle'
      ctx.fillText(item.year.toString(), lineX - 14, y)

      // 描述
      ctx.font = isSelected ? '11px sans-serif' : '10px sans-serif'
      ctx.fillStyle = isSelected ? '#E8E4D9' : '#5C5A52'
      ctx.textAlign = 'left'
      ctx.fillText(item.desc, lineX + 16, y)

      // 选中高亮条
      if (isSelected) {
        ctx.fillStyle = '#C4A26515'
        ctx.fillRect(lineX + 10, y - 12, w - lineX - 20, 24)
      }
    }
  }

  private handleTimelineTouch(tx: number, ty: number) {
    const lineX = 60
    const startY = 20
    const gap = 32
    for (let i = 0; i < this.timeline.length; i++) {
      const y = startY + i * gap
      if (Math.abs(ty - y) < 16 && tx > 10 && tx < 310) {
        this.selectedYear = this.selectedYear === i ? -1 : i
        this.drawTimeline()
        return
      }
    }
    this.selectedYear = -1
    this.drawTimeline()
  }
}

// ─── L19 卡片流 ────────────────────────────────────────────
@Component
export struct L19 {
  @State selectedCard: number = 0

  build() {
    Column() {
      Row() {
        Text('9:41').fontSize(FontSize.XS).fontColor(AppColors.FG_SECONDARY)
        Blank()
        Text('●●● ◗ ▮').fontSize(FontSize.XS).fontColor(AppColors.FG_SECONDARY)
      }.width('100%').padding({ left: Spacing.BASE, right: Spacing.BASE, top: 6, bottom: 4 })

      Row() {
        Text('←').fontSize(FontSize.LG).fontColor(AppColors.FG_SECONDARY).padding(Spacing.XS)
        Text('卡片流').fontSize(FontSize.BASE).fontColor(AppColors.FG).fontWeight(FontWeight.Bold).layoutWeight(1)
      }.width('100%').height(40).padding({ left: Spacing.SM, right: Spacing.SM })

      Scroll() {
        Column() {
          ForEach(KN_DATA.slice(0, 8), (node: KnowledgeNode, index: number) => {
            Row() {
              // 左侧色条
              Column()
                .width(3)
                .height('100%')
                .borderRadius(2)
                .backgroundColor(this.selectedCard === index ? AppColors.ACCENT : '#2A2820')

              Column() {
                Text(node.name)
                  .fontSize(FontSize.BASE)
                  .fontColor(this.selectedCard === index ? AppColors.FG : '#9A9688')
                  .fontWeight(this.selectedCard === index ? FontWeight.Bold : FontWeight.Normal)

                Row() {
                  Text(node.cat)
                    .fontSize(FontSize.XS)
                    .fontColor(AppColors.FG_DIM)
                    .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                    .borderRadius(Radius.SM)
                    .backgroundColor('#262622')

                  Text(`Lv.${node.lv}`)
                    .fontSize(FontSize.XS)
                    .fontColor(AppColors.ACCENT_DIM)
                    .margin({ left: Spacing.SM })
                }.margin({ top: Spacing.XS })
              }
              .layoutWeight(1)
              .padding({ left: Spacing.SM })
              .alignItems(HorizontalAlign.Start)

              Text('›')
                .fontSize(FontSize.LG)
                .fontColor(this.selectedCard === index ? AppColors.ACCENT : '#5C5A52')
            }
            .width('100%')
            .height(64)
            .padding({ left: Spacing.BASE, right: Spacing.BASE, top: Spacing.SM, bottom: Spacing.SM })
            .borderRadius(Radius.MD)
            .backgroundColor(this.selectedCard === index ? '#1E1E1B' : '#161614')
            .border({
              width: this.selectedCard === index ? 1 : 0,
              color: this.selectedCard === index ? '#C4A26540' : Color.Transparent
            })
            .margin({ bottom: Spacing.XS })
            .onClick(() => { this.selectedCard = index })
          }, (node: KnowledgeNode) => node.id.toString())
        }
        .padding({ left: Spacing.SM, right: Spacing.SM })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }
}

// ─── L20 星座连线 ──────────────────────────────────────────
@Component
export struct L20 {
  @State selectedStar: number = -1
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private stars: PositionNode[] = [
    { name: 'ML', x: 60, y: 50 },
    { name: 'DL', x: 160, y: 30 },
    { name: 'NLP', x: 260, y: 60 },
    { name: 'Python', x: 40, y: 140 },
    { name: '神经网络', x: 140, y: 120 },
    { name: 'CV', x: 240, y: 150 },
    { name: '线性代数', x: 80, y: 230 },
    { name: '概率统计', x: 180, y: 210 },
    { name: 'TF', x: 280, y: 240 },
    { name: 'Transformer', x: 120, y: 300 },
    { name: 'CNN', x: 220, y: 290 }
  ]
  private constellations: number[][] = [
    [0, 1], [1, 2], [0, 3], [3, 4], [4, 1],
    [1, 5], [3, 6], [6, 7], [7, 4], [5, 8],
    [7, 9], [9, 10], [10, 5], [6, 9]
  ]

  build() {
    Column() {
      Row() {
        Text('9:41').fontSize(FontSize.XS).fontColor(AppColors.FG_SECONDARY)
        Blank()
        Text('●●● ◗ ▮').fontSize(FontSize.XS).fontColor(AppColors.FG_SECONDARY)
      }.width('100%').padding({ left: Spacing.BASE, right: Spacing.BASE, top: 6, bottom: 4 })

      Row() {
        Text('←').fontSize(FontSize.LG).fontColor(AppColors.FG_SECONDARY).padding(Spacing.XS)
        Text('星座连线').fontSize(FontSize.BASE).fontColor(AppColors.FG).fontWeight(FontWeight.Bold).layoutWeight(1)
        Text('✦').fontSize(FontSize.LG).fontColor(AppColors.ACCENT).padding(Spacing.XS)
      }.width('100%').height(40).padding({ left: Spacing.SM, right: Spacing.SM })

      Canvas(this.ctx)
        .width('100%')
        .layoutWeight(1)
        .onReady(() => { this.drawConstellation() })
        .onTouch((e: TouchEvent) => {
          if (e.type === TouchType.Up) {
            this.handleStarTouch(e.touches[0].x, e.touches[0].y)
          }
        })
    }
    .width('100%')
    .height(444)
    .backgroundColor('#161614')
    .borderRadius(24)
    .border({ width: 2, color: '#2A2820' })
    .clip(true)
  }

  private drawConstellation() {
    const ctx = this.ctx
    const w = 320
    const h = 340
    ctx.clearRect(0, 0, w, h)

    // 背景星点装饰
    const bgStars = [15, 45, 75, 105, 135, 165, 195, 225, 255, 285]
    for (const bx of bgStars) {
      for (const by of [20, 80, 160, 250, 310]) {
        ctx.beginPath()
        ctx.arc(bx + (by % 3) * 5, by + (bx % 5), 0.5, 0, Math.PI * 2)
        ctx.fillStyle = '#5C5A5220'
        ctx.fill()
      }
    }

    // 连线
    for (const edge of this.constellations) {
      const from = this.stars[edge[0]]
      const to = this.stars[edge[1]]
      const isHighlighted = this.selectedStar === edge[0] || this.selectedStar === edge[1]
      ctx.beginPath()
      ctx.moveTo(from.x, from.y)
      ctx.lineTo(to.x, to.y)
      ctx.strokeStyle = isHighlighted ? '#C4A26580' : '#C4A26520'
      ctx.lineWidth = isHighlighted ? 1.5 : 0.8
      ctx.stroke()
    }

    // 星点
    for (let i = 0; i < this.stars.length; i++) {
      const star = this.stars[i]
      const isSelected = this.selectedStar === i
      const r = isSelected ? 10 : 6

      // 光晕
      if (isSelected) {
        ctx.beginPath()
        ctx.arc(star.x, star.y, r + 8, 0, Math.PI * 2)
        ctx.fillStyle = '#C4A26520'
        ctx.fill()
        ctx.beginPath()
        ctx.arc(star.x, star.y, r + 4, 0, Math.PI * 2)
        ctx.fillStyle = '#C4A26515'
        ctx.fill()
      }

      // 星点
      ctx.beginPath()
      ctx.arc(star.x, star.y, r, 0, Math.PI * 2)
      ctx.fillStyle = isSelected ? AppColors.ACCENT : '#E8E4D9'
      ctx.fill()

      // 十字光芒
      if (isSelected) {
        ctx.strokeStyle = '#C4A26560'
        ctx.lineWidth = 0.8
        ctx.beginPath(); ctx.moveTo(star.x - r - 6, star.y); ctx.lineTo(star.x + r + 6, star.y); ctx.stroke()
        ctx.beginPath(); ctx.moveTo(star.x, star.y - r - 6); ctx.lineTo(star.x, star.y + r + 6); ctx.stroke()
      }

      // 标签
      ctx.font = isSelected ? 'bold 10px sans-serif' : '9px sans-serif'
      ctx.fillStyle = isSelected ? AppColors.ACCENT : '#5C5A52'
      ctx.textAlign = 'center'
      ctx.textBaseline = 'top'
      ctx.fillText(star.name, star.x, star.y + r + 4)
    }
  }

  private handleStarTouch(tx: number, ty: number) {
    for (let i = 0; i < this.stars.length; i++) {
      const star = this.stars[i]
      const dx = tx - star.x
      const dy = ty - star.y
      if (dx * dx + dy * dy < 225) {
        this.selectedStar = this.selectedStar === i ? -1 : i
        this.drawConstellation()
        return
      }
    }
    this.selectedStar = -1
    this.drawConstellation()
  }
}
