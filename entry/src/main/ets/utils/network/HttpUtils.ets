import axios,{InternalAxiosRequestConfig,AxiosError,AxiosResponse, Type} from '@ohos/axios'
import { Ip } from '../http';

//1.axios实例对象

export  const axiosInstance =axios.create({
  baseURL: Ip+"/api", //模拟的后端数据请求
  timeout: 10000, //请求超时时间，可选
  // headers: {'X-Custom-Header': 'foobar'} //请求头，可选
})

//2.添加请求拦截器,在请求发送前对配置进行统一处理
axiosInstance.interceptors.request.use((config:InternalAxiosRequestConfig) => {
  // 对请求数据做点什么

  return config;
}, (error:AxiosError) => {
  // 对请求错误做些什么
  return Promise.reject(error);
});

export type  ResType<T> =AxiosResponse<T>

//3.添加响应拦截器,统一处理响应数据和错误
axiosInstance.interceptors.response.use((response:AxiosResponse)=> {

  // 对响应数据做点什么
  return response;
}, (error:AxiosError)=> {
  // 对响应错误做点什么
  return Promise.reject(error);
});

//4.封装并导出自定义请求
export class AxiosUtil{
  static get<T>(url:string,params?:object):Promise<ResType<T>>{
    return axiosInstance.get<null,ResType<T>>(url,{params})
  }
  static  post<T>(url:string,data?:object):Promise<ResType<T>>{
    return axiosInstance.post<null,ResType<T>>(url,data)
  }
  static  put<T>(url:string,data?:object):Promise<ResType<T>>{
    return axiosInstance.put<null,ResType<T>>(url,data)
  }
  static  delete<T>(url:string,data?:object):Promise<ResType<T>>{
    return axiosInstance.delete<null,ResType<T>>(url,data)
  }
}
 
 