import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:knowledge_manager/common/net/code.dart';
import 'package:knowledge_manager/common/net/interceptors/error_interceptor.dart';
import 'package:knowledge_manager/common/net/interceptors/header_interceptor.dart';
import 'package:knowledge_manager/common/net/interceptors/response_interceptor.dart';
import 'package:knowledge_manager/common/net/interceptors/token_interceptor.dart';
import 'package:knowledge_manager/common/net/result_data.dart';

// http请求
class HttpManager {
  static const CONTENT_TYPE_JSON = 'application/json';
  static const CONTENT_TYPE_FORM = 'application/x-www-form-urlencoded';

  Dio _dio = new Dio(); // 使用默认设置

  final TokenInterceptor _tokenInterceptors = new TokenInterceptor();

  HttpManager() {
    _dio.interceptors.add(new HeaderInterceptor());
    _dio.interceptors.add(_tokenInterceptors);
    _dio.interceptors.add(new LogInterceptor());
    _dio.interceptors.add(new ErrorInterceptor(_dio));
    _dio.interceptors.add(new ResponseInterceptor());
  }

  // 发起网络请求
  // 重新封装的 _dio.request(url, data, options);
  // [url] 请求url
  // [params] 请求参数
  // [header] 外加头
  // [option] 配置
  Future<ResultData> netFetch(
      url, params, Map<String, dynamic> header, Options option,
      {noTip = false}) async {
    Map<String, dynamic> headers = new HashMap();
    // 先把 headers 准备好
    if (header != null) {
      headers.addAll(header);
    }
    // 有个 option，再把 headers 加上
    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "get");
      option.headers = headers;
    }

    resultError(DioError e) {
      // Response 是 dio包中的类
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }
      return new ResultData(
        Code.errorHandler(errorResponse.statusCode, e.message, noTip), // data
        false, // result = false 没得到结果
        errorResponse.statusCode, // code
      );
    }

    Response response;
    try {
      response = await _dio.request(url, data: params, options: option);
    } on DioError catch (e) {
      return resultError(e);
    }

    if (response.data is DioError) {
      return resultError(response.data);
    } else {
      return response.data;
    }
  }

  // 清除授权
  clearAuthorization() {
    _tokenInterceptors.clearAuthorization();
  }

  // 获取授权token
  getAuthorization() {
    return _tokenInterceptors.getAuthorization();
  }
}

final HttpManager httpManager = new HttpManager();