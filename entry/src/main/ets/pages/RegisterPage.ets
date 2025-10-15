import { router } from '@kit.ArkUI'
import { promptAction } from '@kit.ArkUI'

@Preview
@Component
export struct RegisterPage {
  @State phone: string = ''
  @State verificationCode: string = ''
  @State password: string = ''
  @State confirmPassword: string = ''
  @State isPasswordVisible: boolean = false
  @State isConfirmPasswordVisible: boolean = false
  @State isLoading: boolean = false
  @State isCodeSent: boolean = false
  @State countdown: number = 0
  @State agreeTerms: boolean = false

  build() {
    Column() {
      // Header with back button and title
      Row() {
        Button() {
          Image($r('app.media.chevron_up'))
            .width(20)
            .height(20)
            .rotate({ angle: -90 })
        }
        .width(40)
        .height(40)
        .backgroundColor('transparent')
        .onClick(() => {
          router.back()
        })

        Text('注册账号')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .margin({ left: 15 })

        Blank()
      }
      .width('100%')
      .margin({ top: 20, bottom: 30 })

      // Logo and subtitle
      Column() {
        Image($r('app.media.address'))
          .width(60)
          .height(60)
          .margin({ bottom: 15 })

        Text('创建新账号')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .margin({ bottom: 8 })
      }
      .margin({ bottom: 30 })

      // Form
      Column() {
        // Phone input
        TextInput({ placeholder: '请输入手机号' })
          .width('100%')
          .height(50)
          .backgroundColor('#F5F5F5')
          .borderRadius(25)
          .padding({ left: 20, right: 20 })
          .fontSize(16)
          .onChange((value: string) => {
            this.phone = value
          })
          .margin({ bottom: 20 })

        // Password input
        Row() {
          TextInput({
            placeholder: '请输入密码（至少6位）',
          })
            .layoutWeight(1)
            .height(50)
            .backgroundColor('#F5F5F5')
            .borderRadius(25)
            .padding({ left: 20, right: 20 })
            .fontSize(16)
            .onChange((value: string) => {
              this.password = value
            })

          Image($r('app.media.chevron_up'))
            .width(20)
            .height(20)
            .margin({ right: 15 })
            .onClick(() => {
              this.isPasswordVisible = !this.isPasswordVisible
            })
        }
        .width('100%')
        .backgroundColor('#F5F5F5')
        .borderRadius(25)
        .margin({ bottom: 20 })

        // Confirm password input
        Row() {
          TextInput({
            placeholder: '请确认密码',
          })
            .layoutWeight(1)
            .height(50)
            .backgroundColor('#F5F5F5')
            .borderRadius(25)
            .padding({ left: 20, right: 20 })
            .fontSize(16)
            .onChange((value: string) => {
              this.confirmPassword = value
            })

          Image($r('app.media.chevron_up'))
            .width(20)
            .height(20)
            .margin({ right: 15 })
            .onClick(() => {
              this.isConfirmPasswordVisible = !this.isConfirmPasswordVisible
            })
        }
        .width('100%')
        .backgroundColor('#F5F5F5')
        .borderRadius(25)
        .margin({ bottom: 20 })

        // Terms agreement
        Row() {
          Button() {
            Image(this.agreeTerms ? $r('app.media.startIcon') : $r('app.media.chevron_up'))
              .width(16)
              .height(16)
              .fillColor(this.agreeTerms ? '#FF6B35' : '#CCCCCC')
          }
          .width(20)
          .height(20)
          .backgroundColor('transparent')
          .borderRadius(10)
          .onClick(() => {
            this.agreeTerms = !this.agreeTerms
          })

          Text('我已阅读并同意')
            .fontSize(14)
            .fontColor('#666666')
            .margin({ left: 8 })

          Text('《用户协议》')
            .fontSize(14)
            .fontColor('#FF6B35')
            .onClick(() => {
              promptAction.showToast({ message: '用户协议功能开发中' })
            })

          Text('和')
            .fontSize(14)
            .fontColor('#666666')

          Text('《隐私政策》')
            .fontSize(14)
            .fontColor('#FF6B35')
            .onClick(() => {
              promptAction.showToast({ message: '隐私政策功能开发中' })
            })
        }
        .width('100%')
        .margin({ bottom: 30 })

        // Register button
        Button(this.isLoading ? '注册中...' : '注册')
          .width('100%')
          .height(50)
          .backgroundColor(this.canRegister() ? '#FF6B35' : '#CCCCCC')
          .borderRadius(25)
          .fontSize(18)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Medium)
          .enabled(this.canRegister() && !this.isLoading)
          .onClick(() => {
            this.handleRegister()
          })
          .margin({ bottom: 20 })

        // Login link
        Row() {
          Text('已有账号？')
            .fontSize(14)
            .fontColor('#666666')

          Text('立即登录')
            .fontSize(14)
            .fontColor('#FF6B35')
            .onClick(() => {
              router.back()
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding({ left: 20, right: 20 })
    .backgroundColor('#FFFFFF')
    .justifyContent(FlexAlign.Start)
  }

  private canSendCode(): boolean {
    return this.phone.trim().length === 11 && /^1[3-9]\d{9}$/.test(this.phone)
  }

  private canRegister(): boolean {
    return this.phone.trim().length > 0 &&
           this.verificationCode.trim().length > 0 &&
           this.password.trim().length >= 6 &&
           this.confirmPassword.trim().length >= 6 &&
           this.password === this.confirmPassword &&
           this.agreeTerms
  }

  private sendVerificationCode() {
    if (!this.canSendCode()) {
      promptAction.showToast({ message: '请输入正确的手机号' })
      return
    }

    this.countdown = 60
    this.isCodeSent = true

    const timer = setInterval(() => {
      this.countdown--
      if (this.countdown <= 0) {
        clearInterval(timer)
      }
    }, 1000)

    promptAction.showToast({ message: '验证码已发送' })
  }

  private handleRegister() {
    if (!this.canRegister()) {
      if (!this.agreeTerms) {
        promptAction.showToast({ message: '请同意用户协议和隐私政策' })
      } else {
        promptAction.showToast({ message: '请填写完整信息' })
      }
      return
    }

    if (this.password !== this.confirmPassword) {
      promptAction.showToast({ message: '两次密码输入不一致' })
      return
    }

    this.isLoading = true

    // Simulate register API call
    setTimeout(() => {
      this.isLoading = false
      promptAction.showToast({ message: '注册成功' })
      
      // Navigate back to login page
      router.replaceUrl({
        url: 'pages/LoginPage'
      })
    }, 1500)
  }
}