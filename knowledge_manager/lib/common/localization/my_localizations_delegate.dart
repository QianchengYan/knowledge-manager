import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:knowledge_manager/common/localization/default_localizations.dart';

/**
 * 多语言代理
 */
class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // 支持中文和英文
    return true;
  }

  // 根据 locale，创建一个对象用于提供当前 locale 下的文本显示
  @override
  Future<MyLocalizations> load(Locale locale) {
    return new SynchronousFuture<MyLocalizations>(new MyLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<MyLocalizations> old) {
    return false;
  }

  // 全局静态的代理
  static MyLocalizationsDelegate delegate = new MyLocalizationsDelegate();

}