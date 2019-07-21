<template>
  <div id="app">
    <excl msg="Welcome to Your Vue.js App"/>
  </div>
</template>

<script>
import excl from './components/excl.vue'

export default {
  name: 'app',
  components: {
    excl
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
