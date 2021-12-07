<!-- 
	This is the sign in page, it uses the dashboard layout in: 
	"./layouts/Default.vue" .
 -->

<template>
  <div class="sign-in">
    <a-row type="flex" :gutter="[24, 24]" justify="space-around" align="middle">
      <!-- Sign In Form Column -->
      <a-col
        :span="24"
        :md="12"
        :lg="{ span: 12, offset: 0 }"
        :xl="{ span: 6, offset: 2 }"
        class="col-form"
      >
        <h1 class="mb-15">로그인</h1>
        <h5 class="font-regular text-muted">
          HappyHouse의 더 많은 정보를 얻기 위해 로그인 해주세요!
        </h5>

        <!-- Sign In Form -->
        <a-form
          id="components-form-demo-normal-login"
          :form="form"
          class="login-form"
          @submit="handleSubmit"
          :hideRequiredMark="true"
        >
          <!-- <a-alert
            message="아이디 또는 비밀번호를 확인하세요."
            show
            type="warning"
            v-if="isLoginError"
          /> -->
          <a-form-item class="mb-10" label="아이디" :colon="false">
            <a-input
              v-model="user.userid"
              required
              placeholder="아이디"
              @keyup.enter="confirm"
            />
          </a-form-item>
          <a-form-item class="mb-5" label="비밀번호" :colon="false">
            <a-input
              type="password"
              id="userpwd"
              v-model="user.userpwd"
              required
              placeholder="패스워드"
              @keyup.enter="confirm"
            />
          </a-form-item>
          <!-- <a-form-item class="mb-10">
            <a-switch v-model="rememberMe" /> Remember Me
          </a-form-item> -->
          <a-form-item>
            <a-button type="primary" @click="confirm" class="login-form-button">
              로그인
            </a-button>
          </a-form-item>
        </a-form>
        <!-- / Sign In Form -->

        <p class="font-semibold text-muted">
          아직 계정이 없으신가요?
          <router-link to="/sign-up" class="font-bold text-dark"
            >회원가입 하기</router-link
          >
        </p>
        <p class="font-semibold text-muted">
          비밀번호를 잊으셨나요?
          <router-link to="/findpw" class="font-bold text-dark"
            >비밀번호 찾기</router-link
          >
        </p>
      </a-col>
      <!-- / Sign In Form Column -->

      <!-- Sign In Image Column -->
      <a-col :span="24" :md="12" :lg="12" :xl="12" class="col-img">
        <img src="../assets/house.jpg" alt="" />
      </a-col>
      <!-- Sign In Image Column -->
    </a-row>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";

const memberStore = "memberStore";

export default {
  name: "MemberLogin",
  data() {
    return {
      // Binded model property for "Sign In Form" switch button for "Remember Me" .
      //   rememberMe: true,
      user: {
        userid: null,
        userpwd: null,
      },
    };
  },
  computed: {
    ...mapState(memberStore, ["isLogin", "isLoginError"]),
  },
  //   beforeCreate() {
  //     // Creates the form and adds to it component's "form" property.
  //     this.form = this.$form.createForm(this, { name: "normal_login" });
  //   },
  methods: {
    ...mapActions(memberStore, ["userConfirm", "getUserInfo"]),
    async confirm() {
      await this.userConfirm(this.user);
      let token = sessionStorage.getItem("access-token");
      console.log(token);
      if (token == null) {
        alert("아이디 비밀번호를 확인해주세요.");
      }
      if (this.isLogin) {
        await this.getUserInfo(token);
        this.$router.push({ name: "Home" });
      }
    },
    movePage() {
      this.$router.push({ name: "Sign-Up" });
    },
    // Handles input validation after submission.
    // handleSubmit(e) {
    //   e.preventDefault();
    //   this.form.validateFields((err, values) => {
    //     if (!err) {
    //       console.log("Received values of form: ", values);
    //     }
    //   });
    // },
  },
};
</script>

<style lang="scss">
body {
  background-color: #ffffff;
}
</style>
