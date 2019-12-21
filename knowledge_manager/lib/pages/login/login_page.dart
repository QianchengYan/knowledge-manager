import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:knowledge_manager/common/config/config.dart';
import 'package:knowledge_manager/common/local/local_storage.dart';
import 'package:knowledge_manager/common/localization/default_localizations.dart';
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
                        new Image(
                            image: new AssetImage(MyICons.DEFAULT_USER_ICON),
                            width: 90,
                            height: 90),
                        new Padding(padding: new EdgeInsets.all(10)),
                        // 用户名输入框
                        new MyInputWidget(
                            hintText: MyLocalizations.i18n(context)
                                .login_username_hint_text,
                            iconData: MyICons.LOGIN_USER,
                            obscureText: false,
                            onChanged: (String value) {
                              _username = value;
                            },
                            controller: usernameController),
                        // 密码输入框
                        new MyInputWidget(
                            hintText: MyLocalizations.i18n(context)
                                .login_password_hint_text,
                            iconData: MyICons.LOGIN_PW,
                            obscureText: true,
                            onChanged: (String value) {
                              _password = value;
                            },
                            controller: passwordController),
                        new Padding(padding: new EdgeInsets.all(30)),
                        // 登录按钮
                        new MyFlexButton(
                            text: MyLocalizations.i18n(context).login_text,
                            color: Theme.of(context).primaryColor,
                            textColor: MyColors.textWhite,
                            onPress: login),
                        // 切换语言 水纹波
                        InkWell(
                          onTap: () {
                            CommonUtils.showLanguageDialog(context);
                          },
                          child: Text(
                            MyLocalizations.i18n(context).switch_language,
                            style: TextStyle(color: MyColors.subTextColor)
                          ),
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

  var _username = "";
  var _password = "";

  @override
  void initState() {
    super.initState();
    initParams();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.removeListener(_usernameChange);
    passwordController.removeListener(_passwordChange);
  }

  initParams() async {
    _username = await LocalStorage.get(Config.USERNAME_KEY);
    _password = await LocalStorage.get(Config.PASSWORD_KEY);
    usernameController.value = new TextEditingValue(text: _username ?? "");
    passwordController.value = new TextEditingValue(text: _password ?? "");
  }

  _usernameChange() {
    _username = usernameController.text;
  }

  _passwordChange() {
    _password = passwordController.text;
  }

  login() async {
    if (_username == null || _username.isEmpty) {
      return;
    }
    if (_password == null || _password.isEmpty) {
      return;
    }
    // 通过 redux 去执行登录流程
    StoreProvider.of<MyState>(context)
        .dispatch(LoginAction(context, _username, _password));
  }
}
