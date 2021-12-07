import { sidoList, gugunList, dongList, houseList } from "@/api/house.js";

const houseStore = {
  namespaced: true,
  state: {
    sidos: [{ value: null, text: "선택하세요" }],
    guguns: [{ value: null, text: "선택하세요" }],
    dongs: [{ value: null, text: "선택하세요" }],

    sido: "", // 현재 선택된 시
    gugun: "", // 현재 선택된 구
    dong: "", // 현재 선택된 동

    houses: [],
    house: null,

    interest: [],
  },

  getters: {},

  mutations: {
    SET_SIDO_LIST: (state, sidos) => {
      sidos.forEach((sido) => {
        state.sidos.push({ value: sido.sidoCode, text: sido.sidoName });
      });
    },
    SET_GUGUN_LIST: (state, guguns) => {
      guguns.forEach((gugun) => {
        state.guguns.push({ value: gugun.gugunCode, text: gugun.gugunName });
      });
    },
    SET_DONG_LIST: (state, dongs) => {
      dongs.forEach((dong) => {
        state.dongs.push({ value: dong.dongCode, text: dong.dongName });
      });
    },
    SET_HOUSE_LIST: (state, houses) => {
      //   console.log(houses);
      state.houses = houses;
    },
    SET_DETAIL_HOUSE: (state, house) => {
      state.house = house;
    },
    SET_SIDO: (state, sido) => {
      state.sido = sido;
    },
    SET_GUGUN: (state, gugun) => {
      state.gugun = gugun;
    },
    SET_DONG: (state, dong) => {
      state.dong = dong;
    },
    SET_INTEREST: (state, house) => {
      state.interest.push(house);
    },

    CLEAR_SIDO_LIST: (state) => {
      state.sidos = [{ value: null, text: "선택하세요" }];
    },
    CLEAR_GUGUN_LIST: (state) => {
      state.guguns = [{ value: null, text: "선택하세요" }];
    },
    CLEAR_DONG_LIST: (state) => {
      state.dongs = [{ value: null, text: "선택하세요" }];
    },
    CLEAR_HOUSE_LIST: (state) => {
      state.houses = [];
    },
    CLEAR_HOUSE: (state) => {
      state.house = null;
    },
    CLEAR_SIDO: (state) => {
      state.sido = "";
    },
    CLEAR_GUGUN: (state) => {
      state.gugun = "";
    },
    CLEAR_DONG: (state) => {
      state.dong = "";
    },
  },

  actions: {
    getSido: ({ commit }) => {
      sidoList(
        ({ data }) => {
          commit("SET_SIDO_LIST", data);
        },
        (error) => {
          console.log(error);
        }
      );
    },
    getGugun: ({ commit }, sidoCode) => {
      const params = {
        sido: sidoCode,
      };
      gugunList(
        params,
        ({ data }) => {
          // console.log(commit, response);
          commit("SET_GUGUN_LIST", data);
        },
        (error) => {
          console.log(error);
        }
      );
    },
    getDong: ({ commit }, gugunCode) => {
      const params = {
        gugun: gugunCode,
      };
      dongList(
        params,
        ({ data }) => {
          commit("SET_DONG_LIST", data);
        },
        (error) => {
          console.log(error);
        }
      );
    },

    getHouseList: ({ commit }, gugunCode) => {
      // vue cli enviroment variables 검색
      //.env.local file 생성.
      // 반드시 VUE_APP으로 시작해야 한다.
      const SERVICE_KEY = process.env.VUE_APP_APT_DEAL_API_KEY;
      //   const SERVICE_KEY =
      //     "9Xo0vlglWcOBGUDxH8PPbuKnlBwbWU6aO7%2Bk3FV4baF9GXok1yxIEF%2BIwr2%2B%2F%2F4oVLT8bekKU%2Bk9ztkJO0wsBw%3D%3D";
      const today = new Date();
      const params = {
        LAWD_CD: gugunCode,
        DEAL_YMD:
          today.getFullYear().toString() + today.getUTCMonth().toString(),
        serviceKey: decodeURIComponent(SERVICE_KEY),
      };
      houseList(
        params,
        (response) => {
          commit("SET_HOUSE_LIST", response.data.response.body.items.item);
        },
        (error) => {
          console.log(error);
        }
      );
    },
    getSearchHouseList: ({ commit }, data) => {
      commit("SET_HOUSE_LIST", data);
    },

    detailHouse: ({ commit }, house) => {
      // 나중에 house.일련번호를 이용하여 API 호출
      console.log(house);
      commit("SET_DETAIL_HOUSE", house);
    },

    selectSido: ({ commit }, sido) => {
      commit("SET_SIDO", sido);
    },
    selectGugun: ({ commit }, gugun) => {
      commit("SET_GUGUN", gugun);
    },
    selectDong: ({ commit }, dong) => {
      commit("SET_DONG", dong);
    },
    selectInterest: ({ commit }, house) => {
      console.log(house);
      commit("SET_INTEREST", house);
    },
  },
};

export default houseStore;
