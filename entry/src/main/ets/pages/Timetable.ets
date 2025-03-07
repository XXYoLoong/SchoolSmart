import router from '@ohos.router'

interface courses{
  day: number; time: string; name: string; location: string; teacher: string
}

@Entry
@Component
export default struct TimetablePage {
  @State selectedDay: number = 0  // 当前选中的星期（0-6 对应周一到周日）
  @State selectedMonth: number = new Date().getMonth() + 1  // 当前选中的月份
  @State course: courses[] =  [
    { day: 0, time: "08:00 - 09:30", name: "操作系统（英文）", location: "12-204", teacher: "徐婧" },
    { day: 0, time: "09:40 - 11:10", name: "数值计算", location: "4-208", teacher: "阙程晟" },
    { day: 0, time: "12:40 - 15:50", name: "数据库原理及技术", location: "12-501", teacher: "马辉男" },

    { day: 1, time: "08:00 - 09:30", name: "大学英语拓展", location: "4-210", teacher: "高昊欣" },
    { day: 1, time: "09:40 - 11:10", name: "马克思主义基本原理", location: "3-102", teacher: "王莹" },
    { day: 1, time: "12:40 - 14:10", name: "习近平新时代中国特色社会主义思想概论", location: "3-102", teacher: "张菊" },
    { day: 1, time: "14:20 - 15:50", name: "工程理论", location: "12-415", teacher: "于晓东" },

    { day: 2, time: "08:00 - 11:10", name: "Java语言程序设计", location: "12-614", teacher: "陈柳桥" },
    { day: 2, time: "12:40 - 14:10", name: "形势与政策", location: "3-510", teacher: "刘珍珍" },

    { day: 3, time: "08:00 - 09:30", name: "计算机组成原理", location: "4-209", teacher: "隋欣" },
    { day: 3, time: "09:40 - 11:10", name: "操作系统（英文）", location: "12-204", teacher: "徐婧" },
    { day: 3, time: "12:40 - 14:10", name: "体育（足球）", location: "体育馆", teacher: "曾祥意" },

    //{ day: 4, time: "12:40 - 14:10", name: "[排本间] 数据库应用课程设计", location: "12-415", teacher: "白博文" },

    { day: 4, time: "08:00 - 09:30", name: "数值计算", location: "4-208", teacher: "阙程晟" },
    { day: 4, time: "09:40 - 11:10", name: "计算机组成原理", location: "4-209", teacher: "隋欣" },
    { day: 4, time: "12:40 - 15：50", name: "数据库应用课程设计", location: "12-415", teacher: "白博文" }
  ];

  build() {
    Column() {
      // 标题栏
      Row() {
        Image($r('app.media.back_left'))
          .width("20%")
          .height("30vp")
            //  .backgroundColor("#E74C3C")
          .onClick(() => { router.back() })


        Text("📅 我的课程表")
          .width("70%")
          .textAlign(TextAlign.Center)
          .fontSize("24fp")
          .fontWeight(FontWeight.Bold)
          .margin({bottom:10})

      }
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({bottom:10})

      // 月份切换
      Row() {
        Button("⬅ 上个月")
          .width("40%")
          .onClick(() => { this.selectedMonth = Math.max(1, this.selectedMonth - 1) })
          .backgroundColor("#3498DB")
          .fontColor("#FFFFFF")

        Text(`📆 ${this.selectedMonth} 月`)
          .fontSize("20fp")
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .width("20%")

        Button("下个月 ➡")
          .width("40%")
          .onClick(() => { this.selectedMonth = Math.min(12, this.selectedMonth + 1) })
          .backgroundColor("#3498DB")
          .fontColor("#FFFFFF")
      }
      .justifyContent(FlexAlign.SpaceAround)
      .margin({bottom:15})

      // 星期切换
      Row() {
        ForEach(["周一", "周二", "周三", "周四", "周五", "周六", "周日"], (day: string, index: number) => {
          Button()
          {
            Text(day)
              .fontSize("16fp")
              .textAlign(TextAlign.Center)
          }
          .type(ButtonType.Circle)
          .width("12%")
          .height("40vp")
          .margin({right:5})
          .backgroundColor(this.selectedDay === index ? "#3498DB" : "#BDC3C7")
          .fontColor("#FFFFFF")
          .onClick(() => { this.selectedDay = index })
        })
      }
      .justifyContent(FlexAlign.SpaceAround)

      // 课程信息
      Column() {
        ForEach(this.course.filter(course => course.day === this.selectedDay), (course:courses) => {
          Column() {
            Text(course.name)
              .fontSize("20fp")
              .fontWeight(FontWeight.Bold)
              .fontColor("#2C3E50")
              .margin({bottom:5})

            Text(`⏰ 时间: ${course.time}`)
              .fontSize("16fp")
              .fontColor("#34495E")
              .margin({bottom:3})

            Text(`📍 地点: ${course.location}`)
              .fontSize("16fp")
              .fontColor("#16A085")
              .margin({bottom:3})

            Text(`👨‍🏫 教师: ${course.teacher}`)
              .fontSize("16fp")
              .fontColor("#8E44AD")
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
