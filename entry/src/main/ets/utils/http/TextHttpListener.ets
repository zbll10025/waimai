import { IDataListener } from './interface/IDataListener';
import { IHttpListener } from './interface/IHttpListener';

export class TextHttpListener implements IHttpListener {
  private dataListener: IDataListener<string>;

  constructor(dataListener: IDataListener<string>) {
    this.dataListener = dataListener;
  }

  onSuccess(result: string): void {
    this.dataListener.onSuccess(result);
  }

  onFailure(): void {
    this.dataListener.onFailure();
  }
}


