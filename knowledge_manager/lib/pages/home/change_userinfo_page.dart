import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:knowledge_manager/common/config/config.dart';
import 'package:knowledge_manager/common/localization/default_localizations.dart';
import 'package:knowledge_manager/common/style/my_colors.dart';
import 'package:knowledge_manager/common/utils/common_utils.dart';
import 'package:knowledge_manager/common/utils/navigator_utils.dart';
import 'package:knowledge_manager/common/utils/show_dialog_utils.dart';
import 'package:knowledge_manager/dao/dao_result.dart';
import 'package:knowledge_manager/dao/user_dao.dart';
import 'package:knowledge_manager/redux/my_state.dart';
import 'package:knowledge_manager/widgets/my_flex_button.dart';

/**
 * 登录页
 */
class ChangeUserInfoPage extends StatefulWidget {
  static const routeName = 'changeUserInfo';
  @override
  _ChangeUserInfoPageState createState() => _ChangeUserInfoPageState();
}

class _ChangeUserInfoPageState extends State<ChangeUserInfoPage> {
  List<IconData> icons = [
    Icons.ac_unit, // 头像上传
    Icons.ac_unit, // 密码
    Icons.ac_unit, // 昵称
    Icons.ac_unit, // 手机
    Icons.ac_unit, // 邮箱
  ];
  _onSignupButtonTap() async {
    await changeUserInfo();
    print("======SignupButtonTap$changeUserInfoResult");
    String alertContent = changeUserInfoDetail;
    switch (changeUserInfoResult) {
      case -2:
        // 网络错误
        return;
      case 1:
        // 修改个人信息成功
        Navigator.of(context).pop();
        break;
      default:
        break;
    }
    DialogUtils.showMyDialog(context, "提示", alertContent);
  }

  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();

  String _username;
  String _password;
  String _name;
  String _phone;
  String _email;

  int changeUserInfoResult = 0;
  String changeUserInfoDetail;

  var store;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    store = StoreProvider.of<MyState>(context);
    _username = store.state.userInfo.username;
    _password = "";
    _name = store.state.userInfo.name;
    _phone = store.state.userInfo.phone;
    _email = store.state.userInfo.email;
    passwordController.value = new TextEditingValue(text: _password ?? "");
    nameController.value = new TextEditingValue(text: _name ?? "");
    phoneController.value = new TextEditingValue(text: _phone ?? "");
    emailController.value = new TextEditingValue(text: _email ?? "");
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
  }

  changeUserInfo() async {
    _password = passwordController.value.text;
    _name = nameController.value.text;
    _phone = phoneController.value.text;
    _email = emailController.value.text;
    if (Config.DEBUG) {
      print("_username:$_username");
      print("_password:${_password.length}");
      print("_name:$_name");
      print("_phone:$_phone");
      print("_email:$_email");
    }

    if (_password == null || _password.length == 0) {
      // 提示：密码不能为空
      changeUserInfoResult = -1;
      changeUserInfoDetail = "密码不能为空";
      return;
    }
    if (_name == null || _name.length == 0) {
      // 提示：用户昵称不能为空
      changeUserInfoResult = -1;
      _name = "用户昵称不能为空";
      return;
    }

    changeUserInfoResult = 0;
    DaoResult result = await UserDao.changeUserInfo(
        _username, _password, _name, _phone, _email, store);

    if (result != null) {
      if (result.result) {
        // 修改个人信息成功
        changeUserInfoResult = 1;
      } else {
        // 修改个人信息失败
        changeUserInfoResult = 0;
      }
      changeUserInfoDetail = result.data;
    } else {
      //网络错误，不做处理
      changeUserInfoResult = -2;
    }
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
                          text: MyLocalizations.i18n(context).change_userinfo_check,
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
