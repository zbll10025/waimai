import { Goods } from "./Goods"
import { Shop } from "./Shop"

export enum OrderStatus {
  Created = 0,       // 已下单/待支付
  Paid = 1,          // 已支付/制作中
  Delivering = 2,    // 配送中
  Completed = 3,     // 已完成
  Cancelled = 4      // 已取消
}

export class OrderItem {
  bid:number = -1
  food?: Goods
  price:number = 0
  count:number = 1
}

export class Order {
  bid?:number = -1
  sname?:string = ""
  simgStr?:ResourceStr = $r('app.media.shop1')
  gname?:string = ""
  status?:OrderStatus = OrderStatus.Created
  items:OrderItem[] = []
  get totalPrice():number {
    let s = 0
    this.items.forEach(i=>{ s += (i.price || 0) * (i.count || 0) })
    return Number(s.toFixed(2))
  }
  get totalCount():number {
    let c = 0
    this.items.forEach(i=>{ c += (i.count || 0) })
    return c
  }
}

function buildOrder(partial: Partial<Order>): Order {
  const o = new Order()
  if (partial.bid !== undefined) { o.bid = partial.bid }
  if (partial.sname !== undefined) { o.sname = partial.sname }
  if (partial.simgStr !== undefined) { o.simgStr = partial.simgStr }
  if (partial.gname !== undefined) { o.gname = partial.gname }
  if (partial.status !== undefined) { o.status = partial.status }
  if (partial.items !== undefined) { o.items = partial.items }
  return o
}

export const mockOrders:Order[] = [
  buildOrder({
    bid: 1001,
    sname: "重庆鸡公煲",
    simgStr: $r('app.media.shop1'),
    gname: "招牌炒鸡+火锅面+米饭",
    status: OrderStatus.Completed,
    items: [
      { bid: 1, price: 19.88, count: 1, food: { gid: 1, gname: "招牌炒鸡", price: 19.88, gimage: $r('app.media.food1') } as Goods }
    ]
  }),
  buildOrder({
    bid: 1002,
    sname: "原味汤粉王",
    simgStr: $r('app.media.shop1'),
    gname: "招牌汤粉(大份)",
    status: OrderStatus.Delivering,
    items: [
      { bid: 2, price: 25.5, count: 2, food: { gid: 2, gname: "汤粉", price: 12.75, gimage: $r('app.media.food1') } as Goods }
    ]
  }),
  buildOrder({
    bid: 1003,
    sname: "粥道",
    simgStr: $r('app.media.shop1'),
    gname: "皮蛋瘦肉粥",
    status: OrderStatus.Paid,
    items: [
      { bid: 3, price: 9.9, count: 3, food: { gid: 3, gname: "皮蛋瘦肉粥", price: 9.9, gimage: $r('app.media.food1') } as Goods }
    ]
  }),
  buildOrder({
    bid: 1004,
    sname: "吉发瓦香鸡",
    simgStr: $r('app.media.shop1'),
    gname: "瓦香鸡+米饭",
    status: OrderStatus.Created,
    items: [
      { bid: 4, price: 29.9, count: 1, food: { gid: 4, gname: "瓦香鸡", price: 29.9, gimage: $r('app.media.food1') } as Goods }
    ]
  })
]


