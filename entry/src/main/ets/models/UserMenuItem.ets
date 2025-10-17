
export class  MenuItem {
  icon?: Resource;       // 图标资源
  title?: string;        // 标题
  subtitle?: string;    // 副标题（可选）
  showArrow?: boolean;   // 是否显示
  name:string = ""  // 路由名称
}
export const menuArray: Array<MenuItem> = [
  {
    icon: $r('app.media.address'),
    title: '收货地址',
    subtitle: '管理收货地址',
    showArrow: true,
    name:"AddressPage"
  },
  {
    icon: $r('app.media.address'),
    title: '账户与安全',
    subtitle: '密码、手机号',
    showArrow: true,
    name:"AccountSecurityPage"
  },
  {
    icon: $r('app.media.address'),
    title: '关于我们',
    subtitle: '版本信息',
    showArrow: true,
    name:"AboutPage"
  }
]