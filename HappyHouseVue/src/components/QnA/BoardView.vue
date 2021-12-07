<template>
  <div>
    <!-- Authors Table Card -->
    <a-card
      :bordered="false"
      class="header-solid h-full"
      :bodyStyle="{ padding: 0 }"
    >
      <template #title
        ><a-row :gutter="24" type="flex" align="stretch">
          <a-col :span="24" :xl="24" class="mb-24">
            <a-row type="flex" align="middle">
              <a-col :span="24" :md="12">
                <h5 class="font-semibold m-0">QnA</h5>
              </a-col>
              <a-col
                :span="24"
                :md="12"
                style="
                  display: flex;
                  align-items: center;
                  justify-content: flex-end;
                "
              >
                <a-button @click="listQna()" style="margin-right: 5px"
                  >글목록</a-button
                >
                <a-button
                  @click="moveModifyQna()"
                  v-if="isWrite"
                  style="margin-right: 5px"
                  type="primary"
                  >글수정</a-button
                >
                <a-button
                  @click="deleteQna()"
                  v-if="isWrite"
                  style="margin-right: 5px"
                  type="danger"
                  >글삭제</a-button
                >
                <a-button
                  @click="moveWriteAnswer()"
                  v-if="userInfo.userid == 'admin' && qna.answercontent == null"
                  style="margin-right: 5px"
                  type="dark"
                  >답변 등록</a-button
                >
                <a-button
                  @click="moveWriteAnswer()"
                  v-if="userInfo.userid == 'admin' && qna.answercontent != null"
                  style="margin-right: 5px"
                  type="dark"
                  >답변 수정</a-button
                >
                <!-- <a-button
                  @click="deleteAnswer()"
                  v-if="userInfo.userid == 'admin' && qna.answercontent != null"
                  style="margin-right: 5px"
                  type="danger"
                  >답변 삭제</a-button
                > -->
              </a-col>
            </a-row>
            <a-row type="flex" align="middle">
              <h3>{{ qna.title }}</h3>
            </a-row>
            <a-row type="flex" align="middle">
              <p>조회수 : {{ qna.hit }}</p>
            </a-row>
            <a-row type="flex" align="middle">
              <p>작성자 : {{ qna.userid }}</p>
            </a-row>
            <a-row>
              <p>작성시각 : {{ qna.regtime }}</p>
              <a-divider>내용</a-divider>
              <h5>{{ qna.content }}</h5>
            </a-row>
          </a-col>
        </a-row>
      </template>
      <!-- table start -->

      <!-- table end  -->
    </a-card>
    <!-- / Authors Table Card -->

    <a-row
      v-if="qna.answercontent !== null"
      :gutter="24"
      type="flex"
      align="stretch"
      ><a-divider>답변</a-divider>
      <a-col :span="24" :xl="24" class="mb-24">
        <answer-view></answer-view>
      </a-col>
    </a-row>
  </div>
</template>

<script>
// import moment from "moment";
import http from "@/util/http-common";
import AnswerView from "./AnswerView.vue";
import { mapState } from "vuex";
const memberStore = "memberStore";

export default {
  components: {
    AnswerView,
  },
  data() {
    return {
      qna: {},
      isWrite: false,
    };
  },
  computed: {
    ...mapState(memberStore, ["isLogin", "userInfo"]),
    message() {
      if (this.qna.content) return this.qna.content.split("\n").join("<br>");
      return "";
    },
    // changeDateFormat() {
    //   return moment(new Date(this.article.regtime)).format(
    //     "YYYY.MM.DD hh:mm:ss"
    //   );
    // },
  },
  created() {
    http.get(`/qna/${this.$route.params.qnano}`).then(({ data }) => {
      console.log(this.userInfo);
      this.qna = data;
      if (this.qna.userid == this.userInfo.userid) {
        this.isWrite = true;
      }
      // console.log("qna" + this.qna.userid);
      // console.log("userInfo" + this.userInfo.userid);
      console.log(this.isWrite);
    });
  },
  methods: {
    listQna() {
      this.$router.push({ name: "QnaList" });
    },
    moveModifyQna() {
      this.$router.replace({
        name: "QnaUpdate",
        params: { qnano: this.qna.qnano },
      });
      //   this.$router.push({ path: `/board/modify/${this.article.articleno}` });
    },
    moveWriteAnswer() {
      this.$router.replace({
        name: "AnswerWrite",
        params: { qnano: this.qna.qnano },
      });
      //   this.$router.push({ path: `/board/modify/${this.article.articleno}` });
    },
    deleteQna() {
      if (confirm("정말로 삭제하시겠습니까?")) {
        this.$router.replace({
          name: "QnaDelete",
          params: { qnano: this.qna.qnano },
        });
      }
    },
    // deleteAnswer() {
    //   if (confirm("정말로 삭제하시겠습니까?")) {
    //     this.qna.answercontent = "";
    //     this.$router.push({ name: "QnaList" });
    //   }
    // },
  },
};
</script>

<style></style>
