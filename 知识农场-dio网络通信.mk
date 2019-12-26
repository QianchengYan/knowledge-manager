**调试方法**

打印

```dart
if (Config.DEBUG) {
    print("=============UserDao.getUserInfo: 获取当前用户信息成功");
    print("the type of userInfo:${userInfo.runtimeType.toString()}");
    print("the content of userInfo:${userInfo.toString()}");
}
```



**URL设置**

正确

```
String host = "http://139.224.112.248:8000/";
```
错误
```
String host = "139.224.112.248:8000/";
```



**接收数据**

接收的数据如何取出来 `response.data["key"]`

```dart
Response response = await dio.get("/token");
//Set the token to headers
options.headers["token"] = response.data["data"]["token"];
```



**数据类型**

后端

```python
def get_my_info(self):
	return {
            'id': self.id,
            'username': self.username,
            'name': self.name,
            'avatarUrl': self.avatar_url,
            'phone': self.phone,
            'email': self.email,
        }     
```

```python
params = {
    'data': user.get_my_info(),
    'success': True,
    'message': '用户信息获取成功',
}
return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                    content_type='application/json;charset=utf-8')
```

flutter

```dart
class NetResult {
  NetResult(this.data, this.result, this.code, {this.headers});
  var data;
  bool result;
  int code;
  var headers;
}
```

```dart
var params = { // 注意不能用 Map，但是queryParameters的类型也为Map，奇怪
    "username": username,
};
// 发起http请求
String url = isMy ? Address.getMyInfo() : Address.getUserInfo();
NetResult netResult = await myDio.get(url, params);

response = await dio.get(url, queryParameters: params);
return new NetResult(
    response.data,
    true, // result = false 没得到结果
    0, // code
);
```

数据类型

```dart
netResult.data["data"] // 类型为 HashMap
```

