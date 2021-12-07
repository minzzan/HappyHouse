<template>
  <!-- Authors Table Card -->
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
          <a-button @click="listArticle()" style="margin-right: 5px"
            >글목록</a-button
          >
          <a-button
            v-if="userInfo.userid == 'admin'"
            @click="moveModifyArticle()"
            style="margin-right: 5px"
            type="primary"
            >글수정</a-button
          >
          <a-button
            v-if="userInfo.userid == 'admin'"
            @click="deleteArticle()"
            type="danger"
            >글삭제</a-button
          >
        </a-col>
      </a-row>
      <a-row type="flex" align="middle">
        <h3>{{ article.subject }}</h3>
      </a-row>
      <a-row type="flex" align="middle">
        <p>조회수 : {{ article.hit }}</p>
      </a-row>
      <a-row type="flex" align="middle">
        <p>작성자 : {{ article.userid }}</p>
      </a-row>
      <a-row>
        <p>작성시각 : {{ article.regtime }}</p>
        <a-divider>내용</a-divider>
        <h5>{{ article.content }}</h5>
      </a-row>
    </template>
    <!-- table start -->

    <!-- table end  -->
  </a-card>
  <!-- / Authors Table Card -->
</template>

<script>
// import moment from "moment";
import http from "@/util/http-common";
import { mapState } from "vuex";
const memberStore = "memberStore";

export default {
  data() {
    return {
      article: {},
    };
  },
  computed: {
    ...mapState(memberStore, ["isLogin", "userInfo"]),
    message() {
      if (this.article.content)
        return this.article.content.split("\n").join("<br>");
      return "";
    },
    // changeDateFormat() {
    //   return moment(new Date(this.article.regtime)).format(
    //     "YYYY.MM.DD hh:mm:ss"
    //   );
    // },
  },
  created() {
    http.get(`/board/${this.$route.params.articleno}`).then(({ data }) => {
      this.article = data;
      console.log(this.userInfo.userid);
      console.log(this.article);
    });
  },
  methods: {
    listArticle() {
      this.$router.push({ name: "BoardList" });
    },
    moveModifyArticle() {
      this.$router.replace({
        name: "BoardUpdate",
        params: { articleno: this.article.articleno },
      });
      //   this.$router.push({ path: `/board/modify/${this.article.articleno}` });
    },
    deleteArticle() {
      if (confirm("정말로 삭제?")) {
        this.$router.replace({
          name: "BoardDelete",
          params: { articleno: this.article.articleno },
        });
      }
    },
  },
};
</script>

<style></style>
