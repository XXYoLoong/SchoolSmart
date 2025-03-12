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

// 导入路由模块，用于页面导航或其他操作（目前未在此组件内使用）
import router from '@ohos.router'

// 使用装饰器标识此结构体为入口组件
@Entry
  // 使用装饰器声明为组件
@Component
export default struct UserProfile {
  // 定义用户姓名状态，初始化为 "小小游龙"
  @State userName: string = "小小游龙"
  // 定义用户邮箱状态，初始化为 "2561889884@qq.com"
  @State userEmail: string = "2561889884@qq.com"
  // 定义用户电话号码状态，初始化为 "15655551005"
  @State userPhone: string = "15655551005"
  // 定义用户头像资源状态，初始化为应用内资源
  @State userAvatar: Resource = $r('app.media.test')
  // 定义用户简介状态，描述用户对开发与创新的热情
  @State userBio: string = "热衷于HarmonyOS开发，智能校园系统与AIoT创新"
  // 定义校园ID状态，表示用户的学号或身份标识
  @State campusID: string = "F23011126"
  // 定义用户专业状态，初始化为 "计算机科学与技术"
  @State major: string = "计算机科学与技术"
  // 定义宿舍信息状态，初始化为 "6号楼 666室"
  @State dormitory: string = "6号楼 666室"
  // 定义图书馆状态，显示当前借阅和预约的图书数量
  @State libraryStatus: string = "当前借阅 2 本 | 已预约 1 本"
  // 定义课程安排状态，包含课程名称、时间与教室信息
  @State courseSchedule: string = "OpenHarmony软硬协同 | 18:40 - 20:10 | 12-706"
  // 定义校园卡余额状态，显示余额信息
  @State campusCardBalance: string = "余额: ¥58.30"

