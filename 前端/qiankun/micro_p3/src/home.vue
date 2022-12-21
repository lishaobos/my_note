<template>
  <div>
    
    home111

    <img src="/assets/logo.png" alt="">


    <button @click="click">window.microName</button>

    <div class="aaa"></div>


  </div>
</template>

<script>

export default {
  created() {
    window.microName = '33333333'
  },
  methods: {
    click () {
      console.log('window.microName:', window.microName)
    }
  }
}

</script>


<style scoped>

.aaa {
  background-image: url('/assets/logo.png');
}



</style>