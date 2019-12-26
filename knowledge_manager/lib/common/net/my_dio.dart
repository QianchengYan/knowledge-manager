import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:knowledge_manager/common/config/config.dart';
import 'package:knowledge_manager/common/net/code.dart';
import 'package:knowledge_manager/common/net/interceptors/error_interceptor.dart';
import 'package:knowledge_manager/common/net/interceptors/header_interceptor.dart';
import 'package:knowledge_manager/common/net/interceptors/response_interceptor.dart';
import 'package:knowledge_manager/common/net/interceptors/token_interceptor.dart';
import 'package:knowledge_manager/common/net/result_data.dart';

class MyDio {
  Dio _dio = new Dio(); // 使用默认设置

  Future<NetResult> netFetch(
    url,
    body,
    Map<String, dynamic> header,
    Options option, {
    noTip = false,
  }) async {
    if (Config.DEBUG) {
      print("===============MyDio.netFetch: $url");
    }

    Map<String, dynamic> headers = new HashMap();
    // 先把 headers 准备好
    if (header != null) {
      headers.addAll(header);
    }
    // 有个 option，再把 headers 加上
    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "post");
      option.headers = headers;
    }

    Response response;
    try {
      response = await _dio.request(url, data: body, options: option);
      print("==============_dio.response: $response");
    } on DioError catch (e) {
      // 这里需要做网络访问错误的UI显示
      print("==============_dio.request erro $e");
      return new NetResult(
        null,
        false, // result = false 没得到结果
        0, // code
      );
    }

    if (response.data is DioError) {
      print("==============_dio.response.data = DioErro ");
      return new NetResult(
        response.data,
        false, // result = false 没得到结果
        0, // code
      );
    } else {
      print("==============_dio.response.data ${response.data}");
      return new NetResult(
        response.data,
        true, // result = false 没得到结果
        0, // code
      );
    }
  }

  Future<NetResult> get(
    url,
    Map params, {
    noTip = false,
  }) async {
    Response response;
    try {
      response = await dio.get(url, queryParameters: params);
      print(response.data.toString());
      print("==============_dio.response: $response");
    } on DioError catch (e) {
      // 这里需要做网络访问错误的UI显示
      print("==============_dio.request erro $e");
      return new NetResult(
        null,
        false, // result = false 没得到结果
        0, // code
      );
    }

    if (response.data is DioError) {
      print("==============_dio.response.data = DioErro ");
      return new NetResult(
        response.data,
        false, // result = false 没得到结果
        0, // code
      );
    } else {
      print("==============_dio.response.data ${response.data}");
      return new NetResult(
        response.data,
        true, // result = false 没得到结果
        0, // code
      );
    }
  }
}

final MyDio myDio = new MyDio();
final Dio dio = new Dio();

// http请求
class HttpManager {
  static const CONTENT_TYPE_JSON = 'application/json';
  static const CONTENT_TYPE_FORM = 'application/x-www-form-urlencoded';

  Dio _dio = new Dio(); // 使用默认设置

  final TokenInterceptor _tokenInterceptors = new TokenInterceptor();

  HttpManager() {
    // _dio.interceptors.add(new HeaderInterceptor());
    // _dio.interceptors.add(_tokenInterceptors);
    // _dio.interceptors.add(new LogInterceptor());
    // _dio.interceptors.add(new ErrorInterceptor(_dio));
    // _dio.interceptors.add(new ResponseInterceptor());
  }

  // 发起网络请求
  // 重新封装的 _dio.request(url, data, options);
  // [url] 请求url
  // [body] 请求参数
  // [header] 外加头
  // [option] 配置
  Future<NetResult> netFetch(
    url,
    body,
    Map<String, dynamic> header,
    Options option, {
    noTip = false,
  }) async {
    //     try {
    //   Response response;
    //   // response = await Dio().post('http://139.224.112.248:8000/api/login/login?username=1&password=1');
    //   response = await Dio().request(url, data: body, options: option);
    //   // response = await Dio().post(url);

    //   // return print(response);
    // } catch (e) {
    //   // return print(e);
    // }

    if (Config.DEBUG) {
      print("===============httpManager.netFetch");
      print("url: $url");
    }

    Map<String, dynamic> headers = new HashMap();
    // 先把 headers 准备好
    if (header != null) {
      headers.addAll(header);
    }
    // 有个 option，再把 headers 加上
    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "post");
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
      return new NetResult(
        Code.errorHandler(errorResponse.statusCode, e.message, noTip), // data
        false, // result = false 没得到结果
        errorResponse.statusCode, // code
      );
    }

    Response response;
    try {
      response = await _dio.request(url, data: body, options: option);
      print("==============_dio.response: $response");
    } on DioError catch (e) {
      print("==============_dio.request erro $e");
      return resultError(e);
    }

    if (response.data is DioError) {
      print("==============_dio.response.data = DioErro ");
      return resultError(response.data);
    } else {
      print("==============_dio.response.data ${response.data}");
      return response.data;
    }
  }

  /**
   * 清除授权
   */
  clearAuthorization() {
    _tokenInterceptors.clearAuthorization();
  }

  /**
   * 获取授权token
   */
  getAuthorization() {
    return _tokenInterceptors.getAuthorization();
  }
}

// final HttpManager httpManager = new HttpManager();
