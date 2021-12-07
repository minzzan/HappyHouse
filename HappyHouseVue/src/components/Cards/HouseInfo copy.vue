<template>
  <a-card
    :bordered="false"
    class="header-solid h-full"
    :bodyStyle="{ paddingTop: '16px', paddingBottom: '16px' }"
  >
    <table v-if="keyword && keyword.length != 0">
      <tr>
        <td>빌딩 이름</td>
        <td>{{ house.place_name }}</td>
      </tr>
      <tr>
        <td>주소</td>
        <td>{{ house.address_name }}</td>
      </tr>
      <tr>
        <td>카테고리</td>
        <td>{{ house.category_name }}</td>
      </tr>
    </table>
    <table v-else-if="house && house.length != 0">
      <tr>
        <td>일련번호</td>
        <td>{{ house.일련번호 }}</td>
      </tr>
      <tr>
        <td>아파트 이름</td>
        <td>{{ house.아파트 }}</td>
      </tr>
      <tr>
        <td>거래금액</td>
        <td>{{ house.거래금액 }}</td>
      </tr>
      <tr>
        <td>건축년도</td>
        <td>{{ house.건축년도 }}</td>
      </tr>
      <tr>
        <td>전용면적</td>
        <td>{{ house.전용면적 }}</td>
      </tr>
      <tr>
        <td>거래날자</td>
        <td>{{ house.월 }} 월 {{ house.일 }} 일</td>
      </tr>
      <tr>
        <td>층</td>
        <td>{{ house.층 }} 층</td>
      </tr>
    </table>
  </a-card>
  <!-- / Your Transactions Card -->
</template>

<script>
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
  name: "HouseInfo",
  components: {},
  data() {
    return {
      // columns,
    };
  },

  computed: {
    ...mapState(houseStore, ["house"]),
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
