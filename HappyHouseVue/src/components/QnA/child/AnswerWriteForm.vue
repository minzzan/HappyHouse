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
      <a-form-item label="답변">
        <a-textarea
          :auto-size="{ minRows: 10, maxRows: 20 }"
          v-model="qna.answercontent"
          v-decorator="[
            'answercontent',
            { rules: [{ required: true, message: '답변을 입력해 주세요!' }] },
          ]"
        />
      </a-form-item>
      <a-form-item :wrapper-col="{ span: 10, offset: 2 }">
        <a-button style="margin: 10px" type="primary" html-type="submit">
          답변 작성
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
  name: "AnswerWriteForm",
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
        answercontent: "",
      },
      isUserid: false,
    };
  },
  props: {
    type: { type: String },
  },
  created() {
    http.get(`/qna/${this.$route.params.qnano}`).then(({ data }) => {
      // this.article.articleno = data.article.articleno;
      // this.article.userid = data.article.userid;
      // this.article.subject = data.article.subject;
      // this.article.content = data.article.content;
      this.qna = data;
      console.log(this.qna);
    });
    this.isUserid = true;
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
        !this.qna.answercontent &&
        ((msg = "내용 입력해주세요"),
        (err = false),
        this.$refs.content.focus());

      if (!err) alert(msg);
      else this.registAnswer();
    },
    onReset(event) {
      event.preventDefault();
      this.qna.qnano = 0;
      this.qna.title = "";
      this.qna.content = "";
      this.$router.push({ name: "QnaList" });
    },
    registAnswer() {
      http
        .put(`/qna/answer`, {
          qnano: this.qna.qnano,
          userid: this.qna.userid,
          title: this.qna.title,
          content: this.qna.content,
          answercontent: this.qna.answercontent,
        })
        .then(({ data }) => {
          let msg = "답변 등록 중 문제가 발생했습니다.";
          if (data === "success") {
            msg = "답변 등록이 완료되었습니다.";
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
