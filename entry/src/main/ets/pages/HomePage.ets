import { Home_Swiper } from '../component/HomePage/Home_Swiper';
import { Location_Search } from '../component/HomePage/Location_Search';
import { ShopList } from '../component/HomePage/ShopList';
import { Shop, shopList,shopListUpDate } from '../models/Shop';
import { promptAction } from '@kit.ArkUI'
import { Goods } from '../models/Goods';
import { ShopListDataListener, SuggestGoodsDataListener } from '../utils/http/HttpModel/DataListener';
import { HttpFrame } from '../utils/http/HttpFrame';
import { Ip, ShopListHttp, SuggestFoodHttp } from '../utils/http';
import { Category, categoryList } from '../models/Category';

@Entry
@Component
export  struct HomePage {
  @State message: string = '首页';
  @State isRefreshing:boolean = false
  @State isDownRefresh:boolean =false
  @State isUpRefreshing:boolean = false
  @State isOverUpRefresh:boolean = false
  @State shopOffer:number = 0
  @State shopList:Shop[] = []
  @State suggestFoodList:Goods[] = []
  @State categoryListParam:Category[] = categoryList
  build() {
    Refresh({refreshing:$$this.isRefreshing,offset:30,friction:70}){
      Stack({alignContent:Alignment.Top}){
        //定位与搜索
        Location_Search()
        List(){
          ListItem(){
            Column(){
              //网格内容
              Home_Swiper({suggestFoodList:this.suggestFoodList})
              //商店列表
              ShopList({shopList:this.shopList})
            }
          }
        }
        .height('100%')
        .width('100%')
        .margin({top:100})
        .scrollBar(BarState.Auto)
        .onReachEnd(()=>{
          this.UpRefresh()
        })
      }
    }
    //.onStateChange()
    .onRefreshing(() => {
      if(this.isDownRefresh){return}
      this.isDownRefresh =true
      HttpFrame.sendReq<Goods[]>(Ip+SuggestFoodHttp,new SuggestGoodsDataListener(this))
      if(this.shopList.length<5){
        HttpFrame.sendReq<Shop[]>(Ip+ShopListHttp+(this.shopOffer.toString()),new ShopListDataListener(this))
      }
      promptAction.showToast({ message: this.suggestFoodList.length.toString()});
    })
  }
  private UpRefresh(){
    if (this.isOverUpRefresh){ promptAction.showToast({ message: "到底了"}); return}
    if(!this.isUpRefreshing){
      this.isUpRefreshing = true
      HttpFrame.sendReq<Shop[]>(Ip+ShopListHttp+(this.shopOffer.toString()),new ShopListDataListener(this))
    }else {
      promptAction.showToast({message:`正在刷新`})
    }
  }
  aboutToAppear(){
    HttpFrame.sendReq<Goods[]>(Ip+SuggestFoodHttp,new SuggestGoodsDataListener(this))
  }
}