<template>
  <!-- Authors Table Card -->
  <a-card
    :bordered="false"
    class="header-solid h-full"
    :bodyStyle="{ padding: 0 }"
  >
    <template #title>
      <a-row type="flex" align="middle">
        <a-col :span="12" :md="12">
          <h5 class="font-semibold m-0">
            <svg
              style="padding-top: 7px"
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
            >
              <path
                d="M12 2c5.514 0 10 4.486 10 10s-4.486 10-10 10-10-4.486-10-10 4.486-10 10-10zm0-2c-6.627 0-12 5.373-12 12s5.373 12 12 12 12-5.373 12-12-5.373-12-12-12zm-.001 5.75c.69 0 1.251.56 1.251 1.25s-.561 1.25-1.251 1.25-1.249-.56-1.249-1.25.559-1.25 1.249-1.25zm2.001 12.25h-4v-1c.484-.179 1-.201 1-.735v-4.467c0-.534-.516-.618-1-.797v-1h3v6.265c0 .535.517.558 1 .735v.999z"
              />
            </svg>
            공지사항
          </h5>
        </a-col>
        <a-col
          :span="12"
          :md="12"
          style="display: flex; align-items: center; justify-content: flex-end"
        >
          <a-button style="margin-bottom: 10px" @click="moveWrite()"
            >글쓰기</a-button
          >
        </a-col>
      </a-row>
      <a-row type="flex" align="middle">
        <a-col :span="24" :md="24">
          <vue-good-table
            :columns="columns2"
            :rows="articles"
            :pagination-options="{
              enabled: true,
            }"
            :search-options="{
              enabled: true,
            }"
            styleClass="vgt-table"
          >
          </vue-good-table>
        </a-col>
      </a-row>
    </template>
  </a-card>
  <!-- / Authors Table Card -->
</template>

<script>
import http from "@/util/http-common";
export default {
  name: "BoardList",
  data() {
    return {
      articles: [],
      //   data,
      columns2: [
        {
          label: "글번호",
          field: "articleno",
        },
        {
          label: "글제목",
          field: "subject",
          width: 500,
        },
        {
          label: "작성자",
          field: "userid",
        },
        {
          label: "작성일",
          field: "regtime",
        },
        {
          label: "조회수",
          field: "hit",
        },
      ],
    };
  },
  created() {
    http.get(`/board`).then(({ data }) => {
      this.articles = data;
      console.log(this.articles);
    });
  },
  methods: {
    moveWrite() {
      this.$router.push({ name: "BoardWrite" });
    },
    viewArticle(articleno) {
      this.$router.push({
        name: "BoardView",
        params: { articleno: articleno },
      });
    },
  },
};
</script>
