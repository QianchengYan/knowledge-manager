import 'package:dio/dio.dart';
import 'package:knowledge_manager/common/config/config.dart';
import 'package:knowledge_manager/common/local/local_storage.dart';

/**
 * Token 拦截器
 */
class TokenInterceptors extends InterceptorsWrapper {
  String _token;

  @override
  onRequest(RequestOptions options) async {
    // 授权码
    if (_token == null) {
      var authorizationCode = await getAuthorization();
    }
  }

  // 获取授权 token
  // 根据代码来看，token 就是 USER_BASE_CODE？账号加密码组成的字符串？
  // 见 UserDao 中的 login
  getAuthorization() async {
    String token = await LocalStorage.get(Config.TOKEN_KEY);
    if (token == null) {
      String basic = await LocalStorage.get(Config.USER_BASE_CODE);
      if (basic == null) {
        // 提示输入账号密码

      } else {
        // 通过 basic 去获取 token，获取到设置，返回token
        return "Basic $basic";
      }
    } else {
      this._token = token;
      return token;
    }
  }

  // 清除授权
  clearAuthorization() {
    this._token = null;
    LocalStorage.remove(Config.TOKEN_KEY);
    releaseClient();
  }
}
