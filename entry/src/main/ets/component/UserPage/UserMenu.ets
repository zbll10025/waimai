import { MenuItem,menuArray } from "../../models/UserMenuItem"
import  ConnectionUtils from "../../utils/network/ConnectionUtils"
import { AnimatedDrawableDescriptor, promptAction } from '@kit.ArkUI';
import { AxiosUtil } from "../../utils/network/HttpUtils.ets"
@Preview
@Component
export struct UserMenu {
  @Consume navStack: NavPathStack
  @State menuItems: Array<MenuItem> = menuArray

  @State inf: dizhi[] = [] //Inf接口自己定义
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
      if (item.showArrow) {
        Image($r('app.media.chevron_right'))
          .width(25)
          .height(25)
          .fillColor('#CCCCCC')

      }
    }
    .width('100%')
    .height(100)
    .padding({ left: 16, right: 16 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor('transparent')
    .onClick(() => {
      this.navStack.replacePath({name:item.name})
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
          .margin({ left: 16, right: 16, bottom: 12 })

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
            .onClick(async () => {
              // let httpUtil: HttpUtils = new HttpUtils();
              // await httpUtil.getHttpRequest<dizhi[]>("/api/addresses").then((value: dizhi[]) => {
              //   promptAction.showToast({
              //     message: value[2].aid?.toString()
              //   });
              // });
              //
              try {
                let res = await AxiosUtil.get<dizhi[]>("http://192.168.0.182:8080/api/addresses")
                promptAction.showToast({
                      message: res.data[1].address
                    });
                console.log(res.data[1]);
              } catch (e) {
                console.log(e, "失败")

              }
              // const res = await AxiosUtil.get<dizhi>("/addresses")
              // promptAction.showToast({
              //   message: res.data.data as string
              // })
            })
        }
        .margin({ bottom: 30 })
  }
}
class dizhi{
  aid?:number
  address?:string
  uid?:number
}
class User{
  id?:number
  name?:string
  password?:string
  telePhone?:string
  balance?:number
}