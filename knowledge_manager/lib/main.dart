import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_manager/app.dart';
import 'package:knowledge_manager/env/config_wrapper.dart';
import 'package:knowledge_manager/env/env_config.dart';
import 'package:knowledge_manager/pages/error_page.dart';

// 提供config，我感觉用json自动生成这种方式意义不大
import 'env/dev.dart';

void main() {
  runZoned(
    () {
      ErrorWidget.builder = (FlutterErrorDetails details) {
        Zone.current.handleUncaughtError(details.exception, details.stack);
        return ErrorPage(
            details.exception.toString() + '\n' + details.stack.toString(),
            details);
      };

      runApp(ConfigWrapper(
        child: FlutterReduxApp(),
        config: EnvConfig.fromJson(config),
      ));
    },
    onError: (Object obj, StackTrace stack) {
      print(obj);
      print(stack);
    },
  );
}
