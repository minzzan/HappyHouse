<template>
  <!-- 공지사항 Table Card -->
  <a-card
    :bordered="false"
    class="header-solid h-full"
    :bodyStyle="{ padding: 0 }"
  >
    <template #title>
      <a-row type="flex" align="middle">
        <a-col :span="24" :md="12">
          <h5 class="font-semibold m-0">공지사항</h5>
        </a-col>
        <a-col
          :span="24"
          :md="12"
          style="display: flex; align-items: center; justify-content: flex-end"
        >
          <!-- <a-radio-group v-model="projectHeaderBtns" size="small">
            <a-radio-button value="all">ALL</a-radio-button>
            <a-radio-button value="online">ONLINE</a-radio-button>
            <a-radio-button value="stores">STORES</a-radio-button>
          </a-radio-group> -->
        </a-col>
      </a-row>
    </template>
    <a-table :columns="columns" :data-source="data" :pagination="false">
      <a-space
        slot="members"
        slot-scope="members"
        :size="-12"
        class="avatar-chips"
      >
        <template v-for="member in members">
          <a-avatar :key="member" size="small" :src="member" />
        </template>
      </a-space>

      <template slot="company" slot-scope="company">
        <h6 class="m-0">
          <img :src="company.logo" width="25" class="mr-10" />
          {{ company.name }}
        </h6>
      </template>

      <!-- <template slot="completion" slot-scope="completion">
        <span class="font-bold text-muted text-sm">{{
          completion.label ? completion.label : completion
        }}</span>
        <a-progress
          :percent="completion.value ? completion.value : completion"
          :show-info="false"
          size="small"
          :status="completion.status ? completion.status : 'normal'"
        />
      </template> -->
    </a-table>
  </a-card>
  <!-- / 공지사항 Table Card -->
</template>

<script>
export default {
  props: {
    data: {
      type: Array,
      default: () => [],
    },
    columns: {
      type: Array,
      default: () => [],
    },
  },
  data() {
    return {
      // Active button for the "Projects" table's card header radio button group.
      projectHeaderBtns: "all",
    };
  },
};
</script>
