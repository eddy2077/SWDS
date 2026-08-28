import { AppColors, FontSize, Radius, Spacing } from '../common/Constants'
import { AIMessage } from '../common/DataModels'
import { generateTopicDataWithAI, getAIApiKey } from '../common/AIHelper'
import { router } from '@kit.ArkUI'
import { http } from '@kit.NetworkKit'

@Entry
@Component
struct AIChatPage {
  @State messages: ChatMessage[] = []
  @State inputText: string = ''
  @State isLoading: boolean = false
  @State currentTopic: string = ''

  aboutToAppear() {
    const params = router.getParams() as Record<string, Object>
    if (params && params['topic']) {
      this.currentTopic = params['topic'] as string
    }
    this.messages = [
      { role: 'assistant', content: '你好！我是AI知识导师，可以帮你解答学习中的问题。请输入你想了解的内容。' }
    ]
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

        Text('AI 对话')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)

        if (this.currentTopic.length > 0) {
          Text(this.currentTopic)
            .fontSize(FontSize.SM)
            .fontColor(AppColors.ACCENT)
        }
      }
      .width('100%')
      .height(56)
      .padding({ left: Spacing.MD, right: Spacing.BASE })
      .backgroundColor(AppColors.BG_SURFACE)
      .alignItems(VerticalAlign.Center)

      Divider().color(AppColors.BORDER).height(0.5)

      // 消息列表
      List() {
        ForEach(this.messages, (msg: ChatMessage, index: number) => {
          ListItem() {
            Row() {
              if (msg.role === 'user') {
                Blank().layoutWeight(1)
              }

              Column() {
                if (msg.role === 'assistant') {
                  Row() {
                    Stack() {
                      Text('AI')
                        .fontSize(FontSize.XS)
                        .fontColor(AppColors.ACCENT)
                        .fontWeight(FontWeight.Bold)
                    }
                    .width(24)
                    .height(24)
                    .borderRadius(12)
                    .backgroundColor(AppColors.ACCENT + '15')
                    .alignContent(Alignment.Center)
                    .margin({ right: Spacing.SM })

                    Text(msg.content)
                      .fontSize(FontSize.BASE)
                      .fontColor(AppColors.FG)
                      .lineHeight(22)
                      .layoutWeight(1)
                  }
                  .width('100%')
                } else {
                  Text(msg.content)
                    .fontSize(FontSize.BASE)
                    .fontColor(AppColors.BG)
                    .lineHeight(22)
                    .padding({ left: Spacing.BASE, right: Spacing.BASE, top: 10, bottom: 10 })
                    .borderRadius(Radius.LG)
                    .backgroundColor(AppColors.ACCENT)
                }
              }
              .constraintSize({ maxWidth: '80%' })
              .alignItems(msg.role === 'user' ? HorizontalAlign.End : HorizontalAlign.Start)

              if (msg.role === 'assistant') {
                Blank().layoutWeight(1)
              }
            }
            .width('100%')
            .padding({ left: Spacing.BASE, right: Spacing.BASE, top: Spacing.SM, bottom: Spacing.SM })
          }
        }, (msg: ChatMessage, index: number) => msg.role + index)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // 快捷指令
      if (this.currentTopic.length > 0) {
        Scroll() {
          Row() {
            ForEach([
              `解释${this.currentTopic}的核心概念`,
              `${this.currentTopic}的学习建议`,
              `推荐${this.currentTopic}学习资源`,
              `${this.currentTopic}常见误区`
            ], (cmd: string) => {
              Text(cmd)
                .fontSize(FontSize.XS)
                .fontColor(AppColors.ACCENT)
                .padding({ left: 10, right: 10, top: 6, bottom: 6 })
                .borderRadius(Radius.PILL)
                .backgroundColor(AppColors.ACCENT + '10')
                .border({ width: 1, color: AppColors.ACCENT + '25' })
                .margin({ right: Spacing.SM })
                .onClick(() => { this.sendMessage(cmd) })
            }, (cmd: string) => cmd)
          }
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')
        .padding({ left: Spacing.BASE, right: Spacing.BASE, top: Spacing.SM, bottom: Spacing.SM })
      }

      Divider().color(AppColors.BORDER).height(0.5)

      // 输入区
      Row() {
        TextInput({ placeholder: '输入你的问题...', text: this.inputText })
          .layoutWeight(1)
          .height(44)
          .fontSize(FontSize.BASE)
          .fontColor(AppColors.FG)
          .placeholderColor(AppColors.FG_DIM)
          .backgroundColor(AppColors.BG_SURFACE)
          .borderRadius(Radius.MD)
          .border({ width: 1, color: AppColors.BORDER })
          .padding({ left: Spacing.BASE })
          .onChange((v: string) => { this.inputText = v })
          .onSubmit(() => { this.sendMessage(this.inputText) })

        Button('发送')
          .height(44)
          .fontSize(FontSize.BASE)
          .fontWeight(FontWeight.Bold)
          .backgroundColor(AppColors.ACCENT)
          .fontColor(AppColors.BG)
          .borderRadius(Radius.MD)
          .margin({ left: Spacing.SM })
          .enabled(!this.isLoading)
          .onClick(() => { this.sendMessage(this.inputText) })
      }
      .width('100%')
      .padding({ left: Spacing.BASE, right: Spacing.BASE, top: Spacing.SM, bottom: Spacing.SM })
      .backgroundColor(AppColors.BG_SURFACE)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.BG)
  }

  private async sendMessage(text: string) {
    const trimmed = text.trim()
    if (trimmed.length === 0 || this.isLoading) return

    this.messages.push({ role: 'user', content: trimmed })
    this.inputText = ''
    this.isLoading = true

    // 调用AI
    try {
      const apiKey = getAIApiKey()
      const httpRequest = http.createHttp()
      const systemPrompt = this.currentTopic.length > 0
        ? `你是一个专业的AI知识导师，用户正在学习「${this.currentTopic}」。请用简洁易懂的方式回答问题。`
        : '你是一个专业的AI知识导师，请用简洁易懂的方式回答问题。'

      const requestMsgs: AIMessage[] = [
        { role: 'system', content: systemPrompt },
        { role: 'user', content: trimmed }
      ]

      const requestBody = JSON.stringify({
        model: 'mimo-v2.5-pro',
        messages: requestMsgs,
        temperature: 0.7,
        max_tokens: 2000
      })

      const response: http.HttpResponse = await httpRequest.request(
        'https://token-plan-cn.xiaomimimo.com/v1/chat/completions',
        {
          method: http.RequestMethod.POST,
          header: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${apiKey}`
          },
          extraData: requestBody,
          expectDataType: http.HttpDataType.STRING,
          connectTimeout: 30000,
          readTimeout: 60000,
        }
      )

      httpRequest.destroy()

      if (response.responseCode === 200) {
        const resultStr = response.result as string
        const result = JSON.parse(resultStr) as Record<string, Object>
        const choices = result['choices'] as Object[]
        const firstChoice = choices[0] as Record<string, Object>
        const message = firstChoice['message'] as Record<string, string>
        this.messages.push({ role: 'assistant', content: message['content'] })
      } else {
        this.messages.push({ role: 'assistant', content: '抱歉，请求失败了，请稍后重试。' })
      }
    } catch (_e) {
      this.messages.push({ role: 'assistant', content: '网络错误，请检查网络连接后重试。' })
    }

    this.isLoading = false
  }
}

interface ChatMessage {
  role: string
  content: string
}
