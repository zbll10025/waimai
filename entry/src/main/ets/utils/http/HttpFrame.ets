import { HttpTask } from './HttpTask';
import { IDataListener } from './interface/IDataListener';
import { JsonHttpListener } from './JsonHttpListener';
import { JsonHttpRequest } from './JsonHttpRequest'
import { JsonPostHttpRequest } from './JsonPostHttpRequest'
import { TextHttpListener } from './TextHttpListener'
type JsonPrimitive = string | number | boolean | null;
type JsonBody = string | object | Array<JsonPrimitive | object>;
/**
 * Http 框架
 */
export class HttpFrame {
  /**
   * 发起请求
   * @param url
   * @param dataListener
   */
  static sendReq<T>(url: string, dataListener: IDataListener<T>){
    let jsonRequest = new JsonHttpRequest();
    let jsonHttpListener = new JsonHttpListener(dataListener);
    let task = new HttpTask(url, "", jsonRequest, jsonHttpListener);
    task.run()

  }

  /**
   * 发起POST请求
   * @param url 请求地址
   * @param body JSON字符串或JSON对象/数组
   * @param dataListener 数据回调
   */
  static sendPostReq<T>(url: string, body: JsonBody, dataListener: IDataListener<T>) {
    const jsonRequest = new JsonPostHttpRequest();
    const jsonHttpListener = new JsonHttpListener(dataListener);
    const requestData = typeof body === 'string' ? body : JSON.stringify(body);
    const task = new HttpTask(url, requestData, jsonRequest, jsonHttpListener);
    task.run();
  }

  /**
   * 发起POST请求(纯文本响应，不做JSON解析)
   */
  static sendPostTextReq(url: string, body: JsonBody, dataListener: IDataListener<string>) {
    const jsonRequest = new JsonPostHttpRequest();
    const textListener = new TextHttpListener(dataListener);
    const requestData = typeof body === 'string' ? body : JSON.stringify(body);
    const task = new HttpTask(url, requestData, jsonRequest, textListener);
    task.run();
  }
}