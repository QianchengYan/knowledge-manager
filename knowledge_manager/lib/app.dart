import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:knowledge_manager/common/event/http_error_event.dart';
import 'package:knowledge_manager/common/event/index.dart';
import 'package:knowledge_manager/common/localization/default_localizations.dart';
import 'package:knowledge_manager/common/net/code.dart';
import 'package:knowledge_manager/common/style/my_colors.dart';
import 'package:knowledge_manager/common/utils/common_utils.dart';
import 'package:knowledge_manager/model/User.dart';
import 'package:knowledge_manager/redux/my_state.dart';
import 'package:redux/redux.dart';

class FlutterReduxApp extends StatefulWidget {
  @override
  _FlutterReduxAppState createState() => _FlutterReduxAppState();
}

class _FlutterReduxAppState extends State<FlutterReduxApp> with HttpErrorListener {
  // 创建Store，引用 MyState 中的 appReducer 实现 Reducer 方法
  // initState 初始化 State
  final store = new Store<MyState>(
    appReducer,
    // 拦截器
    middleware: middleware,
    // 初始化数据
    initialState: new MyState(
        userInfo: User.empty(),
        login: false,
        themeData: CommonUtils.getThemeData(MyColors.primarySwatch),
        locale: Locale('zh', 'CH')),
  );


  @override
  Widget build(BuildContext context) {
    return Container();
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
