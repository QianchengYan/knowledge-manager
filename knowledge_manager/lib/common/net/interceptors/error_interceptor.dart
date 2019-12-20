import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:knowledge_manager/common/net/code.dart';
import 'package:knowledge_manager/common/net/result_data.dart';

// 是否需要弹窗显示
const NOT_TIP_KEY = "noTip";

/**
 * 错误拦截
 */
class ErrorInterceptor extends InterceptorsWrapper {
  final Dio _dio;
  // 构造方法
  ErrorInterceptor(this._dio);
  @override
  Future onRequest(RequestOptions options) async {
    // 检测网络是否正常
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // 没有网络
      // 这里就很神奇了，过滤器，竟然自己造个对象送出去了。
      return _dio.resolve(new ResultData(
          Code.errorHandler(Code.NETWORK_ERROR, "", false),
          false,
          Code.NETWORK_ERROR));
    } else {
      return options;
    }
  }
}
