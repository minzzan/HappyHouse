<!-- 
	This is the dashboard page, it uses the dashboard layout in: 
	"./layouts/Dashboard.vue" .
 -->

<template>
  <div>
    <!-- Cards -->

    <a-row :gutter="24" type="flex" align="stretch">
      <a-col :span="24" :xl="24" class="mb-24">
        <!-- Information Card 2 -->
        <CardInfo2></CardInfo2>
        <!-- / Information Card 2 -->
      </a-col>
      <a-col :span="24" :xl="12" class="mb-24">
        <CardInfo></CardInfo>
      </a-col>
      <a-col :span="24" :xl="12" class="mb-24">
        <Weather></Weather>
      </a-col>
    </a-row>
    <!-- / Cards -->
    <!-- Table & Timeline -->
    <a-row :gutter="24" type="flex" align="stretch">
      <!-- Table -->
      <a-col :span="24" :xl="12" class="mb-24">
        <!-- Projects Table Card -->
        <CardBoardList
          :data="tableData"
          :columns="tableColumns"
        ></CardBoardList>
        <!-- / Projects Table Card -->
      </a-col>

      <a-col :span="24" :xl="12" class="mb-24">
        <!-- Projects Table Card -->
        <!-- <CardProjectTable2
          :data="tableData"
          :columns="tableColumns"
        ></CardProjectTable2> -->
        <WordCloud></WordCloud>
        <!-- / Projects Table Card -->
      </a-col>
      <!-- / Table -->
    </a-row>
    <!-- / Table & Timeline -->
  </div>
</template>

<script>
// "Projects" table component.
import CardProjectTable from "../components/Cards/CardProjectTable";

// "Projects" table component.
import CardProjectTable2 from "../components/Cards/CardProjectTable2";

// Information card 1.
import CardInfo from "../components/Cards/CardInfo";

// Information card 2.
import CardInfo2 from "../components/Cards/CardInfo2";

import CardBoardList from "../components/Cards/CardBoardList";

import Weather from "../components/Cards/Weather";

// import WordCloud from "../components/Cards/WordCloud";
import WordCloud from "../components/Cards/WordCloud.vue";

// "Projects" table list of columns and their properties.
const tableColumns = [
  {
    title: "번호",
    // dataIndex: "members",
    class: "font-bold text-muted text-sm",
  },
  {
    title: "글제목",
    dataIndex: "company",
    scopedSlots: { customRender: "company" },
    width: 300,
  },
  {
    title: "작성자",
    // dataIndex: "members",
    class: "font-bold text-muted text-sm",
  },
];

export default {
  components: {
    CardProjectTable,
    CardProjectTable2,
    CardInfo,
    CardInfo2,
    CardBoardList,
    Weather,
    WordCloud,
  },
  data() {
    return {
      // Associating table data with its corresponding property.
      tableData,

      // Associating table columns with its corresponding property.
      tableColumns,

      // Counter Widgets Stats
      stats,
    };
  },
};
</script>

<style lang="scss"></style>
