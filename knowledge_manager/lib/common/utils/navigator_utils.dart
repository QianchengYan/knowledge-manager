
import 'package:flutter/cupertino.dart';
import 'package:knowledge_manager/pages/login/login_page.dart';

/**
 * 路由的重新封装，根据页面的需求
 */
class NavigatorUtils {
  
  // 登录页
  static goLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginPage.routeName);
  }
}