import { Home_Swiper } from '../component/HomePage/Home_Swiper';
import { Location_Search } from '../component/HomePage/Location_Search';
import { ShopList } from '../component/HomePage/ShopList';
import { Shop, shopList,shopListUpDate } from '../models/Shop';
import { promptAction } from '@kit.ArkUI'

@Entry
@Component
export  struct HomePage {
  @State message: string = '首页';
  @State isRefreshing:boolean = false
  @State isUpRefreshing:boolean = false
  @State shopList:Shop[] = shopList
  @State shopListUpDate:Shop[] = shopListUpDate
  build() {
    Refresh({refreshing:$$this.isRefreshing,offset:30,friction:70}){
      Stack({alignContent:Alignment.Top}){
        //定位与搜索
        Location_Search()
        List(){
          ListItem(){
            Column(){
              //网格内容
              Home_Swiper()
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
    .onStateChange((refreshStatus:RefreshStatus)=>{
      if(refreshStatus == RefreshStatus.Refresh){
        promptAction.showToast({message:`${this.shopList.length}`})
      }

    })
    .onRefreshing(()=>{
    this.DownRefresh()
    })

  }
  private UpRefresh(){
    if(!this.isUpRefreshing){
      promptAction.showToast({message:`正在刷新`})
      this.isUpRefreshing = true
      setTimeout(()=>{
        this.shopList = [...this.shopList,...this.shopListUpDate]
        this.isUpRefreshing = false
      },1000)
    }
  }
  private DownRefresh(){
    setTimeout(()=>{
      this.isRefreshing = false
    },1000)
  }
}