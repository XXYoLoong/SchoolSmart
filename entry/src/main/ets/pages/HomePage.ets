// HomePage.ets - 学生端主页（基于 Tabs）
import router from '@system.router';
// import { NFCService } from '../services/NFCService';
// import { GPSService } from '../services/GPSService';
// import { ScheduleService } from '../services/ScheduleService';
import HomeMain from './student/HomeMain';
// import SchedulePage from './student/SchedulePage';
// import LibraryPage from './student/LibraryPage';
// import ProfilePage from './student/ProfilePage';

@Entry
@Component
struct HomePage {
  @State selectedTab: number = 0; // 记录当前选中的 Tab 页

  build() {
    Column() {
      // Tabs 组件：底部导航栏
      Tabs({
        index: this.selectedTab,
        barPosition: BarPosition.End, // 设置导航栏在底部
      }) {
        // 主页 Tab
        TabContent() {
          HomeMain();
        }
        .tabBar({
          icon: $r('app.media.Home_tab'),
          text: "主页",
        });

        // 课程表 Tab
        TabContent() {
          //SchedulePage();
        }
        .tabBar({
          icon: $r('app.media.main_kcb'),
          text: "课程表",
        });

        // 图书馆 Tab
        TabContent() {
          //LibraryPage();
        }
        .tabBar({
          icon: $r('app.media.main_tsg'),
          text: "图书馆",
        });

        // 个人中心 Tab
        TabContent() {
          //ProfilePage();
        }
        .tabBar({
          icon: $r('app.media.Home_tab'),
          text: "我的",
        });
      }
      .width("100%")
      .height("100%")
      .backgroundColor("#ffffff");
    }
    .width("100%")
    .height("100%")
  }
}
