import 'package:flutter/material.dart';
import 'package:knowledge_manager/common/config/config.dart';
import 'package:knowledge_manager/env/env_config.dart';

// 往下共享环境配置
class ConfigWrapper extends StatelessWidget {
  final EnvConfig config;
  final Widget child;

  ConfigWrapper({Key key, this.config, this.child});

  @override
  Widget build(BuildContext context) {
    // 设置 Config.DEBUG 的静态变量
    Config.DEBUG = this.config.debug;
    print("ConfigWrapper build ${Config.DEBUG}");
    return new _InheritedConfig(config: this.config, child: this.child);
  }

  static EnvConfig of(BuildContext context) {
    final _InheritedConfig inheritedConfig = 
      context.inheritFromWidgetOfExactType(_InheritedConfig);
    return inheritedConfig.config;
  }
}

class _InheritedConfig extends InheritedWidget {

  final EnvConfig config;

  const _InheritedConfig(
    {Key key,
    @required this.config,
    @required Widget child,}
  ) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedConfig oldWidget) =>
    config != oldWidget.config;
}