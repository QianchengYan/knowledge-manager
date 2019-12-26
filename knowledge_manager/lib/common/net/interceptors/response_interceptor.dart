import 'package:dio/dio.dart';
import 'package:knowledge_manager/common/net/code.dart';
import 'package:knowledge_manager/common/net/result_data.dart';

// 把 response 返回类型重写了，改成了 NetResult ，自己定义的数据类型
class ResponseInterceptor extends InterceptorsWrapper {
  @override
  onResponse(Response response) async {
    var value;
    try {
      var header = response.headers[Headers.contentTypeHeader];
      if ((header != null && header.toString().contains("text"))) {
        value = new NetResult(response.data, true, Code.SUCCESS);
      } else if (response.statusCode >= 200 && response.statusCode < 300) {
        value = new NetResult(response.data, true, Code.SUCCESS,
            headers: response.headers);
      }
    } catch (e) {
      RequestOptions option = response.request;
      print(e.toString() + option.path);
      value = new NetResult(response.data, false, response.statusCode,
          headers: response.headers);
    }
    return value;
  }
}
