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

// 导入主页面组件，用于显示“主页”标签页
import MainCompoments from "../components/indexpages/Main"
// 导入校园环境监测组件，用于显示“监测”标签页
import CamCompoments from "../components/indexpages/CampusEnvMonitor"
// 导入个人中心组件，用于显示“我的”标签页
import HomeCompents from "../components/indexpages/Home"

// @Entry 注解标识此组件作为应用程序的入口
// @Component 注解将结构体声明为一个UI组件
@Entry
@Component
struct Index {
  // 定义一个状态变量 message，初始化为 'Main Pages'
  @State message: string = 'Main Pages'

  // build 方法用于构建当前组件的UI布局
  build() {
    // 最外层使用 Column 组件，垂直排列所有子组件
    Column() {
      // 嵌套的 Column 用于包裹整个标签页区域
      Column() {
        // Tabs 组件用于创建底部标签栏，barPosition 设置为 End 表示标签栏显示在末尾
        Tabs({ barPosition: BarPosition.End }) {

          // 第一个 TabContent，用于显示主页面内容
          TabContent() {
            // 调用 MainCompoments 组件，显示主页内容
            MainCompoments()
          }
          // 设置内容居中对齐，添加边框颜色和背景色
          .align(Alignment.Center)
          .borderColor("#000000")
          .backgroundColor("#ffffff")
          // 定义标签栏项，包含图标和文字描述
          .tabBar({ icon: $r('app.media.Main_tab'), text: "主页" })

          // 第二个 TabContent，用于显示校园环境监测页面
          TabContent() {
            // 调用 CamCompoments 组件，显示监测相关内容
            CamCompoments()
          }
          // 定义标签栏项，设置图标和文字描述
          .tabBar({ icon: $r('app.media.CampusEnvMonitor_tab'), text: "监测" })

          // 第三个 TabContent，用于显示个人中心页面
          TabContent() {
            // 调用 HomeCompents 组件，显示用户个人信息
            HomeCompents()
          }
          // 设置内容居中对齐，并定义标签栏项的图标与文字描述
          .align(Alignment.Center)
          .tabBar({ icon: $r('app.media.Home_tab'), text: "我的"})
        }
        // 设置 Tabs 组件的宽度和高度都占满父容器
        .width("100%")
        .height("100%")
      }
      // 外层 Column 的宽度和高度均占满全屏
      .width("100%")
      .height("100%")
      // 水平居中对齐子组件
      .alignItems(HorizontalAlign.Center)
      // 将内容在垂直方向上靠底部对齐
      .justifyContent(FlexAlign.End)
    }
    // 设置最外层容器占满全屏
    .width("100%")
    .height("100%")
  }
}

// 定义一个函数 Main，当前未实现具体功能，抛出错误提示
function Main() {
  throw new Error('Function not implemented.')
}
