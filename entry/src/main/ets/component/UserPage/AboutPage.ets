
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
          

          Text('前端项目：')
            .fontSize(14)
            .fontColor('#666666')
            .margin({ top: 8 })

          Text('https://github.com/zbll10025/waimai')
            .fontSize(14)
            .fontColor('#007AFF')
            .decoration({ type: TextDecorationType.Underline })
            .margin({ top: 4 })

          Text('后端项目：')
            .fontSize(14)
            .fontColor('#666666')
            .margin({ top: 12 })

          Text('https://github.com/zbll10025/wmHouDuan')
            .fontSize(14)
            .fontColor('#007AFF')
            .decoration({ type: TextDecorationType.Underline })
            .margin({ top: 4 })
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


