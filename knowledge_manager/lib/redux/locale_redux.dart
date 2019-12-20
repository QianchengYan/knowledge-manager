import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// 定义 Action 类
class RefreshLocaleAction {
  final Locale locale;
  RefreshLocaleAction(this.locale);
}

// 定义处理 Action 的方法
Locale _refresh(Locale locale, RefreshLocaleAction action) {
  locale = action.locale;
  return locale;
}

// 将 Action 和 处理 Action 的方法绑定成 Reducer
final LocaleReducer = combineReducers<Locale>([
  TypedReducer<Locale, RefreshLocaleAction>(_refresh),
]);