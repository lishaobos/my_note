<template>
  <div class="home">
    <h1>我是 pro-2 的 home</h1>

    <img src="/assets/logo.png" alt="">

    <button @click="click">window.microName</button>

  </div>
</template>

<script>

export default {
  name: 'Home',
  created() {
    window.microName = '2222222'
  },
  methods: {
    click() {
      console.log('window.microName:', window.microName)
    }
  }
}
</script>
