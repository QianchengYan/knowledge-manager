import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_manager/pages/home/home_page.dart';
import 'package:knowledge_manager/pages/login/login_page.dart';

/**
 * 路由的重新封装，根据页面的需求
 */
class NavigatorUtils {
  // 登录页
  static goLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginPage.routeName);
  }

  // 主页
  static goHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomePage.routeName);
  }

  // 弹出 dialog
  static Future<T> showMyDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder,
  }) {
    return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return MediaQuery(
            // 不受系统字体放缩影响
            data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                .copyWith(textScaleFactor: 1),
            child: new SafeArea(
              child: builder(context),
            ),
          );
        });
  }
}
