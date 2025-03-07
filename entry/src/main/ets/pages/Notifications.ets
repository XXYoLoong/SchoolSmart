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

// 导入路由模块，用于页面导航和返回操作
import router from '@ohos.router'

// 定义公告（announcements）接口，描述每个公告的信息结构
interface announcements {
  title: string;        // 公告标题
  date: string;         // 公告日期
  description: string;  // 公告的详细描述
}

// 定义活动（events）接口，描述每个活动的信息结构
interface events {
  title: string;         // 活动标题
  date: string;          // 活动日期
  location: string;      // 活动举办地点
  isRegistered: boolean; // 用户是否已报名参加该活动
  isCheckedIn: boolean;  // 用户是否已签到参加该活动
}

// 使用 @Entry 和 @Component 装饰器将该结构体声明为入口组件
@Entry
@Component
export default struct Notificationse {
  // 状态变量 announcement 存储公告数组，初始化了3条示例公告
  @State announcement: announcements[] = [
    { title: "校园网络升级维护通知", date: "2025-03-10", description: "全校网络将在3月10日凌晨进行升级维护，预计2小时，请提前做好准备。" },
    { title: "春季运动会报名开始", date: "2025-03-15", description: "春季运动会即将开始，欢迎同学们踊跃报名，截止日期3月20日。" },
    { title: "2025年校企合作招聘会", date: "2025-04-05", description: "校企合作招聘会将在4月5日举行，提供大量实习与就业机会，敬请关注。" }
  ]

  // 状态变量 event 存储活动数组，包含了报名和签到状态的示例活动
  @State event: events[] = [
    { title: "AI前沿技术讲座", date: "2025-03-12", location: "学术报告厅", isRegistered: false, isCheckedIn: false },
    { title: "校园环保志愿者活动", date: "2025-03-18", location: "校园主广场", isRegistered: true, isCheckedIn: false },
    { title: "计算机科学竞赛", date: "2025-04-02", location: "信息学院A201", isRegistered: true, isCheckedIn: true }
  ]

