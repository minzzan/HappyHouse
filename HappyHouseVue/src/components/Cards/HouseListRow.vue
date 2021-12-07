<template>
  <tr
    v-if="keyword && keyword.length != 0"
    class="index m-2"
    @click="selectHouse"
    @mouseover="colorChange(true)"
    @mouseout="colorChange(false)"
    :class="{ 'mouse-over-bgcolor': isColor }"
  >
    <td style="text-align: center">{{ house.place_name }}</td>
    <td style="text-align: center">{{ house.address_name }}</td>
    <td style="text-align: center">{{ house.category_name }}</td>
    <td style="text-align: center" class="interest" @click="interest">
      <span class="material-icons">star_outline</span>
    </td>
  </tr>

  <tr
    v-else-if="house && house.length != 0"
    class="index m-2"
    @click="selectHouse"
    @mouseover="colorChange(true)"
    @mouseout="colorChange(false)"
    :class="{ 'mouse-over-bgcolor': isColor }"
  >
    <td style="text-align: center">[{{ house.일련번호 }}]</td>
    <td style="text-align: center">{{ house.아파트 }}</td>
    <td style="text-align: center">{{ house.거래금액 }}</td>
    <td style="text-align: center">{{ house.건축년도 }}</td>
    <td style="text-align: center">{{ house.전용면적 }}</td>
    <td style="text-align: center">{{ house.월 }}월 {{ house.일 }}일</td>
    <td style="text-align: center">{{ house.층 }}층</td>
    <td style="text-align: center" class="interest" @click="interest">
      <span class="material-icons">star_outline</span>
    </td>
  </tr>
</template>

<script>
import { mapState, mapActions } from "vuex";

const houseStore = "houseStore";
const mapStore = "mapStore";

export default {
  name: "HouseListRow",
  data() {
    return {
      isColor: false,
    };
  },
  props: {
    house: Object,
  },
  computed: {
    ...mapState(houseStore, ["interest"]),
  },
  methods: {
    ...mapActions(houseStore, ["detailHouse", "selectInterest"]),
    selectHouse() {
      // console.log("listRow : ", this.house);
      // this.$store.dispatch("getHouse", this.house);
      this.detailHouse(this.house);
    },
    colorChange(flag) {
      this.isColor = flag;
    },
    interest() {
      this.selectInterest(this.house);
    },
  },
  computed: {
    ...mapState(mapStore, ["keyword"]),
  },
};
</script>

<style scoped>
.index {
  cursor: pointer;
}
.mouse-over-bgcolor {
  background-color: lightblue;
}

table,
td,
tr {
  border: solid black 1px;
  text-align: center;
  font-size: 15px;
}
</style>
