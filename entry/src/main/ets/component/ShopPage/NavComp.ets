import { promptAction } from '@kit.ArkUI'
import { ShowGoodsComp } from './ShowGoodsComp'

@Component
export struct  NavComp{
  @Prop shopName:string
  @Builder
  navItemBuild(isSelected:boolean,title:string,subTitle?:string){
    Column(){
      Text(){
        Span(title)
          .fontSize(16)
          .fontWeight(isSelected?600:300)
          .fontColor(isSelected?'#000':'#999')
        if(subTitle){
          Span(subTitle)
            .fontSize(10)
            .fontColor(isSelected?'#000':'#999')
        }
      }.layoutWeight(1)
      Text()
        .width(20)
        .height(3).backgroundColor(isSelected?'#FFDD00':'transparent')
    }
  }
  @State selectIndex:number =0
  private  controller:TabsController = new TabsController()
  build() {
    Row({space:10}){
      this.navItemBuild(true,'点菜')
      /*this.navItemBuild(false,'评价','1397')
      this.navItemBuild(false,'商家','品牌故事')
      Row(){
        Text('好友拼单').fontColor('#FF8000').fontSize(14).fontWeight(600)
      }.width(68).height(26).borderRadius(8).border({width:0.5,color:'#FF8000'})
       .padding(5).margin({bottom:12})*/
      Text(this.shopName).fontSize(25).fontColor('#FF8000').fontWeight(600).margin({left:100})
    }
    .width('100%')
    .height(60)
    .border({color:'#e4e4e4',width:{bottom:0.5}})
    .padding(15)
  }
}