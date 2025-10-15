import { router } from '@kit.ArkUI'
import { promptAction } from '@kit.ArkUI'
import http from '@ohos.net.http'

interface GeneratedObjectLiteralInterface_1 {
  name: string;
  password: string;
  telePhone: string;
}

@Entry
@Component
export struct RegisterPage {
  @State telePhone: string = ''
  @State name: string = ''
  @State password: string = ''
  @State confirmPassword: string = ''
  @State isPasswordVisible: boolean = false
  @State isConfirmPasswordVisible: boolean = false
  @State isLoading: boolean = false
  
  private readonly baseUrl: string = 'http://192.168.0.128:8080'
  private readonly registerEndpoint: string = '/api/users'

  build() {
    Column() {
      // Logo & title
      Column() {
        Image($r('app.media.address'))
          .width(80)
          .height(80)
          .margin({ bottom: 20 })

        Text('注册账号')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .margin({ bottom: 8 })

        Text('创建你的外卖账户')
          .fontSize(14)
          .fontColor('#666666')
      }
      .margin({ top: 60, bottom: 60 })

      // Form (aligned with LoginPage style)
      Column() {
        // Phone
        TextInput({ placeholder: '请输入手机号' })
          .width('100%')
          .height(50)
          .backgroundColor('#F5F5F5')
          .borderRadius(25)
          .padding({ left: 20, right: 20 })
          .fontSize(16)
          .onChange((value: string) => {
            this.telePhone = value
          })
          .margin({ bottom: 20 })

        // Name
        TextInput({ placeholder: '请输入姓名' })
          .width('100%')
          .height(50)
          .backgroundColor('#F5F5F5')
          .borderRadius(25)
          .padding({ left: 20, right: 20 })
          .fontSize(16)
          .onChange((value: string) => {
            this.name = value
          })
          .margin({ bottom: 20 })

        // Password
        Row() {
          TextInput({ placeholder: '请输入密码（至少6位）' })
            .layoutWeight(1)
            .height(50)
            .backgroundColor('#F5F5F5')
            .borderRadius(25)
            .padding({ left: 20, right: 20 })
            .fontSize(16)
            .type(this.isPasswordVisible ? InputType.Normal : InputType.Password)
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

        // Confirm Password
        Row() {
          TextInput({ placeholder: '请确认密码' })
            .layoutWeight(1)
            .height(50)
            .backgroundColor('#F5F5F5')
            .borderRadius(25)
            .padding({ left: 20, right: 20 })
            .fontSize(16)
            .type(this.isConfirmPasswordVisible ? InputType.Normal : InputType.Password)
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

        // Back to login
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
      .width('85%')
      .padding({ left: 20, right: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .justifyContent(FlexAlign.Start)
  }

  private canRegister(): boolean {
    return this.telePhone.trim().length > 0 &&
           this.name.trim().length > 0 &&
           this.password.trim().length >= 6 &&
           this.confirmPassword.trim().length >= 6 &&
           this.password === this.confirmPassword
  }

  private async handleRegister() {
    if (!this.canRegister()) {
      if (this.password !== this.confirmPassword) {
        promptAction.showToast({ message: '两次密码输入不一致' })
      } else {
        promptAction.showToast({ message: '请填写完整信息' })
      }
      return
    }

    this.isLoading = true

    let httpRequest: http.HttpRequest | undefined
    try {
      httpRequest = http.createHttp()

      // 使用 JSON 请求体提交注册信息
      const registerUrl = `${this.baseUrl}${this.registerEndpoint}`
      const payload: GeneratedObjectLiteralInterface_1 = {
        name: this.name,
        password: this.password,
        telePhone: this.telePhone
      }

      const response = await httpRequest.request(registerUrl, {
        method: http.RequestMethod.POST,
        header: {
          'Content-Type': 'application/json'
        },
        extraData: JSON.stringify(payload)
      })

      console.info('Register response status:', response.responseCode)
      console.info('Register response body:', response.result)

      if (response.responseCode === 200) {
        promptAction.showToast({ message: '注册成功' })
        router.replaceUrl({
          url: 'pages/LoginPage'
        })
      } else {
        promptAction.showToast({ message: '注册失败，请检查信息后重试' })
      }
    } catch (error) {
      console.error('Register error:', error)
      promptAction.showToast({ message: '网络错误，请检查网络连接' })
    } finally {
      this.isLoading = false
      try {
        httpRequest?.destroy()
      } catch {}
    }
  }
}