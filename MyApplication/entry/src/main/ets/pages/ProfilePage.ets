import { router } from '@kit.ArkUI'
import { AppColors, FontSize, Radius, Spacing } from '../common/Constants'
import { loadHistory, removeHistory } from '../common/LocalStorage'
import { HistoryItem } from '../common/DataModels'
import { getAIApiKey, setAIApiKey, getAIModel, setAIModel } from '../common/AIHelper'

@Entry
@Component
struct ProfilePage {
  @State userName: string = '学习者'
  @State historyList: HistoryItem[] = []
  @State showApiSettings: boolean = false
  @State apiKeyInput: string = ''
  @State modelSelect: number = 0
  @State toastMsg: string = ''
  @State showToast: boolean = false

  aboutToAppear() {
    try {
      const name = AppStorage.get<string>('user_name')
      if (name && name.length > 0) {
        this.userName = name
      }
    } catch (_e) {
    }
    this.historyList = loadHistory()
    this.apiKeyInput = getAIApiKey()
    this.modelSelect = getAIModel() === 'mimo-v2.5-pro' ? 0 : 1
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

        Text('个人中心')
          .fontSize(FontSize.LG)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
      }
      .width('100%')
      .height(56)
      .padding({ left: Spacing.MD, right: Spacing.BASE })
      .backgroundColor(AppColors.BG_SURFACE)

      Divider().color(AppColors.BORDER).height(0.5)

      Scroll() {
        Column() {
          // 用户信息卡片
          Column() {
            Stack() {
              Text(this.userName.charAt(0).toUpperCase())
                .fontSize(28)
                .fontColor(AppColors.ACCENT)
                .fontWeight(FontWeight.Bold)
            }
            .width(72)
            .height(72)
            .borderRadius(36)
            .backgroundColor(AppColors.ACCENT + '15')
            .border({ width: 2, color: AppColors.ACCENT + '30' })
            .margin({ bottom: Spacing.MD })

            Text(this.userName)
              .fontSize(FontSize.XXL)
              .fontColor(AppColors.FG)
              .fontWeight(FontWeight.Bold)

            Text('免费版')
              .fontSize(FontSize.XS)
              .fontColor(AppColors.FG_DIM)
              .padding({ left: 10, right: 10, top: 3, bottom: 3 })
              .borderRadius(Radius.PILL)
              .backgroundColor(AppColors.BG_HOVER)
              .margin({ top: Spacing.SM })
          }
          .margin({ top: Spacing.XXL, bottom: Spacing.XL })

          // 统计卡片
          Row() {
            this.StatItem(this.historyList.length.toString(), '已学主题')
            this.StatItem('0', '完成节点')
            this.StatItem('0', '测验通过')
          }
          .width('92%')
          .justifyContent(FlexAlign.SpaceAround)
          .padding(Spacing.XL)
          .borderRadius(Radius.LG)
          .backgroundColor(AppColors.BG_SURFACE)
          .border({ width: 1, color: AppColors.BORDER })
          .margin({ bottom: Spacing.XL })

          // 学习历史
          Column() {
            Text('学习历史')
              .fontSize(FontSize.BASE)
              .fontColor(AppColors.FG)
              .fontWeight(FontWeight.Medium)
              .margin({ bottom: Spacing.MD })

            if (this.historyList.length === 0) {
              Text('暂无学习记录')
                .fontSize(FontSize.SM)
                .fontColor(AppColors.FG_DIM)
                .padding(Spacing.XL)
            } else {
              ForEach(this.historyList, (item: HistoryItem) => {
                Row() {
                  Circle()
                    .width(8)
                    .height(8)
                    .fill(AppColors.ACCENT)
                    .margin({ right: Spacing.MD })

                  Text(item.topic)
                    .fontSize(FontSize.BASE)
                    .fontColor(AppColors.FG)
                    .layoutWeight(1)
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })

                  Text('✕')
                    .fontSize(FontSize.SM)
                    .fontColor(AppColors.FG_DIM)
                    .padding({ left: 8, right: 4, top: 4, bottom: 4 })
                    .onClick(() => {
                      removeHistory(item.topic)
                      this.historyList = loadHistory()
                    })
                }
                .width('100%')
                .padding({ left: Spacing.MD, right: Spacing.MD, top: 10, bottom: 10 })
                .borderRadius(Radius.MD)
                .backgroundColor(AppColors.BG_HOVER)
                .margin({ bottom: Spacing.XS })
              }, (item: HistoryItem) => item.topic + item.timestamp)
            }
          }
          .width('92%')
          .padding(Spacing.LG)
          .borderRadius(Radius.LG)
          .backgroundColor(AppColors.BG_SURFACE)
          .border({ width: 1, color: AppColors.BORDER })
          .margin({ bottom: Spacing.XL })

