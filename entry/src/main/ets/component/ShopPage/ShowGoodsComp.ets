import { Category,categoryList } from "../../models/Category"
import { Goods } from "../../models/Goods"
import { AddCart } from "../../utils"
import {CalcBtn } from "../common/Calc"

@Component
export  struct  ShowGoodsComp{
  @Prop categoryList:Category[]= []
  @Prop menuSelectedIndex:number = 0
  @Builder
  goodsBuilder(item:Goods){
    Row(){
      Column(){
        Image($r('app.media.food1')).width(100).aspectRatio(1).borderRadius(6)
      }.height('100%').justifyContent(FlexAlign.Start).margin({left:10,right:10})
      Column({space:5}){
        Text(item.gname)
          .fontSize(16).fontWeight(500)
          .textOverflow({overflow:TextOverflow.Ellipsis})
          .maxLines(2)
        Row(){
          if(item.remark){
            Text(item.remark).fontSize(10).fontColor('#FF8000')
            Image($r('app.media.chevron_right')).width(6).aspectRatio(1)
              .fillColor('#FF8000')
          }
        }
        Text(`月售${item.monthSale}`).fontSize(10).fontColor('#858687')
        Text(item.zhekou?item.zhekou:'').fontSize(10).fontColor('#F84D2C')
        Row(){
          Text(){
            Span('￥').fontSize(10).fontWeight(400)
            Span((item.discount?item.discount:item.price).toString()).fontWeight(600).fontSize(16).fontColor('#F84D2C')
            Span(item.discount?`￥${item.price}`:'').fontSize(10).decoration({ type: TextDecorationType.LineThrough, style: TextDecorationStyle.SOLID})
              .fontColor('#858687').margin({left:10})
          }
        CalcBtn({iconResource:$r('app.media.plus')})
          .onClick(()=>{
            this.AddCart(item)
          })
          .margin({right:30})
        }.width('100%').justifyContent(FlexAlign.SpaceBetween)
      }
      .layoutWeight(1).height('100%')
      .alignItems(HorizontalAlign.Start)
    }.width('100%').height(120).backgroundColor('#fff')
      .alignItems(VerticalAlign.Top)
  }
  build() {
    Row(){
      List(){
        ForEach(
          this.categoryList,
          (item:Category,index:number)=>{
            ListItem(){
              Text(item.name).fontSize(14).fontWeight(600)
                .width('100%').height(50)
                .textAlign(TextAlign.Center)
                .backgroundColor(this.menuSelectedIndex == index?'#FFFFFF':'transparent')
                .borderRadius(this.menuSelectedIndex == index?0:8)
                .onClick(()=>{
                  this.menuSelectedIndex = index
                })
            }
          }
        )
      }.width(90).height('100%').margin({left:10}).backgroundColor('#e4e4e4')
      List({space:10}){
          ListItem(){
            Text(this.categoryList[this.menuSelectedIndex].name)
              .fontSize(16).fontWeight(500)
          }.margin(10)
          ForEach(
            this.categoryList[this.menuSelectedIndex].foods,
            (item:Goods)=>{
              ListItem(){
                this.goodsBuilder(item)
              }
            }
          )
      }.height('100%').layoutWeight(1)
    }.width('100%').padding({top:65,bottom:40,right:10})
  }
 private AddCart(goods:Goods){
    AddCart(goods)
 }
}