import 'package:flutter/material.dart';
import 'package:knowledge_manager/common/dao/user_dao.dart';
import 'package:knowledge_manager/common/utils/navigator_utils.dart';
import 'package:knowledge_manager/redux/my_state.dart';
import 'package:redux/redux.dart';

class LoginSuccessAction {
  final BuildContext context;
  final bool success;

  LoginSuccessAction(this.context, this.success);
}

class LogoutAction {
  final BuildContext context;
  final String userName;
  final String password;

  LogoutAction(this.context, this.userName, this.password);
}

class LoginMiddleWare implements MiddlewareClass<MyState> {
  @override
  void call(Store<MyState> store, dynamic action, NextDispatcher next) {
    if(action is LogoutAction) {
      UserDao.clearAll(store);
      SqlManager.close();
      NavigatorUtils.goLogin(action.context);
    }
  }
}