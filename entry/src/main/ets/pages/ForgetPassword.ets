import { router } from '@kit.ArkUI'
import { promptAction } from '@kit.ArkUI'

@Preview
@Component
export struct ForgetPassword {
  @State phone: string = ''
  @State verificationCode: string = ''
  @State newPassword: string = ''
  @State confirmPassword: string = ''
  @State isPasswordVisible: boolean = false
  @State isConfirmPasswordVisible: boolean = false
  @State isLoading: boolean = false
  @State isCodeSent: boolean = false
  @State countdown: number = 0

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

        Text('忘记密码')
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

        Text('重置密码')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .margin({ bottom: 8 })

        Text('请输入手机号获取验证码')
          .fontSize(14)
          .fontColor('#666666')
      }
      .margin({ bottom: 40 })

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

        // Verification code input
        Row() {
          TextInput({ placeholder: '请输入旧密码' })
            .layoutWeight(1)
            .height(50)
            .backgroundColor('#F5F5F5')
            .borderRadius(25)
            .padding({ left: 20, right: 20 })
            .fontSize(16)
            .onChange((value: string) => {
              this.verificationCode = value
            })
        }
        .width('100%')
        .margin({ bottom: 20 })

        // New password input
        Row() {
          TextInput({
            placeholder: '请输入新密码',
          })
            .layoutWeight(1)
            .height(50)
            .backgroundColor('#F5F5F5')
            .borderRadius(25)
            .padding({ left: 20, right: 20 })
            .fontSize(16)
            .onChange((value: string) => {
              this.newPassword = value
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
            placeholder: '请确认新密码',
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
        .margin({ bottom: 30 })

        // Reset password button
        Button(this.isLoading ? '重置中...' : '重置密码')
          .width('100%')
          .height(50)
          .backgroundColor(this.canReset() ? '#FF6B35' : '#CCCCCC')
          .borderRadius(25)
          .fontSize(18)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Medium)
          .enabled(this.canReset() && !this.isLoading)
          .onClick(() => {
            this.handleResetPassword()
          })
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

  private canReset(): boolean {
    return this.phone.trim().length > 0 &&
           this.verificationCode.trim().length > 0 &&
           this.newPassword.trim().length >= 6 &&
           this.confirmPassword.trim().length >= 6 &&
           this.newPassword === this.confirmPassword
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

  private handleResetPassword() {
    if (!this.canReset()) {
      promptAction.showToast({ message: '请填写完整信息' })
      return
    }

    if (this.newPassword !== this.confirmPassword) {
      promptAction.showToast({ message: '两次密码输入不一致' })
      return
    }

    this.isLoading = true

    // Simulate reset password API call
    setTimeout(() => {
      this.isLoading = false
      promptAction.showToast({ message: '密码重置成功' })
      
      // Navigate back to login page
      router.replaceUrl({
        url: 'pages/LoginPage'
      })
    }, 1500)
  }
}