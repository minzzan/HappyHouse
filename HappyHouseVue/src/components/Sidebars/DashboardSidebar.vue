<template>
  <!-- Main Sidebar -->
  <a-layout-sider
    collapsible
    class="sider-primary"
    breakpoint="lg"
    collapsed-width="0"
    width="250px"
    :collapsed="sidebarCollapsed"
    @collapse="$emit('toggleSidebar', !sidebarCollapsed)"
    :trigger="null"
    :class="[
      'ant-layout-sider-' + sidebarColor,
      'ant-layout-sider-' + sidebarTheme,
    ]"
    theme="light"
    :style="{ backgroundColor: 'transparent' }"
  >
    <div class="brand" style="font-size: 20px" @click="this.$router.push('/')">
      <a-icon type="home" theme="outlined" /> <span>Happy House</span>
    </div>
    <!-- <div class="brand" style="font-size: 20px; font-align: center">
      <img
        src="hhlogo.PNG"
        width="150"
        style="margin-left: 30px"
        @click="this.$router.push('/')"
      />
    </div> -->
    <hr />

    <!-- Sidebar Navigation Menu -->
    <a-menu theme="light" mode="inline">
      <a-menu-item>
        <router-link to="/dashboard">
          <span class="icon">
            <svg
              width="20"
              height="20"
              viewBox="0 0 20 20"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                d="M3 4C3 3.44772 3.44772 3 4 3H16C16.5523 3 17 3.44772 17 4V6C17 6.55228 16.5523 7 16 7H4C3.44772 7 3 6.55228 3 6V4Z"
                fill="#111827"
              />
              <path
                d="M3 10C3 9.44771 3.44772 9 4 9H10C10.5523 9 11 9.44771 11 10V16C11 16.5523 10.5523 17 10 17H4C3.44772 17 3 16.5523 3 16V10Z"
                fill="#111827"
              />
              <path
                d="M14 9C13.4477 9 13 9.44771 13 10V16C13 16.5523 13.4477 17 14 17H16C16.5523 17 17 16.5523 17 16V10C17 9.44771 16.5523 9 16 9H14Z"
                fill="#111827"
              />
            </svg>
          </span>
          <span class="label">홈</span>
        </router-link>
      </a-menu-item>
      <a-menu-item>
        <router-link to="/tables">
          <span class="icon">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
            >
              <path
                d="M12 2c5.514 0 10 4.486 10 10s-4.486 10-10 10-10-4.486-10-10 4.486-10 10-10zm0-2c-6.627 0-12 5.373-12 12s5.373 12 12 12 12-5.373 12-12-5.373-12-12-12zm-.001 5.75c.69 0 1.251.56 1.251 1.25s-.561 1.25-1.251 1.25-1.249-.56-1.249-1.25.559-1.25 1.249-1.25zm2.001 12.25h-4v-1c.484-.179 1-.201 1-.735v-4.467c0-.534-.516-.618-1-.797v-1h3v6.265c0 .535.517.558 1 .735v.999z"
              />
            </svg>
          </span>
          <span class="label">공지사항</span>
        </router-link>
      </a-menu-item>
      <a-menu-item>
        <router-link to="/billing">
          <span class="icon">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
            >
              <path
                d="M12 0c-3.148 0-6 2.553-6 5.702 0 4.682 4.783 5.177 6 12.298 1.217-7.121 6-7.616 6-12.298 0-3.149-2.851-5.702-6-5.702zm0 8c-1.105 0-2-.895-2-2s.895-2 2-2 2 .895 2 2-.895 2-2 2zm12 16l-6.707-2.427-5.293 2.427-5.581-2.427-6.419 2.427 4-9 3.96-1.584c.38.516.741 1.08 1.061 1.729l-3.523 1.41-1.725 3.88 2.672-1.01 1.506-2.687-.635 3.044 4.189 1.789.495-2.021.465 2.024 4.15-1.89-.618-3.033 1.572 2.896 2.732.989-1.739-3.978-3.581-1.415c.319-.65.681-1.215 1.062-1.731l4.021 1.588 3.936 9z"
              />
            </svg>
          </span>
          <span class="label">지도</span>
        </router-link>
      </a-menu-item>
      <a-menu-item>
        <router-link to="/news">
          <span class="icon">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
            >
              <path
                d="M7 16h13v1h-13v-1zm13-3h-13v1h13v-1zm0-6h-5v1h5v-1zm0 3h-5v1h5v-1zm-17-8v17.199c0 .771-1 .771-1 0v-15.199h-2v15.98c0 1.115.905 2.02 2.02 2.02h19.958c1.117 0 2.022-.904 2.022-2.02v-17.98h-21zm19 17h-17v-15h17v15zm-9-12h-6v4h6v-4z"
              />
            </svg>
          </span>
          <span class="label">관련 기사</span>
        </router-link>
      </a-menu-item>
      <!-- <a-menu-item>
        <router-link to="/rtl">
          <span class="icon">
            <svg
              width="20"
              height="20"
              viewBox="0 0 20 20"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                fill-rule="evenodd"
                clip-rule="evenodd"
                d="M3 6C3 4.34315 4.34315 3 6 3H16C16.3788 3 16.725 3.214 16.8944 3.55279C17.0638 3.89157 17.0273 4.29698 16.8 4.6L14.25 8L16.8 11.4C17.0273 11.703 17.0638 12.1084 16.8944 12.4472C16.725 12.786 16.3788 13 16 13H6C5.44772 13 5 13.4477 5 14V17C5 17.5523 4.55228 18 4 18C3.44772 18 3 17.5523 3 17V6Z"
                fill="#111827"
              />
            </svg>
          </span>
          <span class="label">RTL</span>
        </router-link>
      </a-menu-item> -->
      <a-menu-item class="menu-item-header"> Account Pages </a-menu-item>
      <a-menu-item v-if="userInfo">
        <router-link to="/profile">
          <span class="icon">
            <svg
              width="20"
              height="20"
              viewBox="0 0 20 20"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                fill-rule="evenodd"
                clip-rule="evenodd"
                d="M18 10C18 14.4183 14.4183 18 10 18C5.58172 18 2 14.4183 2 10C2 5.58172 5.58172 2 10 2C14.4183 2 18 5.58172 18 10ZM12 7C12 8.10457 11.1046 9 10 9C8.89543 9 8 8.10457 8 7C8 5.89543 8.89543 5 10 5C11.1046 5 12 5.89543 12 7ZM9.99993 11C7.98239 11 6.24394 12.195 5.45374 13.9157C6.55403 15.192 8.18265 16 9.99998 16C11.8173 16 13.4459 15.1921 14.5462 13.9158C13.756 12.195 12.0175 11 9.99993 11Z"
                fill="#111827"
              />
            </svg>
          </span>
          <span class="label">회원정보 조회</span>
        </router-link>
      </a-menu-item>
      <a-menu-item v-if="!userInfo">
        <router-link to="/sign-in">
          <span class="icon">
            <svg
              width="20"
              height="20"
              viewBox="0 0 20 20"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                fill-rule="evenodd"
                clip-rule="evenodd"
                d="M6 2C5.44772 2 5 2.44772 5 3V4H4C2.89543 4 2 4.89543 2 6V16C2 17.1046 2.89543 18 4 18H16C17.1046 18 18 17.1046 18 16V6C18 4.89543 17.1046 4 16 4H15V3C15 2.44772 14.5523 2 14 2C13.4477 2 13 2.44772 13 3V4H7V3C7 2.44772 6.55228 2 6 2ZM6 7C5.44772 7 5 7.44772 5 8C5 8.55228 5.44772 9 6 9H14C14.5523 9 15 8.55228 15 8C15 7.44772 14.5523 7 14 7H6Z"
                fill="#111827"
              />
            </svg>
          </span>
          <span class="label">로그인</span>
        </router-link>
      </a-menu-item>
      <a-menu-item v-if="!userInfo">
        <router-link to="/sign-up">
          <span class="icon">
            <svg
              width="14px"
              height="14px"
              viewBox="0 0 14 14"
              version="1.1"
              xmlns="http://www.w3.org/2000/svg"
              xmlns:xlink="http://www.w3.org/1999/xlink"
            >
              <title>duplicate</title>
              <g
                id="Page-1"
                stroke="none"
                stroke-width="1"
                fill="none"
                fill-rule="evenodd"
              >
                <g
                  id="Tables"
                  transform="translate(-58.000000, -507.000000)"
                  fill="#BFBFBF"
                  fill-rule="nonzero"
                >
                  <g id="sidebar" transform="translate(33.000000, 43.000000)">
                    <g
                      id="sign-up"
                      transform="translate(16.000000, 455.000000)"
                    >
                      <g
                        id="duplicate"
                        transform="translate(9.000000, 9.000000)"
                      >
                        <path
                          d="M4,6 C4,4.89543 4.89543,4 6,4 L12,4 C13.1046,4 14,4.89543 14,6 L14,12 C14,13.1046 13.1046,14 12,14 L6,14 C4.89543,14 4,13.1046 4,12 L4,6 Z"
                          id="Path"
                        ></path>
                        <path
                          d="M2,0 C0.89543,0 0,0.89543 0,2 L0,8 C0,9.1046 0.89543,10 2,10 L2,4 C2,2.8954305 2.8954305,2 4,2 L10,2 L10,2 C10,0.89543 9.1046,0 8,0 L2,0 Z"
                          id="Path"
                        ></path>
                      </g>
                    </g>
                  </g>
                </g>
              </g>
            </svg>
          </span>
          <span class="label">회원가입</span>
        </router-link>
      </a-menu-item>
    </a-menu>
    <!-- / Sidebar Navigation Menu -->

    <!-- Sidebar Footer -->
    <div class="aside-footer">
      <div class="footer-box">
        <!-- <span class="icon">
          <svg
            width="20"
            height="20"
            viewBox="0 0 20 20"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              d="M3 4C3 3.44772 3.44772 3 4 3H16C16.5523 3 17 3.44772 17 4V6C17 6.55228 16.5523 7 16 7H4C3.44772 7 3 6.55228 3 6V4Z"
              fill="#111827"
            />
            <path
              d="M3 10C3 9.44771 3.44772 9 4 9H10C10.5523 9 11 9.44771 11 10V16C11 16.5523 10.5523 17 10 17H4C3.44772 17 3 16.5523 3 16V10Z"
              fill="#111827"
            />
            <path
              d="M14 9C13.4477 9 13 9.44771 13 10V16C13 16.5523 13.4477 17 14 17H16C16.5523 17 17 16.5523 17 16V10C17 9.44771 16.5523 9 16 9H14Z"
              fill="#111827"
            />
          </svg>
        </span> -->
        <h6>도움이 필요하신가요?</h6>
        <p>Q&A 게시판을 이용해주세요.</p>
        <a-button @click="moveQnA()"> Q&A 게시판 이동 </a-button>
      </div>
    </div>
    <!-- / Sidebar Footer -->

    <a-button
      v-if="userInfo"
      type="primary"
      block
      target="_blank"
      @click.prevent="onClickLogout"
    >
      로그아웃
    </a-button>
    <a-button
      v-else
      type="primary"
      block
      target="_blank"
      @click="$router.push({ name: 'Sign-In' })"
    >
      로그인
    </a-button>
  </a-layout-sider>
  <!-- / Main Sidebar -->
