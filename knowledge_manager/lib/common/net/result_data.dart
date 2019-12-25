/**
 * 网络结果数据
 */
class ResultData {
  ResultData(this.data, this.result, this.code, {this.headers});

  var data;
  bool result;
  int code;
  var headers;

}