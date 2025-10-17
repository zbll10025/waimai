import { Address } from '../../models/Address';
import { AxiosUtil } from '../../utils/network/HttpUtils';
import { promptAction } from '@kit.ArkUI';
import { ID } from '../../pages/LoginPage';

@Component
export struct AddressPage {
  @StorageProp(ID) userid: string = '';
  @State addressList: Address[] = [];
  @State showAddDialog: boolean = false;
  @State showEditDialog: boolean = false;
  @State editingAddress: Address = new Address();
  @State newAddressText: string = '';

  aboutToAppear() {
    this.loadAddressList();
  }

  // 加载地址列表
  async loadAddressList() {
    let res = await AxiosUtil.get<Address[]>("addresses/user/"+this.userid)
    if(res.status === 200){
      this.addressList = res.data
    }else{
      promptAction.showToast({ message: res.statusText })
    }
  }

  // 添加新地址
  async  addAddress() {
    if (this.newAddressText.trim().length > 0) {
      const newAddress = new Address();
      newAddress.address = this.newAddressText.trim();
      newAddress.uid = parseInt(this.userid);

      let res = await AxiosUtil.post<string>("addresses",newAddress)
      if(res.status === 200){
        promptAction.showToast({ message: res.data })
      }
      else {
        promptAction.showToast({ message: res.statusText })
      }
      this.addressList.push(newAddress);
      this.newAddressText = '';
      this.showAddDialog = false;
    }
  }

  // 编辑地址
  editAddress(address: Address) {
    // 创建地址对象的副本，避免直接引用
    this.editingAddress = address
    this.showEditDialog = true;
  }

  // 保存编辑
  async saveEdit() {
    if (this.editingAddress.address.trim().length > 0) {

      let res = await AxiosUtil.put<string>("addresses/"+this.editingAddress.aid,this.editingAddress)

      if(res.status === 200){
        promptAction.showToast({ message: res.data })
        // 重新加载地址列表确保UI更新
        await this.loadAddressList();
        this.showEditDialog = false;
      }
      else {
        promptAction.showToast({ message: res.statusText })
      }
    }
  }

  // 删除地址
  deleteAddress(address: Address) {
     AlertDialog.show({
      title: '确认删除',
      message: '确定要删除这个地址吗？',
      primaryButton: {
        value: '取消',
        action: () => {}
      },
      secondaryButton: {
        value: '删除',
        fontColor: '#FF4444',
        action:async  () => {

          let res = await AxiosUtil.delete<string>("addresses/"+address.aid)
          if(res.status === 200){
            promptAction.showToast({ message: res.data })
          }
          else {
            promptAction.showToast({ message: res.statusText })
          }

          this.addressList = this.addressList.filter(item => item.aid !== address.aid);
        }
      }
    });
  }

