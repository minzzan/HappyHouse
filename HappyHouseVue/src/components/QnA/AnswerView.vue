<template>
  <a-card :bordered="false" class="card-info">
    <a-row type="flex" align="middle">
      <svg
        xmlns="http://www.w3.org/2000/svg"
        width="24"
        height="24"
        viewBox="0 0 24 24"
      >
        <path
          d="M10 13h-4v-1h4v1zm2.318-4.288l3.301 3.299-4.369.989 1.068-4.288zm11.682-5.062l-7.268 7.353-3.401-3.402 7.267-7.352 3.402 3.401zm-6 8.916v.977c0 4.107-6 2.457-6 2.457s1.518 6-2.638 6h-7.362v-20h14.056l1.977-2h-18.033v24h10.189c3.163 0 9.811-7.223 9.811-9.614v-3.843l-2 2.023z"
        />
      </svg>
      <h5>답변 내용</h5>
      <a-divider />
      <h5>{{ qna.answercontent }}</h5>
    </a-row>
  </a-card>
</template>

<script>
// import moment from "moment";
import http from "@/util/http-common";

export default {
  data() {
    return {
      qna: {},
    };
  },
  computed: {
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
      this.qna = data;
      console.log(this.qna);
    });
  },
};
</script>
