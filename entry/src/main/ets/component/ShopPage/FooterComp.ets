import { CartItemData } from "../../models/CartItemData"
import { router } from "@kit.ArkUI"
import { RouterPath } from "../../route/RoutePath"

@Component
export  struct FooterComp{
  @Link showCart:boolean
  @Link
  cartItemList:CartItemData[]
  build() {
      Row(){
        Badge({
          value:this.cartItemList.length+'',
          position:BadgePosition.Right,
          style:{
            badgeSize:12
          }
        }){
          Image($r('app.media.waimai'))
            .width(47)
            .height(69)
            .onClick(()=>{
              this.showCart = !this.showCart
            })
        }.margin({left:20})
        Column(){
          Row({space:5}){
            Text(this.cartItemList.reduce((p,c)=>p+((c.discount?c.discount:c.price) as number)*c.count,0).toFixed(2).toString()).fontSize(25).fontColor(Color.Red)
            Image($r('app.media.chevron_up')).width(12).fillColor('#FAE35A')
          }
          .margin({top:10})
          Text('总价为').fontSize(12).fontColor(Color.Black)
        }.alignItems(HorizontalAlign.Start).padding({left:10}).layoutWeight(1).margin({left:10})
        Row(){
          Text('去结算').fontSize(18)
        }
        .backgroundColor(this.cartItemList.length == 0?'#999':'#FFE546')
        .height('100%').width(80)
        .borderRadius({topRight:25,bottomRight:25})
        .justifyContent(FlexAlign.Center)
        .onClick(()=>{
          router.push({url:RouterPath.CheckoutPage})
        })

      }
      .height(50)
      .width('100%')
      .backgroundColor(Color.White)
  }
}