  build() {
    NavDestination() {
        Column() {
          // 标题区域
          Column() {
            Text('收货地址')
              .fontSize(22)
              .fontWeight(600)
              .fontColor('#333333')

            Text('在这里管理您的收货地址')
              .fontSize(16)
              .fontColor('#666666')
              .margin({ top: 6 })
          }
          .width('100%')
          .padding({
            left: 16,
            right: 16,
            top: 16,
            bottom: 16
          })
          .backgroundColor('#FFFFFF')
          .borderRadius(12)

          // 地址列表
          if (this.addressList.length > 0) {
            Scroll() {
                List() {
                  ForEach(this.addressList, (address: Address, index: number) => {
                    ListItem() {
                      this.AddressItem(address, index)

                    }
                  }, (address: Address) => address.address)
                }
                .width('100%')
                .margin({ top: 16 })
                .padding({ left: 16, right: 16 })
            }
            .width('100%')
            .height(475)
            .scrollBar(BarState.Auto)
            .margin({bottom:30})

          } else {
            // 空状态
            Column() {
              Image($r('app.media.address'))
                .width(80)
                .height(80)
                .opacity(0.5)

              Text('暂无收货地址')
                .fontSize(16)
                .fontColor('#999999')
                .margin({ top: 16 })

              Text('点击下方按钮添加您的收货地址')
                .fontSize(14)
                .fontColor('#CCCCCC')
                .margin({ top: 8 })
            }
            .width('100%')
            .height(425)
            .justifyContent(FlexAlign.Center)
            .margin({ top: 50,bottom:30 })
          }
          // 添加地址按钮
          Button('+ 添加新地址')
            .width('100%')
            .height(50)
            .fontSize(16)
            .fontColor('#FFFFFF')
            .backgroundColor('#FF6B35')
            .borderRadius(25)
            .margin({
              left: 16,
              right: 16,
              top: 20,
              bottom: 20
            })
            .onClick(() => {
              console.info('添加地址按钮被点击');
              this.showAddDialog = true;
              console.info('showAddDialog状态:', this.showAddDialog);
            })
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F5F5')

      // 添加地址对话框
      if (this.showAddDialog) {
        this.AddAddressDialog()
      }

      // 编辑地址对话框
      if (this.showEditDialog) {
        this.EditAddressDialog()
      }
    }
  }

  // 地址项组件
  @Builder
  AddressItem(address: Address, index: number) {
    Column() {
      Row() {
        Column() {

          Text(address.address)
            .fontSize(16)
            .fontColor('#333333')
            .textAlign(TextAlign.Start)
            .maxLines(3)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('100%')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        Column() {
          Button('编辑')
            .fontSize(12)
            .fontColor('#FF6B35')
            .backgroundColor('#FFF5F0')
            .borderRadius(15)
            .padding({ left: 12, right: 12, top: 6, bottom: 6 })
            .onClick(() => {
              this.editAddress(address);
            })

          Button('删除')
            .fontSize(12)
            .fontColor('#FF4444')
            .backgroundColor('#FFF0F0')
            .borderRadius(15)
            .padding({ left: 12, right: 12, top: 6, bottom: 6 })
            .margin({ top: 8 })
            .onClick(() => {
              this.deleteAddress(address);
            })
        }
        .alignItems(HorizontalAlign.End)
      }
      .width('100%')
      .padding({
        left: 16,
        right: 16,
        top: 16,
        bottom: 16
      })
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ bottom: 12 })
  }

  // 添加地址对话框
  @Builder
  AddAddressDialog() {
    Column() {
      Column() {
        Text('添加新地址')
          .fontSize(18)
          .fontWeight(600)
          .fontColor('#333333')
          .margin({ bottom: 20 })

        TextArea({ placeholder: '请输入详细地址信息' })
          .width('100%')
          .height(120)
          .fontSize(16)
          .borderRadius(8)
          .backgroundColor('#F8F8F8')
          .onChange((value: string) => {
            this.newAddressText = value;
          })

        Row() {
          Button('取消')
            .fontSize(16)
            .fontColor('#666666')
            .backgroundColor('#F0F0F0')
            .borderRadius(20)
            .padding({ left: 30, right: 30, top: 12, bottom: 12 })
            .onClick(() => {
              this.showAddDialog = false;
              this.newAddressText = '';
            })

          Button('确定')
            .fontSize(16)
            .fontColor('#FFFFFF')
            .backgroundColor('#FF6B35')
            .borderRadius(20)
            .padding({ left: 30, right: 30, top: 12, bottom: 12 })
            .margin({ left: 16 })
            .onClick(() => {
              this.addAddress();
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.End)
        .margin({ top: 20 })
      }
      .width('100%')
      .padding(20)
      .backgroundColor('#FFFFFF')
      .borderRadius(16)
      .margin({ left: 20, right: 20 })
      .onClick(() => {
        // 阻止事件冒泡，防止点击对话框内容时关闭对话框
      })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('rgba(0,0,0,0.5)')
    .position({ x: 0, y: 0 })
    .zIndex(999)
    .onClick(() => {
      this.showAddDialog = false;
    })
  }

  // 编辑地址对话框
  @Builder
  EditAddressDialog() {
    Column() {
      Column() {
        Text('编辑地址')
          .fontSize(18)
          .fontWeight(600)
          .fontColor('#333333')
          .margin({ bottom: 20 })

        TextArea({ text: this.editingAddress.address })
          .width('100%')
          .height(120)
          .fontSize(16)
          .borderRadius(8)
          .backgroundColor('#F8F8F8')
          .onChange((value: string) => {
            this.editingAddress.address = value;
          })

        Row() {
          Button('取消')
            .fontSize(16)
            .fontColor('#666666')
            .backgroundColor('#F0F0F0')
            .borderRadius(20)
            .padding({ left: 30, right: 30, top: 12, bottom: 12 })
            .onClick(() => {
              this.showEditDialog = false;
            })

          Button('保存')
            .fontSize(16)
            .fontColor('#FFFFFF')
            .backgroundColor('#FF6B35')
            .borderRadius(20)
            .padding({ left: 30, right: 30, top: 12, bottom: 12 })
            .margin({ left: 16 })
            .onClick(() => {
              this.saveEdit();
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.End)
        .margin({ top: 20 })
      }
      .width('100%')
      .padding(20)
      .backgroundColor('#FFFFFF')
      .borderRadius(16)
      .margin({ left: 20, right: 20 })
      .onClick(() => {
        // 阻止事件冒泡，防止点击对话框内容时关闭对话框
      })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('rgba(0,0,0,0.5)')
    .position({ x: 0, y: 0 })
    .zIndex(999)
    .onClick(() => {
      this.showEditDialog = false;
    })
  }
}


