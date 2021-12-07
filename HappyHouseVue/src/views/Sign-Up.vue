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
        <h1 class="mb-5">회원가입</h1>
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
      <!-- <template #title>
        <h5 class="font-semibold text-center">Register With</h5>
      </template>
      <div class="sign-up-gateways">
        <a-button>
          <img src="images/logos/logos-facebook.svg" alt="" />
        </a-button>
        <a-button>
          <img src="images/logos/logo-apple.svg" alt="" />
        </a-button>
        <a-button>
          <img src="images/logos/Google__G__Logo.svg.png" alt="" />
        </a-button>
      </div>
      <p class="text-center my-25 font-semibold text-muted">Or</p> -->
      <a-form
        id="components-form-demo-normal-login"
        :form="form"
        class="login-form"
        @submit="onSubmit"
      >
        <a-form-item class="mb-10" style="margin-top: 10px">
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
        <a-row>
          <a-col :span="18">
            <a-form-item class="mb-10">
              <a-input
                type="email"
                id="emailText"
                v-model="userInfo.email"
                v-decorator="[
                  'email',
                  {
                    rules: [
                      {
                        required: true,
                        message: '이메일주소를 입력해 주세요!',
                      },
                    ],
                  },
                ]"
                placeholder="이메일"
              >
              </a-input> </a-form-item
          ></a-col>
          <a-col :span="6">
            <a-button
              id="emailCheck"
              style="margin-left: 10px; margin-top: 4px"
              @click="emailSend"
              >인증번호 전송</a-button
            ></a-col
          ></a-row
        >
        <a-row>
          <a-col :span="18">
            <a-form-item class="mb-10">
              <a-input
                v-model="inputCode"
                v-decorator="[
                  'certification',
                  {
                    rules: [
                      {
                        required: true,
                        message: '인증번호를 입력해 주세요!',
                      },
                    ],
                  },
                ]"
                placeholder="인증번호"
              >
              </a-input> </a-form-item
          ></a-col>
          <a-col :span="6">
            <a-button
              v-if="!isCert"
              style="margin-left: 10px; margin-top: 4px"
              type="danger"
              @click="emailCertification"
              >인증번호 확인</a-button
            ></a-col
          ><a-col v-if="isCert" :span="6">
            <a-button style="margin-left: 10px; margin-top: 4px" disabled
              >인증됨</a-button
            ></a-col
          ></a-row
        >
        <!-- <a-form-item class="mb-10">
          <a-input
            type="email"
            id="emailText"
            v-model="userInfo.email"
            v-decorator="[
              'email',
              {
                rules: [
                  {
                    required: true,
                    message: '이메일주소를 입력해 주세요!',
                  },
                ],
              },
            ]"
            placeholder="이메일@email.com"
          >
          </a-input>
        </a-form-item> -->
        <a-form-item class="mb-10">
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
        </a-form-item>
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
            placeholder="비밀번호"
          >
          </a-input>
        </a-form-item>
        <a-form-item class="mb-5">
          <a-input
            v-model="userInfo.hint"
            v-decorator="[
              'hint',
              {
                rules: [
                  { required: true, message: '비밀번호 답변을 입력해 주세요!' },
                ],
              },
            ]"
            type="hint"
            placeholder="내가 가장 좋아하는 캐릭터는?"
          >
          </a-input>
        </a-form-item>
        <a-form-item class="mb-10">
          <a-checkbox
            v-decorator="[
              'remember',
              {
                valuePropName: 'unchecked',
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
            회원가입
          </a-button>
        </a-form-item>
      </a-form>
      <p class="font-semibold text-muted text-center">
        이미 계정이 있으신가요?
        <router-link to="/sign-in" class="font-bold text-dark"
          >로그인 하기</router-link
        >
      </p>
    </a-card>
    <!-- / Sign Up Form -->
  </div>
</template>

<script>
import http from "@/util/http-common";
import { addUser } from "@/api/member";

export default {
  name: "SignUp",
  data() {
    return {
      userInfo: {
        username: "",
        userid: "",
        userpwd: "",
        email: "",
        hint: "",
      },
      isUserid: false,
      isCert: false,
      inputCode: "",
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

      if (!this.userInfo.username) {
        msg = "이름을 입력해주세요";
      }
      if (!this.userInfo.userid) {
        msg = "아이디를 입력해주세요";
      }
      if (!this.userInfo.userpwd) {
        msg = "비밀번호를 입력해주세요";
      }
      if (!this.userInfo.email) {
        msg = "이메일을 입력해주세요";
      }
      if (!this.userInfo.hint) {
        msg = "질문 답변을 입력해주세요";
      }

      if (!err) alert(msg);
      else {
        if (!this.isCert) {
          alert("이메일 인증을 진행 해 주세요");
        } else {
          this.signUp();
        }
      }
      //   this.signUp();
    },
    signUp() {
      addUser(
        {
          username: this.userInfo.username,
          userid: this.userInfo.userid,
          userpwd: this.userInfo.userpwd,
          email: this.userInfo.email,
          hint: this.userInfo.hint,
        },
        ({ data }) => {
          let msg = "회원가입 처리시 문제가 발생했습니다.";
          if (data === "success") {
            msg = "회원가입이 완료되었습니다.";
          }
          alert(msg);
          this.moveSignIn();
        },
        (error) => {
          alert("해당 아이디를 사용할 수 없습니다.");
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
    moveSignIn() {
      this.$router.push({ name: "Sign-In" });
    },
    emailSend() {
      let clientEmail = this.userInfo.email;

      console.log("입력 이메일" + clientEmail);

      http.post(`/service/mail`, {
        userEmail: clientEmail,
      });
      alert("인증번호가 전송되었습니다.");
      // .then(({ data }) => {
      //   let msg = "전송 처리시 문제가 발생했습니다.";
      //   if (data === "success") {
      //     msg = "전송이 완료되었습니다.";
      //   }
      //   alert(msg);
      // });
    },
    emailCertification() {
      let clientEmail = this.userInfo.email;
      let inputCode = this.inputCode;
      console.log("이메일" + clientEmail);
      console.log("인증코드" + inputCode);

      http
        .post(`/service/verifyCode`, {
          inputCode: inputCode,
        })
        .then(({ data }) => {
          let msg = "등록 처리시 문제가 발생했습니다.";
          if (data == "1") {
            msg = "인증이 완료되었습니다.";
            this.isCert = true;
          }
          alert(msg);
        });
    },
  },
};
</script>

<style lang="scss"></style>
