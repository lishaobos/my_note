<script setup>
</script>

<template>
  <div>
    <p>vite + vue3</p>
    <ul>
      <router-link to="/">home</router-link>
      <router-link to="/about" style="margin-left: 10px">about</router-link>
    </ul>
    <router-view></router-view>
  </div>
</template>

<style scoped>
.logo {
  height: 6em;
  padding: 1.5em;
  will-change: filter;
}
.logo:hover {
  /* filter: drop-shadow(0 0 2em #646cffaa); */
}
.logo.vue:hover {
  /* filter: drop-shadow(0 0 2em #42b883aa); */
}
</style>
