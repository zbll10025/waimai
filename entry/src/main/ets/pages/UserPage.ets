import { UserHeader } from '../component/UserPage/UserHeader'
import { UserMenu } from '../component/UserPage/UserMenu'
import { AboutPage } from '../component/UserPage/AboutPage'
import { AccountSecurityPage } from "../component/UserPage/AccountSecurityPage"
import { AddressPage } from "../component/UserPage/AddressPage"
import { ID } from './LoginPage'
import { AxiosUtil } from '../utils/network/HttpUtils'

@Preview
@Component
export struct UserPage {
  @Provide navStack: NavPathStack = new NavPathStack()
  @State isLogin : boolean = false
  @StorageProp(ID) userid: string = '';
  @Builder
  PageMap(name: string) {
    if (name === 'AboutPage') {
      AboutPage()
    }else if (name === "AccountSecurityPage")
    {
      AccountSecurityPage()
    }else{
      AddressPage()
    }
  }

  build() {
    Navigation(this.navStack) {
      Column() {
        // 用户头部信息
        UserHeader({ isLogin: this.isLogin })

        // 用户功能菜单
        UserMenu({ isLogin: this.isLogin })
      }
      .width('100%')
      .backgroundColor('#F5F5F5')
    }
    .navDestination(this.PageMap)
    .mode(NavigationMode.Stack)
    .hideTitleBar(true)
  }

  aboutToAppear() {
    // 页面加载时检查是否已经登录
    this.checkAutoLogin()
  }

  private checkAutoLogin()
  {
    if (this.userid !== '-1') {
      this.isLogin = true
    }else {
      this.isLogin = false
    }
  }
}
