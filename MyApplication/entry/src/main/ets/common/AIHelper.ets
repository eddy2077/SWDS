import { http } from '@kit.NetworkKit'
import { TopicData, GraphNode, GraphEdge, PathStep, QuizItem, AIMessage } from './DataModels'

const AI_API_URL: string = 'https://token-plan-cn.xiaomimimo.com/v1/chat/completions'
// Do not embed API keys in a mobile app or commit them to source control.
// Route AI requests through a backend service, or let users securely provide
// their own credentials during local development.
const DEFAULT_AI_KEY: string = ''

export function getAIApiKey(): string {
  try {
    const key = AppStorage.get<string>('ai_api_key')
    if (key && key.length > 0) {
      return key
    }
  } catch (_e) {
  }
  return DEFAULT_AI_KEY
}

export function setAIApiKey(key: string): void {
  AppStorage.setOrCreate<string>('ai_api_key', key)
}

export function getAIModel(): string {
  try {
    const model = AppStorage.get<string>('ai_model')
    if (model && model.length > 0) {
      return model
    }
  } catch (_e) {
  }
  return 'mimo-v2.5-pro'
}

export function setAIModel(model: string): void {
  AppStorage.setOrCreate<string>('ai_model', model)
}

function buildAIPrompt(topic: string): string {
  return `你是一个知识图谱生成器。请为学习主题「${topic}」生成一个知识图谱数据，严格按照以下JSON格式返回，不要包含任何其他文字：

{
  "nodes": [
    {"id": "root", "label": "${topic}", "type": "center", "desc": "简短描述", "status": "in-progress", "related": ["子领域1","子领域2"]},
    {"id": "l1_1", "label": "子领域1", "type": "l1", "desc": "简短描述", "status": "not-started", "related": ["知识点1","知识点2"]},
    {"id": "l2_1", "label": "知识点1", "type": "l2", "desc": "简短描述", "status": "not-started", "related": ["其他知识点"]}
  ],
  "edges": [
    {"from": "root", "to": "l1_1"},
    {"from": "l1_1", "to": "l2_1"}
  ],
  "path": [
    {"id": "l2_1", "title": "知识点1", "desc": "简短描述", "topics": ["子主题1","子主题2"], "status": "not-started"}
  ],
  "quizzes": [
    {"topic": "知识点1", "question": "问题？", "options": ["选项A","选项B","选项C","选项D"], "answer": 0, "explain": "解释"}
  ]
}

要求：
1. 1个center节点，3-5个l1节点，6-12个l2节点
2. edges连接center到l1，l1到l2，以及部分l2之间的关联
3. path包含5-8个学习步骤，按依赖顺序排列
4. quizzes包含3-5道选择题
5. 所有status默认为"not-started"，第一个path步骤为"in-progress"
6. 只返回JSON，不要markdown代码块`
}

export async function generateTopicDataWithAI(topic: string): Promise<TopicData | null> {
  const apiKey = getAIApiKey()
  const model = getAIModel()

  try {
    const httpRequest = http.createHttp()
    const requestBody = JSON.stringify({
      model: model,
      messages: [
        { role: 'system', content: '你是一个知识图谱生成器，只返回JSON格式数据。' } as AIMessage,
        { role: 'user', content: buildAIPrompt(topic) } as AIMessage
      ],
      temperature: 0.7,
      max_tokens: 4000
    })

    const response: http.HttpResponse = await httpRequest.request(AI_API_URL, {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${apiKey}`
      },
      extraData: requestBody,
      expectDataType: http.HttpDataType.STRING,
      connectTimeout: 30000,
      readTimeout: 60000,
    })

    httpRequest.destroy()

    if (response.responseCode === 200) {
      const resultStr = response.result as string
      const result = JSON.parse(resultStr) as Record<string, Object>
      const choices = result['choices'] as Object[]
      const firstChoice = choices[0] as Record<string, Object>
      const message = firstChoice['message'] as Record<string, string>
      const content = message['content']
      return parseAITopicData(content, topic)
    }
    return null
  } catch (_e) {
    return null
  }
}

function parseAITopicData(text: string, topic: string): TopicData | null {
  try {
    // 尝试提取JSON
    let jsonStr = text.trim()
    if (jsonStr.startsWith('```')) {
      const start = jsonStr.indexOf('{')
      const end = jsonStr.lastIndexOf('}')
      if (start >= 0 && end > start) {
        jsonStr = jsonStr.substring(start, end + 1)
      }
    }

    const data = JSON.parse(jsonStr) as Record<string, Object>

    if (!data['nodes'] || !data['edges']) {
      return null
    }

    const nodes = data['nodes'] as GraphNode[]
    const edges = data['edges'] as GraphEdge[]
    const pathRaw = data['path']
    const path: PathStep[] = pathRaw ? pathRaw as PathStep[] : []
    const quizzesRaw = data['quizzes']
    const quizzes: QuizItem[] = quizzesRaw ? quizzesRaw as QuizItem[] : []

    // 验证并修复数据
    for (const node of nodes) {
      if (!node.id) node.id = 'node_' + nodes.indexOf(node)
      if (!node.label) node.label = topic
      if (!node.type) node.type = 'l2'
      if (!node.desc) node.desc = ''
      if (!node.status) node.status = 'not-started'
      if (!node.related) node.related = []
    }

    for (const edge of edges) {
      if (!edge.from || !edge.to) continue
    }

    if (path.length === 0 && nodes.length > 0) {
      const l2Nodes = nodes.filter(n => n.type === 'l2')
      for (const node of l2Nodes.slice(0, 6)) {
        path.push({
          id: node.id,
          title: node.label,
          desc: node.desc,
          topics: node.related.slice(0, 3),
          status: 'not-started'
        })
      }
      if (path.length > 0) {
        path[0].status = 'in-progress'
      }
    }

    if (quizzes.length === 0 && nodes.length > 0) {
      const quizNodes = nodes.filter(n => n.type === 'l2').slice(0, 3)
      for (const node of quizNodes) {
        quizzes.push({
          topic: node.label,
          question: `关于${node.label}，以下哪个说法是正确的？`,
          options: [node.desc, '这个说法不正确', '以上都不对', '无法确定'],
          answer: 0,
          explain: node.desc
        })
      }
    }

    return { nodes, edges, path, quizzes }
  } catch (_e) {
    return null
  }
}
