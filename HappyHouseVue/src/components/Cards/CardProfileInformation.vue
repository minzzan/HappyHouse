<template>
  <!-- Profile Information Card -->
  <a-card
    :bordered="false"
    class="header-solid h-full card-profile-information"
    :bodyStyle="{ paddingTop: 0, paddingBottom: '16px' }"
    :headStyle="{ paddingRight: 0 }"
  >
    <br />
    <a-descriptions title="" :column="1">
      <a-descriptions-item label="이름">
        {{ userInfo.username }}
      </a-descriptions-item>
      <a-descriptions-item label="아이디">
        {{ userInfo.userid }}
      </a-descriptions-item>
      <a-descriptions-item label="Email">
        {{ userInfo.email }}
      </a-descriptions-item>
      <a-descriptions-item label="SNS">
        <a href="#" class="mx-5 px-5">
          <a-icon type="twitter" style="color: #3ea1ec" />
        </a>
        <a href="#" class="mx-5 px-5">
          <a-icon type="facebook" style="color: #344e86" />
        </a>
        <a href="#" class="mx-5 px-5">
          <a-icon type="instagram" style="color: #e1306c" />
        </a>
      </a-descriptions-item>
    </a-descriptions>
  </a-card>
  <!-- / Profile Information Card -->
</template>

<script>
import { mapState } from "vuex";
const memberStore = "memberStore";
export default {
  computed: {
    ...mapState(memberStore, ["isLogin", "userInfo"]),
  },
  data() {
    return {};
  },
};
</script>
