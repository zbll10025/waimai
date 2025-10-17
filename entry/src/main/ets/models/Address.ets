/**
 * 地址数据模型
 */
export class Address {
  aid?: number = 0;        // 地址ID
  address: string = '';   // 地址内容
  uid: number = 0;        // 用户ID

  constructor(aid: number = 0, address: string = '', uid: number = 0) {
    this.aid = aid;
    this.address = address;
    this.uid = uid;
  }
}
