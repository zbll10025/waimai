@Preview
@Component
export struct UserHeader {
  @State userName: string = '用户昵称'
  @State userAvatar: Resource = $r('app.media.food1') // 使用默认头像

  build() {
    Column() {
      // 顶部状态栏区域
      Row() {
        Text('我的')
          .fontSize(20)
          .fontWeight(600)
          .fontColor('#FFFFFF')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // 用户信息区域
      Row() {
        // 用户头像
        Image(this.userAvatar)
          .width(60)
          .height(60)
          .borderRadius(30)
          .border({ width: 2, color: '#FFFFFF' })
          .onClick(() => {
            // 点击头像编辑个人信息
          })

        // 用户信息
        Column({ space: 8 }) {
          Row() {
            Text(this.userName)
              .fontSize(18)
              .fontWeight(600)
              .fontColor('#FFFFFF')
          }
          .alignItems(VerticalAlign.Center)

        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
         .margin({ left: 16 })

      }
      .width('100%')
      .padding({  bottom: 20 })
      .alignItems(VerticalAlign.Center)

      // 快捷操作区域
      Row() {
        Column({ space: 4 }) {
          Text('0')
            .fontSize(20)
            .fontWeight(600)
            .fontColor('#FFFFFF')
          Text('待付款')
            .fontSize(12)
            .fontColor('#FFFFFF')
            .opacity(0.8)
        }
        .onClick(() => {
          // 跳转到待付款订单
        })

        Column({ space: 4 }) {
          Text('0')
            .fontSize(20)
            .fontWeight(600)
            .fontColor('#FFFFFF')
          Text('待收货')
            .fontSize(12)
            .fontColor('#FFFFFF')
            .opacity(0.8)
        }
        .onClick(() => {
          // 跳转到待收货订单
        })

        Column({ space: 4 }) {
          Text('0')
            .fontSize(20)
            .fontWeight(600)
            .fontColor('#FFFFFF')
          Text('待评价')
            .fontSize(12)
            .fontColor('#FFFFFF')
            .opacity(0.8)
        }
        .onClick(() => {
          // 跳转到待评价订单
        })

        Column({ space: 4 }) {
          Text('0')
            .fontSize(20)
            .fontWeight(600)
            .fontColor('#FFFFFF')
          Text('退款/售后')
            .fontSize(12)
            .fontColor('#FFFFFF')
            .opacity(0.8)
        }
        .onClick(() => {
          // 跳转到退款售后
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
      .padding({ bottom: 20 })
    }
    .backgroundColor('#FF8000')
    .borderRadius({ bottomLeft: 20, bottomRight: 20 })
    .padding({ left: 16, right: 16, top: 16, bottom: 12 })
    .margin({ left: 16, right: 16})
  }
}
