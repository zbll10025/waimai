import { Order, OrderStatus, mockOrders } from "../models/Order"

@Entry
@Component
export struct OrderListPage {
  @State orders:Order[] = mockOrders

  private statusText(status:OrderStatus):string {
    switch(status){
      case OrderStatus.Created: return "待支付"
      case OrderStatus.Paid: return "制作中"
      case OrderStatus.Delivering: return "配送中"
      case OrderStatus.Completed: return "已完成"
      case OrderStatus.Cancelled: return "已取消"
      default: return "未知"
    }
  }

  private statusColor(status:OrderStatus):ResourceColor {
    switch(status){
      case OrderStatus.Completed: return Color.Gray
      case OrderStatus.Delivering: return Color.Orange
      case OrderStatus.Paid: return Color.Blue
      case OrderStatus.Created: return Color.Red
      case OrderStatus.Cancelled: return Color.Gray
      default: return Color.Gray
    }
  }

  private canCancel(status:OrderStatus):boolean {
    // 数据库用数字表示，已完成或已取消不允许取消
    return !(status === OrderStatus.Completed || status === OrderStatus.Cancelled)
  }
  @Builder
   orderCard(order:Order){
    Column(){
      // 顶部：店铺信息与状态
      Row(){
        Row(){
          Image(order.shopImage).width(24).height(24).borderRadius(12)
          Text(order.shopName).fontWeight(FontWeight.Medium)
        }.justifyContent(FlexAlign.Start).layoutWeight(1)
         Text(this.statusText(order.status ?? OrderStatus.Created))
          .fontSize(14)
           .fontColor(this.statusColor(order.status ?? OrderStatus.Created))
      }.width('100%')

      // 中间：商品图片 + 名称 + 价格数量
      Row(){
        // 根据要求，商品图片统一用 Image(item.food?.image)
        Image(order.items[0]?.food?.image)
          .width(100).aspectRatio(1)
        Column({space:5}){
          Text(order.title).fontSize(22).fontWeight(FontWeight.Medium).maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis }).width(150).margin({bottom:5})
          Text(`￥${order.items[0]?.price.toFixed(2)}`)
            .fontColor('#1F1F1F')
          Text(`共 ${order.totalCount} 件`).fontColor(Color.Gray).fontSize(12)
        }.alignItems(HorizontalAlign.Start).margin({left:20})
      }.margin({ top:8 ,right:80})

      // 底部：操作按钮（再来一单、取消订单（条件显示））
      Row(){
        Blank()
        Button("再来一单")
          .fontSize(14)
          .type(ButtonType.Capsule)
          .backgroundColor('#FEE543')
          .borderColor('#E5E5E5')
          .borderWidth(1)
          .margin({ right:8 })
          .fontColor('#232426')
          .onClick(()=>{
          })
         if(this.canCancel(order.status ?? OrderStatus.Created)){
          Button("取消订单")
            .fontSize(14)
            .type(ButtonType.Capsule)
            .backgroundColor('#FFECEC')
            .fontColor('#D03030')
            .onClick(()=>{
              // 示例：仅本地变更状态为已取消
              const idx = this.orders.findIndex(o=>o.id===order.id)
              if(idx>=0){
                this.orders[idx].status = OrderStatus.Cancelled
                this.orders = [...this.orders]
              }
            })
        }
      }.width('100%').margin({ top:10 })
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
  }

  build(){
    Column(){
      List(){
        ForEach(this.orders, (order:Order)=>{
          ListItem(){
            this.orderCard(order)
          }
          .margin({ left:12, right:12, top:8, bottom:8 })
        })
      }
      .edgeEffect(EdgeEffect.Spring)
      .divider({ strokeWidth: 0 })
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}


