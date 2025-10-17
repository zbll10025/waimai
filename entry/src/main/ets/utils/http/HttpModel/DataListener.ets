import { Goods, GoodsDefault } from "../../../models/Goods";
import { IDataListener } from "../interface/IDataListener";
import { promptAction, router } from '@kit.ArkUI';
import { HomePage } from "../../../pages/HomePage";
import { Shop } from "../../../models/Shop";
import { Category } from "../../../models/Category";
import { RouterPath } from "../../../route/RoutePath";
import { AddCart, ClearCart, GlobalStore } from "../..";
import { ShopPage } from "../../../pages/ShopPage";
import { User } from "../../../models/User";
import { UserHeader } from "../../../component/UserPage/UserHeader";
import { OrderListPage } from "../../../pages/OrderListPage";
import { Order } from "../../../models/Order";

export  class UserDataListener implements IDataListener<User>{
  private userHeader:UserHeader
  constructor(userHeader: UserHeader) {
    this.userHeader = userHeader;
  }
  onSuccess(result: User) {
    this.userHeader.userName = result.name??""
  }
  onFailure() {
    promptAction.showToast({ message: "失败了"});
  }
}

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
export  class BillGetDataListener implements  IDataListener<Order[]>{

  orderListPage:OrderListPage
  constructor(orderListPage:OrderListPage) {
    this.orderListPage = orderListPage
  }
  onSuccess(result: Order[]) {
    this.orderListPage.orders = result
    promptAction.showToast({ message: "刷新成功"});
    setTimeout(()=>{
      this.orderListPage.isRefreshing = false
      this.orderListPage.isDownRefresh =false
    },500)
    //promptAction.showToast({ message: JSON.stringify(result[0])});
  }
  onFailure() {
    promptAction.showToast({ message: "失败了"});
    setTimeout(()=>{
      this.orderListPage.isRefreshing = false
      this.orderListPage.isDownRefresh =false
    },500)

  }
}
export  class BillPostListener implements  IDataListener<string>{

  onSuccess(result: string): void {
    promptAction.showToast({ message: "提交成功"+result});
    setTimeout(()=>{
      ClearCart()
      router.pushUrl({url:RouterPath.MainPage})
    },1000)
  }
  onFailure(): void {
    promptAction.showToast({ message: "提交失败"});
  }
}

export  class BillStateListener implements  IDataListener<string>{

  onSuccess(result: string): void {
    promptAction.showToast({ message: result});
    setTimeout(()=>{

    },1000)
  }
  onFailure(): void {
    promptAction.showToast({ message: "订单状态改变成功"});
  }
}

