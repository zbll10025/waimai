@Component
export struct AboutPage {
  build() {
    NavDestination() {
      Column() {
        Column() {
          Text('外卖示例应用')
            .fontSize(22)
            .fontWeight(600)
            .fontColor('#333333')

          Text('版本 v1.0.0')
            .fontSize(16)
            .fontColor('#666666')
            .margin({ top: 6 })

          Text('这是一个用于演示的关于页面。')
            .fontSize(16)
            .fontColor('#666666')
            .margin({ top: 12 })
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


