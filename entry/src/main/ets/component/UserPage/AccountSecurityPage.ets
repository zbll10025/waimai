import { ID } from "../../pages/LoginPage";

@Component
export struct AccountSecurityPage {
  @StorageProp(ID) userid: string = '';

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

        Blank().height(20)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')
    }
  }
}


