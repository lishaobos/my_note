// import { createApp } from 'vue'
import Vue from 'vue'
import './style.css'
import App from './App.vue'
// import { createRouter, createWebHistory } from 'vue-router'
import VueRouter from 'vue-router'
import pkg from '../package.json'
import { createLifecyle, getMicroApp } from 'vite-plugin-legacy-qiankun'


Vue.use(VueRouter)

const microApp = getMicroApp(pkg.name)

// const router = createRouter({
//   history: createWebHistory(microApp.__POWERED_BY_QIANKUN__ ? pkg.name : '/'),
//   routes: [
//     {
//       path: '/',
//       name: 'home',
//       component: () => import('./home.vue')
//     },
//     {
//       path: '/about',
//       name: 'about',
//       component: () => import('./about.vue')
//     }
//   ]
// })

const router = new VueRouter({
  mode: 'history',
  base: microApp.__POWERED_BY_QIANKUN__ ? pkg.name : '/',
  routes: [
    {
      path: '/',
      name: 'home',
      component: () => import('./home.vue')
    },
    {
      path: '/about',
      name: 'about',
      component: () => import('./about.vue')
    }
  ]
})

const render = () => {
  new Vue({
    router,
    render: (h) => h(App)
  }).$mount('#app_p3')
  // createApp(App)
  //   .use(router)
  //   .mount(`#app_p3`)
}

if (microApp.__POWERED_BY_QIANKUN__) {
  createLifecyle(pkg.name, {
    mount(props) {
      console.log('mount', pkg.name);
      render();
    },
    bootstrap() {
      console.log('bootstrap', pkg.name);
    },
    unmount() {
      console.log('unmount', pkg.name)
    }
  })
} else {
  render();
}

