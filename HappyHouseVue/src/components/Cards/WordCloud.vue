<template>
  <a-card :bordered="false" class="card-info">
    <a-row type="flex">
      <a-col class="col-content" :span="24" :xl="24">
        <div class="card-content">
          <a-col :span="12" :md="12">
            <h5 class="font-semibold m-0">
              <svg
                width="24"
                height="24"
                xmlns="http://www.w3.org/2000/svg"
                fill-rule="evenodd"
                clip-rule="evenodd"
              >
                <path
                  d="M15.75 18.805c-2.435-.564-5.204-2.006-4.107-4.086 3.341-6.333.886-9.719-2.642-9.719-3.599 0-5.994 3.516-2.644 9.719 1.131 2.092-1.724 3.534-4.107 4.086-2.175.504-2.257 1.588-2.25 3.484l.004.711h17.993l.003-.689c.007-1.909-.066-3-2.25-3.506zm-1.546-7.805c.397-.869.838-2.063.815-2.895-.535-.71-.837-1.625-.837-2.556 0-2.628 2.316-4.549 4.909-4.549 2.577 0 4.909 1.907 4.909 4.549 0 2.751-2.754 5.32-6.532 4.298-.686.468-2.2.939-3.264 1.153zm4.185-6.371l-1.592.22 1.159 1.114-.283 1.582 1.418-.758 1.417.758-.282-1.582 1.159-1.114-1.593-.22-.701-1.447-.702 1.447z"
                />
              </svg>
              관심있는 동네
            </h5>
            <a-row type="row-flex" justify="center" style="padding-left: 50px">
              <vue-word-cloud
                style="cursor: pointer; height: 360px; width: 480px"
                @click="onWordClick(word)"
                :words="words"
                :color="
                  ([, weight]) =>
                    weight > 10
                      ? 'DeepPink'
                      : weight > 5
                      ? 'RoyalBlue'
                      : 'Indigo'
                "
                font-family="Roboto"
              />
              <!-- <vue-word-cloud :words="words">
                <template slot-scope="{ text, weight }">
                  <div :title="weight" style="cursor: pointer">
                    {{ text }}
                  </div>
                </template>
              </vue-word-cloud> -->
            </a-row>
          </a-col>
        </div>
      </a-col>
    </a-row>
  </a-card>
</template>

<script>
import VueWordCloud from "vuewordcloud";
export default {
  components: {
    [VueWordCloud.name]: VueWordCloud,
  },
  data() {
    return {
      // words: [
      //   [
      //     text: "청담동",
      //     word: "청담동",
      //     weight: 3,
      //   ],
      //   [
      //     word: "압구정동",
      //     weight: 19,
      //   ],
      //   [
      //     word: "동교동",
      //     weight: 7,
      //   ],
      //   [
      //     word: "동춘동",
      //     weight: 3,
      //     ],
      // ],
      words: [
        ["합정동", 19],
        ["공덕동", 3],
        ["불광1동", 7],
        ["신사2동", 3],
        ["내곡동", 5],
        ["신월동", 2],
        ["오륜동", 6],
        ["잠실7동", 8],
        ["가양1동", 7],
        ["화곡본동", 5],
        ["역삼동", 13],
        ["청담동", 20],
        ["논현1동", 15],
      ],
    };
  },
  methods: {
    onWordClick(word) {
      console.log("들어왔니");
      for (let i = 0; i < this.words.length; i++) {
        let w = this.words[i][0];
        if (w == word) {
          this.words[i][1]++;
        }
      }
    },
  },
};
</script>

<style></style>
