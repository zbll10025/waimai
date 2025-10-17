import { MenuItem,menuArray } from "../../models/UserMenuItem"
import { router } from '@kit.ArkUI'
import { ID } from "../../pages/LoginPage"

@Preview
@Component
export struct UserMenu {
  @Consume navStack: NavPathStack
  @State menuItems: Array<MenuItem> = menuArray
  @StorageProp(ID) userid: string = "";
  @Link isLogin:boolean
  @Builder
  menuItemBuilder(item: MenuItem, index: number) {
    Row() {
      // 图标
      Image(item.icon)
        .width(40)
        .height(40)
        .margin({ right: 12 })

      // 文字信息
      Column({ space: 2 }) {
        Text(item.title)
          .fontSize(20)
          .fontWeight(500)
          .fontColor('#333333')
          .alignSelf(ItemAlign.Start)

        if (item.subtitle) {
          Text(item.subtitle)
            .fontSize(16)
            .fontColor('#999999')
            .alignSelf(ItemAlign.Start)
        }
      }

      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // 显示

      Image($r('app.media.chevron_right'))
        .width(25)
        .height(25)
        .fillColor('#CCCCCC')

    }
    .width('100%')
    .height(100)
    .padding({ left: 16, right: 16 })
    .margin({ top: 5})
    .alignItems(VerticalAlign.Center)
    .backgroundColor('transparent')
    .onClick(() => {
      if(this.isLogin || item.name == "AboutPage"){
        this.navStack.replacePath({name:item.name})
      }
      else {
        router.replaceUrl({
          url: 'pages/LoginPage'
        })
      }
    })
  }

  build() {
        Column() {
          // 我的订单区域
          Column() {
            Row() {
              Text('我的订单')
                .fontSize(20)
                .fontWeight(600)
                .fontColor('#333333')


              Text('查看全部订单')
                .fontSize(16)
                .fontColor('#999999')
                .layoutWeight(1)
                .textAlign(TextAlign.End)

              Image($r('app.media.chevron_right'))
                .width(20)
                .height(20)
                .fillColor('#CCCCCC')
                .margin({ left: 8 })
            }
            .width('100%')
            .padding({
              left: 16,
              right: 16,
              top: 16,
              bottom: 12
            })
            .onClick(() => {
              AppStorage.set('tabIndex', 1)
            })
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .margin({
            top: 12,
            left: 16,
            right: 16,
            bottom: 12
          })

          // 设置卡片
          Column() {
            Text('设置')
              .fontSize(20)
              .fontWeight(600)
              .fontColor('#333333')
              .margin({ top: 10, bottom: 12 })
            ForEach(this.menuItems, (item: MenuItem, index) => {
              this.menuItemBuilder(item, index)
            })
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .padding({ bottom: 12 })
          .margin({ left: 16, right: 16, bottom: 25 })
          if(this.isLogin){
          Button('退出登录')
            .width('90%')
            .height(50)
            .fontSize(16)
            .fontWeight(500)
            .fontColor('#FF4444')
            .backgroundColor('#FFFFFF')
            .border({ width: 1, color: '#FF4444' })
            .borderRadius(25)
            //登出逻辑
            .onClick( () => {
              this.userid = "-1"
              this.isLogin = false
              AppStorage.set(ID,this.userid)
            })
          }
        }
        .margin({ bottom: 30 })
  }
}
