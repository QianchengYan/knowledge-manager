import 'package:flutter/material.dart';
import 'package:knowledge_manager/common/config/config.dart';
import 'package:knowledge_manager/model/User.dart';
import 'package:knowledge_manager/redux/locale_redux.dart';
import 'package:knowledge_manager/redux/login_redux.dart';
import 'package:knowledge_manager/redux/middleware/epic_middleware.dart';
import 'package:knowledge_manager/redux/theme_redux.dart';
import 'package:knowledge_manager/redux/user_redux.dart';
import 'package:redux/redux.dart';

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
  Locale platformLocale;

  // 是否登录
  bool login;

  // 构造方法
  MyState({this.userInfo, this.themeData, this.locale, this.login});
}

// 创建 Reducer
// 源码中 Reducer 是一个防范 typedef State Reducer<State>(State state, dynamic action);
// 我们自定义了 appReducer 用于创建 store
MyState appReducer(MyState state, action) {
  if(Config.DEBUG) {
    print("=================appReducer: $action");
  }
  return MyState(
    userInfo: UserReducer(state.userInfo, action),
    themeData: ThemeDataReducer(state.themeData, action),
    locale: LocaleReducer(state.locale, action),
  );
}

final List<Middleware<MyState>> middleware = [
  EpicMiddleware<MyState>(UserInfoEpic()),
  // EpicMiddleware<MyState>(LoginEpic()),
  UserInfoMiddleware(),
  // LoginMiddleWare(),
];
