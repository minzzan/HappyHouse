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
          v-model="article.subject"
          v-decorator="[
            'subject',
            { rules: [{ required: true, message: '제목을 입력해 주세요!' }] },
          ]"
        />
      </a-form-item>
      <a-form-item label="내용">
        <a-textarea
          :auto-size="{ minRows: 10, maxRows: 20 }"
          v-model="article.content"
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

export default {
  name: "BoardWriteForm",
  data() {
    return {
      article: {
        articleno: 0,
        userid: "admin",
        subject: "",
        content: "",
      },
      isUserid: false,
    };
  },
  props: {
    type: { type: String },
  },
  created() {
    if (this.type === "modify") {
      http.get(`/board/${this.$route.params.articleno}`).then(({ data }) => {
        // this.article.articleno = data.article.articleno;
        // this.article.userid = data.article.userid;
        // this.article.subject = data.article.subject;
        // this.article.content = data.article.content;
        this.article = data;
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
        !this.article.subject &&
        ((msg = "제목 입력해주세요"),
        (err = false),
        this.$refs.subject.focus());
      err &&
        !this.article.content &&
        ((msg = "내용 입력해주세요"),
        (err = false),
        this.$refs.content.focus());

      if (!err) alert(msg);
      else
        this.type === "register" ? this.registArticle() : this.modifyArticle();
    },
    onReset(event) {
      event.preventDefault();
      this.article.articleno = 0;
      this.article.subject = "";
      this.article.content = "";
      this.$router.push({ name: "BoardList" });
    },
    registArticle() {
      http
        .post(`/board`, {
          userid: this.article.userid,
          subject: this.article.subject,
          content: this.article.content,
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
    modifyArticle() {
      http
        .put(`/board`, {
          articleno: this.article.articleno,
          userid: this.article.userid,
          subject: this.article.subject,
          content: this.article.content,
        })
        .then(({ data }) => {
          let msg = "수정 처리시 문제가 발생했습니다.";
          if (data === "success") {
            msg = "수정이 완료되었습니다.";
          }
          alert(msg);
          // 현재 route를 /list로 변경.
          this.$router.push({ name: "BoardList" });
        });
    },
    moveList() {
      this.$router.push({ name: "BoardList" });
    },
  },
};
</script>

<style></style>
