/**
 * 网络结果数据
 */
class NetResult {
  NetResult(this.data, this.result, this.code, {this.headers});

  var data;
  bool result;
  int code;
  var headers;

}