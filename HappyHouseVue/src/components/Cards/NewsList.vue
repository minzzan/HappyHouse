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
          <h5 class="font-semibold m-0">관련 기사</h5>
        </a-col>
      </a-row>
    </template>
    <!-- table start -->
    <template>
      <a-table :columns="columns" :data-source="news" :pagination="false">
        <template slot="subject" slot-scope="text, record">
          <a :href="record.link">{{ text }}</a>
        </template>
      </a-table>
    </template>
    <!-- table end  -->
  </a-card>
  <!-- / Authors Table Card -->
</template>

<script>
import { listNews } from "@/api/news.js";

export default {
  name: "NewsList",
  data() {
    return {
      news: [],
      //   data,
      columns: [
        {
          title: "기사 제목",
          dataIndex: "title",
          width: "70%",
          scopedSlots: { customRender: "subject" },
        },
        {
          title: "작성일",
          dataIndex: "pubDate",
          class: "font-semibold text-muted",
        },
      ],
      param: { pg: 1, spp: 20, key: null, word: null },
    };
  },
  created() {
    listNews(
      this.param,
      (response) => {
        // this.news = response.data.items;
        var stringified = JSON.stringify(response.data.items);
        stringified = stringified.replace(/&quot;/g, " ");
        stringified = stringified.replace("<b>", "");
        stringified = stringified.replace("</b>", "");
        // console.log(stringified);
        this.news = JSON.parse(stringified);
      },
      (error) => {
        console.log(error);
      }
    );
  },
  methods: {
    moveWrite() {
      this.$router.push({ name: "QnaWrite" });
    },
    viewNews(qnano) {
      this.$router.push({
        name: "QnaView",
        params: { qnano: qnano },
      });
    },

    handleChange(value) {
      this.param.key = value;
      console.log(this.param.key);
    },
  },
};
</script>
