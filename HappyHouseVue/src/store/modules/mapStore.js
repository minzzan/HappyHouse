const mapStore = {
  namespaced: true,
  state: {
    keyword: "",
  },
  getters: {},
  mutations: {
    SET_KEYWORD: (state, keyword) => {
      state.keyword = keyword;
    },
    CLEAR_KEYWORD: (state) => {
      state.keyword = "";
    },
  },
  actions: {
    selectKeyword: ({ commit }, keyword) => {
      commit("SET_KEYWORD", keyword);
    },
  },
};
export default mapStore;
