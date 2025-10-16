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

PersistentStorage.persistProp(CARTKEY,'[]')
@Entry
@Component
export  struct ShopPage {
  @State message: string = 'ShopPage';
  @State showCart:boolean = false
  @State categoryList:Category[] =[]
  @State categoryIndex:number = 0
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
            NavComp()
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