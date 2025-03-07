import router from '@ohos.router'

@Entry
@Component
export default struct UserProfile {
  @State userName: string = "小小游龙"
  @State userEmail: string = "2561889884@qq.com"
  @State userPhone: string = "15655551005"
  @State userAvatar: Resource = $r('app.media.test')
  @State userBio: string = "热衷于HarmonyOS开发，智能校园系统与AIoT创新"
  @State campusID: string = "F23011126"
  @State major: string = "计算机科学与技术"
  @State dormitory: string = "6号楼 666室"
  @State libraryStatus: string = "当前借阅 2 本 | 已预约 1 本"
  @State courseSchedule: string = "OpenHarmony软硬协同 | 18:40 - 20:10 | 12-706"
  @State campusCardBalance: string = "余额: ¥58.30"


  build() {
    Column() {
      Column() {

        Image(this.userAvatar)
          .width(100)
          .height(100)
          .borderRadius(50)
          .margin({ bottom: 10 })


        Text(this.userName)
          .fontSize("24fp")
          .fontWeight(FontWeight.Bold)
          .fontColor("#FFFFFF")
          .margin({ bottom: 5 })

        Text(this.userBio)
          .fontSize("16fp")
          .fontColor("#FFFFFF")
      }
      .width("100%")
      .height(200)
      .backgroundColor("#3498DB")
      .borderRadius(15)
      .padding(5)
      .alignItems(HorizontalAlign.Center)

      // 个人智慧校园信息
      Column(){


        Row (){
          Text(`🎓 学号: ${this.campusID}`)
            .fontSize("18fp")
              .fontColor("#333333")

        }
        .margin({bottom:10})

        Row() {
          Text(`📚 专业: ${this.major}`)
            .fontSize("18fp")
              .fontColor("#333333")

        }
        .margin({bottom:10})

        Row() {
          Text(`🏠 宿舍: ${this.dormitory}`)
            .fontSize("18fp")
              .fontColor("#333333")

        }
        .margin({bottom:10})

        Row() {
          Text(`📖 图书馆: ${this.libraryStatus}`)
            .fontSize("18fp")
              .fontColor("#333333")

        }
        .margin({bottom:10})

        Column() {
          Text("📅 课程安排: ")
            .fontSize("18fp")
            .fontColor("#333333")
        }
        Column() {
          Text(this.courseSchedule)
            .fontSize("16fp")
              .fontColor("#333333")
        }
        .margin({bottom:5})

        Row() {
          Text(`💳 校园卡: ${this.campusCardBalance}`)
            .fontSize("18fp")
              .fontColor("#333333")

        }
      }
      .width("100%")
      .backgroundColor("#FFFFFF")
      .borderRadius(15)
      .padding(15)
      .margin({top:15})
      .shadow(3)

      // 个人信息
        Row() {
          Image($r('app.media.email'))
            .width(24)
            .height(24)
            .margin({ right: 10 })

          Text(this.userEmail)
            .fontSize("18fp")
            .fontColor("#333333")
        }
        .width("100%")
        .backgroundColor("#FFFFFF")
        .borderRadius(15)
        .padding(15)
        .margin({ top: 5 })
        .shadow(3)

      Row() {
          Image($r('app.media.phone'))
            .width(24)
            .height(24)
            .margin({ right: 10 })

          Text(this.userPhone)
            .fontSize("18fp")
            .fontColor("#333333")
        }
        .width("100%")
        .backgroundColor("#FFFFFF")
        .borderRadius(15)
        .padding(15)
        .margin({ top: 5 })
        .shadow(3)


        Column() {


          Button("编辑资料")
            .width("80%")
            .height(50)
            .backgroundColor("#2ECC71")
            .fontColor("#FFFFFF")
            .fontSize("18fp")
            .borderRadius(10)
            .onClick(() => {
              console.info("编辑资料按钮点击")
            })
            .margin({ bottom: 15 })

          Button("退出登录")
            .width("80%")
            .height(50)
            .backgroundColor("#E74C3C")
            .fontColor("#FFFFFF")
            .fontSize("18fp")
            .borderRadius(10)
            .onClick(() => {
              console.info("退出登录按钮点击")
            })

        }
        .width("100%")
        .margin({ top: 20 })
         .alignItems(HorizontalAlign.Center)

    }
  }
}