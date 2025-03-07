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

// 导入路由模块，用于页面导航（如果需要）
import router from '@ohos.router'

// 定义接口 LocationData，用于描述各个地点的环境监测数据
interface LocationData {
  name: string;         // 地点名称，如教学楼、实验楼等
  temperature: number;  // 温度数据，单位为摄氏度
  humidity: number;     // 湿度数据，单位为百分比
  co2Level: number;     // 二氧化碳浓度，单位为ppm
  fireDetected: boolean;  // 是否检测到火焰
  smokeDetected: boolean; // 是否检测到烟雾
}

// 主组件 CampusEnvMonitor 的入口和声明，使用 @Entry 和 @Component 装饰器
@Entry
@Component
export default struct CampusEnvMonitor {
  // 声明状态变量 locations，保存各个地点的环境数据，初始值全部为默认状态
  @State locations: LocationData[] = [
    { name: "教学楼", temperature: 0, humidity: 0, co2Level: 0, fireDetected: false, smokeDetected: false },
    { name: "实验楼", temperature: 0, humidity: 0, co2Level: 0, fireDetected: false, smokeDetected: false },
    { name: "宿舍楼", temperature: 0, humidity: 0, co2Level: 0, fireDetected: false, smokeDetected: false },
    { name: "图书馆", temperature: 0, humidity: 0, co2Level: 0, fireDetected: false, smokeDetected: false }
  ]

  // 生命周期方法，当组件即将出现在页面上时调用
  aboutToAppear(){
    // 启动自动刷新功能，定期更新环境监测数据
    this.startAutoRefresh();
  }

  // 自动刷新方法，使用定时器每隔3000毫秒（3秒）刷新数据
  startAutoRefresh() {
    setInterval(() => {
      // 调用 fetchSensorData 方法来获取新的传感器数据
      this.fetchSensorData();
    }, 3000);
  }

