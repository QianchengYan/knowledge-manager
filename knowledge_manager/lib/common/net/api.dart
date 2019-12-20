import 'package:dio/dio.dart';

// http请求
class HttpManager {
  static const CONTENT_TYPE_JSON = 'application/json';
  static const CONTENT_TYPE_FORM = 'application/x-www-form-urlencoded';

  Dio _dio = new Dio(); // 使用默认设置

  final TokenInterceptors = 
}