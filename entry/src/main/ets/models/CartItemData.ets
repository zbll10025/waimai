import { Goods } from "./Goods"

export  class CartItemData{
  id:number =-1
  image?:ResourceStr
  name?:string
  count:number = 1
  price?:number
  discount?:number =0.1
  goods?:Goods
}