  // 构建页面的 UI 布局
  build() {
    // 使用 Column 布局作为最外层容器，垂直排列所有元素
    Column(){
      // 内部 Column 用于显示标题部分
      Column(){
        // 标题文本，使用 Emoji 增加视觉效果
        Text("🌍 智慧校园环境监测系统")
          .width("100%")                     // 宽度占满容器
          .textAlign(TextAlign.Center)       // 居中对齐文本
          .fontSize("28fp")                  // 设置大字号
          .fontWeight(FontWeight.Bold)       // 加粗显示
          .fontColor("#2C3E50")              // 设置字体颜色
          .margin(5)                         // 设置外边距
      }
      .width("100%")                         // 外层 Column 宽度为 100%
      .alignItems(HorizontalAlign.Center)    // 子元素水平居中对齐

      // 使用 Scroll 组件包裹动态列表，允许内容滚动
      Scroll(){
        // 垂直 Column 用于排列多个监测信息卡片
        Column(){
          // 使用 ForEach 对 locations 数组中的每个地点生成对应的 UI 卡片
          ForEach(this.locations, (location: LocationData) => {
            Column(){
              // 显示地点名称，前面带有图标
              Text(`📍 ${location.name}`)
                .fontSize("22fp")               // 设置标题字号
                .fontWeight(FontWeight.Bold)    // 加粗显示地点名称
                .fontColor("#2980B9")           // 使用醒目颜色
                .margin({ bottom:10 })          // 底部外边距，便于分隔

              // Row 布局显示温度和湿度信息并排显示
              Row(){
                // 温度显示，调用 toFixed 保留一位小数
                Text(`🌡 温度: ${location.temperature.toFixed(1)} °C`)
                  .fontSize("18fp")             // 设置字号
                  .fontColor("#2C3E50")         // 字体颜色
                // 湿度显示，同样保留一位小数
                Text(`💧 湿度: ${location.humidity.toFixed(1)} %`)
                  .fontSize("18fp")
                  .fontColor("#2C3E50")
              }
              .justifyContent(FlexAlign.SpaceBetween)  // 子元素之间均匀分布
              .margin({ bottom:5 })                      // 下边距调整

              // 显示二氧化碳浓度信息
              Text(`🛑 二氧化碳浓度: ${location.co2Level.toFixed(1)} ppm`)
                .fontSize("18fp")
                .fontColor("#2C3E50")
                .margin({ bottom:5 })

              // 安全预警信息区域，采用 Column 嵌套布局
              Column() {
                // 安全预警标题，根据检测结果改变颜色
                Text("⚠️ 安全预警")
                  .fontSize("18fp")
                  .fontWeight(FontWeight.Bold)
                  .fontColor(location.fireDetected || location.smokeDetected ? "#C62828" : "#388E3C")
                  .margin({ bottom:5 })
                // 火焰检测状态显示，条件渲染文本和颜色
                Text(`🔥 火焰检测: ${location.fireDetected ? "⚠️ 发现火焰!" : "✅ 安全"}`)
                  .fontSize("16fp")
                  .fontColor(location.fireDetected ? "#C62828" : "#388E3C")
                  .margin({ bottom:3 })
                // 烟雾检测状态显示，条件渲染文本和颜色
                Text(`💨 烟雾检测: ${location.smokeDetected ? "⚠️ 发现烟雾!" : "✅ 安全"}`)
                  .fontSize("16fp")
                  .fontColor(location.smokeDetected ? "#C62828" : "#388E3C")
              }
              .width("100%")    // 安全预警区域宽度占满
              .backgroundColor(location.fireDetected || location.smokeDetected ? "#FFEBEE" : "#E8F5E9")  // 背景色根据预警状态改变
              .borderRadius(10) // 圆角边框
              .shadow(3)        // 阴影效果
              .padding(10)      // 内边距
              .margin({top:5})  // 顶部外边距

            }
            .width("90%")                // 卡片宽度为父容器的 90%
            .backgroundColor("#ffffff")  // 卡片背景为白色
            .borderRadius(15)            // 卡片圆角边框
            .shadow(5)                   // 卡片阴影效果
            .padding(15)                 // 卡片内边距
            .alignSelf(ItemAlign.Center) // 卡片在父容器中居中显示
            .margin(10)                  // 卡片外边距
          })
        }
        .width("100%")
        .alignItems(HorizontalAlign.Center)
      }
      .width("100%")
      .height("83%")  // 设置滚动区域高度，占总高度的 83%

      // 刷新按钮区域，使用 Row 布局使按钮居中显示
      Row() {
        // 按钮组件，点击时刷新传感器数据
        Button("🔄 刷新数据")
          .onClick(() => {
            // 单击按钮时，调用 fetchSensorData 方法获取新数据
            this.fetchSensorData()
          })
          .width("50%")           // 按钮宽度设置
          .height("50vp")         // 按钮高度设置
          .backgroundColor("#3498DB")  // 按钮背景颜色
          .fontColor("#ffffff")   // 按钮文字颜色
          .borderRadius(10)       // 按钮圆角
          .fontSize("20fp")       // 按钮文字字号
          .shadow(5)              // 按钮阴影
      }
      .justifyContent(FlexAlign.Center) // Row 布局内居中按钮
      .margin({top:15})                // Row 顶部外边距
    }
    .width("100%")    // 主容器宽度占满屏幕
    .height("100%")   // 主容器高度占满屏幕
    .backgroundColor("#F0F8FF") // 设置背景色
    .padding(15)      // 主容器内边距
  }

  // 方法：fetchSensorData 模拟获取各个地点的传感器数据，并更新状态
  fetchSensorData() {
    // 遍历 locations 数组，为每个地点生成随机数据
    this.locations = this.locations.map((location: LocationData) => {
      return {
        name: location.name,  // 保留原有名称
        temperature: Math.random() * 10 + 20,  // 生成 20-30°C 的随机温度
        humidity: Math.random() * 50 + 30,       // 生成 30%-80% 的随机湿度
        co2Level: Math.random() * 200 + 400,       // 生成 400-600 ppm 的二氧化碳浓度
        fireDetected: Math.random() > 0.8,         // 20% 可能性检测到火焰
        smokeDetected: Math.random() > 0.85        // 15% 可能性检测到烟雾
      } as LocationData;  // 类型断言，确保数据符合 LocationData 接口
    });
  }
}
