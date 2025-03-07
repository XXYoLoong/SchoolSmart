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

// 导入路由模块，用于页面跳转和返回操作
import router from '@ohos.router'

// 定义课程数据接口，描述每一门课程的信息结构
interface courses {
  day: number;      // 上课的星期（0-6，对应周一到周日）
  time: string;     // 上课时间段，例如 "08:00 - 09:30"
  name: string;     // 课程名称
  location: string; // 上课地点
  teacher: string;  // 授课教师
}

// 使用 @Entry 和 @Component 装饰器声明该结构体为应用入口组件
@Entry
@Component
export default struct TimetablePage {
  // 当前选中的星期，初始值为0，代表周一
  @State selectedDay: number = 0

  // 当前选中的月份，使用当前系统月份（注意：getMonth() 返回0-11，所以加1）
  @State selectedMonth: number = new Date().getMonth() + 1

  // 定义课程数组，存储各个课程的详细信息
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

    // { day: 4, time: "12:40 - 14:10", name: "[排本间] 数据库应用课程设计", location: "12-415", teacher: "白博文" }, // 此课程暂时被注释掉

    { day: 4, time: "08:00 - 09:30", name: "数值计算", location: "4-208", teacher: "阙程晟" },
    { day: 4, time: "09:40 - 11:10", name: "计算机组成原理", location: "4-209", teacher: "隋欣" },
    { day: 4, time: "12:40 - 15：50", name: "数据库应用课程设计", location: "12-415", teacher: "白博文" }
  ];

  // build 方法用于构建当前页面的 UI 布局
  build() {
    // 外层容器使用 Column 布局，垂直排列各个子组件
    Column() {

      // 标题栏区域，包含返回按钮和页面标题
      Row() {
        // 返回按钮图标，点击后调用 router.back() 返回到上一个页面
        Image($r('app.media.back_left'))
          .width("20%")              // 占据当前行宽度的20%
          .height("30vp")            // 高度设置为30vp单位
            // .backgroundColor("#E74C3C") // 可选背景色（当前被注释掉）
          .onClick(() => { router.back() })

        // 页面标题文本，显示“我的课程表”
        Text("📅 我的课程表")
          .width("70%")              // 占据当前行宽度的70%
          .textAlign(TextAlign.Center) // 文本居中显示
          .fontSize("24fp")          // 设置较大的字体尺寸
          .fontWeight(FontWeight.Bold) // 标题使用加粗样式
          .margin({bottom:10})       // 底部留出10单位的空隙
      }
      // 设置标题栏行的内容在水平方向上均匀分布
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({bottom:10})         // 标题栏与下方内容之间的外边距

      // 月份切换区域：用户可以切换显示上个月或下个月的课程信息
      Row() {
        // “上个月”按钮：点击后减少当前月份，确保月份不小于1
        Button("⬅ 上个月")
          .width("40%")            // 按钮宽度占当前行宽度的40%
          .onClick(() => { this.selectedMonth = Math.max(1, this.selectedMonth - 1) })
          .backgroundColor("#3498DB") // 按钮背景颜色为蓝色
          .fontColor("#FFFFFF")     // 按钮文字颜色为白色

        // 当前月份显示文本，居中显示所选月份
        Text(`📆 ${this.selectedMonth} 月`)
          .fontSize("20fp")         // 字体大小设置为20fp
          .fontWeight(FontWeight.Bold) // 使用加粗字体
          .textAlign(TextAlign.Center)
          .width("20%")             // 占当前行宽度的20%

        // “下个月”按钮：点击后增加当前月份，确保月份不超过12
        Button("下个月 ➡")
          .width("40%")
          .onClick(() => { this.selectedMonth = Math.min(12, this.selectedMonth + 1) })
          .backgroundColor("#3498DB")
          .fontColor("#FFFFFF")
      }
      // 在月份切换区域内，均匀分布各个子组件
      .justifyContent(FlexAlign.SpaceAround)
      .margin({bottom:15})         // 月份切换区域与下方内容之间的空隙

      // 星期切换区域：展示一周七天按钮供用户选择查看当天课程
      Row() {
        // 使用 ForEach 遍历星期数组（从“周一”到“周日”）
        ForEach(["周一", "周二", "周三", "周四", "周五", "周六", "周日"], (day: string, index: number) => {
          // 为每一天创建一个按钮
          Button() {
            // 按钮内显示星期文本
            Text(day)
              .fontSize("16fp")    // 设置文字大小为16fp
              .textAlign(TextAlign.Center) // 文本居中显示
          }
          .type(ButtonType.Circle)           // 按钮形状为圆形
          .width("12%")                      // 宽度占当前行的12%
          .height("40vp")                    // 高度设置为40vp单位
          .margin({right:5})                 // 右侧外边距5单位
          // 根据当前选中的星期改变背景色：选中时蓝色，否则灰色
          .backgroundColor(this.selectedDay === index ? "#3498DB" : "#BDC3C7")
          .fontColor("#FFFFFF")              // 按钮文字颜色为白色
          // 点击按钮时，将 selectedDay 更新为当前按钮的索引值
          .onClick(() => { this.selectedDay = index })
        })
      }
      // 在星期切换区域内，均匀排列按钮
      .justifyContent(FlexAlign.SpaceAround)

      // 课程信息展示区域：只显示与选中星期匹配的课程
      Column() {
        // 过滤出课程数组中 day 属性与 selectedDay 相等的课程，然后遍历生成课程卡片
        ForEach(this.course.filter(course => course.day === this.selectedDay), (course: courses) => {
          // 单个课程信息卡片使用 Column 布局排列课程详细信息
          Column() {
            // 课程名称文本，使用大号字体和加粗样式
            Text(course.name)
              .fontSize("20fp")
              .fontWeight(FontWeight.Bold)
              .fontColor("#2C3E50")
              .margin({bottom:5})    // 课程名称与下方信息之间的间隔

            // 课程时间文本，显示上课时间段
            Text(`⏰ 时间: ${course.time}`)
              .fontSize("16fp")
              .fontColor("#34495E")
              .margin({bottom:3})    // 下方信息之间的间隔

            // 课程地点文本，显示上课地点，并使用醒目的颜色
            Text(`📍 地点: ${course.location}`)
              .fontSize("16fp")
              .fontColor("#16A085")
              .margin({bottom:3})

            // 授课教师文本，显示教师姓名，并使用与众不同的颜色
            Text(`👨‍🏫 教师: ${course.teacher}`)
              .fontSize("16fp")
              .fontColor("#8E44AD")
          }
          // 每个课程卡片宽度占满父容器
          .width("100%")
          .backgroundColor("#ECF0F1")  // 卡片背景为浅灰色
          .borderRadius(10)          // 边角圆润
          .shadow(3)                 // 添加阴影效果，提升层次感
          .padding(10)               // 内边距，确保内容不紧贴边缘
          .margin({bottom:10})        // 卡片之间的底部间隔
        })
      }
    }
    // 设置整个页面容器宽度和高度占满全屏
    .width("100%")
    .height("100%")
    .backgroundColor("#F5F5F5")    // 页面整体背景色为非常浅的灰色
    .padding(15)                 // 页面内边距15单位，确保内容不贴边
  }
}