  // 构建组件的UI结构
  build() {
    // 主垂直布局容器，将各部分内容按垂直方向排列
    Column() {
      // 顶部用户信息区域，包括头像、姓名与简介
      Column() {
        // 显示用户头像，设置为圆形
        Image(this.userAvatar)
          .width(100)                   // 设置图片宽度为 100 像素
          .height(100)                  // 设置图片高度为 100 像素
          .borderRadius(50)             // 设置圆角为50像素，使图片呈现圆形效果
          .margin({ bottom: 10 })        // 底部外边距10像素，分隔与下方内容

        // 显示用户名
        Text(this.userName)
          .fontSize("24fp")             // 设置文字大小为 24fp
          .fontWeight(FontWeight.Bold)  // 使用加粗字体
          .fontColor("#FFFFFF")         // 文字颜色为白色
          .margin({ bottom: 5 })         // 底部外边距5像素

        // 显示用户自我介绍
        Text(this.userBio)
          .fontSize("16fp")             // 设置文字大小为 16fp
          .fontColor("#FFFFFF")         // 文字颜色为白色，确保与背景形成对比
      }
      .width("100%")                   // 顶部区域宽度占满父容器
      .height(200)                     // 固定高度200像素
      .backgroundColor("#3498DB")      // 背景颜色设置为蓝色
      .borderRadius(15)                // 设置圆角边框，增强视觉效果
      .padding(5)                      // 内边距5像素
      .alignItems(HorizontalAlign.Center) // 内部元素水平居中排列

      // 中部区域：展示个人智慧校园信息
      Column(){
        // 学号展示区域
        Row (){
          Text(`🎓 学号: ${this.campusID}`)
            .fontSize("18fp")           // 设置文字大小为 18fp
            .fontColor("#333333")       // 文字颜色为深灰色
        }
        .margin({bottom:10})            // 底部外边距10像素

        // 专业信息展示区域
        Row() {
          Text(`📚 专业: ${this.major}`)
            .fontSize("18fp")           // 文字大小设置
            .fontColor("#333333")       // 文字颜色为深灰色
        }
        .margin({bottom:10})            // 设置外边距，区分各行信息

        // 宿舍信息展示区域
        Row() {
          Text(`🏠 宿舍: ${this.dormitory}`)
            .fontSize("18fp")           // 文字大小18fp
            .fontColor("#333333")       // 文字颜色深灰色
        }
        .margin({bottom:10})            // 底部外边距10像素

        // 图书馆状态展示区域
        Row() {
          Text(`📖 图书馆: ${this.libraryStatus}`)
            .fontSize("18fp")           // 文字大小设置为18fp
            .fontColor("#333333")       // 文字颜色设置为深灰色
        }
        .margin({bottom:10})            // 底部外边距10像素

        // 课程安排标题
        Column() {
          Text("📅 课程安排: ")
            .fontSize("18fp")           // 设置标题文字大小为18fp
            .fontColor("#333333")       // 文字颜色设置为深灰色
        }
        // 课程安排详细信息展示区域
        Column() {
          Text(this.courseSchedule)
            .fontSize("16fp")           // 设置详细信息文字大小为16fp
            .fontColor("#333333")       // 文字颜色设置为深灰色
        }
        .margin({bottom:5})             // 底部外边距5像素

        // 校园卡余额展示区域
        Row() {
          Text(`💳 校园卡: ${this.campusCardBalance}`)
            .fontSize("18fp")           // 文字大小设置为18fp
            .fontColor("#333333")       // 文字颜色为深灰色
        }
      }
      .width("100%")                   // 中部区域宽度占满父容器
      .backgroundColor("#FFFFFF")      // 背景颜色为白色，突出信息
      .borderRadius(15)                // 设置圆角边框
      .padding(15)                     // 内边距15像素
      .margin({top:15})                // 顶部外边距15像素，分隔与上方区域
      .shadow(3)                       // 添加阴影效果，提升层次感

      // 下部区域：个人联系信息展示（邮箱和电话）
      // 邮箱信息区域，使用水平布局排列图标与文本
      Row() {
        // 邮箱图标展示
        Image($r('app.media.email'))
          .width(24)                 // 设置图标宽度为24像素
          .height(24)                // 设置图标高度为24像素
          .margin({ right: 10 })     // 右侧外边距10像素，分隔图标与文本

        // 显示用户邮箱地址
        Text(this.userEmail)
          .fontSize("18fp")          // 文字大小18fp
          .fontColor("#333333")      // 文字颜色深灰色
      }
      .width("100%")                   // 邮箱区域宽度占满父容器
      .backgroundColor("#FFFFFF")      // 背景为白色
      .borderRadius(15)                // 设置圆角边框
      .padding(15)                     // 内边距15像素
      .margin({ top: 5 })              // 顶部外边距5像素
      .shadow(3)                       // 阴影效果

      // 电话信息区域，采用与邮箱类似的布局
      Row() {
        // 电话图标展示
        Image($r('app.media.phone'))
          .width(24)                 // 图标宽度为24像素
          .height(24)                // 图标高度为24像素
          .margin({ right: 10 })     // 右侧外边距10像素

        // 显示用户电话号码
        Text(this.userPhone)
          .fontSize("18fp")          // 文字大小设置为18fp
          .fontColor("#333333")      // 文字颜色设置为深灰色
      }
      .width("100%")                   // 电话区域宽度占满父容器
      .backgroundColor("#FFFFFF")      // 背景颜色为白色
      .borderRadius(15)                // 圆角边框
      .padding(15)                     // 内边距15像素
      .margin({ top: 5 })              // 顶部外边距5像素
      .shadow(3)                       // 添加阴影效果

      // 按钮区域：包含“编辑资料”与“退出登录”按钮
      Column() {
        // 编辑资料按钮
        Button("编辑资料")
          .width("80%")              // 按钮宽度为父容器的80%
          .height(50)                // 按钮高度固定为50像素
          .backgroundColor("#2ECC71")// 背景颜色为绿色，代表确认操作
          .fontColor("#FFFFFF")      // 文字颜色为白色
          .fontSize("18fp")          // 文字大小18fp
          .borderRadius(10)          // 设置按钮圆角10像素
          .onClick(() => {
            // 当点击“编辑资料”按钮时，在控制台输出日志信息
            console.info("编辑资料按钮点击")
          })
          .margin({ bottom: 15 })     // 底部外边距15像素，分隔按钮

        // 退出登录按钮
        Button("退出登录")
          .width("80%")              // 按钮宽度为父容器的80%
          .height(50)                // 按钮高度50像素
          .backgroundColor("#E74C3C")// 背景颜色为红色，提示危险操作
          .fontColor("#FFFFFF")      // 文字颜色为白色
          .fontSize("18fp")          // 文字大小18fp
          .borderRadius(10)          // 设置圆角10像素
          .onClick(() => {
            // 当点击“退出登录”按钮时，在控制台输出日志信息
            console.info("退出登录按钮点击")
          })
      }
      .width("100%")                   // 按钮区域宽度占满父容器
      .margin({ top: 20 })             // 顶部外边距20像素，增加与上方内容的间隔
      .alignItems(HorizontalAlign.Center) // 按钮区域内容居中对齐
    }
  }
}
