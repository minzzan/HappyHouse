<template>
  <!-- Billing Information Card -->
  <a-card
    :bordered="false"
    class="header-solid h-full"
    :bodyStyle="{ paddingTop: 0, paddingBottom: '16px' }"
  >
    <template #title>
      <h6 class="font-semibold m-0">Map</h6>
    </template>
    <a-row :gutter="[24, 24]">
      <a-col :span="24">
        <!-- 지도를 여따가 넣으면 댐 -->
      </a-col>
    </a-row>
  </a-card>
</template>

<script>
export default {
  data() {
    return {};
  },
};
</script>
