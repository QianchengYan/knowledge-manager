import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:knowledge_manager/common/config/config.dart';
import 'package:knowledge_manager/common/local/local_storage.dart';
import 'package:knowledge_manager/common/net/address.dart';
import 'package:knowledge_manager/common/net/my_dio.dart';
import 'package:knowledge_manager/common/net/result_data.dart';
import 'package:knowledge_manager/common/utils/common_utils.dart';
import 'package:knowledge_manager/dao/dao_result.dart';
import 'package:knowledge_manager/model/User.dart';
import 'package:knowledge_manager/redux/locale_redux.dart';
import 'package:knowledge_manager/redux/my_state.dart';
import 'package:knowledge_manager/redux/user_redux.dart';
import 'package:redux/redux.dart';

/**
 * User数据持久化
 * 只管 local storage 和 local database
 * 不管 store(store只在app生存周期中有效) 
 */
class UserDao {
  /**
   * 登录
   */
  static login(username, password) async {
    // 本地存储用户名
    await LocalStorage.save(Config.USERNAME_KEY, username);
    // 准备http请求 body
    Map requestBody = {
      "username": username,
      "password": password,
    };
    // 发起http请求
    var res = await myDio.netFetch(
      Address.getLoginUrl(),
      json.encode(requestBody),
      null,
      new Options(method: "post"),
    );
    // 处理http请求结果
    if (res != null && res.result) {
      // 网络通信成功
      if (res.data["success"] == true) {
        // 登录成功
        if (Config.DEBUG) {
          print("=============UserDao.login: 登录成功");
        }

        await LocalStorage.save(Config.PASSWORD_KEY, password);
        StoreProvider<MyState> store;
        return DaoResult(res.data["message"], true);
      } else {
        // 登录失败
        if (Config.DEBUG) {
          print("=============UserDao.login: 登录失败");
        }
        return DaoResult(res.data["message"], false);
      }
    } else {
      // 网络通信失败
      // UI显示由 net 来做
      return null;
    }
  }

  /**
   * 注册
   */
  static signup(username, password, name, {phone, email}) async {
    // 本地存储用户名
    await LocalStorage.save(Config.USERNAME_KEY, username);
    // 准备http请求 body
    Map requestBody = {
      "username": username,
      "password": password,
      "name": name,
      "phone": phone,
      "email": email,
    };
    // 发起http请求
    var res = await myDio.netFetch(
      Address.getSignupUrl(),
      json.encode(requestBody),
      null,
      new Options(method: "post"),
    );
    // 处理http请求结果
    if (res != null && res.result) {
      // 网络通信成功
      if (res.data["success"] == true) {
        // 注册成功
        if (Config.DEBUG) {
          print("=============UserDao.signup: 注册成功");
        }
        await LocalStorage.save(Config.PASSWORD_KEY, password);
        return DaoResult(res.data["message"], true);
      } else {
        // 注册失败
        if (Config.DEBUG) {
          print("=============UserDao.signup: 注册失败");
        }
        return DaoResult(res.data["message"], false);
      }
    } else {
      // 网络通信失败
      // UI显示由 net 来做
      return null;
    }
  }


  /**
   * 获取用户信息
   */
  static getUserInfo(username, store) async {
        // 准备http请求 body
    Map requestBody = {
      "username": username,
    };
    // 发起http请求
    NetResult res = await myDio.netFetch(
      Address.getMyInfo(),
      json.encode(requestBody),
      null,
      new Options(method: "post"),
    );
    // 处理http请求结果
    if (res != null && res.result) {
      // 网络通信成功
      if (res.data["success"] == true) {
        // 登录成功
        if (Config.DEBUG) {
          print("=============UserDao.getUserInfo: 获取当前用户信息成功");
        }
        await LocalStorage.save(Config.USER_INFO, User.fromJson(res.data["data"]));
        store.dispatch();
        return DaoResult(res.data["data"], true);
      } else {
        // 登录失败
        if (Config.DEBUG) {
          print("=============UserDao.getUserInfo: 获取当前用户信息失败");
        }
        return DaoResult(res.data["message"], false);
      }
    } else {
      // 网络通信失败
      // UI显示由 net 来做
      return null;
    }
  }

  // 获取本地登录用户信息
  static getUserInfoLocalDao() async {
    // 获取缓存
    var userText = await LocalStorage.get(Config.USER_INFO);
    if (userText != null) {
      // 反序列化得到对象
      var userMap = json.decode(userText);
      User user = User.fromJson(userMap);
      return new DaoResult(user, true);
    } else {
      return new DaoResult(null, false);
    }
  }

  // // 获取用户详细信息
  // static getUserInfo(userName, {needDb = false}) async {
  //   // UserInfoDbProvider provider = new UserInfoDbProvider();
  //   var provider;
  //   // 函数里面定义函数，为了少传一些参数？也为了函数定义的功能不分散？
  //   next() async {
  //     var res;
  //     if (userName == null) {
  //       // 获取自己的信息
  //       res = await httpManager.netFetch(
  //           Address.getMyUserInfo(), null, null, null);
  //     } else {
  //       // 应该是获取其他用户的信息
  //       res = await httpManager.netFetch(
  //           Address.getUserInfo(userName), null, null, null);
  //     }
  //     if (res != null && res.result) {
  //       // 获取有效信息
  //       User user = User.fromJson(res.data);
  //       if (userName == null) {
  //         // 获取自己信息
  //         LocalStorage.save(Config.USER_INFO, json.encode(user.toJson()));
  //       } else {
  //         // 获取他人信息
  //         if (needDb) {
  //           provider.insert(userName, json.encode(user.toJson()));
  //         }
  //       }
  //       return new DataResult(user, true);
  //     } else {
  //       // 获取无效信息
  //       return new DataResult(res.data, false);
  //     }
  //   }

  //   if (needDb) {
  //     User user = await provider.getUserInfo(userName);
  //     if (user == null) {
  //       return await next();
  //     }
  //     DataResult dataResult = new DataResult(user, true, next: next);
  //     return dataResult;
  //   }
  //   return await next();
  // }

  // // 清空关于用户所有信息
  // static clearAll(Store store) async {
  //   httpManager.clearAuthorization();
  //   LocalStorage.remove(Config.USER_INFO);
  //   store.dispatch(new UpdateUserAction(User.empty()));
  // }

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
