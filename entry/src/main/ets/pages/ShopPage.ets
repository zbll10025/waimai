import { CartComp } from '../component/ShopPage/CartComp';
import { FooterComp } from '../component/ShopPage/FooterComp';
import { NavComp } from '../component/ShopPage/NavComp';
import { ShowGoodsComp } from '../component/ShopPage/ShowGoodsComp';
import { CartItemData } from '../models/CartItemData';
import { KEY } from '../utils';
import { JSON } from '@kit.ArkTS';
import { GlobalStore } from '../utils/index';

PersistentStorage.persistProp(KEY,'[]')
@Entry
@Component
export  struct ShopPage {
  @State message: string = 'ShopPage';
  @State showCart:boolean = false
  @StorageProp(KEY)
  @Watch('onChangeCart')
  cartItemListJson:string  = '[]'
  @State cartItemList:CartItemData[] = JSON.parse(this.cartItemListJson)  as  CartItemData[]
  onChangeCart(){
    this.cartItemList = JSON.parse(this.cartItemListJson) as CartItemData[]
  }
  onAppear(callback: () => void) {
    GlobalStore.onBuy?.();
    callback?.();
    return this;
  }
  build() {
    Row(){
      Stack({alignContent:Alignment.Bottom}){
        Column(){
          Stack({alignContent:Alignment.Top}){
            ShowGoodsComp()
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