import 'package:flutter/material.dart';
import 'package:knowledge_manager/common/style/my_colors.dart';
import 'package:knowledge_manager/common/style/my_icons.dart';

/**
 * 登录页
 */
class LoginPage extends StatefulWidget {
  static const routeName = 'login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // 触摸收起键盘
    return new GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        body: new Container(
          color: Theme.of(context).primaryColor,
          child: new Center(
            // 防止overflow的现象
            child: SafeArea(
              // 同时弹出来的键盘不遮挡
              child: SingleChildScrollView(
                child: new Card(
                  elevation: 5,
                  shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  color: MyColors.cardWhite,
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: new Padding(
                    padding: new EdgeInsets.only(
                        left: 30, top: 40, right: 30, bottom: 0),
                    // 核心布局=================================
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Image(
                            image: new AssetImage(MyICons.DEFAULT_USER_ICON),
                            width: 90,
                            height: 90),
                        new Padding(padding: new EdgeInsets.all(10)),
                        new MyInputWidget
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
