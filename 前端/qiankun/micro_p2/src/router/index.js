import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'

Vue.use(VueRouter)

let router
const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/about',
    name: 'About',
    component: () => import('../views/About.vue')
  }
]

const routerRender = () => {
    router = new VueRouter({
        mode: 'history',
        base: window.__POWERED_BY_QIANKUN__ ? '/micro_p2' : '/',
        routes
    })
    return router
}

export default routerRender