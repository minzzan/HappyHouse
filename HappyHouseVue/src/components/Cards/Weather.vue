<template>
  <a-card :bordered="false" class="card-info">
    <a-row type="flex">
      <a-col class="col-content" :span="24" :xl="24">
        <div class="card-content">
          <vue-weather
            api-key="b1fd800af73a26587200639662889004"
            units="uk"
            latitude="37.403672"
            longitude="126.677860"
          />
        </div>
      </a-col>
    </a-row>
  </a-card>
</template>

<script>
import VueWeather from "vue-weather-widget";

export default {
  components: {
    VueWeather,
  },
  data() {
    return {};
  },
};
</script>
