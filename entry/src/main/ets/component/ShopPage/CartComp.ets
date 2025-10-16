import { CartItemData } from "../../models/CartItemData"
import { ClearCart } from "../../utils"
import { CartItem } from "./CartItem"
import { text } from "@kit.ArkGraphics2D"

@Component
export struct  CartComp{
  @Link
  cartitemList:CartItemData[]
  @Link
  showCart:boolean
  build() {
    Column(){
      Text().width('100%').layoutWeight(1)
        .onClick(()=>{
          this.showCart = false
        })
      Column(){
        Row(){
          Text('购物车').fontSize(14)
          Row({space:2}){
            Image($r('app.media.trash'))
              .width(14)
              .aspectRatio(1)
              .fillColor('#999')
            Text('清空购物车')
              .fontSize(14)
              .fontColor('#999')
          }
          .onClick(()=>{
            ClearCart()
            this.showCart= false
          })
        }.width('100%').height(40).padding({left:15,right:15})
         .border({width:{bottom:0.5},color:'#e4e4e4'})
         .justifyContent(FlexAlign.SpaceBetween)
        List({space:15}){
          ForEach(
            this.cartitemList,
            (item:CartItemData)=>{
              ListItem(){
               CartItem({cartItem:item})
              }
            }
          )
          ListItem(){
            Text('').width('100%').height(40)
          }
        }
        .divider({strokeWidth:0.5,color:'#e4e4e4',startMargin:100,endMargin:15})
        .margin({top:15})
      }.width('100%').height(300).backgroundColor(Color.White).margin({bottom:50})
    }
    .width('100%')
    .height('100%')
    .backgroundColor('rgba(0,0,0,0.5)')
    .justifyContent(FlexAlign.End)

  }
}