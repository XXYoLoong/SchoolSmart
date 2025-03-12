import router from '@ohos.router';
import prompt from '@system.prompt';

@Entry
@Component
struct LoginPage {
  private username: string = '';
  private password: string = '';
  private userType: string = '';

  login() {
    // 模拟身份验证 (实际应用应使用后端 API 进行验证)
    if (this.username === 'student' && this.password === '123456') {
      this.userType = 'student';
    } else if (this.username === 'teacher' && this.password === 'admin123') {
      this.userType = 'teacher';
    } else {
      prompt.showToast({ message: '用户名或密码错误' });
      return;
    }

    // 根据角色跳转至相应主页
    if (this.userType === 'student') {
      router.pushUrl({ url: '/OldIndex' });
    } else {
      router.pushUrl({ url: '/teacherHome' });
    }
  }

  build() {
    Column({ space: 20 }) {
      Text('智慧校园系统')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .padding(20)

      TextInput({ placeholder: '请输入用户名', text: this.username })
        .onChange((value) => this.username = value)
        .width('80%')
        .height(50)
        .margin({ top: 10 })
        .borderRadius(8)

      TextInput({ placeholder: '请输入密码', text: this.password })
        .type(InputType.Password)
        .onChange((value) => this.password = value)
        .width('80%')
        .height(50)
        .margin({ top: 10 })
        .borderRadius(8)

      Button('登录')
        .onClick(() => this.login())
        .width('80%')
        .height(50)
        .backgroundColor('#007DFF')
        .borderRadius(8)
        .fontColor('#FFFFFF')
        .margin({ top: 10 });
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .height('100%')
  }
}
