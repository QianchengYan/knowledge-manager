使用 `shared_preferences` 包

model里面建立的对象是为了，反序列化得到对象，序列化后存储对象。

如果有和后端的通信，那么就直接用 json 格式进行收发。收到的数据：

1. 可以直接存到本地
2. 反序列化后可以得到 HashMap，或者调用model中对象的fromJson直接实例化得到对象

**1. 对 task 的本地缓存处理**

从后端获取的是 json 字符串，一个字符串对应一个 task，

**本地存储**

将字符串的列表进行序列化，然后存储到本地

**从本地加载**

将序列化后的列表，`decoder`反序列化得到字符串的列表，然后



## 1. task模块

### 1. 渲染

**1. 添加：单独渲染**



**2. 删除：单独渲染**



**3. 更新：单独渲染**



**4. 查询：整体渲染**

整体渲染最容易，直接从后端得到一个HashMap的Set的json字符串。前端通过`decoder`得到这个Set，然后对其循环渲染就ok了。

数据持久化的目的就是不频繁访问服务器，由于这个过程需要一些判断，是从本地取还是从服务器取。现在先不做持久化，先只访问服务器。