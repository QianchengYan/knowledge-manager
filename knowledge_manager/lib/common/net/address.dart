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

  // 获取所有用户信息
  static getAllUserInfoUrl() {
    return "$host${user}get_all";
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

  /**
   * api/task 接口
   */

  static const String flag = "api/flag/";
  // 添加 FlagContaine
  static addFlagContainerUrl() {
    return "$host${flag}add_container";
  }

  // 删除 FlagContaine
  static deleteFlagContainerUrl() {
    return "$host${flag}delete_container";
  }

  // 更改 FlagContaine
  static updateFlagContainerUrl() {
    return "$host${flag}update_container";
  }

  // 获取 FlagContaine
  static getFlagContainerUrl() {
    return "$host${flag}get_container";
  }

  // 添加 flag
  static addFlagUrl() {
    return "$host${flag}add_flag";
  }

  // 删除 flag
  static deleteFlagUrl() {
    return "$host${flag}delete_flag";
  }

  // 更改 flag
  static updateFlagUrl() {
    return "$host${flag}update_flag";
  }

  // 获取 flag
  static getFlagUrl() {
    return "$host${flag}get_flag";
  }
}
