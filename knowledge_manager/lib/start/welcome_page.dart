import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:knowledge_manager/common/style/my_images.dart';
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

class _WelcomePageState extends State<WelcomePage>
/*with SingleTickerProviderStateMixin*/ {
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
      const Duration(seconds: 2, milliseconds: 100),
      () {
        // 根据本地缓存设置 APP 的 设置
        AppInit.initAppSetting(store);
        // 设置 APP 的 用户信息
        // var result = AppInit.initUserInfo(store);
        // if (result) {
        //   // 有 登录信息缓存
        //   NavigatorUtils.goHome(context);
        // } else {
        //   // 无 登录信息缓存
        //   NavigatorUtils.goLogin(context);
        // }
        NavigatorUtils.goLogin(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double fontSize1 = 50;
    double fontSize2 = 40;

    return StoreBuilder<MyState>(
      builder: (context, store) {
        return new Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image(
                image: AssetImage(MyImages.DEFAULT_USER_AVATAR),
                width: 100,
                height: 100,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "知识农场",
                style: TextStyle(
                  color: Colors.blueGrey,
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        );
      },
    );
  }
}

// child: Stack(
//   fit: StackFit.expand,
//   children: <Widget>[
//     new Center(
//       child: Image(
//         image: AssetImage(MyImages.DEFAULT_USER_AVATAR),
//         fit: BoxFit.cover,
//       ),
//     ),
//     new Align(
//       alignment: Alignment.center,
//       child: new Column(
//         mainAxisSize: MainAxisSize.max,
//         // mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             "Knowledge",
//             style: TextStyle(fontSize: fontSize1),
//             textAlign: TextAlign.start,
//           ),
//           Text(
//             "Manager",
//             style: TextStyle(fontSize: fontSize2),
//             textAlign: TextAlign.end,
//           ),
//         ],
//       ),
//     )
//   ],
// ),

// AnimationController _controller;
// Animation<Offset> _offsetAnimation;

// @override
// void initState() {
//   super.initState();
//   _controller = AnimationController(
//     duration: const Duration(seconds: 2),
//     vsync: this,
//   )..repeat(reverse: true);
//   _offsetAnimation = Tween<Offset>(
//     begin: Offset.zero,
//     end: const Offset(1.5, 0.0),
//   ).animate(CurvedAnimation(
//     parent: _controller,
//     curve: Curves.elasticIn,
//   ));
// }

// @override
// void dispose() {
//   super.dispose();
//   _controller.dispose();
// }

// child: new SlideTransition(
//   position: _offsetAnimation,
//   child: const Padding(
//     padding: EdgeInsets.all(8.0),
//     child: FlutterLogo(size: 150.0),
//   ),
// ),
