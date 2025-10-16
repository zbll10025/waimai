import { Goods, GoodsDefault } from "../../../models/Goods";
import { IDataListener } from "../interface/IDataListener";
import { promptAction, router } from '@kit.ArkUI';
import { HomePage } from "../../../pages/HomePage";
import { Shop } from "../../../models/Shop";
import { Category } from "../../../models/Category";
import { RouterPath } from "../../../route/RoutePath";
import { AddCart, GlobalStore } from "../..";
import { ShopPage } from "../../../pages/ShopPage";

export  class SuggestGoodsDataListener implements  IDataListener<Goods[]>{
    private HomePage: HomePage;
    constructor(HomePage: HomePage) {
      this.HomePage = HomePage;
    }
    onSuccess(result: Goods[]) {
      this.HomePage.suggestFoodList = result
      promptAction.showToast({ message: JSON.stringify(result[0])});
      setTimeout(()=>{
        this.HomePage.isRefreshing = false
        this.HomePage.isDownRefresh =false
      },500)
    }
    onFailure() {
      promptAction.showToast({ message: "失败了"});
      setTimeout(()=>{
        this.HomePage.isRefreshing = false
      },500)
    }
  }
export  class ShopListDataListener implements  IDataListener<Shop[]>{
  private HomePage: HomePage;
  constructor(HomePage: HomePage) {
    this.HomePage = HomePage;
  }
  onSuccess(result: Shop[]) {
    if(result.length<5){this.HomePage.isOverUpRefresh =true}
    this.HomePage.shopList = [...this.HomePage.shopList,...result]
    this.HomePage.shopOffer+=5
    promptAction.showToast({ message: JSON.stringify(result[0])});
    setTimeout(()=>{
      this.HomePage.isUpRefreshing = false
    },2000)
  }
  onFailure() {
    promptAction.showToast({ message: "失败了"});
    setTimeout(()=>{
      this.HomePage.isUpRefreshing = false
    },2000)
  }
}
export  class CategoryListDataListener implements  IDataListener<Category[]>{
  isByShop:boolean = false
  goods?:Goods
  constructor(isByShop:boolean,goods?:Goods) {
    this.isByShop = isByShop
    this.goods = goods
  }
  onSuccess(result: Category[]) {
    if(!this.isByShop){
      let index:number = result.findIndex((item:Category)=>
        item.cid == this.goods?.cid
      )
      GlobalStore.onBuy = (shopPage:ShopPage) => {
        shopPage.categoryIndex = index
        AddCart(this.goods??GoodsDefault)
      };
    }
    router.pushUrl({url:RouterPath.ShopPage,params:{categroyList:JSON.stringify(result)}})
    //promptAction.showToast({ message: JSON.stringify(result[0])});
  }
  onFailure() {
    promptAction.showToast({ message: "失败了"});

  }
}
