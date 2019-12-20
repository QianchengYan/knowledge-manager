
import 'package:flutter/material.dart';

/**
 * 全局store对象，保存state数据
 */
class MyState {
  // 用户信息
  User userInfo;
  // 主题数据
  ThemeData themeData;
  // 语言
  Locale locale;
  // 当前手机平台默认语言
  Locale platformLocal;
  // 是否登录
  bool login;
  // 构造方法
  MyState({this.userInfo, this.themeData, this.locale, this.login})

}

// 创建 Reducer
// 源码中 Reducer 是一个防范 typedef State Reducer<State>(State state, dynamic action);
// 我们自定义了 appReducer 用于创建 store
MyState appReducer(MyState state, action) {
  return MyState(
    // 通过 UserReducer 将 MyState 中的 UserInfo 和 action 关联起来
    userInfo: 
    // 通过 ThemeDataReducer 将 MyState 中的 themeData 和 action 关联起来
    // 通过 LocaleReducer 将 MyState 中的 local 和 action 关联起来
  )
}