          // AI设置
          Column() {
            Row() {
              Column() {
                Text('AI 模型设置')
                  .fontSize(FontSize.BASE)
                  .fontColor(AppColors.FG)
                  .fontWeight(FontWeight.Medium)
                Text(this.apiKeyInput.length > 0 ? '已连接' : '未连接')
                  .fontSize(FontSize.XS)
                  .fontColor(this.apiKeyInput.length > 0 ? AppColors.ACCENT : AppColors.RED)
                  .margin({ top: 2 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Text(this.showApiSettings ? '收起 ▲' : '展开 ▼')
                .fontSize(FontSize.XS)
                .fontColor(AppColors.ACCENT)
            }
            .width('100%')
            .onClick(() => { this.showApiSettings = !this.showApiSettings })

            if (this.showApiSettings) {
              Column() {
                Text('API Key')
                  .fontSize(FontSize.XS)
                  .fontColor(AppColors.FG_DIM)
                  .margin({ bottom: Spacing.SM })
                TextInput({ text: this.apiKeyInput, placeholder: 'sk-xxxxx API Key' })
                  .type(InputType.Password)
                  .height(40)
                  .fontSize(FontSize.SM)
                  .fontColor(AppColors.FG)
                  .placeholderColor(AppColors.FG_DIM)
                  .backgroundColor(AppColors.BG_HOVER)
                  .borderRadius(Radius.MD)
                  .border({ width: 1, color: AppColors.BORDER })
                  .padding({ left: Spacing.BASE })
                  .onChange((v: string) => { this.apiKeyInput = v })

                Text('模型')
                  .fontSize(FontSize.XS)
                  .fontColor(AppColors.FG_DIM)
                  .margin({ top: Spacing.MD, bottom: Spacing.SM })
                Row() {
                  Text('MiMo V2.5 Pro')
                    .fontSize(FontSize.XS)
                    .fontColor(this.modelSelect === 0 ? this.getAccentColor() : AppColors.FG_DIM)
                    .padding({ left: 10, right: 10, top: 5, bottom: 5 })
                    .borderRadius(Radius.SM)
                    .backgroundColor(this.modelSelect === 0 ? AppColors.ACCENT_DIM + '20' : AppColors.BG_HOVER)
                    .border({ width: 1, color: this.modelSelect === 0 ? this.getAccentColor() + '40' : AppColors.BORDER })
                    .margin({ right: Spacing.SM })
                    .onClick(() => { this.modelSelect = 0; setAIModel('mimo-v2.5-pro') })
                  Text('MiMo V2.5 Lite')
                    .fontSize(FontSize.XS)
                    .fontColor(this.modelSelect === 1 ? this.getAccentColor() : AppColors.FG_DIM)
                    .padding({ left: 10, right: 10, top: 5, bottom: 5 })
                    .borderRadius(Radius.SM)
                    .backgroundColor(this.modelSelect === 1 ? AppColors.ACCENT_DIM + '20' : AppColors.BG_HOVER)
                    .border({ width: 1, color: this.modelSelect === 1 ? this.getAccentColor() + '40' : AppColors.BORDER })
                    .onClick(() => { this.modelSelect = 1; setAIModel('mimo-v2.5-lite') })
                }

                Button('保存设置')
                  .height(40)
                  .fontSize(FontSize.SM)
                  .backgroundColor(AppColors.ACCENT)
                  .fontColor(AppColors.BG)
                  .borderRadius(Radius.MD)
                  .width('100%')
                  .margin({ top: Spacing.MD })
                  .onClick(() => {
                    setAIApiKey(this.apiKeyInput)
                    this.toast('设置已保存')
                  })
              }
              .margin({ top: Spacing.MD })
            }
          }
          .width('92%')
          .padding(Spacing.LG)
          .borderRadius(Radius.LG)
          .backgroundColor(AppColors.BG_SURFACE)
          .border({ width: 1, color: AppColors.BORDER })
          .margin({ bottom: Spacing.XL })

          // 关于
          Column() {
            Row() {
              Text('关于应用')
                .fontSize(FontSize.BASE)
                .fontColor(AppColors.FG)
                .layoutWeight(1)
              Text('v1.0.0')
                .fontSize(FontSize.SM)
                .fontColor(AppColors.FG_DIM)
            }
            .width('100%')

            Text('AI知识图谱导师 - 智能学习伙伴')
              .fontSize(FontSize.XS)
              .fontColor(AppColors.FG_DIM)
              .margin({ top: Spacing.SM })
          }
          .width('92%')
          .padding(Spacing.LG)
          .borderRadius(Radius.LG)
          .backgroundColor(AppColors.BG_SURFACE)
          .border({ width: 1, color: AppColors.BORDER })
          .margin({ bottom: Spacing.XL })

          // 退出登录
          Button('退出登录')
            .width('92%')
            .height(48)
            .fontSize(FontSize.BASE)
            .backgroundColor(Color.Transparent)
            .fontColor(AppColors.RED)
            .borderRadius(Radius.MD)
            .border({ width: 1, color: AppColors.RED + '30' })
            .margin({ bottom: Spacing.XXL })
            .onClick(() => {
              try {
                router.replaceUrl({ url: 'pages/LoginPage' })
              } catch (_e) {
              }
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .layoutWeight(1)

      // Toast
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
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.BG)
  }

  @Builder
  StatItem(value: string, label: string) {
    Column() {
      Text(value)
        .fontSize(FontSize.XXL)
        .fontColor(AppColors.ACCENT)
        .fontWeight(FontWeight.Bold)
      Text(label)
        .fontSize(FontSize.XS)
        .fontColor(AppColors.FG_DIM)
        .margin({ top: 2 })
    }
  }

  private getAccentColor(): string {
    return AppColors.ACCENT
  }

  private toast(msg: string) {
    this.toastMsg = msg
    this.showToast = true
    setTimeout(() => { this.showToast = false }, 2500)
  }
}
