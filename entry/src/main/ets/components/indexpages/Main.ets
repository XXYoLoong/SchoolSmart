import router from '@ohos.router'

@Component
struct FeatureItem {
  @Prop label: string = ""
  @Prop route: string = ""
  @Prop png: Resource

  build() {
    Column() {
      Image(this.png)
        .width("80%")
        .height("50%")
        .objectFit(ImageFit.Contain)
        .onClick(() => {
          if (this.route != "") {
            router.pushUrl({ url: this.route })
          }
        })
      Text(this.label)
        .width("100%")
        .height("50%")
        .textAlign(TextAlign.Center)
        .colorBlend('#22000000')
        .fontSize("15fp")
    }
    .width("22%")
    .height("100%")
    .margin(1)
  }
}
//跳转模块封装

@Entry
@Component
export default struct Main {
  @State message: string = '这里是主页面'
  @State videoSrc: Resource = $rawfile('Main_videa1.mp4')
  @State previewUri: Resource = $r('app.media.Main_ph1')//视频预览图片
  @State curRate: PlaybackSpeed = PlaybackSpeed.Speed_Forward_1_00_X
  @State isAutoPlay: boolean = false
  @State showControls: boolean = true
  controller: VideoController = new VideoController()
  @State carouselImages: Resource[] = [$r('app.media.Main_banner1'), $r('app.media.Main_banner2'), $r('app.media.Main_banner3')]

  build() {
    Column() {
      Text("ZZNJ·智慧校园系统\n")
        .width("100%")
        .height("5%")
        .textAlign(TextAlign.Center)
        .fontSize("25fp")
      Search({value: "你想搜索些什么"})
        .width("90%")
        .height("40vp")
        .margin(10)

      // 轮播图组件
      Swiper()
     {
        ForEach(this.carouselImages, (image: Resource) => {
          Image(image)
            .width("100%")
            .height("100%")
            .onClick(() => {
              console.info("轮播图点击")
            })
        })
      }
      .width("90%")
      .height("20%")
      .margin(10)
      .indicator(true)
      .loop(true)
      .autoPlay(true)
      .interval(3000)
      .onChange((index: number) => {
        console.info("当前轮播图索引: " + index)
      })

      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Center }) {
        FeatureItem({ label: "课程表", route: "pages/Timetable", png: $r('app.media.main_kcb') })
        FeatureItem({ label: "校园导航", route: "pages/Navigation", png: $r('app.media.main_dh') })
        FeatureItem({ label: "图书馆", route: "pages/Library", png: $r('app.media.main_tsg') })
        FeatureItem({ label: "公告·活动", route: "pages/Notifications", png: $r('app.media.main_gg') })
      }
      .width("90%")
      .height("10%")

      Row() {
        // 视频播放组件
        Video({
          src: this.videoSrc,
          previewUri: this.previewUri,
          currentProgressRate: this.curRate,
          controller: this.controller
        })
          .width("90%")
          .height(180)
          .controls(this.showControls)
          .autoPlay(this.isAutoPlay)
          .loop(false)
          .onStart(() => console.info('视频开始播放'))
          .onPause(() => console.info('视频暂停'))
          .onFinish(() => console.info('视频播放结束'))
          .onError(() => console.info('视频播放错误'))
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .margin(10)

      Row()
      {
        Image($r("app.media.Main_ph2"))
          .width("90%")
          .height(150)
          .objectFit(ImageFit.Fill)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .margin(10)

    }
    .width("100%")
    .height("100%")
  }

}
