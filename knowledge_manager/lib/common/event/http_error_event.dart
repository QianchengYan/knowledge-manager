// 自己声明了一个事件结构 HttpErrorEvent
class HttpErrorEvent {
  final int code;
  final String message;
  HttpErrorEvent(this.code, this.message);
}