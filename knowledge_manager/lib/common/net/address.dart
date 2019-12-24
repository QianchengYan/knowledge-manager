
class Address {
  static const String host = "http://139.224.112.248:8000/";
  static const String updateUrl = "https://www.xx.com";

  // 获取授权
  static getAuthorizationUrl() {
    return "${host}authorizations";
  }

  static getMyUserInfo() {
    return "${host}user";
  }
  // login 登录
  static getLoginUrl() {
    return "${host}api/login/login/";
  }

  // 获取用户信息
  static getUserInfo(userName) {
    return "${host}user/$userName";
  }
}