import { Goods } from "./Goods"
import { Shop } from "./Shop"

export enum OrderStatus {
  Created = 0,       // 已下单/待支付
  Paid = 1,          // 已支付/制作中
  Delivering = 2,    // 配送中
  Completed = 3,     // 已完成
  Cancelled = 4      // 已取消
}

// 扁平化的订单记录：一个用户的某次购买（Bill+Goods+Shop）
export class Order {
  // Bill 字段
  bid:number = -1
  gid:number = -1
  time:string = "" // 购买时间（ISO 字符串）
  cost:number = 0   // 本条商品购买总价（与 bill.cost 一致）
  gcount:number = 1 // 购买数量
  billstate:number = OrderStatus.Created // 账单状态

  // Goods 与 Shop 展示字段
  food?: Goods       // 购买的商品对象（至少包含 gid, gname, gimage, price）
  sname:string = ""  // 商店名称
  simgStr:ResourceStr = $r('app.media.shop1') // 商店图片

  // 派生：UI 使用的枚举状态
  get status():OrderStatus { return this.billstate as OrderStatus }
}

function buildOrder(partial: Partial<Order>): Order {
  const o = new Order()
  if (partial.bid !== undefined) { o.bid = partial.bid }
  if (partial.gid !== undefined) { o.gid = partial.gid }
  if (partial.time !== undefined) { o.time = partial.time }
  if (partial.cost !== undefined) { o.cost = partial.cost }
  if (partial.gcount !== undefined) { o.gcount = partial.gcount }
  if (partial.billstate !== undefined) { o.billstate = partial.billstate }
  if (partial.food !== undefined) { o.food = partial.food }
  if (partial.sname !== undefined) { o.sname = partial.sname }
  if (partial.simgStr !== undefined) { o.simgStr = partial.simgStr }
  return o
}

export const mockOrders:Order[] = [
  buildOrder({
    bid: 1004, gid: 4, time: "2025-10-16T10:05:00Z", cost: 29.90, gcount: 1, billstate: OrderStatus.Created,
    sname: "吉发瓦香鸡", simgStr: $r('app.media.shop1'),
    food: { gid: 4, gname: "瓦香鸡", price: 29.90, gimage: $r('app.media.food1') } as Goods
  }),
  buildOrder({
    bid: 1002, gid: 2, time: "2025-10-16T09:30:00Z", cost: 25.50, gcount: 2, billstate: OrderStatus.Delivering,
    sname: "原味汤粉王", simgStr: $r('app.media.shop1'),
    food: { gid: 2, gname: "汤粉(大份)", price: 12.75, gimage: $r('app.media.food1') } as Goods
  }),
  buildOrder({
    bid: 1003, gid: 3, time: "2025-10-16T08:15:00Z", cost: 29.70, gcount: 3, billstate: OrderStatus.Paid,
    sname: "粥道", simgStr: $r('app.media.shop1'),
    food: { gid: 3, gname: "皮蛋瘦肉粥", price: 9.90, gimage: $r('app.media.food1') } as Goods
  }),
  buildOrder({
    bid: 1001, gid: 1, time: "2025-10-15T20:00:00Z", cost: 19.88, gcount: 1, billstate: OrderStatus.Completed,
    sname: "重庆鸡公煲", simgStr: $r('app.media.shop1'),
    food: { gid: 1, gname: "招牌炒鸡", price: 19.88, gimage: $r('app.media.food1') } as Goods
  })
]


