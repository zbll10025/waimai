import { Shop } from "../../models/Shop"
import { router } from "@kit.ArkUI"
import { RouterPath } from "../../route/RoutePath"
import { Category, categoryList } from "../../models/Category"
import { JSON } from "@kit.ArkTS"
import { ToShopHttpFun } from "../../utils/http/HttpModel/HttpFunction"

@Component
export  struct  ShopList{
    @Link shopList:Shop[]
    @Builder shopItem(shop:Shop){
        Row(){
            Image($r('app.media.shop1'))
                .height(110)
                .width(110)
                .margin({left:10,top:15})
            Column({space:10}){
                Text(shop.sname)
                    .fontSize(30)
                    .fontWeight(FontWeight.Bold)
                Row({space:5}){
                    Text(shop.scroce)
                        .fontColor('red')
                        .fontSize(FontWeight.Bold)
                    Text(`月销售${shop.salesVolums}`)
                        .fontSize(10)
                        .margin({bottom:5})
                }
                Text(shop.content)
                    .margin({top:10})
                    .fontSize(15)
                    .fontColor('#E38724')
                    .backgroundColor('#FEF8E0')
                    .borderRadius(10)
            }
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.Start)
            .margin({top:15,left:10})

        }
        .width('95%')
        .height(140)
        .alignItems(VerticalAlign.Top)
        .margin({left:10,right:10})
        .backgroundColor('#FFFFFF')
        .onClick(()=>{
            ToShopHttpFun(shop.sid,true)
        })
     }
    build() {

        Column({space:10}){
            ForEach(this.shopList,(item:Shop)=>{
                    this.shopItem(item)
            })
            if(this.shopList.length == 0){
                Text('商品列表暂时为空').fontSize(30).margin({top:150})
            }
        }
        .width('100%')
        .backgroundColor('#F5F5F5')
        .margin({bottom:120})
    }
    JumpToShop(){
        
    }
}