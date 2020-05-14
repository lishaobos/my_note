### 本页面用于收集各种好用的插件和组件 

## Vue
    1.v-viewer
        说明：此插件是预览图片的组件
    2.socket.io-client 
        说明：此插件是前端组件，需要后台配合使用 socket.io，他可以处理兼容性，如果 websocket 不支持，会变为 commet 长连接
    3.postcss-px-to-viewport
        说明: 此插件是针对移动端开发,可以自动把 px 转为 vw 单位,达到所有设备视窗适配,详细配置去看官网
        使用:
            # in vue.config.js
            module.exports = {
                css: {
                    loaderOptions: {
                        postcss: {
                            plugins: loader => [
                            require('postcss-px-to-viewport')({
                                viewportWidth: 750,
                                unitPrecision: 6,
                                minPixelValue: 1,
                                viewportUnit: 'vw',
                                fontViewportUnit: 'vw',
                                mediaQuery: false,
                                selectorBlackList: ['html', 'body'],
                                exclude: /node_modules/
                            })
                            ]
                        }
                    }
                }
            }
    4.vue-clipboard2
        说明：拷贝内容到粘贴版

## 通用
    1.storybook
        说明：此应用用于编写前端 ui组件 文档
    2.vuePress
        说明：此应用用于编写前端文档
    3.html2canvas
        说明：此插件用于前端截屏
    4.eruda
        说明：可以方便调试移动端
    5.sentry
        说明：收集错误日志，没有平台限制，极其好用
    6.sortableJs
        说明：轻松拖拽
        
## vscode
    1.csscomb
        说明：格式化CSS，可排序
