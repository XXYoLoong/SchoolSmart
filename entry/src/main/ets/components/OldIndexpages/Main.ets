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

// 导入路由模块，用于页面跳转操作
import router from '@ohos.router'

// FeatureItem 组件用于展示单个功能入口，包括图标和标签
@Component
struct FeatureItem {
  // 定义传入属性：显示的标签文本
  @Prop label: string = ""
  // 定义传入属性：点击后跳转的路由地址（若为空则不跳转）
  @Prop route: string = ""
  // 定义传入属性：用于显示的图标资源
  @Prop png: Resource

  // 构建 FeatureItem 的UI布局
  build() {
    // 使用 Column 布局将图标和标签垂直排列
    Column() {
      // 图片组件，展示功能图标
      Image(this.png)
        .width("80%")                     // 图标宽度为父容器的80%
        .height("50%")                    // 图标高度为父容器的50%
        .objectFit(ImageFit.Contain)      // 设置图片适应模式为包含，保持图标比例
        .onClick(() => {                  // 点击图标时触发事件
          if (this.route != "") {         // 若路由不为空，则执行页面跳转
            router.pushUrl({ url: this.route })
          }
        })
      // 文本组件，显示功能标签
      Text(this.label)
        .width("100%")                    // 文本宽度占满父容器
        .height("50%")                    // 文本高度为父容器的50%
        .textAlign(TextAlign.Center)      // 文本居中显示
        .colorBlend('#22000000')          // 设置文字颜色混合效果，增强视觉效果
        .fontSize("15fp")                 // 设置文字大小为15fp
    }
    .width("22%")                       // FeatureItem整体宽度占父容器的22%
    .height("100%")                     // 高度占满父容器
    .margin(1)                          // 设置边距，确保多个FeatureItem间有间隔
  }
}

// 跳转模块封装：Main组件为主页面入口，展示搜索、轮播图、功能入口及视频播放
@Entry
@Component
export default struct Main {
  // 定义主页面状态变量和资源
  @State message: string = '这里是主页面'                              // 页面提示信息
  @State videoSrc: Resource = $rawfile('Main_videa1.mp4')               // 视频文件资源
  @State previewUri: Resource = $r('app.media.Main_ph1')                // 视频预览图片资源
  @State curRate: PlaybackSpeed = PlaybackSpeed.Speed_Forward_1_00_X      // 视频播放速度状态
  @State isAutoPlay: boolean = false                                    // 是否自动播放视频
  @State showControls: boolean = true                                   // 是否显示视频播放控制按钮
  controller: VideoController = new VideoController()                   // 视频播放控制器实例
  // 定义轮播图中显示的图片资源数组
  @State carouselImages: Resource[] = [
    $r('app.media.Main_banner1'),
    $r('app.media.Main_banner2'),
    $r('app.media.Main_banner3')
  ]

  // 构建主页面UI结构
  build() {
    // 主垂直布局容器，按垂直方向排列各模块
    Column() {
      // 标题文本，展示系统名称
      Text("ZZNJ·智慧校园系统\n")
        .width("100%")                  // 标题宽度占满全屏
        .height("5%")                   // 高度占屏幕5%
        .textAlign(TextAlign.Center)    // 标题文字居中显示
        .fontSize("25fp")               // 设置标题文字大小

      // 搜索组件，预设搜索提示文字
      Search({ value: "你想搜索些什么" })
        .width("90%")                   // 搜索框宽度90%
        .height("40vp")                 // 搜索框高度为40vp单位
        .margin(10)                     // 设置外边距为10单位

      // 轮播图组件，用于展示多个横幅图片
      Swiper() {
        // 遍历轮播图图片资源数组，逐一生成图片组件
        ForEach(this.carouselImages, (image: Resource) => {
          Image(image)
            .width("100%")              // 图片宽度占满Swiper容器
            .height("100%")             // 图片高度占满Swiper容器
            .onClick(() => {            // 点击图片时输出日志
              console.info("轮播图点击")
            })
        })
      }
      .width("90%")                     // Swiper整体宽度为90%
      .height("20%")                    // 高度占屏幕20%
      .margin(10)                       // 外边距10单位
      .indicator(true)                  // 显示轮播图指示器
      .loop(true)                       // 启用循环播放
      .autoPlay(true)                   // 启用自动播放模式
      .interval(3000)                   // 自动播放间隔3000毫秒
      .onChange((index: number) => {     // 轮播图切换回调
        console.info("当前轮播图索引: " + index)
      })

      // Flex 布局区域，用于展示功能入口模块（FeatureItem组件）
      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Center }) {
        // 调用 FeatureItem 组件，传递功能标签、路由和图标资源
        FeatureItem({ label: "课程表", route: "pages/Timetable", png: $r('app.media.main_kcb') })
        FeatureItem({ label: "校园导航", route: "pages/Navigation", png: $r('app.media.main_dh') })
        FeatureItem({ label: "图书馆", route: "pages/Library", png: $r('app.media.main_tsg') })
        FeatureItem({ label: "公告·活动", route: "pages/Notifications", png: $r('app.media.main_gg') })
      }
      .width("90%")                     // 功能入口区域宽度90%
      .height("10%")                    // 高度占屏幕10%

      // 视频播放区域，使用Row布局确保居中显示
      Row() {
        // Video组件用于展示视频，配置相关参数与回调
        Video({
          src: this.videoSrc,               // 视频源文件
          previewUri: this.previewUri,        // 视频预览图片
          currentProgressRate: this.curRate,  // 当前播放速度
          controller: this.controller         // 播放控制器
        })
          .width("90%")                    // 视频组件宽度90%
          .height(180)                     // 固定高度为180像素
          .controls(this.showControls)     // 显示或隐藏播放控制条
          .autoPlay(this.isAutoPlay)         // 是否自动播放视频
          .loop(false)                     // 不循环播放
          .onStart(() => console.info('视频开始播放'))  // 视频开始播放回调
          .onPause(() => console.info('视频暂停'))      // 视频暂停回调
          .onFinish(() => console.info('视频播放结束'))    // 视频播放结束回调
          .onError(() => console.info('视频播放错误'))     // 视频播放错误回调
      }
      .justifyContent(FlexAlign.Center)   // 水平居中视频组件
      .alignItems(VerticalAlign.Center)   // 垂直居中视频组件
      .margin(10)                         // 外边距10单位

      // 单独图片展示区域，用于补充说明或广告展示
      Row() {
        Image($r("app.media.Main_ph2"))
          .width("90%")                   // 图片宽度90%
          .height(150)                    // 固定高度150像素
          .objectFit(ImageFit.Fill)       // 图片填充模式设置为填充整个容器
      }
      .justifyContent(FlexAlign.Center)   // 图片区域水平居中
      .alignItems(VerticalAlign.Center)   // 图片区域垂直居中
      .margin(10)                         // 外边距10单位

    }
    .width("100%")                        // 主容器宽度100%
    .height("100%")                       // 主容器高度100%
  }
}
