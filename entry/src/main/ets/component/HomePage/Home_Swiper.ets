import { Goods } from "../../models/Goods";
import { TakeAwayItem, takeAwayList} from "../../models/TakeAwayItem";
import { AddCart, GlobalStore } from "../../utils";
import { RouterPath } from "../../route/RoutePath";
import { ToShopHttpFun } from "../../utils/http/HttpModel/HttpFunction";
import { ShopPage } from "../../pages/ShopPage";

@Component
export struct Home_Swiper{
    @Prop suggestFoodList:Goods[]
    build() {
      GridRow({
        columns:2,
        gutter:{x:3,y:5},
        direction:GridRowDirection.Row
      }){
          ForEach(
            this.suggestFoodList,
            (item:Goods)=>{
              GridCol(){
                Row({space:5}){
                  Image($r('app.media.food1'))
                    .width(100).aspectRatio(1)
                    .borderRadius(5)
                    .onClick(()=>{
                      ToShopHttpFun(item.gid, false,item)
                    })
                  Column(){
                    Text(item.gname)
                      .fontSize(15)
                      .fontWeight(FontWeight.Medium)
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                      .width(100)
                    Text(`￥${item.discount?item.discount:item.price}`).fontColor('#EA442F').fontSize(16)
                  }.alignItems(HorizontalAlign.Start)
                }
              }
            }
          )
      }.height(250).width('95%')
    }
}