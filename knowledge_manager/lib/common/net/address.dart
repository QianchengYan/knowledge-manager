
class Address {
  static const String host = "127.0.0.1:8000/";

  // 获取授权
  static getAuthorization() {
    return "${host}authorizations";
  }

  static getMyUserInfo() {
    return "${host}user";
  }

  // 获取用户信息
  static getUserInfo(userName) {
    return "${host}user/${userName}";
  }
}