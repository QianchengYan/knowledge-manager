import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

/**
 * 事件Redux
 */

// 定义一个 Action 类
// 在 Reducer 中
// 将该 Action 与处理该 Action 的方法绑定
class RefreshThemeDataAction {
  final ThemeData themeData;
  RefreshThemeDataAction(this.themeData);
}

// 定义处理 Action 行为的方法，返回新的 State
ThemeData _refresh(ThemeData themeData, action) {
  // 这种传参很诡异，形参的改变无法带出去，如何不定义成局部变量
  themeData = action.themeData;
  return themeData;
}

// 通过 flutter_redux 的 combineReducers 实现 Reducer 方法
final ThemeDataReducer = combineReducers<ThemeData>([
  // 将 Action、处理 Action 的方法、State 绑定
  TypedReducer<ThemeData, RefreshThemeDataAction>(_refresh),
]);
