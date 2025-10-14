import { router } from '@kit.ArkUI'
import { promptAction } from '@kit.ArkUI'
import http from '@ohos.net.http'
export const ID = 'userid'
PersistentStorage.persistProp(ID,'-1')
@Entry
@Component
export struct LoginPage {
  @State username: string = ''
  @State password: string = ''
  @State isPasswordVisible: boolean = false
  @State isLoading: boolean = false
  @StorageProp(ID) userid: string = "123"

  private readonly baseUrl: string = 'http://124.71.28.168:8080'
  private readonly loginEndpoint: string = '/api/users/login'

  aboutToAppear() {
    // 页面加载时检查是否已经登录
    this.checkAutoLogin()
  }

  build() {
    Column() {

      // Logo and title section
      Column() {
        Image($r('app.media.address'))
          .width(80)
          .height(80)
          .margin({ bottom: 20 })

        Text('外卖助手')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .margin({ bottom: 8 })

        Text('享受便捷的外卖服务')
          .fontSize(14)
          .fontColor('#666666')
      }
      .margin({ top: 60, bottom: 60 })

      // Login form
      Column() {
        // Username/Phone input
        TextInput({ placeholder: '请输入手机号/用户名' })
          .width('100%')
          .height(50)
          .backgroundColor('#F5F5F5')
          .borderRadius(25)
          .padding({ left: 20, right: 20 })
          .fontSize(16)
          .onChange((value: string) => {
            this.username = value
          })
          .margin({ bottom: 20 })

        // Password input
        Row() {
          TextInput({
            placeholder: '请输入密码',
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
        .margin({ bottom: 30 })

        // Login button
        Button(this.isLoading ? '登录中...' : '登录')
          .width('100%')
          .height(50)
          .backgroundColor(this.canLogin() ? '#FF6B35' : '#CCCCCC')
          .borderRadius(25)
          .fontSize(18)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Medium)
          .enabled(this.canLogin() && !this.isLoading)
          .onClick(() => {
            this.handleLogin()
          })
          .margin({ bottom: 20 })

        // Forgot password and register
        Row() {
          Text('忘记密码?')
            .fontSize(14)
            .fontColor('#FF6B35')
            .onClick(() => {
              this.handleForgotPassword()
            })

          Blank()

          Text('注册账号')
            .fontSize(14)
            .fontColor('#FF6B35')
            .onClick(() => {
              this.handleRegister()
            })
        }
        .width('100%')
        .margin({ bottom: 40 })

        // Third-party login options
        Column() {
          Text('其他登录方式')
            .fontSize(14)
            .fontColor('#999999')
            .margin({ bottom: 20 })

          Row({ space: 20 }) {
            Column(){
              Button() {
                Image($r('app.media.Scan'))
                  .width(24)
                  .height(24)
              }
              .width(50)
              .height(50)
              .backgroundColor('#F5F5F5')
              .borderRadius(25)
              Text('扫码')
                .fontSize(14)
                .fontColor('#333333')
            }
            Column(){
              Button() {
                Image($r('app.media.QQ'))
                  .width(24)
                  .height(24)
              }
              .width(50)
              .height(50)
              .backgroundColor('#F5F5F5')
              .borderRadius(25)
              Text('QQ登录')
                .fontSize(14)
                .fontColor('#333333')
            }

            Column(){
              Button() {
                Image($r('app.media.Wexin'))
                  .width(24)
                  .height(24)
              }
              .width(50)
              .height(50)
              .backgroundColor('#F5F5F5')
              .borderRadius(25)
              Text('微信登录')
                .fontSize(14)
                .fontColor('#333333')
            }
        }
      }
    }
      .width('85%')
      .padding({ left: 20, right: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .justifyContent(FlexAlign.Start)
  }

  private canLogin(): boolean {
    return this.username.trim().length > 0 && this.password.trim().length > 0
  }

  private async handleLogin() {
    if (!this.canLogin()) {
      promptAction.showToast({ message: '请填写完整信息' })
      return
    }

    this.isLoading = true

    try {
      const httpRequest = http.createHttp()
      
      // 构建请求URL，使用Query参数
      const loginUrl = `${this.baseUrl}${this.loginEndpoint}?name=${encodeURIComponent(this.username)}&password=${encodeURIComponent(this.password)}`
      
      const response = await httpRequest.request(loginUrl, {
        method: http.RequestMethod.POST,
        header: {
          'Content-Type': 'application/json'
        }
      })

      console.info('Login response status:', response.responseCode)
      console.info('Login response body:', response.result)

      if (response.responseCode === 200) {
        // 登录成功

        promptAction.showToast({ message: '登录成功' })

        // 跳转到主页面
        router.replaceUrl({
          url: 'pages/MainPage'
        })
      } else {
        // 登录失败
        promptAction.showToast({ message: '用户名或密码错误' })
      }
    } catch (error) {
      console.error('Login error:', error)
      promptAction.showToast({ message: '网络错误，请检查网络连接' })
    } finally {
      this.isLoading = false
    }
  }

  private handleForgotPassword() {
    router.pushUrl({
      url: 'pages/ForgetPassword'
    })
  }

  private handleRegister() {
    router.pushUrl({
      url: 'pages/RegisterPage'
    })
  }

  private checkAutoLogin() {
    if (this.userid === '-1') {
      console.info('default')
    } else {
      // 跳转到主页
      console.info('success')
      router.replaceUrl({
        url: 'pages/MainPage'
      })
    }
  }


}

