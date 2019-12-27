class Address {
  static const String host = "http://139.224.112.248:8000/";
  static const String updateUrl = "https://www.xx.com";

  // 获取授权
  static getAuthorizationUrl() {
    return "${host}authorizations";
  }

  /**
   * api/user 接口
   */
  static const String user = "api/user/";
  // login 登录
  static getLoginUrl() {
    return "$host${user}login";
  }

  // signup 登录
  static getSignupUrl() {
    return "$host${user}signup";
  }

  // 获取我的信息
  static getMyInfoUrl() {
    return "$host${user}my_info";
  }

  // 获取用户信息
  static getUserInfoUrl() {
    return "$host${user}user_info";
  }

  // 更改用户信息
  static updateUserInfoUrl() {
    return "$host${user}update";
  }

  /**
   * api/task 接口
   */
  static const String task = "api/task/";
  // 添加 task
  static addTaskUrl() {
    return "$host${task}add";
  }

  // 删除 task
  static deleteTaskUrl() {
    return "$host${task}delete";
  }
    // 更改 task
  static updateTaskUrl() {
    return "$host${task}update";
  }

  // 获取 task
  static getTaskUrl() {
    return "$host${task}get";
  }

}
