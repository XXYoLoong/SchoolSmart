/*
 * Copyright 2025 Jiacheng Ni
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// 导入路由模块，用于页面跳转操作，例如返回上一个页面
import router from '@ohos.router'

// 定义图书数据接口，用于描述每本书的信息
interface books {
  title: string;         // 图书标题
  author: string;        // 作者姓名
  status: string;        // 图书状态，如“可借阅”、“已借出”或“可预约”
  isRecommended: boolean;// 是否为推荐图书
}

// 使用 @Entry 注解标识此组件为入口组件，@Component 标识为一个UI组件
@Entry
@Component
export default struct LibraryPage {
  // 定义状态变量 searchQuery，用于存储用户在搜索栏中输入的查询关键字
  @State searchQuery: string = ""
  // 定义状态变量 book，存储图书列表，初始值包含几本示例图书
  @State book: books[] = [
    { title: "计算机网络", author: "谢希仁", status: "可借阅", isRecommended: true },
    { title: "数据结构与算法", author: "王道", status: "已借出", isRecommended: false },
    { title: "人工智能导论", author: "周志华", status: "可预约", isRecommended: true },
    { title: "编译原理", author: "龙书", status: "可借阅", isRecommended: false },
    { title: "软件工程", author: "Ian Sommerville", status: "已借出", isRecommended: true },
  ]

  // 构建页面 UI 的主要方法
  build() {
    // 外层 Column 容器，垂直排列页面各模块
    Column() {

      // 顶部导航栏区域，包含返回按钮和页面标题
      Row(){
        // 返回按钮图标，点击后调用 router.back() 返回上一页
        Image($r('app.media.back_left'))
          .width("20%")
          .height("30vp")
            // 可选背景颜色（已注释）
            // .backgroundColor("#E74C3C")
          .onClick(() => { router.back() })

        // 页面标题，显示“图书馆管理系统”
        Text("  📚 图书馆管理系统")
          .width("100%")
          .textAlign(TextAlign.Start)
          .fontSize("24fp")
          .fontWeight(FontWeight.Bold)
          .margin({bottom:10})
      }

      // 搜索栏区域，用户可通过该区域搜索图书
      Row() {
        // 搜索组件，默认显示提示文本
        TextInput({ placeholder:"请输入您要搜索的书籍名称" })
          .width("70%")
        //可通过 onChange 事件捕获输入变化，目前已注释掉
        .onChange((value: string) => { this.searchQuery = value.trim() })

        // 搜索按钮，点击后可触发搜索操作（目前仅输出日志，已注释掉 onClick 事件）
        Button("搜索")
          .width("25%")
          .backgroundColor("#3498DB")
          .fontColor("#FFFFFF")
        // .onClick(() => console.info("搜索: " + this.searchQuery))
      }
      .margin({bottom:15}) // 搜索栏与下方内容间距

      // 书籍列表区域，动态展示图书信息

        Scroll() {
          Column() {
          // 使用 ForEach 循环遍历图书数组，根据搜索查询过滤图书
          ForEach(this.book.filter(book => this.searchQuery === "" || book.title.includes(this.searchQuery)),
            (book: books) => {
              // 每本图书的信息展示在一个独立的卡片中
              Column() {
                // 第一行：展示图书标题、作者和状态信息
                Row() {
                  // 图书标题
                  Text(book.title)
                    .fontSize("20fp")
                    .fontWeight(FontWeight.Bold)
                    .fontColor("#2C3E50")
                    .width("50%")

                  // 作者信息，前置图标用于提示
                  Text(`📝 ${book.author}`)
                    .fontSize("16fp")
                    .fontColor("#34495E")
                    .width("30%")

                  // 图书状态，根据状态不同设置不同的字体颜色
                  Text(`📖 ${book.status}`)
                    .fontSize("16fp")
                    .fontColor(
                      book.status === "可借阅" ? "#27AE60" :
                        book.status === "可预约" ? "#F39C12" : "#C0392B"
                    )
                    .width("20%")
                }
                .margin({ bottom: 5 }) // 第一行与第二行之间的间距

                // 第二行：根据图书状态显示相应的操作按钮以及推荐标识
                Row() {
                  // 如果图书状态为“可借阅”，显示借阅按钮
                  if (book.status === "可借阅") {
                    Button("📥 借阅")
                      .width("30%")
                      .backgroundColor("#2ECC71")
                      .fontColor("#FFFFFF")
                      .onClick(() => console.info("借阅: " + book.title))
                  }
                  // 如果图书状态为“可预约”，显示预约按钮
                  else if (book.status === "可预约") {
                    Button("📌 预约")
                      .width("30%")
                      .backgroundColor("#F1C40F")
                      .fontColor("#FFFFFF")
                      .onClick(() => console.info("预约: " + book.title))
                  }

                  // 如果图书为推荐书籍，显示“推荐”标识
                  if (book.isRecommended) {
                    Text("⭐ 推荐")
                      .fontSize("16fp")
                      .fontWeight(FontWeight.Bold)
                      .fontColor("#E67E22")
                      .margin({ left: 10 })
                  }
                }
              }
              .width("100%") // 卡片宽度占满父容器
              .backgroundColor("#ECF0F1") // 卡片背景色为浅灰色
              .borderRadius(10) // 卡片边角圆润
              .shadow(3) // 添加阴影效果，提升视觉层次感
              .padding(10) // 内边距，确保内容不贴边
              .margin({ bottom: 10 }) // 卡片之间的垂直间距
            })
        }
      }
    }
    .width("100%")        // 页面宽度占满屏幕
    .height("100%")       // 页面高度占满屏幕
    .backgroundColor("#F5F5F5") // 页面整体背景色为非常浅的灰色
    .padding(15)          // 页面内边距，确保内容不贴边显示
  }
}
