import { apiInstance } from "./index.js";

const api = apiInstance();

async function login(user, success, fail) {
  await api.post(`/user/login`, JSON.stringify(user)).then(success).catch(fail);
}

async function findById(userid, success, fail) {
  api.defaults.headers["access-token"] = sessionStorage.getItem("access-token");
  await api.get(`/user/info/${userid}`).then(success).catch(fail);
}

function addUser(user, success, fail) {
  api.post(`/user/signup`, JSON.stringify(user)).then(success).catch(fail);
}

function modifyUser(user, success, fail) {
  api.put(`/user`, JSON.stringify(user)).then(success).catch(fail);
}

function deleteUser(userid, success, fail) {
  api.delete(`/user/${userid}`).then(success).catch(fail);
}

function findPassword(user, success, fail) {
  api.post(`/user/findpw`, JSON.stringify(user)).then(success).catch(fail);
}

// function logout(success, fail)

export { login, findById, addUser, modifyUser, deleteUser, findPassword };
