<template>
  <a-card
    :bordered="false"
    class="header-solid h-full"
    :bodyStyle="{ padding: 0 }"
  >
    <div style="margin: 30px 0" />
    <a-form
      :form="form"
      :label-col="{ span: 2 }"
      :wrapper-col="{ span: 20 }"
      @submit="onSubmit"
    >
      <a-form-item label="제목">
        <a-input
          v-model="qna.title"
          v-decorator="[
            'title',
            { rules: [{ required: true, message: '제목을 입력해 주세요!' }] },
          ]"
        />
      </a-form-item>
      <a-form-item label="내용">
        <a-textarea
          :auto-size="{ minRows: 10, maxRows: 20 }"
          v-model="qna.content"
          v-decorator="[
            'content',
            { rules: [{ required: true, message: '내용을 입력해 주세요!' }] },
          ]"
        />
      </a-form-item>
      <a-form-item :wrapper-col="{ span: 10, offset: 2 }">
        <a-button style="margin: 10px" type="primary" html-type="submit">
          글작성
        </a-button>
        <a-button style="margin: 10px" type="danger" html-type="reset">
          초기화
        </a-button>
      </a-form-item>
    </a-form>
  </a-card>
</template>

<script>
export default {
  data() {
    return {
      formLayout: "horizontal",
      form: this.$form.createForm(this, { name: "coordinated" }),
    };
  },
  methods: {
    handleSubmit(e) {
      e.preventDefault();
      this.form.validateFields((err, values) => {
        if (!err) {
          console.log("Received values of form: ", values);
        }
      });
    },
  },
};
</script>

<script>
import http from "@/util/http-common";
import { mapState } from "vuex";
const memberStore = "memberStore";

export default {
  name: "BoardWriteForm",
  computed: {
    ...mapState(memberStore, ["isLogin", "userInfo"]),
  },
  data() {
    return {
      qna: {
        qnano: 0,
        userid: "",
        title: "",
        content: "",
      },
      isUserid: false,
    };
  },
  props: {
    type: { type: String },
  },
  created() {
    // this.qna.userid
    console.log(this.userInfo.userid);
    this.qna.userid = this.userInfo.userid;
    if (this.type === "modify") {
      http.get(`/qna/${this.$route.params.qnano}`).then(({ data }) => {
        // this.article.articleno = data.article.articleno;
        // this.article.userid = data.article.userid;
        // this.article.subject = data.article.subject;
        // this.article.content = data.article.content;
        this.qna = data;
      });
      this.isUserid = true;
    }
  },
  methods: {
    onSubmit(event) {
      event.preventDefault();

      let err = true;
      let msg = "";
      // !this.article.userid &&
      //   ((msg = "작성자 입력해주세요"),
      //   (err = false),
      //   this.$refs.userid.focus());
      err &&
        !this.qna.title &&
        ((msg = "제목 입력해주세요"), (err = false), this.$refs.title.focus());
      err &&
        !this.qna.content &&
        ((msg = "내용 입력해주세요"),
        (err = false),
        this.$refs.content.focus());

      if (!err) alert(msg);
      else this.type === "register" ? this.registQna() : this.modifyQna();
    },
    onReset(event) {
      event.preventDefault();
      this.qna.qnano = 0;
      this.qna.title = "";
      this.qna.content = "";
      this.$router.push({ name: "QnaList" });
    },
    registQna() {
      http
        .post(`/qna`, {
          userid: this.qna.userid,
          title: this.qna.title,
          content: this.qna.content,
        })
        .then(({ data }) => {
          let msg = "등록 처리시 문제가 발생했습니다.";
          if (data === "success") {
            msg = "등록이 완료되었습니다.";
          }
          alert(msg);
          this.moveList();
        });
    },
    modifyQna() {
      http
        .put(`/qna`, {
          qnano: this.qna.qnano,
          userid: this.qna.userid,
          title: this.qna.title,
          content: this.qna.content,
        })
        .then(({ data }) => {
          let msg = "수정 처리시 문제가 발생했습니다.";
          if (data === "success") {
            msg = "수정이 완료되었습니다.";
          }
          alert(msg);
          // 현재 route를 /list로 변경.
          this.$router.push({ name: "QnaList" });
        });
    },
    moveList() {
      this.$router.push({ name: "QnaList" });
    },
  },
};
</script>

<style></style>
