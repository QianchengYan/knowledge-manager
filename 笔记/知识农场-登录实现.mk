**1. WelcomePage 判断是否之前登录过，没登陆过跳转到 LoginPage**



**2. LoginPage 将 username password 存入 MyState 的 store 中，经过Redux中间件调用 login 函数**



**3. login 方法 位于 UserDao 中，编码后通过 httpManager 传给后端**



**4. 重点就在 httpManager 了， 它是 根据 DIO 自定义封装的 HttpManager 的对象**

先看最核心的代码 

```dart
Response response = await _dio.request(url, data: params, options: option);
```

再看调用

```dart
class Address {  
  static const String host = "127.0.0.1:8000/";
  static getAuthorizationUrl() {
    return "${host}authorizations";
  }

Map requestParams = {
      "scopes": ['user', 'repo', 'gist', 'notifications'],
      "note": "admin_script",
      "client_id": NetConfig.CLIENT_ID,
      "client_secret": NetConfig.CLIENT_SECRET
    };

var res = await httpManager.netFetch(
      Address.getAuthorizationUrl(),
      json.encode(requestParams),
      null,
      new Options(method: "post"),
    );
```

嗯，貌似就 requestParams 有点东西，Option 估计也就是之前学过的 post get 等方法，url好说，就是django urls.py 等着去正则匹配的那堆urls。