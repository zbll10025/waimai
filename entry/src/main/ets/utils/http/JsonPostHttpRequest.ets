import { IHttpListener } from './interface/IHttpListener';
import { IHttpRequest } from './interface/IHttpRequest';
import { http } from '@kit.NetworkKit';
import { HttpUtil } from './HttpUtil';

export class JsonPostHttpRequest implements IHttpRequest {
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
      httpRequest.request(
        this.url,
        {
          method: http.RequestMethod.POST,
          connectTimeout: 60000,
          readTimeout: 60000,
          expectDataType: http.HttpDataType.STRING,
          usingCache: false,
          priority: 1,
          usingProtocol: http.HttpProtocol.HTTP1_1,
          usingProxy: false,
          header: {
            'Content-Type': 'application/json'
          },
          // send JSON body
          extraData: this.param
        }
      ).then((data) => {
        HttpUtil.log(`POST ${this.url} -> code=${data.responseCode}`);
        HttpUtil.log(`POST result=${data.result?.toString()}`);
        if (data.responseCode == http.ResponseCode.OK) {
          this.httpListener?.onSuccess(data.result?.toString())
          resolve();
        } else {
          HttpUtil.log(`POST failure, code=${data.responseCode}`);
          this.httpListener?.onFailure();
          reject();
        }
      }).catch((err:string) => {
        HttpUtil.log(`POST error: ${JSON.stringify(err)}`);
        this.httpListener?.onFailure();
        reject();      })
    })
  }

  setListener(listener: IHttpListener): void {
    this.httpListener = listener;
  }
}


