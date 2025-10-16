import { Goods } from "../models/Goods"
import { JSON } from "@kit.ArkTS"
import { CartItemData } from "../models/CartItemData"
import { ShopPage } from "../pages/ShopPage"

export const CARTKEY = 'cart_key'

export const AddCart = (food:Goods)=>{
  const json = AppStorage.Get<string>(CARTKEY) || '[]'
  let  catItemList = JSON.parse(json) as CartItemData[]
  let  f = catItemList.find(item=>item.id ===food.gid)
  if(f){
    f.count++
  }else{
    const id = food.gid;
    const name = food.gname;
    const price = food.price;
    const discount = food.discount;
    const image = food.gimage;
    const cartFood:CartItemData = {id,name,price,discount,image,count:1,goods:food}
    catItemList.push(cartFood)
  }
  AppStorage.set(CARTKEY,JSON.stringify(catItemList))
}
export const  DelCart = (id:number)=>{
  const json = AppStorage.Get<string>(CARTKEY) || '[]'
  let  cartItemlist = JSON.parse(json) as CartItemData[]
  const f = cartItemlist.find(item=>item.id === id)
  if(f && f.count>=1){
    f.count--
    if(f.count == 0){
       cartItemlist = cartItemlist.filter(item=>item!==f)
    }
  }
  AppStorage.set(CARTKEY,JSON.stringify(cartItemlist))
}
export const   ClearCart = ()=>{
  AppStorage.set(CARTKEY,'[]')
}

export interface IGlobalStore {
  onBuy?: (shopPage:ShopPage) => void;
}

export const GlobalStore: IGlobalStore = {};