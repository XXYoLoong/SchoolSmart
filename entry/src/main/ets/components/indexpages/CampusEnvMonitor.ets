import router from '@ohos.router'

interface LocationData {
  name: string;
  temperature: number;
  humidity: number;
  co2Level: number;
  fireDetected: boolean;
  smokeDetected: boolean;
}
@Entry
@Component
export default struct CampusEnvMonitor {
  @State locations: LocationData[] = [
    { name: "教学楼", temperature: 0, humidity: 0, co2Level: 0, fireDetected: false, smokeDetected: false },
    { name: "实验楼", temperature: 0, humidity: 0, co2Level: 0, fireDetected: false, smokeDetected: false },
    { name: "宿舍楼", temperature: 0, humidity: 0, co2Level: 0, fireDetected: false, smokeDetected: false },
    { name: "图书馆", temperature: 0, humidity: 0, co2Level: 0, fireDetected: false, smokeDetected: false }
  ]

  aboutToAppear(){
    this.startAutoRefresh();
  }

  startAutoRefresh() {
    setInterval(() => {
      this.fetchSensorData();
    }, 3000);
  }

  build() {
    Column(){
      Column(){
        // 标题
        Text("🌍 智慧校园环境监测系统")
          .width("100%")
          .textAlign(TextAlign.Center)
          .fontSize("28fp")
          .fontWeight(FontWeight.Bold)
          .fontColor("#2C3E50")
          .margin(5)
      }
      .width("100%")
      .alignItems(HorizontalAlign.Center)

      Scroll(){
        Column(){
          // 监测信息卡片（多个地点）
          ForEach(this.locations, (location: LocationData) => {
            Column(){
              Text(`📍 ${location.name}`)
                .fontSize("22fp")
                .fontWeight(FontWeight.Bold)
                .fontColor("#2980B9")
                .margin({ bottom:10 })

              Row(){
                Text(`🌡 温度: ${location.temperature.toFixed(1)} °C`)
                  .fontSize("18fp")
                  .fontColor("#2C3E50")
                Text(`💧 湿度: ${location.humidity.toFixed(1)} %`)
                  .fontSize("18fp")
                  .fontColor("#2C3E50")
              }
              .justifyContent(FlexAlign.SpaceBetween)
              .margin({ bottom:5 })

              Text(`🛑 二氧化碳浓度: ${location.co2Level.toFixed(1)} ppm`)
                .fontSize("18fp")
                .fontColor("#2C3E50")
                .margin({ bottom:5 })

              Column() {
                Text("⚠️ 安全预警")
                  .fontSize("18fp")
                  .fontWeight(FontWeight.Bold)
                  .fontColor(location.fireDetected || location.smokeDetected ? "#C62828" : "#388E3C")
                  .margin({ bottom:5 })
                Text(`🔥 火焰检测: ${location.fireDetected ? "⚠️ 发现火焰!" : "✅ 安全"}`)
                  .fontSize("16fp")
                  .fontColor(location.fireDetected ? "#C62828" : "#388E3C")
                  .margin({ bottom:3 })
                Text(`💨 烟雾检测: ${location.smokeDetected ? "⚠️ 发现烟雾!" : "✅ 安全"}`)
                  .fontSize("16fp")
                  .fontColor(location.smokeDetected ? "#C62828" : "#388E3C")

              }
              .width("100%")
              .backgroundColor(location.fireDetected || location.smokeDetected ? "#FFEBEE" : "#E8F5E9")
              .borderRadius(10)
              .shadow(3)
              .padding(10)
              .margin({top:5})

            }
            .width("90%")
            .backgroundColor("#ffffff")
            .borderRadius(15)
            .shadow(5)
            .padding(15)
            .alignSelf(ItemAlign.Center)
            .margin(10)

          })
        }
        .width("100%")
        .alignItems(HorizontalAlign.Center)

      }
      .width("100%")
      .height("83%")

      // 刷新按钮
      Row()
        {
        Button("🔄 刷新数据")
          .onClick(() => {
            this.fetchSensorData()
          })
          .width("50%")
          .height("50vp")
          .backgroundColor("#3498DB")
          .fontColor("#ffffff")
          .borderRadius(10)
          .fontSize("20fp")
          .shadow(5)
      }
      .justifyContent(FlexAlign.Center)
      .margin({top:15})
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#F0F8FF") // 背景色
    .padding(15)
  }

  fetchSensorData() {
    this.locations = this.locations.map((location: LocationData) => {
      return {
        name: location.name,
        temperature: Math.random() * 10 + 20,
        humidity: Math.random() * 50 + 30,
        co2Level: Math.random() * 200 + 400,
        fireDetected: Math.random() > 0.8,
        smokeDetected: Math.random() > 0.85
      } as LocationData;
    });
  }
}
