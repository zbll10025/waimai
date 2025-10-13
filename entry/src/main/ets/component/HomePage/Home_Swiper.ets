import { TakeAwayItem, takeAwayList} from "../../models/TakeAwayItem";

@Component
export struct Home_Swiper{
    @State takeAwayList:TakeAwayItem[][] =takeAwayList
    @Builder
    takeAwayItemBuilder(takeAwayList:TakeAwayItem[]){
            GridRow({
              columns:5,
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
      Column(){
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
      .backgroundColor('#FFFFFF')
    }
}