
class Address {
  static const String host = "http://139.224.112.248:8000/";
  static const String updateUrl = "https://www.xx.com";

  // 获取授权
  static getAuthorizationUrl() {
    return "${host}authorizations";
  }

  
  // login 登录
  static getLoginUrl() {
    return "${host}api/user/login";
  }
  // signup 登录
  static getSignupUrl() {
    return "${host}api/user/signup";
  }
  // 获取我的信息
  static getMyInfo() {
    return "${host}api/user/my_info";
  }
  // 获取用户信息
  static getUserInfo() {
    return "${host}api/user/user_info";
  }
  // 更改用户信息
  static updateUserInfoUrl() {
    return "${host}api/user/update";
  }



}