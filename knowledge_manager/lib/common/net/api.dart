import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:knowledge_manager/common/net/interceptors/token_interceptor.dart';
import 'package:knowledge_manager/common/net/result_data.dart';

// http请求
class HttpManager {
  static const CONTENT_TYPE_JSON = 'application/json';
  static const CONTENT_TYPE_FORM = 'application/x-www-form-urlencoded';

  Dio _dio = new Dio(); // 使用默认设置

  final TokenInterceptors _tokenInterceptors = new TokenInterceptors();

  HttpManager() {
    _dio.interceptors.add(new HeadInterceptors());
    _dio.interceptors.add(_tokenInterceptors);
    _dio.interceptors.add(new LogsInterceptors());
    _dio.interceptors.add(new ErrorInterceptors());
    _dio.interceptors.add(new ResponseInterceptors());

    // 发起网络请求
    // [url] 请求url
    // [params] 请求参数
    // [header] 外加头
    // [option] 配置
    Future<ResultData> netFetch(
      url, params, Map<String, dynamic> header, Options option, {noTip = false}
    ) async {
      Map<String, dynamic> headers = new HashMap();
      // 先把 headers 准备好
      if(header != null) {
        headers.addAll(header);
      }
      // 有个 option，再把 headers 加上
      if(option != null) {
        option.headers = headers;
      } else {
        option = new Options(method: "get");
        option.headers = headers;
      }

      resultError(DioError e) {
        Response errorResponse;
        if(e.response != null) {
          errorResponse = e.response;
        } else {
          errorResponse = new Response(statusCode: 666);
        }
      }
    }
  }
}