<!-- 
	This is the user profile page, it uses the dashboard layout in: 
	"./layouts/Dashboard.vue" .
 -->

<template>
  <div>
    <!-- Header Background Image -->
    <div
      class="profile-nav-bg"
      style="background-image: url('images/bg-profile.jpg')"
    ></div>
    <!-- / Header Background Image -->

    <!-- User Profile Card -->
    <a-card
      :bordered="false"
      class="card-profile-head"
      :bodyStyle="{ padding: 0 }"
    >
      <template #title>
        <a-row type="flex" align="middle">
          <a-col :span="24" :md="12" class="col-info">
            <a-avatar :size="74" shape="square" icon="user" />
            <div class="avatar-info">
              <h4 class="font-semibold m-0">{{ userInfo.username }}</h4>
              <p>가입일자 : {{ userInfo.joindate }}</p>
            </div>
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
            <a-button
              type="primary"
              style="margin-right: 5px"
              @click="moveModifyUser()"
              >회원 수정</a-button
            >
            <a-button type="danger" @click="removeUser()">회원 탈퇴</a-button>
          </a-col>
        </a-row>
      </template>
    </a-card>
    <!-- User Profile Card -->

    <!-- Projects Card -->
    <a-card
      :bordered="false"
      class="header-solid h-full mb-24"
      :bodyStyle="{ paddingTop: '14px' }"
    >
      <a-row type="flex" :gutter="[24, 24]" align="stretch">
        <!-- Project Column -->
        <CardProfileInformation></CardProfileInformation>
        <!-- / Project Column -->
      </a-row>
    </a-card>
    <!-- / Projects Card -->
  </div>
</template>

<script>
import CardProfileInformation from "../components/Cards/CardProfileInformation";
import { mapState, mapMutations } from "vuex";
import { deleteUser } from "@/api/member";
const memberStore = "memberStore";

export default {
  components: {
    CardProfileInformation,
  },
  computed: {
    ...mapState(memberStore, ["isLogin", "userInfo"]),
  },
  data() {
    return {
      // Active button for the "User Profile" card's radio button group.
      profileHeaderBtns: "overview",
    };
  },
  methods: {
    moveModifyUser() {
      // this.$router.replace({
      //   name: "UserUpdate",
      // });
      this.$router.push({ path: `/update` });
    },
    ...mapMutations(memberStore, ["SET_IS_LOGIN", "SET_USER_INFO"]),
    removeUser() {
      if (confirm("정말로 탈퇴하시겠습니까?")) {
        deleteUser(this.userInfo.userid, () => {
          this.SET_IS_LOGIN(false);
          this.SET_USER_INFO(null);
          sessionStorage.removeItem("access-token");
          this.$router.push({ name: "Home" });
          alert("탈퇴가 완료되었습니다. 감사합니다.");
        });
      }
    },
  },
};
</script>

<style lang="scss"></style>
