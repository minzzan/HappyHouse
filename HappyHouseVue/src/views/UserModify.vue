<!-- 
	This is the sign up page, it uses the dashboard layout in: 
	"./layouts/Default.vue" .
 -->

<template>
  <div>
    <!-- Sign Up Image And Headings -->
    <div
      class="sign-up-header"
      style="background-image: url('images/bg-signup.jpg')"
    >
      <div class="content">
        <h1 class="mb-5">회원정보 수정</h1>
        <p class="text-lg">HappyHouse에 오신것을 환영합니다!</p>
      </div>
    </div>
    <!-- / Sign Up Image And Headings -->

    <!-- Sign Up Form -->
    <a-card
      :bordered="false"
      class="card-signup header-solid h-full"
      :bodyStyle="{ paddingTop: 0 }"
    >
      <a-form
        id="components-form-demo-normal-login"
        :form="form"
        class="login-form"
        @submit="onSubmit"
        style="padding-top: 30px"
      >
        <span>{{ userInfo.userid }}님의 회원 수정하기</span>
        <a-form-item class="mb-10">
          <a-input
            v-model="userInfo.username"
            v-decorator="[
              'username',
              {
                rules: [{ required: true, message: '이름을 입력해 주세요!' }],
              },
            ]"
            placeholder="이름"
          >
          </a-input>
        </a-form-item>
        <a-form-item class="mb-10">
          <a-input
            v-model="userInfo.email"
            v-decorator="[
              'email',
              {
                rules: [
                  { required: true, message: '이메일주소를 입력해 주세요!' },
                ],
              },
            ]"
            placeholder="이메일"
          >
          </a-input>
        </a-form-item>
        <!-- <a-form-item class="mb-10">
          <a-input
            v-model="userInfo.userid"
            v-decorator="[
              'userid',
              {
                rules: [{ required: true, message: '아이디를 입력해 주세요!' }],
              },
            ]"
            placeholder="아이디"
          >
          </a-input>
        </a-form-item> -->
        <a-form-item class="mb-5">
          <a-input
            v-model="userInfo.userpwd"
            v-decorator="[
              'userpwd',
              {
                rules: [
                  { required: true, message: '비밀번호를 입력해 주세요!' },
                ],
              },
            ]"
            type="password"
            placeholder="Password"
          >
          </a-input>
        </a-form-item>
        <a-form-item class="mb-10">
          <a-checkbox
            v-decorator="[
              'remember',
              {
                valuePropName: 'checked',
                initialValue: true,
              },
            ]"
          >
            <a href="#" class="font-bold text-dark">개인정보 이용약관</a>
            에 동의합니다
          </a-checkbox>
        </a-form-item>
        <a-form-item>
          <a-button
            type="primary"
            block
            html-type="submit"
            class="login-form-button"
          >
            수정하기
          </a-button>
        </a-form-item>
      </a-form>
      <p class="font-semibold text-muted text-center">
        <router-link to="/" class="font-bold text-dark"
          >홈으로 이동</router-link
        >
      </p>
    </a-card>
    <!-- / Sign Up Form -->
  </div>
</template>

<script>
import { modifyUser } from "@/api/member";
import { mapState, mapMutations } from "vuex";
const memberStore = "memberStore";

export default {
  computed: {
    ...mapState(memberStore, ["isLogin", "userInfo"]),
  },
  name: "UserModify",
  data() {
    return {
      // userInfo: {
      //   username: "",
      //   userid: "",
      //   userpwd: "",
      //   email: "",
      // },
      isUserid: false,
    };
  },
  props: {
    type: { type: String },
  },
  beforeCreate() {
    // Creates the form and adds to it component's "form" property.
    this.form = this.$form.createForm(this, { name: "normal_login" });
  },
  methods: {
    onSubmit(event) {
      event.preventDefault();

      let err = true;
      let msg = "";
      !this.userInfo.username &&
        ((msg = "이름을 입력해주세요"),
        (err = false),
        this.$refs.username.focus());
      err &&
        !this.userInfo.userid &&
        ((msg = "아이디를 입력해주세요"),
        (err = false),
        this.$refs.userid.focus());
      err &&
        !this.userInfo.userpwd &&
        ((msg = "패스워드를 입력해주세요"),
        (err = false),
        this.$refs.userpwd.focus());

      if (!err) alert(msg);
      else this.signUp();
      //   this.signUp();
    },
    ...mapMutations(memberStore, ["SET_IS_LOGIN", "SET_USER_INFO"]),
    signUp() {
      modifyUser(
        {
          username: this.userInfo.username,
          userid: this.userInfo.userid,
          userpwd: this.userInfo.userpwd,
          email: this.userInfo.email,
        },
        ({ data }) => {
          let msg = "회원 수정 시 처리시 문제가 발생했습니다.";
          if (data === "success") {
            msg = "회원 수정이 완료되었습니다.";
          }
          alert(msg);
          this.SET_USER_INFO(this.userInfo);
          this.moveHome();
        },
        (error) => {
          console.log(error);
        }
      );
    },
    // Handles input validation after submission.
    handleSubmit(e) {
      e.preventDefault();
      this.form.validateFields((err, values) => {
        if (!err) {
          console.log("Received values of form: ", values);
        }
      });
    },
    moveHome() {
      this.$router.push({ name: "Home" });
    },
  },
};
</script>

<style lang="scss"></style>
