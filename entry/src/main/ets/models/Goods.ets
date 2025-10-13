export class Goods{
  id:number = -1
  name:string = ""
  image?:ResourceStr = $r('app.media.food1')
  price:number = 0
  content?:string
  remark?:string
  discount?:number
  type?:string
  shopName?:string
  url?:string
  month_sale?:number
  zhekou?: string
}

