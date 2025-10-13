import { Category } from "./Category"

export class Shop{
  id?:number
  image:ResourceStr = $r('app.media.shop1')
  name:string = ""
  score:string = ""
  salesVolume:number = 0
  content:string = ""
  categoryList?:Category[]
}
export const shopList:Shop[] =[
  {
    id:0,
    image:$r('app.media.shop1'),
    name:"铜炉火锅鸡",
    score:"4.9分",
    salesVolume:60,
    content:"四样美味俱全"
  },
  {
    id:1,
    image:$r('app.media.shop1'),
    name:"原味汤粉王",
    score:"4.9分",
    salesVolume:60,
    content:"四样美味俱全"
  },
  {
    id:2,
    image:$r('app.media.shop1'),
    name:"粥道",
    score:"4.9分",
    salesVolume:60,
    content:"四样美味俱全"
  },
  {
    id:3,
    image:$r('app.media.shop1'),
    name:"吉发瓦香鸡",
    score:"4.9分",
    salesVolume:60,
    content:"四样美味俱全"
  },
  {
    id:4,
    image:$r('app.media.shop1'),
    name:"老上海馄饨铺",
    score:"4.9分",
    salesVolume:60,
    content:"四样美味俱全"
  },
]
export const  shopListUpDate:Shop[] = [
  {
    id:5,
    image:$r('app.media.shop2'),
    name:"5",
    score:"4.9分",
    salesVolume:60,
    content:"四样美味俱全"
  },
  {
    id:6,
    image:$r('app.media.shop2'),
    name:"6",
    score:"4.9分",
    salesVolume:60,
    content:"四样美味俱全"
  },
  {
    id:7,
    image:$r('app.media.shop2'),
    name:"7",
    score:"4.9分",
    salesVolume:60,
    content:"四样美味俱全"
  },
  {
    id:8,
    image:$r('app.media.shop2'),
    name:"8",
    score:"4.9分",
    salesVolume:60,
    content:"四样美味俱全"
  },
  {
    id:9,
    image:$r('app.media.shop2'),
    name:"9",
    score:"4.9分",
    salesVolume:60,
    content:"四样美味俱全"
  },
]