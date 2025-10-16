import { IHttpListener } from './interface/IHttpListener';
import { IHttpRequest } from './interface/IHttpRequest';
import { http } from '@kit.NetworkKit';
import { HttpUtil } from './HttpUtil';

export class JsonPutHttpRequest implements IHttpRequest {
  private url: string = '';
  private param: string = '';
  private httpListener: IHttpListener | null = null;

  setUrl(url: string): void {
    this.url = url;
  }

  setParam(params: string): void {
    this.param = params;
  }

  execute(): Promise<void> {
    return new Promise<void>((resolve, reject) => {
      const httpRequest = http.createHttp();
      const options: http.HttpRequestOptions = {
        method: http.RequestMethod.PUT,
        connectTimeout: 60000,
        readTimeout: 60000,
        expectDataType: http.HttpDataType.STRING,
        usingCache: false,
        priority: 1,
        usingProtocol: http.HttpProtocol.HTTP1_1,
        usingProxy: false,
        header: { 'Content-Type': 'application/json' }
      };
      if (this.param && this.param.length > 0) {
        options.extraData = this.param;
      }
      httpRequest.request(this.url, options).then((data) => {
        HttpUtil.log(`PUT ${this.url} -> code=${data.responseCode}`);
        HttpUtil.log(`PUT result=${data.result?.toString()}`);
        if (data.responseCode == http.ResponseCode.OK) {
          this.httpListener?.onSuccess(data.result?.toString())
          resolve();
        } else {
          HttpUtil.log(`PUT failure, code=${data.responseCode}`);
          this.httpListener?.onFailure();
          reject();
        }
      }).catch((err:string) => {
        HttpUtil.log(`PUT error: ${JSON.stringify(err)}`);
        this.httpListener?.onFailure();
        reject();
      })
    })
  }

  setListener(listener: IHttpListener): void {
    this.httpListener = listener;
  }
}


