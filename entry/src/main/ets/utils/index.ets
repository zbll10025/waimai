import { Goods } from "../models/Goods"
import { JSON } from "@kit.ArkTS"
import { CartItemData } from "../models/CartItemData"

export const KEY = 'cart_key'

export const AddCart = (food:Goods)=>{
  const json = AppStorage.Get<string>(KEY) || '[]'
  let  catItemList = JSON.parse(json) as CartItemData[]
  let  f = catItemList.find(item=>item.id ===food.id)
  if(f){
    f.count++
  }else{
    const id = food.id;
    const name = food.name;
    const price = food.price;
    const discount = food.discount;
    const image = food.image;
    const cartFood:CartItemData = {id,name,price,discount,image,count:1,goods:food}
    catItemList.push(cartFood)
  }
  AppStorage.set(KEY,JSON.stringify(catItemList))
}
export const  DelCart = (id:number)=>{
  const json = AppStorage.Get<string>(KEY) || '[]'
  let  cartItemlist = JSON.parse(json) as CartItemData[]
  const f = cartItemlist.find(item=>item.id === id)
  if(f && f.count>=1){
    f.count--
    if(f.count == 0){
       cartItemlist = cartItemlist.filter(item=>item!==f)
    }
  }
  AppStorage.set(KEY,JSON.stringify(cartItemlist))
}
export const   ClearCart = ()=>{
  AppStorage.set(KEY,'[]')
}

export interface IGlobalStore {
  onBuy?: () => void;
}

export const GlobalStore: IGlobalStore = {};