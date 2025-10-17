import {  router } from '@kit.ArkUI'
import { Bill } from '../../models/Bill'
import { User }  from "../../models/User.ets"
import { ID } from '../../pages/LoginPage'
import { AxiosUtil } from "../../utils/network/HttpUtils.ets"
import { Order, OrderStatus} from "../../models/Order.ets"



@Preview
@Component
export struct UserHeader {
  @State userName:string = "用户"
  @State orders:Order[] = []
  @Link isLogin:boolean
  @StorageProp(ID) userid: string = '';
  selectedAddress: string = '';
  // 订单状态统计
  @State pendingPaymentCount: number = 0    // 待付款
  @State deliveringCount: number = 0        // 待收货
  @State completedCount: number = 0         // 已完成

  async aboutToAppear() {
    let res1 = await AxiosUtil.get<User>("users/"+this.userid)
    this.userName = res1.data.name??""

    let res2 = await AxiosUtil.get<Order[]>("bills/user/"+this.userid)
    this.orders = res2.data
    
    // 统计不同状态的订单数量
    this.calculateOrderStatus()
  }
  
  // 计算订单状态统计
  calculateOrderStatus() {
    this.pendingPaymentCount = this.orders.filter(order => order.billstate === OrderStatus.Created).length
    this.deliveringCount = this.orders.filter(order => 
      order.billstate === OrderStatus.Paid || order.billstate === OrderStatus.Delivering
    ).length
    this.completedCount = this.orders.filter(order => order.billstate === OrderStatus.Completed).length
  }
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
          .onClick(async ()=>{
            let  user:User = {
              id: 0,
              name: "string",
              password: "string",
              telePhone: "string",
              balance: 0
            }
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // 用户信息区域
      Row() {
        // 用户信息
        if(this.isLogin){
            Text(this.userName)
              .fontSize(18)
              .fontWeight(600)
              .fontColor('#FFFFFF')
        .layoutWeight(1)
        .margin({ top : 16,left: 16 })
        }else {
          Button("登入")
            .fontSize(14)
            .type(ButtonType.Circle)
            .backgroundColor('#FEE543')
            .borderColor('#E5E5E5')
            .borderWidth(1)
            .margin({ right:8 })
            .fontColor('#232426')
            .onClick(()=>{
              router.replaceUrl({
                url: 'pages/LoginPage'
              })
            })
        }

      }
      .width('100%')
      .padding({  bottom: 20 })
      .alignItems(VerticalAlign.Center)

      // 快捷操作区域
      Row() {
        Column({ space: 4 }) {
          Text(this.pendingPaymentCount.toString())
            .fontSize(20)
            .fontWeight(600)
            .fontColor('#FFFFFF')
          Text('待付款')
            .fontSize(12)
            .fontColor('#FFFFFF')
            .opacity(0.8)
        }

        Column({ space: 4 }) {
          Text(this.deliveringCount.toString())
            .fontSize(20)
            .fontWeight(600)
            .fontColor('#FFFFFF')
          Text('待收货')
            .fontSize(12)
            .fontColor('#FFFFFF')
            .opacity(0.8)
        }

        Column({ space: 4 }) {
          Text(this.completedCount.toString())
            .fontSize(20)
            .fontWeight(600)
            .fontColor('#FFFFFF')
          Text('已完成')
            .fontSize(12)
            .fontColor('#FFFFFF')
            .opacity(0.8)
        }
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
