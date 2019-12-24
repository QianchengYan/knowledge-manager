import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:knowledge_manager/common/config/config.dart';
import 'package:knowledge_manager/common/dao/dao_result.dart';
import 'package:knowledge_manager/common/dao/user_dao.dart';
import 'package:knowledge_manager/common/local/local_storage.dart';
import 'package:knowledge_manager/common/net/address.dart';
import 'package:knowledge_manager/common/net/api.dart';
import 'package:knowledge_manager/common/utils/common_utils.dart';
import 'package:knowledge_manager/model/User.dart';
import 'package:knowledge_manager/redux/locale_redux.dart';
import 'package:knowledge_manager/redux/user_redux.dart';
import 'package:redux/redux.dart';

class AppInit {
/**
   * 初始化用户信息
   * 被 welcome_page 调用
   * 在APP启动时会被调用，来初始化 Redux 的 store
   * 为什么这里不login？？？
   * 
   */
  static initUserInfo(Store store) async {
    // 获取 token （token什么时候刷新？代表什么？）
    var token = await LocalStorage.get(Config.TOKEN_KEY);

    // 获取 本地用户信息 （为什么不登录？）
    // 只要之前登陆过就能 get 成功（难道登陆一次，一直有效吗？）
    var res = await UserDao.getUserInfoLocalDao();

    // 加载本地保存的用户信息
    if (res != null && res.result && token != null) {
      store.dispatch(UpdateUserAction(res.data));
    }

    // 返回的这个有函数接收吗？感觉 init 函数返回没有意义
    // 返回值有意义，可以判断出是否有 用户缓存 和 token 缓存
    return new DataResult(res.data, (res.result && (token != null)));
  }

  static initAppSetting(Store store) async {
    // 加载本地保存的主题
    String themeColorIndex = await LocalStorage.get(Config.THEME_COLOR_INDEX);
    if (themeColorIndex != null && themeColorIndex.length != 0) {
      CommonUtils.changeThemeColor(store, int.parse(themeColorIndex));
    }

    // 加载本地保存的语言
    String localIndex = await LocalStorage.get(Config.LOCALE_INDEX);
    if (localIndex != null && localIndex.length != 0) {
      CommonUtils.changeLocale(store, int.parse(localIndex));
    } else {
      CommonUtils.currentLocale = store.state.platformLocale;
      store.dispatch(RefreshLocaleAction(store.state.platformLocale));
    }
  }
}
