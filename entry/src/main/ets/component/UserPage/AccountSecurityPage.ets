import { ID } from "../../pages/LoginPage";
import { AxiosUtil } from "../../utils/network/HttpUtils";
import { promptAction } from '@kit.ArkUI';
import { Ip } from "../../utils/http";

@Component
export struct AccountSecurityPage {
  @StorageProp(ID) userid: string = '-1'
  @State username: string = ''
  @State telePhone : string = ''
  @State password: string = ''
  @State balance: number = -1
  @State isLoading: boolean = false
  @State errorMsg: string = ''
  @State isEditing: boolean = false
  @State editUsername: string = ''
  @State editPassword: string = ''
  @State isEditPasswordVisible: boolean = false
  @State isSaving: boolean = false

  private getFormattedBalance(): string {
    if (!Number.isNaN(this.balance) && this.balance >= 0) {
      return `¥${this.balance.toFixed(2)}`
    }
    return '¥0.00'
  }

  aboutToAppear() {
    this.loadUserInfo();
  }

  build() {
    NavDestination() {
      Column() {
        Column() {
          Text('账户与安全')
            .fontSize(22)
            .fontWeight(600)
            .fontColor('#333333')

          Text('管理密码、手机号等安全设置')
            .fontSize(16)
            .fontColor('#666666')
            .margin({ top: 6 })
        }
        .width('100%')
        .padding({
          left: 16,
          right: 16,
          top: 16,
          bottom: 16
        })
        .backgroundColor('#FFFFFF')
        .borderRadius(12)

        Blank().height(12)

        Text('基本信息')
          .fontSize(14)
          .fontColor('#999999')
          .margin({ left: 4, bottom: 8 })

        Column() {
          if (this.isLoading) {
            Text('正在加载...')
              .fontSize(14)
              .fontColor('#999999')
              .margin({ bottom: 12 })
          }

          if (this.errorMsg) {
            Text(this.errorMsg)
              .fontSize(14)
              .fontColor('#FF3B30')
              .margin({ bottom: 12 })
          }

          Row() {
            Text('姓名')
              .fontSize(15)
              .fontColor('#666666')
            Blank()
            Text(this.username || '-')
              .fontSize(15)
              .fontColor('#333333')
          }
          .width('100%')
          .margin({ bottom: 8 })

          Divider()
            .width('100%')
            .height(1)
            .backgroundColor('#EEEEEE')
            .margin({ bottom: 8 })

          Row() {
            Text('电话')
              .fontSize(15)
              .fontColor('#666666')
            Blank()
            Text(this.telePhone || '-')
              .fontSize(15)
              .fontColor('#333333')
          }
          .width('100%')
          .margin({ bottom: 8 })

          Divider()
            .width('100%')
            .height(1)
            .backgroundColor('#EEEEEE')
            .margin({ bottom: 8 })

          Row() {
            Text('密码')
              .fontSize(15)
              .fontColor('#666666')
            Blank()
            Row({ space: 8 }) {
              Text(this.password || '-')
                .fontSize(15)
                .fontColor('#333333')
            }
          }
          .width('100%')
          .margin({ bottom: 8 })

          Divider()
            .width('100%')
            .height(1)
            .backgroundColor('#EEEEEE')
            .margin({ bottom: 8 })

          Row() {
            Text('余额')
              .fontSize(15)
              .fontColor('#666666')
            Blank()
            Text(this.getFormattedBalance())
              .fontSize(15)
              .fontColor('#333333')
          }
          .width('100%')

          Blank().height(12)

          Row({ space: 12 }) {
            Button('刷新信息')
              .onClick(() => {
                this.loadUserInfo();
              })
              .type(ButtonType.Capsule)
              .backgroundColor('#FF6B35')
              .fontColor('#FFFFFF')

            Button('修改个人信息')
              .onClick(() => {
                this.isEditing = true
                this.editUsername = this.username
                this.editPassword = this.password
                this.isEditPasswordVisible = false
              })
              .type(ButtonType.Normal)
              .backgroundColor('#F5F5F5')
              .fontColor('#333333')
          }
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 16, bottom: 16 })
        .backgroundColor('#FFFFFF')
        .borderRadius(12)

        if (this.isEditing) {
          Blank().height(12)

          Text('编辑信息')
            .fontSize(14)
            .fontColor('#999999')
            .margin({ left: 4, bottom: 8 })

          Column() {
            Row() {
              Text('用户名')
                .fontSize(15)
                .fontColor('#666666')
              Blank()
              TextInput({ placeholder: '请输入新的用户名', text: this.editUsername })
                .width('65%')
                .height(40)
                .backgroundColor('#F5F5F5')
                .borderRadius(8)
                .padding({ left: 12, right: 12 })
                .fontSize(15)
                .onChange((v: string) => { this.editUsername = v })
            }
            .width('100%')
            .margin({ bottom: 8 })

            Divider()
              .width('100%')
              .height(1)
              .backgroundColor('#EEEEEE')
              .margin({ bottom: 8 })

            Row() {
              Text('密码')
                .fontSize(15)
                .fontColor('#666666')
              Blank()
              Row({ space: 8 }) {
                TextInput({ placeholder: '请输入新的密码', text: this.editPassword })
                  .width('65%')
                  .height(40)
                  .backgroundColor('#F5F5F5')
                  .borderRadius(8)
                  .padding({ left: 12, right: 12 })
                  .fontSize(15)
                  .type(InputType.Password)
                  .onChange((value: string) => { this.editPassword = value })
              }
            }
            .width('100%')
            .margin({ bottom: 12 })

            Row({ space: 12 }) {
              Button('取消')
                .onClick(() => { this.isEditing = false })
                .type(ButtonType.Normal)
                .backgroundColor('#F5F5F5')
                .fontColor('#333333')

              Button(this.isSaving ? '保存中...' : '保存')
                .enabled(!this.isSaving && this.editUsername.trim().length > 0 && this.editPassword.trim().length > 0)
                .onClick(async () => { await this.saveUserInfo() })
                .type(ButtonType.Capsule)
                .backgroundColor('#FF6B35')
                .fontColor('#FFFFFF')
            }
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 16, bottom: 16 })
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
        }
      }

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
  // 加载用户信息
  private async loadUserInfo() {
    try {
      this.isLoading = true;
      this.errorMsg = '';
      const response = await AxiosUtil.get<User>(Ip+`/api/users/${this.userid}`);
      console.log("114514"+response.status)
      if (response.status === 200) {
        console.log('用户信息加载成功:', response.data);
        this.username = response.data.name
        this.telePhone = response.data.telePhone
        this.password = response.data.password as string
        this.balance = response.data.balance as number

      } else {
        this.errorMsg = '获取用户信息失败';
        promptAction.showToast({ message: '获取用户信息失败' });
      }
    } catch (error) {
      console.error('用户信息加载失败:', error);
      this.errorMsg = '加载用户信息失败';
      promptAction.showToast({ message: '加载用户信息失败' });
    }
    finally {
      this.isLoading = false;
    }
  }

  private async saveUserInfo() {
    try {
      this.isSaving = true;
      const url = Ip+`/api/users/${this.userid}`;

      const payload: User = {
        id: Number(this.userid),
        name: this.editUsername,
        password: this.editPassword,
        telePhone: this.telePhone,
        balance: this.balance
      };

      if (!payload.name || !payload.password) {
        promptAction.showToast({ message: '用户名或密码不能为空' });
        this.isSaving = false;
        return;
      }

      const response = await AxiosUtil.put<User>(url, payload);
      if (response.status === 200) {
        this.username = payload.name;
        this.password = payload.password;
        promptAction.showToast({ message: '修改成功' });
        this.isEditing = false;
      } else {
        promptAction.showToast({ message: '修改失败，请重试' });
      }
    } catch (e) {
      console.error('更新用户信息失败:', e);
      promptAction.showToast({ message: '网络错误，修改失败' });
    } finally {
      this.isSaving = false;
    }
  }

}

class User {
  id?:number
  name: string = ''
  password: string = ''
  telePhone: string = ''
  balance?:number
}