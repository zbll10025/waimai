import { ID } from "../../pages/LoginPage";
import { AxiosUtil } from "../../utils/network/HttpUtils";
import { promptAction } from '@kit.ArkUI';


interface GeneratedObjectLiteralInterface_1 {
  name: string;
  password: string;
}

interface GeneratedObjectLiteralInterface_2 {
  id: number;
  name: string;
  password: string;
  telePhone: string;
  balance: number;
}

@Component
export struct AccountSecurityPage {
  @StorageProp(ID) userid: string = '-1'
  @State username: string = ''
  @State telePhone : string = ''
  @State password: string = ''
  @State balance: number = -1
  @State isLoading: boolean = false
  @State errorMsg: string = ''
  @State isPasswordVisible: boolean = false
  @State isEditing: boolean = false
  @State editUsername: string = ''
  @State editPassword: string = ''
  @State isEditPasswordVisible: boolean = false
  @State isSaving: boolean = false

  private getFormattedBalance(): string {
    const b = this.balance as number
    if (typeof b === 'number' && !Number.isNaN(b) && b >= 0) {
      return `¥${b.toFixed(2)}`
    }
    return '¥0.00'
  }

  aboutToAppear() {
    this.loadUserInfo();
  }

  build() {
    NavDestination() {
      Column() {
        // 标题部分
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

        // 内联编辑区域
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
                  .width('55%')
                  .height(40)
                  .backgroundColor('#F5F5F5')
                  .borderRadius(8)
                  .padding({ left: 12, right: 12 })
                  .fontSize(15)
                  .type(this.isEditPasswordVisible ? InputType.Normal : InputType.Password)
                  .onChange((v: string) => { this.editPassword = v })
                // Button() {
                //   Text(this.isEditPasswordVisible ? '🙈' : '👁️')
                //     .fontSize(18)
                // }
                //   .onClick(() => { this.isEditPasswordVisible = !this.isEditPasswordVisible })
                //   .type(ButtonType.Normal)
                //   .backgroundColor('#F5F5F5')
                //   .fontColor('#333333')
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
        Blank().height(12)

        Text('基本信息')
          .fontSize(14)
          .fontColor('#999999')
          .margin({ left: 4, bottom: 8 })

        // 用户信息显示区域
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
              Text(this.isPasswordVisible ? (this.password || '-') : '••••••••')
                .fontSize(15)
                .fontColor('#333333')
              Button() {
                Text(this.isPasswordVisible ? '🙈' : '👁️')
                  .fontSize(18)
              }
              .onClick(() => {
                this.isPasswordVisible = !this.isPasswordVisible
              })
              .type(ButtonType.Normal)
              .backgroundColor('#F5F5F5')
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

            // 预留：修改密码/绑定手机操作入口
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
      const response = await AxiosUtil.get<User>(`http://192.168.213.120:8080/api/users/${this.userid}`);
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
      const url = `http://192.168.213.120:8080/api/users/${this.userid}`;

      // 构造完整的请求体（符合接口要求）
      const payload: GeneratedObjectLiteralInterface_2 = {
        id: Number(this.userid), // 将字符串转换为数字      // 路径参数中的id（转为number）
        name: this.editUsername,  // 去除空格，避免无效输入
        password: this.editPassword, // 去除空格
        telePhone: this.telePhone,       // 保留当前手机号
        balance: this.balance            // 保留当前余额
      };

      // 校验必填字段（可选，提升用户体验）
      if (!payload.name || !payload.password) {
        promptAction.showToast({ message: '用户名或密码不能为空' });
        this.isSaving = false;
        return;
      }

      const response = await AxiosUtil.put<User>(url, payload);
      if (response.status === 200) {
        // 更新本地状态（仅修改的字段）
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