import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:knowledge_manager/common/utils/navigator_utils.dart';
import 'package:knowledge_manager/redux/my_state.dart';
import 'package:knowledge_manager/start/app_init.dart';
import 'package:redux/redux.dart';

/**
 * 欢迎页
 */
class WelcomePage extends StatefulWidget {
  static const routeName = '/';
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool hadInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 防止多次进入
    if (hadInit) {
      return;
    } else {
      hadInit = true;
    }
    Store<MyState> store = StoreProvider.of(context);
    new Future.delayed(
      const Duration(seconds: 2, milliseconds: 500),
      () {
        // 根据本地缓存设置 APP 的 设置
        AppInit.initAppSetting(store);
        // 设置 APP 的 用户信息
        AppInit.initUserInfo(store).then((res) {
          if (res != null && res.result) {
            // 有 登录信息缓存
            NavigatorUtils.goHome(context);
          } else {
            // 无 登录信息缓存
            NavigatorUtils.goLogin(context);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
