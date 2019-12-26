## 认识

**store** 是大BOSS，`state`、`action`、`reducer ` 都是小弟
所以先定义了 State、Action、reducer，再去实例化 Store，然后用 **StoreProvider** 绑定到APP顶级界面里。
实例化 Store 时，传入的是 reducer 和 初始的state，而 Action 貌似只当 reducer 中 switch 的参数，用来控制使用哪个函数？

**问题**

如何优雅的处理 action 和 reducer 之间的关系？



**1. 如何从state中获取数据？**

1. 拿到store
2. store.state.xxxxx



```dart
child: new StoreBuilder<MyState>(
    builder: (context, store) {
        User user = store.state.userInfo;
        return new Container(
        )
```



**2. 如何将数据存入state？**

```dart
// 切换语言
CommonUtils.changeLocale(StoreProvider.of<MyState>(context), index);

static changeLocale(Store<MyState> store, int index) {
    Locale locale = store.state.platformLocale;
    
    // 切换语言
    store.dispatch(RefreshLocaleAction(locale));

```

```dart
store.dispatch(new RefreshThemeDataAction(themeData));
```





## 理论

**1. 对比StoreBuilder和StoreConnector**

**定义**

该例子里的界面构建使用的是StoreBuilder来构建，也可以使用StoreConnector来构建，两者就差一个参数。
**StoreConnector**主要是有个数据转化的作用，可以对数据先做一些转化操作再赋值到组件上

```dart
class StoreConnector<S, ViewModel> extends StatelessWidget 
```

**StoreBuilder**是直接将数据给显示在组件上

```dart
 class StoreBuilder<S> extends StatelessWidget 
```

**具体参数**

 **StoreConnector** 要定义两个函数
1、一个是 **converter**，**转化函数**，从 Store 中拿出修改的数据 [store.state.name](http://store.state.name/)
2、一个是 **builder**，将 converter 返回的 name 进一步转化为界面：Text(name)。 

****

**问题**

我为什么要定义转化函数传给StoreConnector？我用StoreBuilder拿到store后，自己再处理不就完了？用 StoreConnector 还得实现定义好转化函数的返回类型，如果我用多个state，那么如何定返回类型？返回个list？？？
我感觉还是直接用StoreBuilder方便。