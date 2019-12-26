import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:knowledge_manager/common/localization/default_localizations.dart';
import 'package:knowledge_manager/common/style/my_colors.dart';
import 'package:knowledge_manager/common/style/my_icons.dart';
import 'package:knowledge_manager/common/style/my_images.dart';
import 'package:knowledge_manager/common/style/my_text_style.dart';
import 'package:knowledge_manager/common/utils/common_utils.dart';
import 'package:knowledge_manager/common/utils/navigator_utils.dart';
import 'package:knowledge_manager/common/utils/show_dialog_utils.dart';
import 'package:knowledge_manager/model/User.dart';
import 'package:knowledge_manager/redux/my_state.dart';
import 'package:knowledge_manager/widgets/my_flex_button.dart';
import 'package:package_info/package_info.dart';

class HomeDrawer extends StatelessWidget {
  // for (int i = 0; i < list.length; i++) {
  //   _list.add(new Center(
  //     child: ListTile(
  //       leading: new Icon(Icons.list),
  //       title: new Text(list[i].name),
  //       trailing: new Icon(Icons.keyboard_arrow_right),
  //     ),
  //   ));
  // }
    showAboutDialog(BuildContext context, String versionName) {
    versionName ??= "Null";
    NavigatorUtils.showMyDialog(
        context: context,
        builder: (BuildContext context) => AboutDialog(
              applicationName: MyLocalizations.i18n(context).app_name,
              applicationVersion: MyLocalizations.i18n(context).app_version +
                  ": " +
                  versionName,
              applicationIcon: new Image(
                  image: new AssetImage(MyICons.DEFAULT_USER_ICON),
                  width: 50.0,
                  height: 50.0),
              applicationLegalese: "http://github.com/CarGuo",
            ));
  }
  @override
  Widget build(BuildContext context) {
    List<String> _titles = [];
    return new Material(
      child: new StoreBuilder<MyState>(
        builder: (context, store) {
          User user = store.state.userInfo;
          return new Drawer(
            // 侧边栏按钮Drawer
            child: new Container(
              // 默认背景
              color: store.state.themeData.primaryColor,
              child: new SingleChildScrollView(
                // item 背景
                child: new Container(
                  constraints: new BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height),
                  child: new Material(
                      color: MyColors.white,
                      child: new Column(
                        children: <Widget>[
                          new UserAccountsDrawerHeader(
                            // Material内置控件
                            // 装饰器
                            decoration: new BoxDecoration(
                              // 用 BoxDecoration 装饰器提供背景图片
                              color: store.state.themeData.primaryColor,
                            ),
                            // 用户名
                            accountName: new Text(
                              user.name ?? "---",
                              style: MyTextStyle.largeTextWhite,
                            ),
                            // 用户邮箱
                            accountEmail: new Text(
                              ((user.email == null || user.email.length == 0)
                                  ? "---"
                                  : user.email),
                              style: MyTextStyle.normalTextLight,
                            ),
                            // 用户头像
                            currentAccountPicture: new GestureDetector(
                              onTap: () {},
                              child: new CircleAvatar(
                                // 圆形图标控件
                                child: new Image(
                                  image: (user.avatarUrl == null ||
                                          user.avatarUrl.length == 0)
                                      ? AssetImage(MyImages.DEFAULT_USER_AVATAR)
                                      : NetworkImage(user.avatarUrl),
                                  width: 100,
                                ),
                              ),
                            ),
                          ),
                          // 个人信息
                          new ListTile(
                            title: new Text(
                              MyLocalizations.i18n(context).drawer_user_info,
                              style: MyTextStyle.normalText,
                            ),
                            onTap: () {
                              NavigatorUtils.goChangeUserInfo(context);
                            },
                          ),
                          // 切换主题
                          new ListTile(
                            title: new Text(
                              MyLocalizations.i18n(context).drawer_change_theme,
                              style: MyTextStyle.normalText,
                            ),
                            onTap: () {
                              CommonUtils.showLanguageDialog(context);
                            },
                          ),
                          // 检查更新
                          new ListTile(
                            title: new Text(
                              MyLocalizations.i18n(context).drawer_check_update,
                              style: MyTextStyle.normalText,
                            ),
                            onTap: () {},
                          ),
                          // 关于
                          new ListTile(
                            title: new Text(
                              MyLocalizations.i18n(context).drawer_about,
                              style: MyTextStyle.normalText,
                            ),
                            onTap: () {
                              // PackageInfo.fromPlatform().then((value) {
                              //   print("=============$value");
                              //   showAboutDialog(context, value.version);
                              // });
                              DialogUtils.showMyDialog(context, MyLocalizations.i18n(context).app_version_title, MyLocalizations.i18n(context).app_version);
                            },
                          ),
                          // 退出登录按钮
                          new ListTile(
                            title: new MyFlexButton(
                              text: MyLocalizations.i18n(context).drawer_logout,
                              color: Colors.redAccent,
                              textColor: MyColors.textWhite,
                              onPress: () {
                                NavigatorUtils.goLogin(context);
                              },
                            ),
                            onTap: () {},
                          ),
                          // ListView(
                          //   children: _list.map((value) {
                          //     return ListTile(
                          //       leading: new Icon(Icons.list),
                          //       title: new Text(value),
                          //       trailing: new Icon(Icons.keyboard_arrow_right),
                          //     );
                          //   }).toList(),
                          // ),
                          // _list.map((value){
                          //     return ListTile(
                          //       leading: new Icon(Icons.list),
                          //       title: new Text(value),
                          //       trailing: new Icon(Icons.keyboard_arrow_right),
                          //     );
                          //   }).toList() as Widget,

                          //  ListTile(
                          //       leading: new Icon(Icons.list),
                          //       title: new Text("value"),
                          //       trailing: new Icon(Icons.keyboard_arrow_right),
                          //     ),

                          // new ListTile(

                          // )
                        ],
                      )),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
