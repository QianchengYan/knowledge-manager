import 'package:dio/dio.dart';
import 'package:knowledge_manager/common/config/config.dart';

/**
 * log拦截器
 */
class LogInterceptor extends InterceptorsWrapper {
  static List<Map> sHttpResponses = new List<Map>();
  static List<String> sHttpResponsesUrl = new List<String>();

  static List<Map<String, dynamic>> sHttpRequest =
      new List<Map<String, dynamic>>();
  static List<String> sHttpRequestUrl = new List<String>();

  static List<Map<String, dynamic>> sHttpError =
      new List<Map<String, dynamic>>();
  static List<String> sHttpErrorUrl = new List<String>();

// url存入 sHttpResponsesUrl， {header:, data:}存入 sHttpResponses
  @override
  Future onRequest(RequestOptions options) async {
    if (Config.DEBUG) {
      print("请求url：${options.path}");
      print("请求头：${options.headers.toString()}");
      if (options.data != null) {
        print("请求参数：${options.data.toString()}");
      }
    }
    try {
      addLog(sHttpRequestUrl, options.path ?? "");
      var map = {
        "header:": {...options.headers},
      };
      var data = options.data ?? Map<String, dynamic>();
      if (options.method == "POST") {
        map["data"] = data;
      }
      addLog(sHttpRequest, map);
    } catch (e) {
      print("common/net/interceptors/log_interceptor.dart/onRequset\n");
      print(e);
    }
    return options;
  }

  @override
  onResponse(Response response) async {
    if (Config.DEBUG) {
      if (response != null) {
        print('返回参数：${response.toString()}');
      }
    }
    if (response.data != null) {
      addLog(sHttpResponsesUrl, response?.request?.uri.toString() ?? "");
    }

    if (response.data is Map || response.data is List) {
      try {
        var data = Map<String, dynamic>();
        data["data"] = response.data;
        addLog(sHttpResponses, data);
      } catch (e) {
        print("common/net/interceptors/log_interceptor.dart/onResponse\n");
        print(e);
      }
    } else if (response.data is String) {
      try {
        var data = Map<String, dynamic>();
        data["data"] = response.data;
        addLog(sHttpRequest, data);
      } catch (e) {
        print("common/net/interceptors/log_interceptor.dart/onResponse\n");
        print(e);
      }
    } else if (response.data != null) {
      try {
        String data = response.data.toJson();
        addLog(sHttpRequest, data);
      } catch (e) {
        print("common/net/interceptors/log_interceptor.dart/onResponse\n");
        print(e);
      }
    }
    return response;
  }

  @override
  onError(DioError error) async {
    if (Config.DEBUG) {
      print('请求异常：' + error.toString());
      print("请求异常信息：" + error.response?.toString() ?? "");
    }
    try {
      addLog(sHttpErrorUrl, error.request.path ?? "null");
      var errors = Map<String, dynamic>();
      errors["error"] = error.message;
      addLog(sHttpError, errors);
    } catch (e) {
      print("common/net/interceptors/log_interceptor.dart/onError\n");
      print(e);
    }
    return error;
  }

  static addLog(List list, data) {
    if (list.length > 20) {
      // 最大保持20条log，删除最之前的log，追加新log
      list.removeAt(0);
    }
    list.add(data);
  }
}
