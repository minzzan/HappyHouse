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
          <h5 class="font-semibold m-0">QnA</h5>
        </a-col>
        <a-col
          :span="24"
          :md="12"
          style="display: flex; align-items: center; justify-content: flex-end"
        >
          <a-input-group compact style="margin-right: 10px">
            <a-select
              style="width: 30%"
              default-value="nothing"
              @change="handleChange"
            >
              <a-select-option value="nothing"> --선택-- </a-select-option>
              <a-select-option value="userid"> 작성자 ID </a-select-option>
              <a-select-option value="title"> 제목 </a-select-option>
            </a-select>
            <a-input-search
              @search="onSearch"
              style="width: 70%"
              placeholder="검색어를 입력해주세요"
            />
          </a-input-group>
          <a-button v-if="userInfo.userid !== null" @click="moveWrite()"
            >글쓰기</a-button
          >
        </a-col>
      </a-row>
    </template>
    <!-- table start -->
    <template>
      <a-table :columns="columns" :data-source="qnas" :pagination="false">
        <template slot="subject" slot-scope="text, record">
          <a-button
            size="large"
            type="link"
            ghost
            @click="viewQna(record.qnano)"
            >{{ text }}</a-button
          >
        </template>
        <template slot="answercontent" slot-scope="text">
          <a-tag color="cyan" v-if="text !== null"> 답변완료 </a-tag>
          <a-tag color="pink" v-else> 답변대기 </a-tag>
        </template>
        <!-- 수정 버튼 -->
        <template slot="editBtn" slot-scope="row">
          <a-button type="link" :data-id="row.key">
            <svg
              width="20"
              height="20"
              viewBox="0 0 20 20"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                class="fill-gray-7"
                d="M13.5858 3.58579C14.3668 2.80474 15.6332 2.80474 16.4142 3.58579C17.1953 4.36683 17.1953 5.63316 16.4142 6.41421L15.6213 7.20711L12.7929 4.37868L13.5858 3.58579Z"
              />
              <path
                class="fill-gray-7"
                d="M11.3787 5.79289L3 14.1716V17H5.82842L14.2071 8.62132L11.3787 5.79289Z"
              />
            </svg>
          </a-button>
        </template>
      </a-table>
    </template>
    <!-- table end  -->
  </a-card>
  <!-- / Authors Table Card -->
</template>

<script>
import http from "@/util/http-common";
import { mapState } from "vuex";
const memberStore = "memberStore";

export default {
  name: "QnaList",
  computed: {
    ...mapState(memberStore, ["isLogin", "userInfo"]),
  },
  data() {
    return {
      qnas: [],
      //   data,
      columns: [
        {
          title: "글번호",
          dataIndex: "qnano",
          class: "font-semibold text-muted",
        },
        {
          title: "질문 제목",
          dataIndex: "title",
          width: 500,
          scopedSlots: { customRender: "subject" },
        },
        {
          title: "작성자",
          dataIndex: "userid",
          class: "font-semibold text-muted",
        },
        {
          title: "작성일",
          dataIndex: "regtime",
          class: "font-semibold text-muted",
        },
        {
          title: "답변 여부",
          dataIndex: "answercontent",
          class: "font-semibold text-muted",
          scopedSlots: { customRender: "answercontent" },
        },
        {
          title: "조회수",
          dataIndex: "hit",
          class: "font-semibold text-muted",
        },
      ],
      param: { pg: 1, spp: 20, key: null, word: null },
    };
  },
  created() {
    http.get(`/qna`, { params: this.param }).then(({ data }) => {
      this.qnas = data;
      // console.log(this.qnas);
      if (this.userInfo === null) {
        alert("로그인 해주세요.");
        this.$router.push({ name: "Sign-In" });
      }
    });
  },
  methods: {
    moveWrite() {
      this.$router.push({ name: "QnaWrite" });
    },
    viewQna(qnano) {
      this.$router.push({
        name: "QnaView",
        params: { qnano: qnano },
      });
    },
    onSearch(value) {
      this.param.word = value;
      console.log(this.param.word);
      if (this.param.key == "nothing" || this.param.key == null) {
        alert("검색조건을 선택해주세요");
      } else {
        http.get(`/qna`, { params: this.param }).then(({ data }) => {
          this.qnas = data;
          // console.log(this.qnas);
          if (this.userInfo === null) {
            alert("로그인 해주세요.");
            this.$router.push({ name: "Sign-In" });
          }
        });
      }
    },
    handleChange(value) {
      this.param.key = value;
      console.log(this.param.key);
    },
  },
};
</script>
