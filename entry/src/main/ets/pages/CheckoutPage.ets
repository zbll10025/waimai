import promptAction from '@ohos.promptAction';
import { Bill } from '../models/Bill';
import { CartItemData } from '../models/CartItemData';
import { CARTKEY, ClearCart } from '../utils';
import { BillsPostHttp, Ip } from '../utils/http';
import { HttpFrame } from '../utils/http/HttpFrame';
import { BillPostListener } from '../utils/http/HttpModel/DataListener';
import { JSON } from '@kit.ArkTS';

interface Product {
  name: string;
  desc: string;
  price: number;
}

@Entry
@Component
struct OrderConfirmPage {
  @State address: string = '男生宿舍10栋 桂电男生宿舍B区-10栋';
  @State receiver: string = '翟先生';
  @State phone: string = '19103411009';
  @State totalPrice: number = 0;
  @StorageProp(CARTKEY)
  @Watch('onChangeCart')
  cartItemListJson:string  = '[]'
  @State cartItemList:CartItemData[] = JSON.parse(this.cartItemListJson)  as  CartItemData[]
  onChangeCart(){
    this.totalPrice =0
    this.cartItemList = JSON.parse(this.cartItemListJson) as CartItemData[]
    this.cartItemList.forEach((item , index) =>{
      this.totalPrice+=item.count*(item.discount??item.price)
    })
  }
  onPageShow(): void {
    this.cartItemList.forEach((item , index) =>{
      this.totalPrice+=item.count*(item.discount??item.price)
    })
  }

  build() {
    Stack() {
      // ===== 可滚动内容 =====
      Scroll() {
        Column({ space: 16 }) {
          // ===== 顶部地址信息框 =====
          Column({ space: 6 }) {
            Text(this.address)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')

            Text(`${this.receiver}  ${this.phone}`)
              .fontSize(15)
              .fontColor('#666666')

            Row({ space: 6 }) {
              Image($r('app.media.laba'))
                .width(16)
                .height(16)
              Text('由商家自行配送，实际送达时间可联系商家确认')
                .fontSize(13)
                .fontColor('#999999')
            }
            .margin({ top: 4 })
          }
          .padding(12)
          .backgroundColor('#FFFFFF')
          .borderRadius(10)
          .shadow({ radius: 4, color: '#11000000' })
          .margin({ top: 10, left: 12, right: 12 })
          .width('100%')
          Blank().height(10)

          // ===== 商品列表框 =====
          Column({ space: 10 }) {
            ForEach(this.cartItemList, (item: CartItemData) => {
              Column() {

                  // 左侧内容：图片 + 文字+价格
                  Row({ space: 10 }) {
                    Row({space:10}){
                      Image(item.image)
                        .width(60)
                        .height(60)
                        .borderRadius(10)
                      Column({ space: 4 }) {
                        Text(item.name)
                          .fontSize(17)
                          .fontWeight(FontWeight.Medium)
                          .fontColor('#222222')
                          .textAlign(TextAlign.Start)
                          .width('100%')
                          .maxLines(1)
                          .textOverflow({ overflow: TextOverflow.Ellipsis })
                        Text(item.goods?.remark)
                          .fontSize(14)
                          .fontColor('#888888')
                          .textAlign(TextAlign.Start)
                          .width('100%')
                        Text(`数量:${item.count}`)
                          .fontSize(14)
                          .fontColor('#888888')
                          .textAlign(TextAlign.Start)
                          .width('100%')
                      }
                      .alignItems(HorizontalAlign.Start)
                      .justifyContent(FlexAlign.Start)
                      .width(100)
                    }
                    Text('￥' + item.price)
                      .fontSize(17)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#FF6600')
                      .textAlign(TextAlign.End)
                      .margin({right:20})
                  }
                  .justifyContent(FlexAlign.SpaceBetween)
                  .alignItems(VerticalAlign.Center)
                  .width('100%')
                  .padding({ left: 10, right: 10, bottom: 6 })
                  Divider().color('#EAEAEA').strokeWidth(1).margin({ left: 10, right: 10 })
              }
            }, (item: Product) => item.name)
            // ===== 总计栏 =====
            Row() {
              Text('总计')
                .fontSize(17)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
              Blank()
              Text('￥' + this.totalPrice)
                .fontSize(19)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FF6600')
            }
            .padding({ left: 20, right: 20, bottom: 20 })
          }
          .padding({ top: 10, bottom: 80 }) // 底部预留按钮悬浮高度
          .backgroundColor('#FFFFFF')
          .borderRadius(10)
          .shadow({ radius: 4, color: '#11000000' })
          .margin({ left: 12, right: 12 })
          .width('100%')

        }
        .height('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F6F6F6')

      // ===== 悬浮底部按钮 =====
      Button('提交订单')
        .width('90%')
        .height(50)
        .backgroundColor('#FFD900')
        .fontColor('#000000')
        .fontSize(18)
        .borderRadius(25)
        .onClick(() => {
          this.BillPost()
          /*promptAction.showToast({
            message: '订单已提交'
          })*/
        })
        .position({ bottom: 20, left: '5%' }) // 悬浮在屏幕底部
    }

  }
  BillPost(){
    let bills:Bill[] = []
    this.cartItemList.forEach(async (item:CartItemData)=>{
      let bill = new Bill()
      bill.uid = 1
      bill.gid = item.id
      bill.cost = (item.discount??item.price) * item.count
      bill.gcount = item.count
      bill.billstate = 1
      //let res = await AxiosUtil.post<string>(Ip+BillsPostHttp,bill)
      //promptAction.showToast({ message: res.data.data})
      HttpFrame.sendPostTextReq(Ip+BillsPostHttp,JSON.stringify(bill),new BillPostListener())
    })
  }
}