import { Order, OrderStatus, mockOrders } from "../models/Order"
import { BillGetHttp, BillStaeChangeHttp, Ip } from "../utils/http"
import { HttpFrame } from "../utils/http/HttpFrame"
import { BillGetDataListener, BillStateListener } from "../utils/http/HttpModel/DataListener"
import { ToShopHttpFun } from "../utils/http/HttpModel/HttpFunction"

@Entry
@Component
export struct OrderListPage {
  @State orders:Order[] = []
  @State isRefreshing:boolean = false
  @State isDownRefresh:boolean =false

  private formatTime(t?:string):string {
    if(!t){ return "" }
    const d = new Date(t)
    const pad = (n:number)=> n<10? `0${n}` : `${n}`
    return `${d.getFullYear()}-${pad(d.getMonth()+1)}-${pad(d.getDate())} ${pad(d.getHours())}:${pad(d.getMinutes())}`
  }

  private statusText(status:number):string {
    switch(status){
      case 0: return "待支付"
      case 1: return "制作中"
      case 2: return "配送中"
      case 3: return "已完成"
      case 4: return "已取消"
      default: return "未知"
    }
  }

  private statusColor(status:OrderStatus):ResourceColor {
    switch(status){
      case 0: return Color.Gray
      case 1: return Color.Orange
      case 2: return Color.Blue
      case 3: return Color.Red
      case 4: return Color.Gray
      default: return Color.Gray
    }
  }

  @Builder
   orderCard(order:Order){
    Column(){
      // 顶部：店铺信息与状态
      Row(){
        Row(){
          Image($r('app.media.shop1')).width(24).height(24).borderRadius(12)
          Text(order.sname).fontWeight(FontWeight.Medium)
        }.justifyContent(FlexAlign.Start).layoutWeight(1)
        Column({space:10}){
          Text(this.formatTime(order.time)).fontSize(14)
          Text(this.statusText(order.billstate))
            .fontSize(14)
            .fontColor(this.statusColor(order.billstate))
            .margin({left:60})
        }
      }.width('100%')

      // 中间：商品图片 + 名称 + 价格数量
      Row(){
        // 根据要求，商品图片统一用 Image(item.food?.image)
        Image($r('app.media.food1'))
          .width(100).aspectRatio(1)
        Column({space:5}){
          Text(order.food?.gname).fontSize(22).fontWeight(FontWeight.Medium).maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis }).width(150).margin({bottom:5})
          Text(`￥${(order.cost ?? 0).toFixed(2)}`)
            .fontColor('#1F1F1F')
          Text(`共 ${order.gcount} 件`).fontColor(Color.Gray).fontSize(12)
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
            ToShopHttpFun(order.gid,false,order.food)
          })
         if(order.billstate !=4){
          Button("取消订单")
            .fontSize(14)
            .type(ButtonType.Capsule)
            .backgroundColor('#FFECEC')
            .fontColor('#D03030')
            .onClick(()=>{
              const idx = this.orders.findIndex(o=>o.bid===order.bid)
              if(idx>=0){
                this.orders[idx].billstate = OrderStatus.Cancelled
                this.orders = [...this.orders]
              }
              HttpFrame.sendPutTextReq(Ip+BillStaeChangeHttp+order.bid.toString()+"/status?status=4",undefined,new BillStateListener())
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

    Refresh({refreshing:$$this.isRefreshing,offset:30,friction:70}){
      Column(){
        List(){
          ForEach([...this.orders].sort((a, b)=>{
            const ta = a.time ? new Date(a.time).getTime() : 0
            const tb = b.time ? new Date(b.time).getTime() : 0
            return tb - ta
          }), (order:Order)=>{
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
    }.onRefreshing(()=>{
      if(this.isDownRefresh){return}
      this.isDownRefresh =true
      HttpFrame.sendReq<Order[]>(Ip+BillGetHttp+'1',new BillGetDataListener(this))
    })
  }
  aboutToAppear(): void {
    HttpFrame.sendReq<Order[]>(Ip+BillGetHttp+'1',new BillGetDataListener(this))
  }
}


