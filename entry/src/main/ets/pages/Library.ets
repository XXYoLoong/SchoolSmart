import router from '@ohos.router'

interface books{
  title: string; author: string; status: string; isRecommended: boolean
}

@Entry
@Component
export default struct LibraryPage {
  @State searchQuery: string = ""
  @State book: books[] = [
    { title: "计算机网络", author: "谢希仁", status: "可借阅", isRecommended: true },
    { title: "数据结构与算法", author: "王道", status: "已借出", isRecommended: false },
    { title: "人工智能导论", author: "周志华", status: "可预约", isRecommended: true },
    { title: "编译原理", author: "龙书", status: "可借阅", isRecommended: false },
    { title: "软件工程", author: "Ian Sommerville", status: "已借出", isRecommended: true },
  ]

  build() {
    Column() {

      Row(){
        Image($r('app.media.back_left'))
          .width("20%")
          .height("30vp")
            //  .backgroundColor("#E74C3C")
          .onClick(() => { router.back() })

        Text("📚 图书馆管理系统")
          .width("100%")
          .textAlign(TextAlign.Center)
          .fontSize("24fp")
          .fontWeight(FontWeight.Bold)
          .margin({bottom:10})
      }


      // 搜索栏
      Row() {
      Search({ value:"🔍 搜索书籍..." })
          .width("70%")
        // .onChange((value: string) => { this.searchQuery = value.trim() })

        Button("搜索")
          .width("25%")
          .backgroundColor("#3498DB")
          .fontColor("#FFFFFF")
          // .onClick(() => console.info("搜索: " + this.searchQuery))
      }
      .margin({bottom:15})

      // 书籍列表
      Column() {
        ForEach(this.book.filter(book => this.searchQuery === "" || book.title.includes(this.searchQuery)), (book:books) => {
          Column() {
            Row() {
              Text(book.title)
                .fontSize("20fp")
                .fontWeight(FontWeight.Bold)
                .fontColor("#2C3E50")
                .width("50%")

              Text(`📝 ${book.author}`)
                .fontSize("16fp")
                .fontColor("#34495E")
                .width("30%")

              Text(`📖 ${book.status}`)
                .fontSize("16fp")
                .fontColor(book.status === "可借阅" ? "#27AE60" : book.status === "可预约" ? "#F39C12" : "#C0392B")
                .width("20%")
            }
            .margin({bottom:5})

            Row() {
              if (book.status === "可借阅") {
                Button("📥 借阅")
                  .width("30%")
                  .backgroundColor("#2ECC71")
                  .fontColor("#FFFFFF")
                  .onClick(() => console.info("借阅: " + book.title))
              } else if (book.status === "可预约") {
                Button("📌 预约")
                  .width("30%")
                  .backgroundColor("#F1C40F")
                  .fontColor("#FFFFFF")
                  .onClick(() => console.info("预约: " + book.title))
              }

              if (book.isRecommended) {
                Text("⭐ 推荐")
                  .fontSize("16fp")
                  .fontWeight(FontWeight.Bold)
                  .fontColor("#E67E22")
                  .margin({left:10})
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