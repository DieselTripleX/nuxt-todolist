<template>
  <TodoList/>
</template>

<script lang="ts">
import Vue from 'vue'
export default Vue.extend({
  name: 'App'
})
</script>

<style lang="scss">
#__nuxt {
  height: 100vh;

  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  background-color: #222435;

  * {
    box-sizing: border-box;
  }

  .default-gray {
    color: #535568;
  }

  .white {
    color: white;
  }

  .big {
    font-size: 45px;
    line-height: 45px;
  }
}

body {
  margin: 0;
  padding: 0;
}
</style>
