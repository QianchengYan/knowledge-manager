import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:knowledge_manager/common/config/config.dart';
import 'package:knowledge_manager/common/local/local_storage.dart';
import 'package:knowledge_manager/common/localization/default_localizations.dart';
import 'package:knowledge_manager/common/net/address.dart';
import 'package:knowledge_manager/common/style/my_colors.dart';
import 'package:knowledge_manager/common/style/my_icons.dart';
import 'package:knowledge_manager/common/utils/common_utils.dart';
import 'package:knowledge_manager/redux/login_redux.dart';
import 'package:knowledge_manager/redux/my_state.dart';
import 'package:knowledge_manager/widgets/my_flex_button.dart';
import 'package:knowledge_manager/widgets/my_input_widget.dart';

/**
 * 登录页
 */
class LoginPage extends StatefulWidget {
  static const routeName = 'login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginBLoC {
  _onLoginButtonTap() {
    String alertContent = "";
    login();
    switch (loginResult) {
      case -1:
        alertContent = "用户名不能为空";
        break;
      case -2:
        alertContent = "密码不能为空";
        break;
      // case 0:
      //   alertContent = "用户名或密码错误";
      //   break;
      // case 1:
      //   alertContent = "登录成功";
      //   break;
      default:
        return;
    }
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('提示'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text(alertContent),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('确定'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((val) {
      print(val);
    });
  }

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
                        // 图片
                        new Icon(
                          Icons.supervisor_account,
                          size: 90,
                          color: Colors.grey,
                        ),
                        new Padding(padding: new EdgeInsets.all(10)),
                        // 用户名输入框
                        new MyInputWidget(
                            hintText: MyLocalizations.i18n(context)
                                .login_username_hint_text,
                            iconData: Icons.account_circle,
                            obscureText: false,
                            // onChanged: (String value) {
                            //   _username = value;
                            // },
                            controller: usernameController),
                        // 密码输入框
                        new MyInputWidget(
                            hintText: MyLocalizations.i18n(context)
                                .login_password_hint_text,
                            iconData: Icons.lock_outline,
                            obscureText: true,
                            // onChanged: (String value) {
                            //   _password = value;
                            // },
                            controller: passwordController),
                        new Padding(padding: new EdgeInsets.all(25)),
                        // 登录按钮
                        new MyFlexButton(
                            text: MyLocalizations.i18n(context).login_text,
                            color: Theme.of(context).primaryColor,
                            textColor: MyColors.textWhite,
                            onPress: _onLoginButtonTap),
                        new SizedBox(
                          height: 10,
                        ),
                        // 切换语言 水纹波
                        InkWell(
                          onTap: () {
                            CommonUtils.showLanguageDialog(context);
                          },
                          child: Text(
                              MyLocalizations.i18n(context).switch_language,
                              style: TextStyle(color: MyColors.subTextColor)),
                        ),
                        new Padding(padding: new EdgeInsets.all(15))
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

mixin LoginBLoC on State<LoginPage> {
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  String _username = "";
  String _password = "";
  int loginResult = 0;

  @override
  void initState() {
    super.initState();
    initParams();
  }

  initParams() async {
    _username = await LocalStorage.get(Config.USERNAME_KEY);
    _password = await LocalStorage.get(Config.PASSWORD_KEY);
    usernameController.value = new TextEditingValue(text: _username ?? "");
    passwordController.value = new TextEditingValue(text: _password ?? "");
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  login() async {
    _username = usernameController.value.text;
    _password = passwordController.value.text;
print("_username:$_username");
print("_password:$_password");

    if (_username == null || _username.length == 0) {
      // 提示：用户名不能为空
      loginResult = -1;
      return;
    }
    if (_password == null || _password.length == 0) {
      // 提示：密码不能为空
      loginResult = -2;
      return;
    } else {
      loginResult = 0;

      // 测试dio
  //     try {
  //   Response response;
  //   response = await Dio().post(Address.getLoginUrl());
  //   return print(response);
  // } catch (e) {
  //   return print(e);
  // }




      // 通过 redux 去执行登录流程
      StoreProvider.of<MyState>(context)
          .dispatch(LoginAction(context, _username, _password));

    }
  }
}
