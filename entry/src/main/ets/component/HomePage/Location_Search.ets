import { SelectedAddress } from "../../pages/AddressPage"

@Component
export  struct  Location_Search{
  @State swiperList:string[]=['水煮肉片','塔斯汀','桂林米粉','蜜雪冰城']
  @StorageProp(SelectedAddress) selectedAddress:string =""
  @State isInputOnFocus:boolean = false
  build() {
      Column(){
        //定位
        Row(){
          Image($r('app.media.gps')).width(18).aspectRatio(1)
          Text(this.selectedAddress).fontSize(18)
        }
        .margin({top:10,left:15}).width('100%')
        /*//搜索框
        Row(){
          Stack({alignContent:Alignment.End}){
            Swiper(){
              ForEach(
                this.swiperList,
                (item:string,index)=>{
                  TextInput({text:item}).width('85%').height(40).backgroundColor('#FFFFFF')
                    .onFocus(()=>{
                      this.isInputOnFocus = true
                    })
                    .onBlur(()=>{
                      this.isInputOnFocus = false
                    })
                    .onChange(()=>{
                      this.InputOnchange()
                    })
                }
              )
            }
            .autoPlay(this.isInputOnFocus?false:true)
            .loop(true)
            .vertical(true)
            .indicator(false)
            Button('搜索')
              .fontColor('#363636')
              .width(80)
              .height(30)
              .margin(5)
              .backgroundColor('#FAE35A')

          }
          Image($r('app.media.Scan')).width(40).aspectRatio(1).fillColor('#363636')
        }.margin({top:10,left:15}).width('100%')*/
      }
      .width('100%')
      .height(50)
      .backgroundColor('#FAE35A')
  }
  private  InputOnchange(){

  }
}
