import { Goods } from "../../models/Goods";
import { GlobalStore, SuggestFoodData,suggestList } from "../../models/SuggestFoodData";
import { TakeAwayItem, takeAwayList} from "../../models/TakeAwayItem";
import { AddCart } from "../../utils";
import { router } from "@kit.ArkUI";
import { RouterPath } from "../../route/RoutePath";

@Component
export struct Home_Swiper{
    @State takeAwayList:TakeAwayItem[][] =takeAwayList
    @State suggestFoodList:SuggestFoodData[] =suggestList
    @Builder
    suggestItem(data:SuggestFoodData){

    }
    @Builder
    takeAwayItemBuilder(takeAwayList:TakeAwayItem[]){
            GridRow({
              columns:10,
              gutter:{x:5,y:15},
              direction:GridRowDirection.Row
            }){
              ForEach(
                takeAwayList,
                (item:TakeAwayItem)=>{
                  GridCol(){
                    Column(){
                      Image(item.itemImage).width(40).height(50).interpolation(ImageInterpolation.High)
                      Text(item.title).fontSize(14)
                    }.height(60)
                  }
                }
              )
            }

    }

    build() {
      /*Column(){
          Swiper(){
              ForEach(
                this.takeAwayList,
                (item:TakeAwayItem[])=>{
                  this.takeAwayItemBuilder(item)
                }
              )

          }
          .loop(false)
          .borderRadius(10)
          .width('95%')
          .height(260)
          .margin({left:5,right:5,top:5})
          .backgroundColor('#FFFFFF')
          .padding(5)
          .indicatorStyle({color:('#E5E5E7'),selectedColor:Color.Yellow})

      }
      .width('100%')
      .height(280)
      .backgroundColor('#FFFFFF')*/
      GridRow({
        columns:2,
        gutter:{x:3,y:5},
        direction:GridRowDirection.Row
      }){
          ForEach(
            this.suggestFoodList,
            (item:SuggestFoodData)=>{
              GridCol(){
                Row({space:5}){
                  Image(item.food?.image)
                    .width(100).aspectRatio(1)
                    .onClick(()=>{
                      GlobalStore.onBuy = () => {
                        AddCart(item.food as Goods)
                      };
                      router.pushUrl({url:RouterPath.ShopPage})
                    })
                  Column(){
                    Text("虾王蒸霸asdad")
                      .fontSize(20)
                      .fontWeight(FontWeight.Medium)
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                      .width(100)
                    Text(`￥${item.food?.discount?item.food?.discount:item.food?.price}`).fontColor('#EA442F').fontSize(16)
                  }.alignItems(HorizontalAlign.Start)
                }
              }
            }
          )
      }.height(200).width('95%')
    }
}