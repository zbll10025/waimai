import { router } from '@kit.ArkUI'
import { promptAction } from '@kit.ArkUI'
import http from '@ohos.net.http'
import { Ip } from '../utils/http';

interface User {
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
  @State isLoading: boolean = false

  build() {
    Column() {
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

      Column() {
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
            .type(InputType.Password)
            .onChange((value: string) => {
              this.password = value
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
            .type(InputType.Password)
            .onChange((value: string) => {
              this.confirmPassword = value
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
    return /^\d{11}$/.test(this.telePhone.trim()) &&
           this.name.trim().length > 0 &&
           this.password.trim().length >= 6 &&
           this.confirmPassword.trim().length >= 6 &&
           this.password === this.confirmPassword
  }

  private async handleRegister() {
    // 手机号需为11位纯数字
    if (!/^\d{11}$/.test(this.telePhone.trim())) {
      promptAction.showToast({ message: '请输入正确的手机号' })
      return
    }
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

      const registerUrl = Ip
      const user: User = {
        name: this.name,
        password: this.password,
        telePhone: this.telePhone
      }


      const response = await httpRequest.request(registerUrl+'/api/users', {
        method: http.RequestMethod.POST,
        header: {
          'Content-Type': 'application/json'
        },
        extraData: JSON.stringify(user)
      })

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