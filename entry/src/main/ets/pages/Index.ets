import MainCompoments from "../components/indexpages/Main"
import CamCompoments from "../components/indexpages/CampusEnvMonitor"
import HomeCompents from "../components/indexpages/Home"

@Entry
@Component
struct Index {
  @State message: string = 'Main Pages'


  build() {
    Column() {
      Column() {
        Tabs({ barPosition: BarPosition.End }) {

          TabContent() {
            MainCompoments()
          }
          .align(Alignment.Center)
          .borderColor("#000000")
          .backgroundColor("#ffffff")
          .tabBar({ icon: $r('app.media.Main_tab'), text: "主页" })

          TabContent() {
            CamCompoments()
          }
          .tabBar({ icon: $r('app.media.CampusEnvMonitor_tab'), text: "监测" })

          TabContent() {
            HomeCompents()
          }
          .align(Alignment.Center)
          .tabBar({ icon: $r('app.media.Home_tab'), text: "我的"})

        }
        .width("100%")
        .height("100%")
      }
      .width("100%")
      .height("100%")
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.End)
    }
    .width("100%")
    .height("100%")
  }
}

function Main() {
  throw new Error('Function not implemented.')
}
