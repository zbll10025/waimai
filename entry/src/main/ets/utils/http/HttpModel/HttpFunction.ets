import { Category } from "../../../models/Category"
import { CategoryListByGoodsHttp, CategoryListHttp, Ip } from "../../http"
import { HttpFrame } from "../HttpFrame"
import { CategoryListDataListener } from "./DataListener"
import { promptAction } from '@kit.ArkUI';
import { Goods } from "../../../models/Goods";

export const ToShopHttpFun =(id:number,isByShopId:boolean,goods?:Goods)=>{
  if(isByShopId){
    let http:string = Ip+CategoryListHttp+id.toString()+'/with-goods'
    HttpFrame.sendReq<Category[]>(http,new CategoryListDataListener(isByShopId))
  }else {
    let http:string = Ip+CategoryListByGoodsHttp+id.toString()+'/shop-categories'
    //promptAction.showToast({ message: http});
    HttpFrame.sendReq<Category[]>(http,new CategoryListDataListener(isByShopId,goods))
  }
}