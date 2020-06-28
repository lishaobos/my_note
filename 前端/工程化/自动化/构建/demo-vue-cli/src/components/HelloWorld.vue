<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <button @click="confirm">按钮</button>
    <h1>我是文字1212</h1>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  props: {
    msg: String
  },
  methods: {
    confirm () {
      console.log(666)
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h1 {
    color: green;
}
</style>
