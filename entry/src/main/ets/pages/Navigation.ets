import router from '@ohos.router'

interface destination {
  name: string;
  description: string
}

@Entry
@Component
export default struct CampusNavigationPage {
  @State searchQuery: string = ""
  @State currentLocation: string = "主教学楼"
  @State destinations: destination[] = [
    { name: "图书馆", description: "提供丰富的书籍和安静的学习环境" },
    { name: "实验楼", description: "计算机科学与工程实验室" },
    { name: "体育馆", description: "篮球场、健身房和游泳馆" },
    { name: "食堂", description: "美味餐饮，种类丰富" },
    { name: "宿舍楼", description: "舒适的住宿环境，24小时安保" },
    { name: "1号教学楼", description: "国际医学与技术学院教学楼" },
    { name: "2号教学楼", description: "胜祥商学院教学楼" },
    { name: "3号教学楼", description: "信息科学与技术学院教学楼" },
    { name: "4号教学楼", description: "信息科学与技术学院教学楼" },
    { name: "5号教学楼", description: "艺术设计与传媒学院教学楼" },
    { name: "6号教学楼", description: "教育学院教学楼" },
  ]

  build() {
    Column() {
     Row(){
       // 返回按钮图标，点击后调用 router.back() 返回上一页
       Image($r('app.media.back_left'))
         .width("20%")
         .height("30vp")
           // 可选背景颜色（已注释）
           // .backgroundColor("#E74C3C")
         .onClick(() => { router.back() })
       Text("      🏫 校园导航")
         .width("100%")
         .textAlign(TextAlign.Start)
         .fontSize("24fp")
         .fontWeight(FontWeight.Bold)
         .margin({bottom:10})
     }

      // 搜索目的地
      Row() {
        Search({ placeholder:"🔍 请输入目的地..." })
          .width("70%")
          .onChange((value: string) => { this.searchQuery = value.trim() })

        Button("搜索")
          .width("25%")
          .backgroundColor("#3498DB")
          .fontColor("#FFFFFF")
          .onClick(() => console.info("搜索: " + this.searchQuery))
      }
      .margin({bottom:10})

      // 当前定位
      Column() {
        Text("📍 当前位置: " + this.currentLocation)
          .fontSize("18fp")
          .fontWeight(FontWeight.Bold)
          .fontColor("#2C3E50")
          .margin({bottom:5})

        Button("刷新定位")
          .width("50%")
          .backgroundColor("#27AE60")
          .fontColor("#FFFFFF")
          .onClick(() => {
            this.currentLocation = "主教学楼" // 模拟实时定位更新
            console.info("定位已更新: " + this.currentLocation)
          })
      }
      .backgroundColor("#ECF0F1")
      .borderRadius(10)
      .shadow(3)
      .padding(10)
      .margin({bottom:20})

      // 目的地列表
      Scroll(){
        Column() {
          ForEach(this.destinations.filter(dest => this.searchQuery === "" || dest.name.includes(this.searchQuery)), (dest:destination) => {
            Column() {
              Text(dest.name)
                .fontSize("20fp")
                .fontWeight(FontWeight.Bold)
                .fontColor("#2C3E50")

              Text(dest.description)
                .fontSize("16fp")
                .fontColor("#34495E")

              Button("导航")
                .width("40%")
                .backgroundColor("#E67E22")
                .fontColor("#FFFFFF")
                .onClick(() => console.info("导航至: " + dest.name))
            }
            .width("100%")
            .backgroundColor("#ECF0F1")
            .borderRadius(10)
            .shadow(3)
            .padding(10)
            .margin({bottom:10})
          })
        }
      }.height("73%")
      .margin({bottom:10})
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#F5F5F5")
    .padding(15)
  }
}
