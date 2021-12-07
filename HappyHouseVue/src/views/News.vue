<!-- 
	This is the tables page, it uses the dashboard layout in: 
	"./layouts/Dashboard.vue" .
 -->

<template>
  <div>
    <!-- News Table -->
    <a-row :gutter="24" type="flex">
      <a-col :span="24" class="mb-24">
        <router-view></router-view>
      </a-col>
    </a-row>
    <!-- / News Table -->
  </div>
</template>

<style lang="scss"></style>
<script>
export default {
  // name: "Board",
};
</script>
