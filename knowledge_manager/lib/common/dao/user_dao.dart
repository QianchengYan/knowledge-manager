import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:knowledge_manager/common/config/config.dart';
import 'package:knowledge_manager/common/local/local_storage.dart';

class UserDao {
  static login(userName, password, store) async {
    String type = userName + ":" + password;
    var bytes = utf8.encode(type);
    var base64str = base64.encode(bytes);
    if(Config.DEBUG) {
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

    httpManager
    
  }
}