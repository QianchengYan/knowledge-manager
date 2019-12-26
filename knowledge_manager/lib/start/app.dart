import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:knowledge_manager/common/event/http_error_event.dart';
import 'package:knowledge_manager/common/event/index.dart';
import 'package:knowledge_manager/common/localization/default_localizations.dart';
import 'package:knowledge_manager/common/localization/my_localizations_delegate.dart';
import 'package:knowledge_manager/common/net/code.dart';
import 'package:knowledge_manager/common/style/my_colors.dart';
import 'package:knowledge_manager/common/utils/common_utils.dart';
import 'package:knowledge_manager/common/utils/navigator_utils.dart';
import 'package:knowledge_manager/model/User.dart';
import 'package:knowledge_manager/pages/farm/FarmPage.dart';
import 'package:knowledge_manager/pages/home/home_page.dart';
import 'package:knowledge_manager/pages/login/login_page.dart';
import 'package:knowledge_manager/pages/login/signup_page.dart';
import 'package:knowledge_manager/redux/my_state.dart';
import 'package:knowledge_manager/start/welcome_page.dart';
import 'package:redux/redux.dart';

class FlutterReduxApp extends StatefulWidget {
  @override
  _FlutterReduxAppState createState() => _FlutterReduxAppState();
}

class _FlutterReduxAppState extends State<FlutterReduxApp>
    with HttpErrorListener {
  // 创建Store，引用 MyState 中的 appReducer 实现 Reducer 方法
  // initState 初始化 State
  final store = new Store<MyState>(
    appReducer,
    // 拦截器
    middleware: middleware,
    // 初始化数据 初始化 state
    initialState: new MyState(
        userInfo: User.empty(),
        login: false,
        themeData: CommonUtils.getThemeData(Colors.blue),
        locale: Locale('zh', 'CH')),
  );

  @override
  Widget build(BuildContext context) {
    // 使用 flutter_redux 做全局状态共享
    // 通过 StoreProvider 应用 store
    return new StoreProvider<MyState>(
      store: store,
      // 使用 StoreBuilder 获取 store 中的 theme、locale
      child: new StoreBuilder<MyState>(
        builder: (context, store) {
          store.state.platformLocale = WidgetsBinding.instance.window.locale;
          // 应用开始真正构建============================================================
          return new MaterialApp(
            // 多语言实现代理
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              MyLocalizationsDelegate.delegate,
            ],
            supportedLocales: [store.state.locale],
            locale: store.state.locale,
            theme: store.state.themeData,
            // 命名式路由
            // ‘/’和 MaterialApp 的 home 参数一个效果
            routes: {
              WelcomePage.routeName: (context) {
                _context = context;
                return WelcomePage();
              },
              LoginPage.routeName: (context) {
                _context = context;
                return NavigatorUtils.pageContainer(new LoginPage());
              },
              SignupPage.routeName: (context) {
                _context = context;
                return NavigatorUtils.pageContainer(new SignupPage());
              },
              HomePage.routeName: (context) {
                _context = context;
                return NavigatorUtils.pageContainer(new HomePage());
              },
              FarmPage.routeName: (context) {
                _context = context;
                return NavigatorUtils.pageContainer(new FarmPage());
              },
            },
          );
        },
      ),
    );
  }
}

mixin HttpErrorListener on State<FlutterReduxApp> {
  StreamSubscription stream;

  BuildContext _context;

  @override
  void initState() {
    super.initState();
    // Stream 演示 event bus
    stream = eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandler(event.code, event.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (stream != null) {
      stream.cancel();
      stream = null;
    }
  }

  // 网络错误提醒
  errorHandler(int code, message) {
    switch (code) {
      case Code.NETWORK_ERROR:
        Fluttertoast.showToast(
            msg: MyLocalizations.i18n(_context).network_error);
        break;
      case 401:
        Fluttertoast.showToast(
            msg: MyLocalizations.i18n(_context).network_error_401);
        break;
      case 402:
        Fluttertoast.showToast(
            msg: MyLocalizations.i18n(_context).network_error_402);
        break;
      case 403:
        Fluttertoast.showToast(
            msg: MyLocalizations.i18n(_context).network_error_403);
        break;
      case 404:
        Fluttertoast.showToast(
            msg: MyLocalizations.i18n(_context).network_error_404);
        break;
      case Code.NETWORK_TIMEOUT:
        Fluttertoast.showToast(
            msg: MyLocalizations.i18n(_context).network_error_timeout);
        break;
      default:
        Fluttertoast.showToast(
            msg: MyLocalizations.i18n(_context).network_error_unknow +
                " " +
                message);
        break;
    }
  }
}
