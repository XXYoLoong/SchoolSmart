// HomeMain.ets - 主页内容
import router from '@system.router';
import { NFCService } from '../../services/NFCService';
import { GPSService } from '../../services/GPSService';
import { ScheduleService } from '../../services/ScheduleService';

@Component
struct HomeMain {
  private currentTime: string = '';
  private weather: string = '晴 25°C';
  private urgentNotice: string = '暂无紧急通知';
  private todayCourses: Array<{ name: string, time: string, location: string }> = [];

  aboutToAppear() {
    this.updateTime();
    this.loadTodayCourses();
  }

  private updateTime() {
    setInterval(() => {
      const now = new Date();
      this.currentTime = `${now.getHours()}:${now.getMinutes()}`;
    }, 60000);
  }

  private loadTodayCourses() {
    ScheduleService.getTodaySchedule().then((courses) => {
      this.todayCourses = courses;
    });
  }

  private handleSignIn() {
    NFCService.scanCard().then((data) => {
      console.log(`签到成功: ${data.userId}`);
    }).catch(() => {
      GPSService.getLocation().then((location) => {
        console.log(`GPS 签到成功: ${location}`);
      });
    });
  }

  build() {
    Column() {
      Column() {
        Text(this.currentTime)
          .fontSize(24).fontWeight(FontWeight.Bold).margin({ top: 16, bottom: 8 });
        Text(this.weather)
          .fontSize(16).margin({ bottom: 8 });
        Text(this.urgentNotice)
          .fontSize(14).fontColor(Color.Red);
      }
      .alignItems(HorizontalAlign.Center)
      .padding(16);

      Column() {
        Button('签到')
          .onClick(() => this.handleSignIn())
          .width(200).height(50).backgroundColor(Color.Blue).fontSize(18)
          .margin({ bottom: 16 });
      }
      .alignItems(HorizontalAlign.Center);

      Column() {
        Text('今日课程')
          .fontSize(18).fontWeight(FontWeight.Bold).margin({ bottom: 8 });
        List() {
          ForEach(this.todayCourses, (course) => {
            ListItem() {
              Column() {
                Text(course.name)
                  .fontSize(16).fontWeight(FontWeight.Medium);
                Text(`${course.time} - ${course.location}`)
                  .fontSize(14).fontColor(Color.Gray);
              }.padding(8);
            };
          });
        }.height(200);
      }
      .padding(16);

      Row() {
        Button('图书馆借阅')
          .onClick(() => router.push({ url: '/LibraryPage' }))
          .width(100).height(40).margin(8).backgroundColor(Color.Green);
        Button('活动报名')
          .onClick(() => router.push({ url: '/EventsPage' }))
          .width(100).height(40).margin(8).backgroundColor(Color.Orange);
      }
      .alignItems(HorizontalAlign.Center)
      .padding(16);
    }
  }
}
