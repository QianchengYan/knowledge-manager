import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_manager/env/config_wrapper.dart';
import 'package:knowledge_manager/env/env_config.dart';
import 'package:knowledge_manager/pages/error_page.dart';
import 'package:knowledge_manager/start/app.dart';

// 提供config，我感觉用json自动生成这种方式意义不大
// import 'env/dev.dart';

// void main() {
//   runZoned(
//     () {
//       ErrorWidget.builder = (FlutterErrorDetails details) {
//         Zone.current.handleUncaughtError(details.exception, details.stack);
//         return ErrorPage(
//             details.exception.toString() + '\n' + details.stack.toString(),
//             details);
//       };

//       runApp(new ConfigWrapper(
//         child: FlutterReduxApp(),
//         config: EnvConfig.fromJson(config),
//       ));
//     },
//     onError: (Object obj, StackTrace stack) {
//       print(obj);
//       print(stack);
//     },
//   );
// }

void main() => runApp(FlutterReduxApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: new ThemeData(
//         // This is the theme of your application.

//         primarySwatch: Colors.blue,
//       ),
//       // 由于HomePage的route是‘/’根路由，所以可以不用写home
//       // home: new HomePage(),
//       routes: {
//         HomePage.routeName: (context) {
//           return HomePage();
//         },
//       },
//     );
//   }
// }
