import { defineConfig } from 'vite'
// import vue from '@vitejs/plugin-vue'
import { createVuePlugin } from 'vite-plugin-vue2'
import { legacyQiankun } from 'vite-plugin-legacy-qiankun'
import legacy from '@vitejs/plugin-legacy'


// https://vitejs.dev/config/
export default defineConfig({
  // base: 'http://1.14.65.92:9529',
  server: {
    port: '9529'
  },
  plugins: [
    // vue(),
    createVuePlugin(),
    legacy(),
    legacyQiankun({ name: 'micro_p3' }),
  ]
})
