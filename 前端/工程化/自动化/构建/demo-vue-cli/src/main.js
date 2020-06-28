import Vue from 'vue'
import App from './App.vue'

import './style.less'

import './test.js'

Vue.config.productionTip = false

new Vue({
  render: h => h(App)
}).$mount('#app')
