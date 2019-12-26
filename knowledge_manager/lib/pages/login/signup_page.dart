import 'package:flutter/material.dart';
import 'package:knowledge_manager/common/config/config.dart';
import 'package:knowledge_manager/common/localization/default_localizations.dart';
import 'package:knowledge_manager/common/style/my_colors.dart';
import 'package:knowledge_manager/common/utils/common_utils.dart';
import 'package:knowledge_manager/common/utils/navigator_utils.dart';
import 'package:knowledge_manager/dao/dao_result.dart';
import 'package:knowledge_manager/dao/user_dao.dart';
import 'package:knowledge_manager/widgets/my_flex_button.dart';

/**
 * 登录页
 */
class SignupPage extends StatefulWidget {
  static const routeName = 'signup';
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with SignupBLoC {
  List<IconData> icons = [
    Icons.ac_unit, // 用户名
    Icons.ac_unit, // 密码
    Icons.ac_unit, // 昵称
    Icons.ac_unit, // 手机
    Icons.ac_unit, // 邮箱
  ];
  _onSignupButtonTap() async {
    await signup();
    print("======SignupButtonTap$signupResult");
    String alertContent = signupDetail;
    switch (signupResult) {
      case -2:
        // 网络错误
        return;
      case 1:
        // 注册成功
        Navigator.of(context).pop();
        break;
      default:
        break;
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
                        new Padding(padding: new EdgeInsets.all(10)),
                        // 账号输入框
                        new TextField(
                          controller: usernameController,
                          onChanged: null,
                          obscureText: false, //是否是密码
                          decoration: new InputDecoration(
                            hintText:
                                MyLocalizations.i18n(context).signup_username,
                            icon: Icon(icons[0]),
                          ),
                        ),
                        // 密码输入框
                        new TextField(
                          controller: passwordController,
                          onChanged: null,
                          obscureText: false, //是否是密码
                          decoration: new InputDecoration(
                            hintText:
                                MyLocalizations.i18n(context).signup_password,
                            icon: Icon(icons[0]),
                          ),
                        ),
                        // 昵称输入框
                        new TextField(
                          controller: nameController,
                          onChanged: null,
                          obscureText: false, //是否是密码
                          decoration: new InputDecoration(
                            hintText: MyLocalizations.i18n(context).signup_name,
                            icon: Icon(icons[0]),
                          ),
                        ),
                        // 手机号输入框
                        new TextField(
                          controller: phoneController,
                          onChanged: null,
                          obscureText: false, //是否是密码
                          decoration: new InputDecoration(
                            hintText:
                                MyLocalizations.i18n(context).signup_phone,
                            icon: Icon(icons[0]),
                          ),
                        ),
                        // 邮箱输入框
                        new TextField(
                          controller: emailController,
                          onChanged: null,
                          obscureText: false, //是否是密码
                          decoration: new InputDecoration(
                            hintText:
                                MyLocalizations.i18n(context).signup_email,
                            icon: Icon(icons[0]),
                          ),
                        ),
                        new Padding(padding: new EdgeInsets.all(15)),
                        // 登录按钮
                        new MyFlexButton(
                          text: "完成注册",
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          onPress: _onSignupButtonTap,
                        ),

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

mixin SignupBLoC on State<SignupPage> {
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();

  String _username = "";
  String _password = "";
  String _name = "";
  String _phone = "";
  String _email = "";

  int signupResult = 0;
  String signupDetail = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
  }

  signup() async {
    _username = usernameController.value.text;
    _password = passwordController.value.text;
    _name = nameController.value.text;
    _phone = phoneController.value.text;
    _email = emailController.value.text;
    if (Config.DEBUG) {
      print("_username:$_username");
      print("_password:$_password");
      print("_name:$_name");
      print("_phone:$_phone");
      print("_email:$_email");
    }

    if (_username == null || _username.length == 0) {
      // 提示：用户名不能为空
      signupResult = -1;
      signupDetail = "用户名不能为空";
      return;
    }
    if (_password == null || _password.length == 0) {
      // 提示：密码不能为空
      signupResult = -1;
      signupDetail = "密码不能为空";
      return;
    }
    if (_name == null || _name.length == 0) {
      // 提示：用户昵称不能为空
      signupResult = -1;
      _name = "用户昵称不能为空";
      return;
    }
    // if (_phone == null || _phone.length == 0) {
    //   // 提示：手机号不能为空
    //   signupResult = -1;
    //   signupDetail = "手机号不能为空";
    //   return;
    // }
    // if (_email == null || _email.length == 0) {
    //   // 提示：邮箱不能为空
    //   signupResult = -1;
    //   signupDetail = "邮箱不能为空";
    //   return;
    // }

    signupResult = 0;
    DaoResult result = await UserDao.signup(_username, _password, _name,
        phone: _phone, email: _email);

    if (result != null) {
      if (result.result) {
        // 登录成功
        signupResult = 1;
      } else {
        // 登录失败
        signupResult = 0;
      }
      signupDetail = result.data;
    } else {
      //网络错误，不做处理
      signupResult = -2;
    }
  }
}
