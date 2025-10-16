import { CartItemData } from "../../models/CartItemData"
import { Goods } from "../../models/Goods"
import { AddCart, DelCart } from "../../utils"
import { CalcBtn } from "../common/Calc"

@Component
export  struct  CartItem{
  @Prop cartItem:CartItemData = {
    id: -1,
    image:$r('app.media.food1'),
    name:"空",
    count:-1,
    price:-1,
    discount:-0.1,
    goods: { gid: 101, gname: "招牌汉堡", gimage: $r('app.media.food1'), price: 18.8, content: "经典牛肉汉堡，鲜嫩多汁", remark: "人气最高", discount: 0.9, type: "主食", shopName: "麦味屋", monthSale: 120, zhekou: "9折",  url: "" }
  }
  build() {
    Row({space:15}){
      Image($r('app.media.food1'))
        .width(60).aspectRatio(1).borderRadius(6)
      Column({space:15}){
        Text(this.cartItem.name).fontSize(18).fontWeight(600)
          .textOverflow({
            overflow:TextOverflow.Ellipsis
          })
          .maxLines(2)
        Row(){
          Row({space:3}){
            Text(this.cartItem.discount?('￥'+this.cartItem.discount?.toString()):this.cartItem.price?.toString()).fontSize(18).fontWeight(600)
            Text(this.cartItem.discount?this.cartItem.price?.toString():'').fontSize(10).fontColor('#999').decoration({ type: TextDecorationType.LineThrough, style: TextDecorationStyle.SOLID})
          }
          Row({space:5}){
            CalcBtn({iconResource:$r('app.media.minus'),isPlain:true})
              .onClick(()=>{
                DelCart(this.cartItem.id)
              })
            Text(this.cartItem.count.toString()).fontSize(16)
            CalcBtn({iconResource:$r('app.media.plus')})
              .onClick(()=>{
                AddCart(this.cartItem.goods as Goods)
              })
          }
        }.justifyContent(FlexAlign.SpaceBetween).width('100%')
      }.alignItems(HorizontalAlign.Start).layoutWeight(1)
    }.width('100%').padding({left:15,right:20}).alignItems(VerticalAlign.Top)
  }
}