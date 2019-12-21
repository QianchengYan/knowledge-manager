import 'package:flutter/material.dart';

import 'my_string_base.dart';
import 'my_string_en.dart';
import 'my_string_zh.dart';

// 自定义多语言实现
class MyLocalizations {
  final Locale locale;
  MyLocalizations(this.locale);

  // 根据不同的 local.languageCode 加载不同语言
  static Map<String, MyStringBase> _localizedValues = {
    'en': new MyStringEn(),
    'zh': new MyStringZh(),
  };

  MyStringBase get currentLocalization {
    if (_localizedValues.containsKey(locale.languageCode)) {
      // 工程中有与当前手机设置的本地化匹配的资源
      return _localizedValues[locale.languageCode];
    } else {
      // 没有与手机设置匹配的资源时，使用“英文”本地化
      return _localizedValues["en"];
    }
  }

  // 通过 Localizations 加载当前的 MyLocalizations
  // 获取对应的 MyStringBase
  static MyLocalizations of(BuildContext context) {
    return Localizations.of(context, MyLocalizations);
  }

  // 这个方法实在看不懂。。。我说怎么看不懂，窗口太小没看见后面的.currentLocalization
  // as不知道怎么使用
  static MyStringBase i18n(BuildContext context) {
    return (Localizations.of(context, MyLocalizations) as MyLocalizations).currentLocalization;
  }
}
// 使用本地化的方法：
// MyLocalization.i18n(context).app_version_title
// 
