import 'package:knowledge_manager/common/event/http_error_event.dart';
import 'package:knowledge_manager/common/event/index.dart';

// 错误编码，自己映射？
// 返回的是 message，但是 message 又是传进来的
// 其实只做了当 noTip==false 时，把 HttpErrorEvent 添加到 eventBus 上
class Code {
  // 网络错误
  static const NETWORK_ERROR = -1;
  // 网络超时
  static const NETWORK_TIMEOUT = -2;
  // 网络返回数据格式化异常
  static const NETWORK_JSON_EXCEPTION = -3;
  // 成功
  static const SUCCESS = 200;
  static errorHandler(code, message, noTip) {
    if(noTip) {
      return message;
    } else {
      eventBus.fire(new HttpErrorEvent(code, message));
      return message;
    }
  }
}