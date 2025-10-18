import { CartComp } from '../component/ShopPage/CartComp';
import { FooterComp } from '../component/ShopPage/FooterComp';
import { NavComp } from '../component/ShopPage/NavComp';
import { ShowGoodsComp } from '../component/ShopPage/ShowGoodsComp';
import { CartItemData } from '../models/CartItemData';
import { CARTKEY } from '../utils';
import { JSON } from '@kit.ArkTS';
import { GlobalStore } from '../utils/index';
import { promptAction, router } from '@kit.ArkUI'
import { Category } from '../models/Category';
import { HttpFrame } from '../utils/http/HttpFrame';
import { Shop } from '../models/Shop';
import { Ip, ShopDataHttp } from '../utils/http';
import { ShopDataListener } from '../utils/http/HttpModel/DataListener';

PersistentStorage.persistProp(CARTKEY,'[]')
@Entry
@Component
export  struct ShopPage {
  @State message: string = 'ShopPage';
  @State showCart:boolean = false
  @State categoryList:Category[] =[]
  @State categoryIndex:number = 0
  @State shopName:string = "暂无商店名称"
  @StorageProp(CARTKEY)
  @Watch('onChangeCart')
  cartItemListJson:string  = '[]'
  @State cartItemList:CartItemData[] = JSON.parse(this.cartItemListJson)  as  CartItemData[]
  onChangeCart(){
    this.cartItemList = JSON.parse(this.cartItemListJson) as CartItemData[]

  }
  onPageShow(): void {
    if(GlobalStore.onBuy){
      this.ClickSugeest()
    }
    GlobalStore.onBuy?.(this);
    GlobalStore.onBuy = undefined
  }
  aboutToAppear(): void {
    this.ParseParams()
    if(this.categoryList.length!=0){
      HttpFrame.sendReq<Shop>(Ip+ShopDataHttp+this.categoryList[0].cid?.toString(),new ShopDataListener(this))
    }
  }
  private ClickSugeest(){
    this.showCart = true
  }
  private ParseParams(){
    const params = router.getParams() as Record<string, string>
    if (params && params['categroyList']){
      this.categoryList = JSON.parse(params['categroyList']) as Category[]
    }
  }
  build() {
    Row(){
      Stack({alignContent:Alignment.Bottom}){
        Column(){
          Stack({alignContent:Alignment.Top}){
            ShowGoodsComp({categoryList:this.categoryList,menuSelectedIndex:this.categoryIndex})
            NavComp({shopName:this.shopName})
          }
        }
        .height('100%')
        if(this.showCart){
          CartComp({cartitemList:$cartItemList,showCart:$showCart})
        }
        FooterComp({showCart:$showCart,cartItemList:$cartItemList})
      }
    }
    .height('100%')
    .width('100%')
  }
}