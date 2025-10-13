export class TabBarItem{
  index:number = 0
  title: string = ""
  icon_selected:Resource = $r('app.media.tabbar1s')
  icon_normal:Resource = $r('app.media.tabbar1')
}

export const tabBarItemList: TabBarItem[] = [
  {
    index:0,
    title:'首页',
    icon_selected:$r('app.media.tabbar1s'),
    icon_normal:$r('app.media.tabbar1')
  },
  {
    index:1,
    title:'订单',
    icon_selected:$r('app.media.tabbar2s'),
    icon_normal:$r('app.media.tabbar2')
  },
  {
    index:2,
    title:'我的',
    icon_selected:$r('app.media.tabbar3s'),
    icon_normal:$r('app.media.tabbar3')
  }
]


