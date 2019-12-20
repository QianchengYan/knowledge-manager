import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:knowledge_manager/common/config/config.dart';
import 'package:knowledge_manager/common/dao/dao_result.dart';
import 'package:knowledge_manager/common/local/local_storage.dart';
import 'package:knowledge_manager/common/net/address.dart';
import 'package:knowledge_manager/common/net/api.dart';
import 'package:knowledge_manager/model/User.dart';
import 'package:knowledge_manager/redux/user_redux.dart';
import 'package:redux/redux.dart';

class UserDao {
  static login(userName, password, store) async {
    String type = userName + ":" + password;
    var bytes = utf8.encode(type);
    var base64str = base64.encode(bytes);
    if (Config.DEBUG) {
      print("base64Str login:" + base64str);
    }
    // 本地存储用户名和密码
    await LocalStorage.save(Config.USER_NAME_KEY, userName);
    await LocalStorage.save(Config.USER_BASE_CODE, base64str);

    Map requestParams = {
      "scopes": ['user', 'repo', 'gist', 'notifications'],
      "note": "admin_script",
      "client_id": NetConfig.CLIENT_ID,
      "client_secret": NetConfig.CLIENT_SECRET
    };

    // 清除授权
    httpManager.clearAuthorization();
    // 重新获取授权
    var res = await httpManager.netFetch(Address.getAuthorization(),
        json.encode(requestParams), null, new Options(method: "post"));
    var resultData = null;
    if(res != null && res.result) {
      // 获取授权成功
      await LocalStorage.save(Config.PASSWORD_KEY, password);
      var resultData = await getUserInfo(null);
      if(Config.DEBUG) {
        print('user result: ${resultData.result.toString()}');
        print(resultData.data);
        print(res.data.toString());
      }
      store.dispatch(new UpdateUserAction(resultData.data));
    }
    return new DataResult(resultData, res.result);
  }

  // 获取本地登录用户信息
  static getUserInfoLocal() async {
    // 获取缓存
    var userText = await LocalStorage.get(Config.USER_INFO);
    if(userText != null) {
      // 反序列化得到对象
      var userMap = json.decode(userText);
      User user = User.fromJson(userMap);
      return new DataResult(user, true);
    } else {
      return new DataResult(null, false);
    }
  }

  // 获取用户详细信息
  static getUserInfo(userName, {needDb = false}) async {
    UserInfoDbProvider provider = new UserInfoDbProvider();
    // 函数里面定义函数，为了少传一些参数？也为了函数定义的功能不分散？
    next() async {
      var res;
      if(userName == null) {
        // 获取自己的信息
        res = await httpManager.netFetch(
          Address.getMyUserInfo(), null, null, null);
      } else {
        // 应该是获取其他用户的信息
        res = await httpManager.netFetch(
          Address.getUserInfo(userName), null, null, null);
      }
      if(res != null && res.result) {
        // 获取有效信息
        User user = User.fromJson(res.data);
        if(userName == null) {
          // 获取自己信息
          LocalStorage.save(Config.USER_INFO, json.encode(user.toJson()));
        } else {
          // 获取他人信息
          if(needDb) {
            provider.insert(userName, json.encode(user.toJson()));
          }
        }
        return new DataResult(user, true);
      } else {
        // 获取无效信息
        return new DataResult(res.data, false);
      }
    }

    if(needDb) {
      User user = await provider.getUserInfo(userName);
      if(user == null) {
        return await next();
      }
      DataResult dataResult = new DataResult(user, true, next: next);
      return dataResult;
    }
    return await next();
  }

  // 清空关于用户所有信息
  static clearAll(Store store) async {
    httpManager.clearAuthorization();
    LocalStorage.remove(Config.USER_INFO);
    store.dispatch(new UpdateUserAction(User.empty()));
  }

  /**
   * 获取用户粉丝列表
   */
  static getFollowerListDao() async {}

  /**
   * 获取用户关注列表
   */
  static getFollowedListDao() async {}

  /**
   * 获取用户相关通知
   */
  static getNotifyDao() async {}

  /**
   * 设置单个通知已读
   */
  static setNotificationAsReadDao() async {}

  /**
   * 设置所有通知已读
   */
  static setAllNotificationAsReadDao() async {}

  /**
   * 检查用户关注状态
   */
  static checkFollowDao() async {}

  /**
   * 关注用户
   */
  static doFollowDao() async {}

  /**
   * 更新用户信息
   */
  static updateUserDao() async {}
}
