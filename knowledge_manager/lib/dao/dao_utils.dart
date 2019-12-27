import 'package:knowledge_manager/common/config/config.dart';
import 'package:knowledge_manager/common/net/result_data.dart';

class DaoResult {
  var data;
  bool result;
  Function next;

  DaoResult(this.data, this.result, {this.next});
}

class DaoUtils {
  static NetResultProcess(NetResult netResult, {api, detail}) {
    // 处理http请求结果
    if (netResult != null && netResult.result) {
      // 网络通信成功
      if (netResult.data["success"] == true) {
        // $detail 成功
        if (Config.DEBUG) {
          print("=============$api: $detail 成功");
        }
        return DaoResult(netResult.data, true);
      } else {
        // $detail 失败
        if (Config.DEBUG) {
          print("=============$api: $detail 失败");
        }
        return DaoResult(netResult.data["message"], false);
      }
    } else {
      // 网络通信失败
      // UI显示由 net 来做
      return null;
    }
  }
}
