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
        <h1 class="mb-15">비밀번호 찾기</h1>
        <h5 class="font-regular text-muted">비밀번호를 잊으셨나요?</h5>

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
          <a-form-item
            class="mb-5"
            label="가장 좋아하는 캐릭터는?"
            :colon="false"
          >
            <a-input
              type="hint"
              id="hint"
              v-model="user.hint"
              required
              placeholder="답변"
              @keyup.enter="confirm"
            />
          </a-form-item>
          <!-- <a-form-item class="mb-10">
            <a-switch v-model="rememberMe" /> Remember Me
          </a-form-item> -->
          <a-form-item>
            <a-button type="primary" @click="confirm" class="login-form-button">
              비밀번호 찾기
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
      </a-col>
      <!-- / Sign In Form Column -->

      <!-- Sign In Image Column -->
      <a-col :span="24" :md="12" :lg="12" :xl="12" class="col-img">
        <img src="../assets/keybg.png" alt="" />
      </a-col>
      <!-- Sign In Image Column -->
    </a-row>
  </div>
</template>

<script>
import http from "@/util/http-common";
export default {
  name: "MemberLogin",
  data() {
    return {
      user: {
        username: "",
        userid: "",
        userpwd: "",
        email: "",
        hint: "",
      },
      password: "",
    };
  },
  methods: {
    confirm() {
      http
        .post(`/user/findpw`, {
          username: this.user.username,
          userid: this.user.userid,
          userpwd: this.user.userpwd,
          email: this.user.email,
          hint: this.user.hint,
        })
        .then(({ data }) => {
          if (data == null) {
            alert("입력하신 정보가 없습니다.");
          } else {
            this.password = data;
            console.log(this.password);
            alert("회원님의 비밀번호는 " + this.password + "입니다.");
          }
        });
    },
    movePage() {
      this.$router.push({ name: "Sign-Up" });
    },
  },
};
</script>

<style lang="scss">
body {
  background-color: #ffffff;
}
</style>
