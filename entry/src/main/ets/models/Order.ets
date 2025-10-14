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
  id:number = -1
  food?: Goods
  price:number = 0
  count:number = 1
}

export class Order {
  id?:number = -1
  shopName?:string = ""
  shopImage?:ResourceStr = $r('app.media.shop1')
  title?:string = "" // 订单名字（可显示第一个商品名+等）
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
  if (partial.id !== undefined) { o.id = partial.id }
  if (partial.shopName !== undefined) { o.shopName = partial.shopName }
  if (partial.shopImage !== undefined) { o.shopImage = partial.shopImage }
  if (partial.title !== undefined) { o.title = partial.title }
  if (partial.status !== undefined) { o.status = partial.status }
  if (partial.items !== undefined) { o.items = partial.items }
  return o
}

export const mockOrders:Order[] = [
  buildOrder({
    id: 1001,
    shopName: "重庆鸡公煲",
    shopImage: $r('app.media.shop1'),
    title: "招牌炒鸡+火锅面+米饭",
    status: OrderStatus.Completed,
    items: [
      { id: 1, price: 19.88, count: 1, food: { id: 1, name: "招牌炒鸡", price: 19.88, image: $r('app.media.food1') } as Goods }
    ]
  }),
  buildOrder({
    id: 1002,
    shopName: "原味汤粉王",
    shopImage: $r('app.media.shop1'),
    title: "招牌汤粉(大份)",
    status: OrderStatus.Delivering,
    items: [
      { id: 2, price: 25.5, count: 2, food: { id: 2, name: "汤粉", price: 12.75, image: $r('app.media.food1') } as Goods }
    ]
  }),
  buildOrder({
    id: 1003,
    shopName: "粥道",
    shopImage: $r('app.media.shop1'),
    title: "皮蛋瘦肉粥",
    status: OrderStatus.Paid,
    items: [
      { id: 3, price: 9.9, count: 3, food: { id: 3, name: "皮蛋瘦肉粥", price: 9.9, image: $r('app.media.food1') } as Goods }
    ]
  }),
  buildOrder({
    id: 1004,
    shopName: "吉发瓦香鸡",
    shopImage: $r('app.media.shop1'),
    title: "瓦香鸡+米饭",
    status: OrderStatus.Created,
    items: [
      { id: 4, price: 29.9, count: 1, food: { id: 4, name: "瓦香鸡", price: 29.9, image: $r('app.media.food1') } as Goods }
    ]
  })
]


