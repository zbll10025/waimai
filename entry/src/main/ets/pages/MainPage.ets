import { TabBarItem,tabBarItemList } from '../models/TabBarItem'
import { promptAction } from '@kit.ArkUI'
import { HomePage } from './HomePage'

@Entry
@Component
struct MainPage {
  @State selectIndex:number = 0
  private  controller:TabsController = new TabsController()
  @State tabBarItemList:TabBarItem [] = tabBarItemList
  @Builder
  tabBarBuilder(item:TabBarItem,index:number) {
      Column(){
        Image(this.selectIndex == index?item.icon_selected:item.icon_normal).width(50).aspectRatio(1).margin({top:5,bottom:1})
      }
  }
  build() {
      Tabs({barPosition:BarPosition.End, index:this.selectIndex, controller:this.controller}){
        TabContent(){
          HomePage()
        }.tabBar(this.tabBarBuilder(tabBarItemList[0],0))
        TabContent(){
          Text('订单')
        }.tabBar(this.tabBarBuilder(tabBarItemList[1],1))
        TabContent(){
          Text('我的')
        }.tabBar(this.tabBarBuilder(tabBarItemList[2],2))
      }
        .onChange((index:number)=>{
          this.selectIndex = index
          promptAction.showToast({message:'当前页面为:'+index})
        })

  }
}