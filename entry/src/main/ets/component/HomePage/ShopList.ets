import { Shop } from "../../models/Shop"
import { router } from "@kit.ArkUI"
import { RouterPath } from "../../route/RoutePath"

@Component
export  struct  ShopList{
    @Link shopList:Shop[]
    @Builder shopItem(shop:Shop){
        Row(){
            Image(shop.image)
                .height(110)
                .width(110)
                .margin({left:10,top:15})

            Column({space:10}){
                Text(shop.name)
                    .fontSize(30)
                    .fontWeight(FontWeight.Bold)
                Row({space:5}){
                    Text(shop.score)
                        .fontColor('red')
                        .fontSize(FontWeight.Bold)
                    Text(`月销售${shop.salesVolume}`)
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
            router.pushUrl({url:RouterPath.ShopPage})
        })
     }
    build() {

        Column({space:10}){
            ForEach(this.shopList,(item:Shop)=>{
                    this.shopItem(item)
            })
        }
        .width('100%')
        .backgroundColor('#F5F5F5')
        .margin({bottom:120})


    }
}