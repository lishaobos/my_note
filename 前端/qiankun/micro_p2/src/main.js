import Vue from 'vue'
import App from './App.vue'
import routerRender from './router'

Vue.config.productionTip = false

const render = () => {
    const router = routerRender()
    new Vue({
        router,
        render: h => h(App)
    }).$mount('#micro_p2')
}


// 如果是qiankun, 动态设置 webpack publicPath，防止资源加载出错
if (window.__POWERED_BY_QIANKUN__) {
    // eslint-disable-next-line no-undef
    __webpack_public_path__ = window.__INJECTED_PUBLIC_PATH_BY_QIANKUN__
}

if (!window.__POWERED_BY_QIANKUN__) {
    render();
}


export async function mount(props) {
    console.log('props from main framework', props);
    render();
}

export async function bootstrap() {
    console.log('vue app bootstraped');
}

export async function unmount() {
    console.log(123)
}
