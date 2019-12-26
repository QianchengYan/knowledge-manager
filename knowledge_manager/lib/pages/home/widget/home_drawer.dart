import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:knowledge_manager/common/style/my_colors.dart';
import 'package:knowledge_manager/common/style/my_images.dart';
import 'package:knowledge_manager/common/style/my_text_style.dart';
import 'package:knowledge_manager/model/User.dart';
import 'package:knowledge_manager/redux/my_state.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
