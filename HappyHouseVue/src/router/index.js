import Vue from "vue";
import VueRouter from "vue-router";

Vue.use(VueRouter);

// const onlyAuthUser = async (to, from, next) => {
//   // console.log(store);
//   const checkUserInfo = store.getters["memberStore/checkUserInfo"];
//   const getUserInfo = store._actions["memberStore/getUserInfo"];
//   let token = sessionStorage.getItem("access-token");
//   if (checkUserInfo == null && token) {
//     await getUserInfo(token);
//   }
//   if (checkUserInfo === null) {
//     alert("로그인이 필요한 페이지입니다..");
//     // next({ name: "SignIn" });
//     router.push({ name: "Sign-In" });
//   } else {
//     console.log("로그인 했다.");
//     next();
//   }
// };

let routes = [
  {
    // will match everything
    path: "*",
    component: () => import("../views/404.vue"),
  },
  {
    path: "/",
    name: "Home",
    redirect: "/dashboard",
  },
  {
    path: "/dashboard",
    name: "Home",
    layout: "dashboard",
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () =>
      import(/* webpackChunkName: "dashboard" */ "../views/Dashboard.vue"),
  },
  {
    path: "/layout",
    name: "Layout",
    layout: "dashboard",
    redirect: "/board/list",
    component: () => import("../views/Layout.vue"),
  },
  {
    path: "/tables",
    name: "공지사항",
    layout: "dashboard",
    component: () => import("../views/Tables.vue"),
    redirect: "/tables/list",
    children: [
      {
        path: "list",
        name: "BoardList",
        component: () => import("../components/Cards/BoardList.vue"),
      },
      {
        path: "write",
        name: "BoardWrite",
        component: () => import("../components/board/BoardWrite.vue"),
      },
      {
        path: "detail/:articleno",
        name: "BoardView",
        component: () => import("../components/board/BoardView.vue"),
      },
      {
        path: "update/:articleno",
        name: "BoardUpdate",
        component: () => import("../components/board/BoardUpdate.vue"),
      },
      {
        path: "delete/:articleno",
        name: "BoardDelete",
        component: () => import("../components/board/BoardDelete.vue"),
      },
    ],
  },
  {
    path: "/qna",
    name: "QnA",
    layout: "dashboard",
    component: () => import("../views/QnA.vue"),
    redirect: "/qna/list",
    children: [
      {
        path: "list",
        name: "QnaList",
        component: () => import("../components/Cards/QnAList.vue"),
      },
      {
        path: "write",
        name: "QnaWrite",
        component: () => import("../components/QnA/BoardWrite.vue"),
      },
      {
        path: "detail/:qnano",
        name: "QnaView",
        component: () => import("../components/QnA/BoardView.vue"),
      },
      {
        path: "update/:qnano",
        name: "QnaUpdate",
        component: () => import("../components/QnA/BoardUpdate.vue"),
      },
      {
        path: "delete/:qnano",
        name: "QnaDelete",
        component: () => import("../components/QnA/BoardDelete.vue"),
      },
      {
        path: "write/:qnano",
        name: "AnswerWrite",
        component: () => import("../components/QnA/AnswerWrite.vue"),
      },
    ],
  },
  {
    path: "/billing",
    name: "지도",
    layout: "dashboard",
    component: () => import("../views/Billing.vue"),
  },
  {
    path: "/rtl",
    name: "RTL",
    layout: "dashboard-rtl",
    meta: {
      layoutClass: "dashboard-rtl",
    },
    component: () => import("../views/RTL.vue"),
  },
  {
    path: "/Profile",
    name: "회원정보 조회",
    layout: "dashboard",
    meta: {
      layoutClass: "layout-profile",
    },
    component: () => import("../views/Profile.vue"),
  },
  {
    path: "/sign-in",
    name: "Sign-In",
    component: () => import("../views/Sign-In.vue"),
  },
  {
    path: "/sign-up",
    name: "Sign-Up",
    meta: {
      layoutClass: "layout-sign-up",
    },
    component: () => import("../views/Sign-Up.vue"),
  },
  {
    path: "/update",
    name: "UserUpdate2",
    meta: {
      layoutClass: "layout-sign-up",
    },
    component: () => import("../views/UserModify.vue"),
  },
  {
    path: "/findpw",
    name: "FindPassWord",
    meta: {
      layoutClass: "layout-sign-up",
    },
    component: () => import("../views/FindPassWord.vue"),
  },
  {
    path: "/wordcloud",
    name: "WordCloud",
    component: () => import("../components/Cards/WordCloud.vue"),
  },
  {
    path: "/news",
    name: "News",
    layout: "dashboard",
    component: () => import("../views/News.vue"),
    redirect: "/news/list",
    children: [
      {
        path: "list",
        name: "NewsList",
        component: () => import("../components/Cards/NewsList.vue"),
      },
    ],
  },
  // {
  //   path: "/user",
  //   name: "Member",
  //   redirect: "/user/signin",
  //   children: [
  //     {
  //       path: "singin",
  //       name: "SignIn",
  //       component: () => import("../views/Sign-In.vue"),
  //     },
  //     {
  //       path: "singup",
  //       name: "SignUp",
  //       component: () => import("../views/Sign-Up.vue"),
  //     },
  //     {
  //       path: "mypage",
  //       name: "MyPage",
  //       beforeEnter: onlyAuthUser,
  //       component: () => import("../views/Profile.vue"),
  //     },
  //   ],
  // },
];

// Adding layout property from each route to the meta
// object so it can be accessed later.
function addLayoutToRoute(route, parentLayout = "default") {
  route.meta = route.meta || {};
  route.meta.layout = route.layout || parentLayout;

  if (route.children) {
    route.children = route.children.map((childRoute) =>
      addLayoutToRoute(childRoute, route.meta.layout)
    );
  }
  return route;
}

routes = routes.map((route) => addLayoutToRoute(route));

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
  scrollBehavior(to, from, savedPosition) {
    if (to.hash) {
      return {
        selector: to.hash,
        behavior: "smooth",
      };
    }
    return {
      x: 0,
      y: 0,
      behavior: "smooth",
    };
  },
});

export default router;
