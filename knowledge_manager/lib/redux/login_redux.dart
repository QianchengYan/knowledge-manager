import 'package:flutter/material.dart';
import 'package:knowledge_manager/common/config/config.dart';
import 'package:knowledge_manager/common/dao/user_dao.dart';
import 'package:knowledge_manager/common/utils/common_utils.dart';
import 'package:knowledge_manager/common/utils/navigator_utils.dart';
import 'package:knowledge_manager/db/sql_manager.dart';
import 'package:knowledge_manager/redux/middleware/epic.dart';
import 'package:knowledge_manager/redux/middleware/epic_store.dart';
import 'package:knowledge_manager/redux/my_state.dart';
import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';

// /**
//  * 登入 Action
//  */
// class LoginAction {
//   final BuildContext context;
//   final String userName;
//   final String password;

//   LoginAction(this.context, this.userName, this.password);
// }

// /**
//  * 登入结果 Action
//  */
// class LoginResultAction {
//   final BuildContext context;
//   final bool success;

//   LoginResultAction(this.context, this.success);
// }

// /**
//  * 登出 Action
//  */
// class LogoutAction {
//   final BuildContext context;

//   LogoutAction(this.context);
// }

// /**
//  * 登入结果 Action 处理方法
//  */
// bool _loginResult(bool result, LoginResultAction action) {
//   if (action.success == true) {
//     // 如果登录成功，跳转到主页面
//     NavigatorUtils.goHome(action.context);
//   }
//   return action.success;
// }

// /**
//  * 登出 Action 处理方法
//  */
// bool _logoutResult(bool result, LogoutAction action) {
//   return true;
// }

// /**
//  * 绑定 Action 和 处理 Action 的方法
//  */
// final LoginReducer = combineReducers<bool>([
//   TypedReducer<bool, LoginResultAction>(_loginResult),
//   TypedReducer<bool, LogoutAction>(_logoutResult),
// ]);

// class LoginMiddleWare implements MiddlewareClass<MyState> {
//   @override
//   void call(Store<MyState> store, dynamic action, NextDispatcher next) {
//     if (action is LogoutAction) {
//       UserDao.clearAll(store);
//       SqlManager.close();
//       NavigatorUtils.goLogin(action.context);
//     }
//     if (Config.DEBUG) {
//       print("==================LoginMiddleWare");
//       print("action:${action.toString()}");
//     }

//     next(action);
//   }
// }

// class LoginEpic implements EpicClass<MyState> {
//   @override
//   Stream<dynamic> call(Stream<dynamic> actions, EpicStore<MyState> store) {
//     if(Config.DEBUG) {
//       print("============LoginEpic:");
//     }
//     return Observable(actions)
//         .whereType<LoginAction>()
//         .switchMap((action) => _loginIn(action, store));
//   }

//   Stream<dynamic> _loginIn(
//       LoginAction action, EpicStore<MyState> store) async* {
//         if(Config.DEBUG) {
//       print("============LoginEpic:");
//     }
//     CommonUtils.showLoadingDialog(action.context);
//     var res =
//         await UserDao.login(action.userName.trim(), action.password, store);
//     Navigator.pop(action.context);
//     yield LoginResultAction(action.context, (res != null && res.result));
//   }
// }
