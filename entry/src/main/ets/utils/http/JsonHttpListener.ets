import { HttpUtil } from './HttpUtil';
import { IDataListener } from './interface/IDataListener';
import { IHttpListener } from './interface/IHttpListener';

export class JsonHttpListener<T> implements IHttpListener {

  private dataListener: IDataListener<T>;

  constructor(dataListener: IDataListener<T>) {
    this.dataListener = dataListener;
  }

  onSuccess(result: string): void {
    try {
      let obj: T = JSON.parse(result);
      this.dataListener.onSuccess(obj);
    } catch (_e) {
      HttpUtil.log(`POST error: ${result}`);
      // 非JSON或解析失败时，走失败回调，不再抛异常
      this.dataListener.onFailure();
    }
  }

  onFailure(): void {
    this.dataListener.onFailure();
  }
}