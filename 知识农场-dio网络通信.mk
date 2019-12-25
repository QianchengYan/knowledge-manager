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

