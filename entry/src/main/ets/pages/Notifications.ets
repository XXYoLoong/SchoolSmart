import router from '@ohos.router'

interface announcements{
  title: string; date: string; description: string
}

interface events{
  title: string; date: string; location: string; isRegistered: boolean; isCheckedIn: boolean
}

@Entry
@Component
export default struct Notificationse {
  @State announcement: announcements[] = [
    { title: "校园网络升级维护通知", date: "2025-03-10", description: "全校网络将在3月10日凌晨进行升级维护，预计2小时，请提前做好准备。" },
    { title: "春季运动会报名开始", date: "2025-03-15", description: "春季运动会即将开始，欢迎同学们踊跃报名，截止日期3月20日。" },
    { title: "2025年校企合作招聘会", date: "2025-04-05", description: "校企合作招聘会将在4月5日举行，提供大量实习与就业机会，敬请关注。" }
  ]

  @State event: events[] = [
    { title: "AI前沿技术讲座", date: "2025-03-12", location: "学术报告厅", isRegistered: false, isCheckedIn: false },
    { title: "校园环保志愿者活动", date: "2025-03-18", location: "校园主广场", isRegistered: true, isCheckedIn: false },
    { title: "计算机科学竞赛", date: "2025-04-02", location: "信息学院A201", isRegistered: true, isCheckedIn: true }
  ]

  build() {
    Scroll(){
      Column() {

        Row(){
          Image($r('app.media.back_left'))
            .width("20%")
            .height("30vp")
              //  .backgroundColor("#E74C3C")
            .onClick(() => { router.back() })

          Text("📢 校园公告 & 活动")
            .width("100%")
            .textAlign(TextAlign.Center)
            .fontSize("24fp")
            .fontWeight(FontWeight.Bold)
            .margin({bottom:10})
        }


        // 公告列表
        Column() {
          Text("📜 最新公告")
            .fontSize("20fp")
            .fontWeight(FontWeight.Bold)
            .margin({bottom:10})

          ForEach(this.announcement, (announcement:announcements) => {
            Column() {
              Text(announcement.title)
                .fontSize("18fp")
                .fontWeight(FontWeight.Bold)
                .fontColor("#2C3E50")

              Text(`📅 日期: ${announcement.date}`)
                .fontSize("16fp")
                .fontColor("#7F8C8D")
                .margin({bottom:5})

              Text(announcement.description)
                .fontSize("16fp")
                .fontColor("#34495E")
            }
            .width("100%")
            .backgroundColor("#ECF0F1")
            .borderRadius(10)
            .shadow(3)
            .padding(10)
            .margin({bottom:10})
          })
        }
        .margin({bottom:20})

        // 活动列表
        Column() {
          Text("🎉 校园活动")
            .fontSize("20fp")
            .fontWeight(FontWeight.Bold)
            .margin({bottom:10})

          ForEach(this.event, (event:events) => {
            Column() {
              Text(event.title)
                .fontSize("18fp")
                .fontWeight(FontWeight.Bold)
                .fontColor("#2C3E50")

              Text(`📅 日期: ${event.date}`)
                .fontSize("16fp")
                .fontColor("#7F8C8D")

              Text(`📍 地点: ${event.location}`)
                .fontSize("16fp")
                .fontColor("#16A085")
                .margin({bottom:5})

              Row() {
                if (!event.isRegistered) {
                  Button("📌 报名")
                    .width("30%")
                    .backgroundColor("#F1C40F")
                    .fontColor("#FFFFFF")
                    .onClick(() => event.isRegistered = true)
                }
                if (event.isRegistered && !event.isCheckedIn) {
                  Button("✅ 签到")
                    .width("30%")
                    .backgroundColor("#2ECC71")
                    .fontColor("#FFFFFF")
                    .onClick(() => event.isCheckedIn = true)
                }
                if (event.isCheckedIn) {
                  Text("✔ 已签到")
                    .fontSize("16fp")
                    .fontWeight(FontWeight.Bold)
                    .fontColor("#27AE60")
                    .margin({bottom:10})
                }
              }
            }
            .width("100%")
            .backgroundColor("#ECF0F1")
            .borderRadius(10)
            .shadow(3)
            .padding(10)
            .margin({bottom:10})
          })
        }
      }
      .width("100%")
      .height("100%")
      .backgroundColor("#F5F5F5")
      .padding(15)
    }
  }
}