  // build 方法构建页面的 UI 布局
  build() {
    // 使用 Scroll 组件确保内容在超出屏幕时可以滚动查看
    Scroll(){
      // 主垂直布局容器，用于依次排列各个页面模块
      Column() {

        // 顶部导航区域，包含返回按钮和页面标题
        Row(){
          // 返回按钮图标，点击时调用 router.back() 返回上一页
          Image($r('app.media.back_left'))
            .width("20%")            // 占父容器宽度的20%
            .height("30vp")          // 高度设置为30vp单位
              // .backgroundColor("#E74C3C") // 可选的背景色（已注释）
            .onClick(() => { router.back() })

          // 页面标题，居中显示，带有图标
          Text("📢 校园公告 & 活动")
            .width("100%")           // 占满整行
            .textAlign(TextAlign.Center) // 文本居中对齐
            .fontSize("24fp")        // 标题文字大小设置为24fp
            .fontWeight(FontWeight.Bold) // 使用加粗字体
            .margin({bottom:10})      // 底部外边距10，分隔与下方内容
        }

        // 公告列表区域
        Column() {
          // 公告区域标题
          Text("📜 最新公告")
            .fontSize("20fp")        // 标题文字大小设置为20fp
            .fontWeight(FontWeight.Bold) // 加粗标题文字
            .margin({bottom:10})      // 底部间距10，为后续公告卡片留出空间

          // 遍历公告数组，逐个生成公告卡片
          ForEach(this.announcement, (announcement: announcements) => {
            // 单个公告卡片容器
            Column() {
              // 公告标题文本
              Text(announcement.title)
                .fontSize("18fp")    // 字体大小18fp
                .fontWeight(FontWeight.Bold) // 加粗显示标题
                .fontColor("#2C3E50") // 深色字体，便于阅读

              // 公告日期文本，带有日期图标
              Text(`📅 日期: ${announcement.date}`)
                .fontSize("16fp")    // 字体大小16fp
                .fontColor("#7F8C8D") // 使用灰色显示日期信息
                .margin({bottom:5})   // 底部间距5，分隔日期和描述

              // 公告描述文本，详细说明公告内容
              Text(announcement.description)
                .fontSize("16fp")    // 字体大小设置为16fp
                .fontColor("#34495E") // 字体颜色设置为稍深的灰色
            }
            .width("100%")              // 公告卡片占满整行宽度
            .backgroundColor("#ECF0F1")  // 浅灰背景，区分于页面背景
            .borderRadius(10)           // 圆角边框，提升视觉效果
            .shadow(3)                  // 添加阴影，增强卡片层次感
            .padding(10)                // 内边距10，为内容提供足够空间
            .margin({bottom:10})        // 卡片之间的底部间距10
          })
        }
        .margin({bottom:20})              // 公告区域整体底部间距20

        // 活动列表区域
        Column() {
          // 活动列表标题
          Text("🎉 校园活动")
            .fontSize("20fp")        // 字体大小20fp
            .fontWeight(FontWeight.Bold) // 加粗标题显示
            .margin({bottom:10})      // 底部间距10

          // 遍历活动数组，逐个生成活动卡片
          ForEach(this.event, (event: events) => {
            // 单个活动卡片容器
            Column() {
              // 活动标题文本
              Text(event.title)
                .fontSize("18fp")    // 字体大小18fp
                .fontWeight(FontWeight.Bold) // 标题加粗
                .fontColor("#2C3E50") // 深色字体

              // 活动日期文本，显示活动的举行日期
              Text(`📅 日期: ${event.date}`)
                .fontSize("16fp")    // 字体大小16fp
                .fontColor("#7F8C8D") // 使用灰色显示日期

              // 活动地点文本，显示活动举办的具体位置
              Text(`📍 地点: ${event.location}`)
                .fontSize("16fp")    // 字体大小设置为16fp
                .fontColor("#16A085") // 使用鲜明的颜色突出地点信息
                .margin({bottom:5})   // 底部间距5，为后续操作按钮预留空间

              // 行容器用于放置操作按钮和状态文本
              Row() {
                // 如果用户尚未报名，显示“报名”按钮
                if (!event.isRegistered) {
                  Button("📌 报名")
                    .width("30%")          // 占行宽度的30%
                    .backgroundColor("#F1C40F") // 黄色背景，吸引注意
                    .fontColor("#FFFFFF")  // 白色字体，清晰可见
                    .onClick(() => event.isRegistered = true) // 点击后标记为已报名
                }
                // 如果用户已报名但尚未签到，显示“签到”按钮
                if (event.isRegistered && !event.isCheckedIn) {
                  Button("✅ 签到")
                    .width("30%")          // 占行宽度的30%
                    .backgroundColor("#2ECC71") // 绿色背景，代表成功
                    .fontColor("#FFFFFF")  // 白色字体
                    .onClick(() => event.isCheckedIn = true) // 点击后标记为已签到
                }
                // 如果用户已完成签到，显示“已签到”状态文本
                if (event.isCheckedIn) {
                  Text("✔ 已签到")
                    .fontSize("16fp")      // 字体大小设置为16fp
                    .fontWeight(FontWeight.Bold) // 加粗显示状态
                    .fontColor("#27AE60")  // 绿色字体，表示成功
                    .margin({bottom:10})   // 底部间距10，为美观留白
                }
              }
            }
            .width("100%")                // 活动卡片占满行宽
            .backgroundColor("#ECF0F1")    // 浅灰背景以区分卡片
            .borderRadius(10)             // 圆角边框设计
            .shadow(3)                    // 阴影效果增加层次感
            .padding(10)                  // 内边距10，保证内容不拥挤
            .margin({bottom:10})         // 卡片之间的底部间距10
          })
        }
      }
      // 设置最外层容器样式，确保整体页面布局统一
      .width("100%")           // 占满全屏宽度
      .height("100%")          // 占满全屏高度
      .backgroundColor("#F5F5F5") // 页面背景色为非常浅的灰色
      .padding(15)             // 整体内边距15，内容不紧贴屏幕边缘
    }
  }
}
