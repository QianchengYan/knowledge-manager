
import 'package:dio/dio.dart';

/**
 * header 拦截器
 */
// options 输入方法，又输出，只是改了 options 部分属性
// 怪不得叫拦截器装饰器
class HeaderInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    // 超时
    options.connectTimeout = 30000;
    return options;
  }
}