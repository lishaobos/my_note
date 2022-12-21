<template>
  <div class="home">
    <img src="/assets/vue.svg" alt="">
    我是 pro-1 的 home1111

    <button @click="click">window.microName</button>
  </div>
</template>

<script>

export default {
  name: 'Home',
  created() {
    window.microName = '1111111111111'
  },
  methods: {
    click() {
      const el = document.createElement('script')
      el.innerHTML = 'console.log(123)'
      document.body.appendChild(el)
      console.log(el)
      console.log('window.microName:', window.microName)
    }
  }
}
</script>
