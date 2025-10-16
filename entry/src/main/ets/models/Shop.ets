import { Category } from "./Category"

export class Shop{
  sid:number =-1
  simgStr:ResourceStr = $r('app.media.shop1')
  sname:string = ""
  scroce:string = ""
  salesVolums:number = 0
  content:string = ""
  stelePhone?:string
  saddress?:string
}

export const shopList:Shop[] =[
  {
    sid:0,
    simgStr:$r('app.media.shop1'),
    sname:"铜炉火锅鸡",
    scroce:"4.9分",
    salesVolums:60,
    content:"四样美味俱全"
  },
  {
    sid:1,
    simgStr:$r('app.media.shop1'),
    sname:"原味汤粉王",
    scroce:"4.9分",
    salesVolums:60,
    content:"四样美味俱全"
  },
  {
    sid:2,
    simgStr:$r('app.media.shop1'),
    sname:"粥道",
    scroce:"4.9分",
    salesVolums:60,
    content:"四样美味俱全"
  },
  {
    sid:3,
    simgStr:$r('app.media.shop1'),
    sname:"吉发瓦香鸡",
    scroce:"4.9分",
    salesVolums:60,
    content:"四样美味俱全"
  },
  {
    sid:4,
    simgStr:$r('app.media.shop1'),
    sname:"老上海馄饨铺",
    scroce:"4.9分",
    salesVolums:60,
    content:"四样美味俱全"
  },
]
export const  shopListUpDate:Shop[] = [
  {
    sid:5,
    simgStr:$r('app.media.shop2'),
    sname:"5",
    scroce:"4.9分",
    salesVolums:60,
    content:"四样美味俱全"
  },
  {
    sid:6,
    simgStr:$r('app.media.shop2'),
    sname:"6",
    scroce:"4.9分",
    salesVolums:60,
    content:"四样美味俱全"
  },
  {
    sid:7,
    simgStr:$r('app.media.shop2'),
    sname:"7",
    scroce:"4.9分",
    salesVolums:60,
    content:"四样美味俱全"
  },
  {
    sid:8,
    simgStr:$r('app.media.shop2'),
    sname:"8",
    scroce:"4.9分",
    salesVolums:60,
    content:"四样美味俱全"
  },
  {
    sid:9,
    simgStr:$r('app.media.shop2'),
    sname:"9",
    scroce:"4.9分",
    salesVolums:60,
    content:"四样美味俱全"
  },
]