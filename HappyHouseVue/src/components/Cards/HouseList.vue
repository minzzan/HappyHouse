<template>
  <a-card
    :bordered="false"
    class="header-solid h-full"
    :bodyStyle="{ height: '600px', paddingTop: '16px', paddingBottom: '16px' }"
  >
    <div>
      <table>
        <tr v-if="keyword">
          <th>빌딩이름</th>
          <th>주소</th>
          <th>카테고리</th>
          <th>즐겨찾기</th>
        </tr>
        <tr v-else-if="houses && houses.length != 0">
          <th>일련번호</th>
          <th>빌딩이름</th>
          <th>거래금액</th>
          <th>건축년도</th>
          <th>전용면적</th>
          <th>거래날자</th>
          <th>층</th>
          <th>즐겨찾기</th>
        </tr>
        <!-- <template slot="일련번호" slot-scope="일련번호">{{ 일련번호 }}</template>
    <template slot="아파트" slot-scope="아파트">{{ 아파트 }}</template>
    <template slot="거래금액" slot-scope="거래금액">{{ 거래금액 }}</template>
    <template slot="건축년도" slot-scope="건축년도">{{ 건축년도 }}년</template>
    <template slot="전용면적" slot-scope="전용면적">{{ 전용면적 }}</template>
    <template slot="월" slot-scope="value">{{ value }}월</template>
    <template slot="일" slot-scope="일">{{ 일 }}일</template>
    <template slot="층" slot-scope="층">{{ 층 }}층</template> -->
        <house-list-row
          v-for="(house, index) in houses"
          :key="index"
          :house="house"
        />
      </table>
    </div>
  </a-card>
</template>

<script>
import HouseListRow from "@/components/Cards/HouseListRow.vue";

import { mapState } from "vuex";

const houseStore = "houseStore";
const mapStore = "mapStore";

// const renderContent = (value, row, index) => {
//   const obj = {
//     children: value,
//     attrs: {},
//   };
//   if (index === 2) {
//     obj.attrs.rowSpan = 1;
//   }
//   return obj;
// };
export default {
  name: "HouseList",
  components: {
    HouseListRow,
  },
  watch: {},
  data() {
    // const columns = [
    //   {
    //     title: "일련번호",
    //     dataIndex: "일련번호",
    //     key: "일련번호",
    //     // customRender: renderContent,
    //     // class: "font-semibold text-muted",
    //   },
    //   {
    //     title: "아파트",
    //     dataIndex: "아파트",
    //     key: "아파트",
    //     // customRender: renderContent,
    //     // class: "font-semibold text-muted text-sm",
    //   },
    //   {
    //     title: "거래금액",
    //     dataIndex: "거래금액",
    //     key: "거래금액",
    //     // customRender: renderContent,
    //   },
    //   {
    //     title: "건축년도",
    //     dataIndex: "건축년도",
    //     key: "건축년도",
    //     // customRender: renderContent,
    //   },
    //   {
    //     title: "거래날자",
    //     dataIndex: "월",
    //     key: "월",
    //     // customRender: (value, row, index) => {
    //     //   const obj = {
    //     //     children: value,
    //     //     attrs: {},
    //     //   };
    //     //   if (index === 0) {
    //     //     obj.attrs.colSpan = 2;
    //     //   }

    //     //   return obj;
    //     // },
    //     colSpan: 2,
    //   },
    //   {
    //     title: "거래날자",
    //     dataIndex: "일",
    //     key: "일",
    //     // customRender: renderContent,
    //     colSpan: 0,
    //   },
    //   {
    //     title: "층",
    //     dataIndex: "층",
    //     key: "층",
    //     // customRender: renderContent,
    //   },
    // ];
    return {
      // columns,
    };
  },
  computed: {
    ...mapState(houseStore, ["houses"]),
    ...mapState(mapStore, ["keyword"]),
    // houses() {
    //   return this.$store.state.houses;
    // },
  },
};
</script>

<style scoped>
table,
td,
tr {
  border: solid black 1px;
  text-align: center;
  font-size: 15px;
}
table {
  width: 100%;
  height: 550px;
}
</style>
