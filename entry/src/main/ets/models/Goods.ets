export class Goods{
  gid:number = -1
  cid?:number = -1
  gname?:string = ""
  gimage?:ResourceStr = $r('app.media.food1')
  price:number = 0
  content?:string
  remark?:string
  discount?:number
  type?:string
  shopName?:string
  url?:string
  monthSale?:number
  zhekou?: string
}

export const GoodsDefault: Goods = new Goods()