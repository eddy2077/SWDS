import { router } from '@kit.ArkUI'
import { AppColors, FontSize, Radius, Spacing } from '../common/Constants'
import { getAIApiKey, setAIApiKey } from '../common/AIHelper'

@Entry
@Component
struct LoginPage {
  @State username: string = ''
  @State password: string = ''
  @State isLoading: boolean = false
  @State errorMsg: string = ''
  @State showApiSettings: boolean = false
  @State apiKeyInput: string = ''
  @State animProgress: number = 0

  aboutToAppear() {
    this.apiKeyInput = getAIApiKey()
    // 简单入场动画
    setTimeout(() => { this.animProgress = 1 }, 100)
  }

  build() {
    Column() {
      Blank().layoutWeight(1)

      // Logo区域
      Column() {
        // 金色圆形Logo
        Stack() {
          Circle()
            .width(80)
            .height(80)
            .fill(AppColors.ACCENT + '15')
          Circle()
            .width(56)
            .height(56)
            .fill(AppColors.ACCENT + '25')
          Text('知')
            .fontSize(28)
            .fontColor(AppColors.ACCENT)
            .fontWeight(FontWeight.Bold)
        }
        .width(80)
        .height(80)
        .margin({ bottom: Spacing.LG })

        Text('AI知识图谱导师')
          .fontSize(FontSize.XXL)
          .fontColor(AppColors.FG)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)

        Text('智能学习 · 知识图谱 · AI驱动')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.FG_DIM)
          .margin({ top: Spacing.SM })
          .letterSpacing(1)
      }
      .margin({ bottom: 48 })

      // 输入区域
      Column() {
        // 用户名
        Column() {
          Text('账号')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.FG_DIM)
            .margin({ bottom: 6 })
          TextInput({ placeholder: '请输入账号', text: this.username })
            .height(44)
            .fontSize(FontSize.BASE)
            .fontColor(AppColors.FG)
            .placeholderColor(AppColors.FG_DIM)
            .backgroundColor(AppColors.BG_SURFACE)
            .borderRadius(Radius.MD)
            .border({ width: 1, color: AppColors.BORDER })
            .padding({ left: Spacing.BASE, right: Spacing.BASE })
            .onChange((v: string) => { this.username = v })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .margin({ bottom: Spacing.BASE })

        // 密码
        Column() {
          Text('密码')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.FG_DIM)
            .margin({ bottom: 6 })
          TextInput({ placeholder: '请输入密码', text: this.password })
            .type(InputType.Password)
            .height(44)
            .fontSize(FontSize.BASE)
            .fontColor(AppColors.FG)
            .placeholderColor(AppColors.FG_DIM)
            .backgroundColor(AppColors.BG_SURFACE)
            .borderRadius(Radius.MD)
            .border({ width: 1, color: AppColors.BORDER })
            .padding({ left: Spacing.BASE, right: Spacing.BASE })
            .onChange((v: string) => { this.password = v })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .margin({ bottom: Spacing.LG })

        // 错误提示
        if (this.errorMsg.length > 0) {
          Text(this.errorMsg)
            .fontSize(FontSize.XS)
            .fontColor(AppColors.RED)
            .margin({ bottom: Spacing.SM })
        }

        // 登录按钮
        Button('登 录')
          .width('100%')
          .height(48)
          .fontSize(FontSize.LG)
          .fontWeight(FontWeight.Bold)
          .backgroundColor(AppColors.ACCENT)
          .fontColor(AppColors.BG)
          .borderRadius(Radius.MD)
          .margin({ bottom: Spacing.BASE })
          .onClick(() => { this.handleLogin() })

        // 游客模式
        Text('游客模式进入')
          .fontSize(FontSize.SM)
          .fontColor(AppColors.ACCENT)
          .textAlign(TextAlign.Center)
          .padding({ top: Spacing.SM, bottom: Spacing.SM })
          .onClick(() => { this.guestLogin() })
      }
      .width('85%')
      .padding({ left: Spacing.XL, right: Spacing.XL, top: Spacing.XL, bottom: Spacing.XL })
      .borderRadius(Radius.XL)
      .backgroundColor(AppColors.BG_SURFACE)
      .border({ width: 1, color: AppColors.BORDER })

      // AI设置
      Column() {
        Row() {
          Text('AI 模型设置')
            .fontSize(FontSize.SM)
            .fontColor(AppColors.FG_SECONDARY)
            .layoutWeight(1)
          Text(this.showApiSettings ? '收起 ▲' : '展开 ▼')
            .fontSize(FontSize.XS)
            .fontColor(AppColors.ACCENT)
        }
        .width('85%')
        .padding({ top: Spacing.LG, bottom: Spacing.SM })
        .onClick(() => { this.showApiSettings = !this.showApiSettings })

        if (this.showApiSettings) {
          Column() {
            TextInput({ text: this.apiKeyInput, placeholder: '输入 API Key' })
              .type(InputType.Password)
              .height(40)
              .fontSize(FontSize.SM)
              .fontColor(AppColors.FG)
              .placeholderColor(AppColors.FG_DIM)
              .backgroundColor(AppColors.BG_SURFACE)
              .borderRadius(Radius.MD)
              .border({ width: 1, color: AppColors.BORDER })
              .padding({ left: Spacing.BASE })
              .onChange((v: string) => { this.apiKeyInput = v })

            Button('保存')
              .height(36)
              .fontSize(FontSize.SM)
              .backgroundColor(AppColors.ACCENT)
              .fontColor(AppColors.BG)
              .borderRadius(Radius.MD)
              .width('100%')
              .margin({ top: Spacing.SM })
              .onClick(() => {
                setAIApiKey(this.apiKeyInput)
                this.errorMsg = ''
              })
          }
          .width('85%')
        }
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)

      Blank().layoutWeight(1)

      Text('© 2025 AI知识图谱导师')
        .fontSize(FontSize.XS)
        .fontColor(AppColors.FG_DIM)
        .margin({ bottom: Spacing.XL })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.BG)
    .alignItems(HorizontalAlign.Center)
  }

  private handleLogin() {
    if (this.username.trim().length === 0) {
      this.errorMsg = '请输入账号'
      return
    }
    if (this.password.trim().length === 0) {
      this.errorMsg = '请输入密码'
      return
    }
    this.isLoading = true
    this.errorMsg = ''
    // 模拟登录
    setTimeout(() => {
      this.isLoading = false
      AppStorage.setOrCreate<string>('user_name', this.username)
      try {
        router.replaceUrl({ url: 'pages/Index' })
      } catch (_e) {
      }
    }, 800)
  }

  private guestLogin() {
    AppStorage.setOrCreate<string>('user_name', '游客')
    try {
      router.replaceUrl({ url: 'pages/Index' })
    } catch (_e) {
    }
  }
}