</template>

<script>
import { mapState, mapMutations } from "vuex";

const memberStore = "memberStore";

export default {
  computed: {
    ...mapState(memberStore, ["isLogin", "userInfo"]),
  },
  props: {
    // Sidebar collapsed status.
    sidebarCollapsed: {
      type: Boolean,
      default: false,
    },

    // Main sidebar color.
    sidebarColor: {
      type: String,
      default: "primary",
    },

    // Main sidebar theme : light, white, dark.
    sidebarTheme: {
      type: String,
      default: "light",
    },
  },
  data() {
    return {
      // sidebarCollapsedModel: this.sidebarCollapsed,
    };
  },
  methods: {
    moveQnA() {
      this.$router.push({ name: "QnA" });
    },
    ...mapMutations(memberStore, ["SET_IS_LOGIN", "SET_USER_INFO"]),
    onClickLogout() {
      this.SET_IS_LOGIN(false);
      this.SET_USER_INFO(null);
      sessionStorage.removeItem("access-token");
      alert("로그아웃 되었습니다.");
      if (this.$route.path != "/") this.$router.push({ name: "Home" });
    },
  },
};
</script>

<style>
/* @import url("https://fonts.googleapis.com/css2?family=Jua&display=swap");
span {
  font-family: "Jua", sans-serif;
} */
</style>
