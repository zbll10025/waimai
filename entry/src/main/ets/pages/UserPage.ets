import { UserHeader } from '../component/UserPage/UserHeader'
import { UserMenu } from '../component/UserPage/UserMenu'
import { AboutPage } from '../component/UserPage/AboutPage'
import { AccountSecurityPage } from "../component/UserPage/AccountSecurityPage"
import { AddressPage } from "../component/UserPage/AddressPage"
@Preview
@Component
export struct UserPage {
  @State isRefreshing: boolean = false
  @Provide navStack: NavPathStack = new NavPathStack()

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
      Refresh({ refreshing: $$this.isRefreshing, offset: 30, friction: 70 }) {
        Scroll() {
          Column() {
            // 用户头部信息
            UserHeader()

            // 用户功能菜单
            UserMenu()
          }
          .width('100%')
          .backgroundColor('#F5F5F5')
        }
        .width('100%')
        .height('100%')
        .scrollBar(BarState.Auto)
      }
      .onStateChange((refreshStatus: RefreshStatus) => {
        if (refreshStatus == RefreshStatus.Refresh) {
          // 刷新用户数据
          this.refreshUserData()
        }
      })
      .onRefreshing(() => {
        this.refreshUserData()
      })
    }
    .navDestination(this.PageMap)
    .mode(NavigationMode.Stack)
    .hideTitleBar(true)
  }


  private refreshUserData() {
    setTimeout(() => {
      this.isRefreshing = false
    }, 1000)
  }
}
