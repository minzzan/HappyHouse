<template>
  <!-- Your Transactions Card -->
  <a-card
    :bordered="false"
    class="header-solid h-full"
    :bodyStyle="{ paddingTop: 0, paddingBottom: '16px' }"
  >
    <template #title>
      <h6 class="font-semibold m-0">매물 정보</h6>
    </template>

    <!-- 여기에 매물 정보 넣으면 댐 -->

    <form>
      <a-row type="flex" :gutter="24">
        <a-col :span="24">
          <input
            type="text"
            name="searchkeyword"
            id="searchkeyword"
            placeholder="읍/면/동 또는 아파트명을 입력해주세요"
            autocomplete="off"
            v-model="word"
            @keydown.enter.prevent="searchKeyword"
          />
        </a-col>

        <a-col :span="8" :md="8" class="mt-20">
          <select id="sido" v-model="sidoCode" @change="gugunList">
            <option
              v-for="(sido, index) in sidos"
              :key="index"
              :value="sido.value"
            >
              {{ sido.text }}
            </option>
          </select>
        </a-col>
        <a-col :span="8" :md="8" class="mt-20">
          <select id="gugun" v-model="gugunCode" @change="dongList">
            <option
              v-for="(gugun, index) in guguns"
              :key="index"
              :value="gugun.value"
            >
              {{ gugun.text }}
            </option>
          </select>
        </a-col>
        <a-col :span="8" :md="8" class="mt-20">
          <select id="dong" v-model="dongCode" @change="searchApt">
            <option
              v-for="(dong, index) in dongs"
              :key="index"
              :value="dong.value"
            >
              {{ dong.text }}
            </option>
          </select>
        </a-col>
      </a-row>

      <!-- <a-select
        id="gugun"
        v-model="gugunCode"
        :options="guguns"
        @change="dongList"
      >
        <a-select-option value=""></a-select-option>
      </a-select>
      <a-form-select
        id="dong"
        v-model="dongCode"
        :options="dongs"
        @change="searchApt"
      ></a-form-select> -->
    </form>
  </a-card>
  <!-- / Your Transactions Card -->
</template>

<script>
import { mapState, mapActions, mapMutations } from "vuex";

const houseStore = "houseStore";
const mapStore = "mapStore";
export default {
  components: {},
  data() {
    return {
      sidoCode: null,
      gugunCode: null,
      dongCode: null,
      word: "",
    };
  },
  computed: {
    ...mapState(houseStore, ["sidos", "guguns", "dongs"]),
    ...mapState(mapStore, ["keyword"]),
    // sidos() {
    //   return this.$store.state.sidos;
    // },
  },
  created() {
    // this.$store.dispatch("getSido");
    // this.sidoList();
    this.CLEAR_SIDO_LIST();
    this.CLEAR_HOUSE();
    this.CLEAR_HOUSE_LIST();
    this.CLEAR_KEYWORD();
    this.getSido();
  },
  methods: {
    ...mapActions(houseStore, [
      "getSido",
      "getGugun",
      "getDong",
      "getHouseList",
      "selectSido",
      "selectGugun",
      "selectDong",
    ]),
    ...mapActions(mapStore, ["selectKeyword"]),

    ...mapMutations(houseStore, [
      "CLEAR_SIDO_LIST",
      "CLEAR_GUGUN_LIST",
      "CLEAR_DONG_LIST",
      "CLEAR_HOUSE_LIST",
      "CLEAR_HOUSE",
      "CLEAR_SIDO",
      "CLEAR_GUGUN",
      "CLEAR_GUGUN",
    ]),
    ...mapMutations(mapStore, ["CLEAR_KEYWORD"]),

    gugunList() {
      this.CLEAR_KEYWORD();
      // console.log(this.sidoCode);
      this.CLEAR_GUGUN_LIST();
      this.CLEAR_DONG_LIST();
      this.gugunCode = null;
      this.dongCode = null;
      if (this.sidoCode) this.getGugun(this.sidoCode);
      this.CLEAR_SIDO();
      // if (this.sidoCode) this.selectSido(this);
    },
    dongList() {
      this.CLEAR_KEYWORD();
      this.CLEAR_DONG_LIST();
      this.dongCode = null;
      if (this.gugunCode) this.getDong(this.gugunCode);
    },
    searchApt() {
      this.CLEAR_KEYWORD();
      if (this.gugunCode) this.getHouseList(this.gugunCode);
    },

    searchKeyword() {
      if (this.word) this.selectKeyword(this.word);
    },
  },
};
</script>
<style scoped>
select {
  width: 100%;
  height: 32px;
}
input {
  width: 100%;
  height: 32px;
}
</style>
