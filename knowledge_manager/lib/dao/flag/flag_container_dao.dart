import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:knowledge_manager/common/config/config.dart';
import 'package:knowledge_manager/common/local/local_storage.dart';
import 'package:knowledge_manager/common/net/address.dart';
import 'package:knowledge_manager/common/net/my_dio.dart';
import 'package:knowledge_manager/common/utils/common_utils.dart';

import '../dao_utils.dart';

class FlagContainerDao {
  /**
   * 添加 FlagContainer
   */
  static add(store, title, description, startTime, totalDays) async {
    // 准备http请求 body
    Map requestBody = {
      "user_username": store.state.userInfo.username,
      "title": title,
      "description": description,
      "startTime": startTime,
      "totalDays": totalDays,
    };
    // 发起http请求
    var netResult = await myDio.netFetch(
      Address.addFlagContainerUrl(),
      json.encode(requestBody),
      null,
      new Options(method: "post"),
    );
    return DaoUtils.NetResultProcess(netResult);
  }

  /**
   * 删除 FlagContainer
   */
  static delete(user_username, title, {imageUrl, description, startTime, endTime}) async {
    // 准备http请求 body
    Map requestBody = {
      "user_username": user_username,
      "title": title,
      "imageUrl": imageUrl,
      "description": description,
      "startTime": startTime,
      "endTime": endTime,
    };
    // 发起http请求
    var netResult = await myDio.netFetch(
      Address.deleteFlagContainerUrl(),
      json.encode(requestBody),
      null,
      new Options(method: "post"),
    );
    return DaoUtils.NetResultProcess(netResult);
  }

  /**
   * 更新 FlagContainer
   */
  static update(user_username, title, {imageUrl, description, startTime, endTime}) async {
    // 准备http请求 body
    Map requestBody = {
      "user_username": user_username,
      "title": title,
      "imageUrl": imageUrl,
      "description": description,
      "startTime": startTime,
      "endTime": endTime,
    };
    // 发起http请求
    var netResult = await myDio.netFetch(
      Address.updateFlagContainerUrl(),
      json.encode(requestBody),
      null,
      new Options(method: "post"),
    );
    return DaoUtils.NetResultProcess(netResult);
  }

  /**
   * 获取 FlagContainer
   */
  static get(username) async {
    print("===========get");
    // 准备http请求 body
    var params = {
      "user_username": username,
    };
    // 发起http请求
    String url = Address.getFlagContainerUrl();
    var netResult = await myDio.get(url, params);
    return DaoUtils.NetResultProcess(netResult);
  }

}