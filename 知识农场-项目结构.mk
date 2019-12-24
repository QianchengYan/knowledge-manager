# 项目结构
## 1. APP前期启动
**1. `lib/main.dart`  `runZoned`**
main函数中执行方法 `runZoned` 接收两个参数，一个是必须的无命名参数 `R body(),`，一个是可选的命名参数 `Function onError` 。两个参数都是方法。
onError那个方法没什么，就是打印个obj和stack。
重点是body那个方法。

```js
() {
  // 更改ErrorWidget.builder
  ErrorWidget.builder = (FlutterErrorDetails details) {
  	// 一些错误信息处理
  };
  // 重点：调用了runApp=====================================
  runApp(ConfigWrapper(
    child: FlutterReduxApp(),
    config: EnvConfig.fromJson(config),
  ));
},
```
**2. `runApp` 中传入的 `new ConfigWrapper(x, x)`**
`ConfigWrapper` 类是自定义的，接收两个参数 `child` `config` 。

```js
class ConfigWrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // 设置 Config.DEBUG 的静态变量 ===========================
    Config.DEBUG = this.config.debug;
    return new _InheritedConfig(config: this.config, child: this.child);
  }
```

```js
class _InheritedConfig extends InheritedWidget {

  final EnvConfig config;

// 把 child 传给 InheritedWidget=======================
  const _InheritedConfig(
    {Key key,
    @required this.config,
    @required Widget child,}
  ) : super(key: key, child: child);
// 使用 config（问题是 config 不会变吧） ================================
  @override
  bool updateShouldNotify(_InheritedConfig oldWidget) =>
    config != oldWidget.config;
}
```

**3. `lib/app.dart` `FlutterReduxApp`**
在 `FlutterReduxApp` 中：
 `FlutterReduxApp` ->  `StoreProvider`  ->  `StoreBuilder<MyState>` -> `MaterialApp` 
1. 定义 store 做redux初始化: store = new Store<MyState\>
2. 将 store 和 new StoreBuilder<MyState\> 传入 new StoreProvider, 然后返回。
3. StoreBuilder 的 builder 中传入方法，该方法返回 `MaterialApp`，应用开始真正构建

```js
class FlutterReduxApp extends StatefulWidget {
  @override
  _FlutterReduxAppState createState() => _FlutterReduxAppState();
}

class _FlutterReduxAppState extends State<FlutterReduxApp> with HttpErrorListener {
  // initState 初始化 State
  final store = new Store<MyState>(
    appReducer,
    // 拦截器
    middleware: middleware,
    // 初始化数据 初始化 state
    initialState: new MyState(
        userInfo: User.empty(),
        login: false,
        themeData: CommonUtils.getThemeData(MyColors.primarySwatch),
        locale: Locale('zh', 'CH')),
    );
  @override
  Widget build(BuildContext context) {
    // 使用 flutter_redux 做全局状态共享
    // 通过 StoreProvider 应用 store
    return new StoreProvider(
      store: store,
      // 使用 StoreBuilder 获取 store 中的 theme、locale
      child: new StoreBuilder<MyState>(
        builder: (context, store) {
          store.state.platformLocale = WidgetsBinding.instance.window.locale;
          // 应用开始真正构建============================================================
          return new MaterialApp(
```
**4. 真正构建应用 实例化 `new MaterialApp`**
实例化时使用的参数，都是从 `store.state` 中获取的。redux 全局状态管理开始使用。
主要工作是在 `Material` 中配置路由，使用命名路由，配置了根路由就不需要传参`home`了。接下来的工作就交给根路由的页面了。
```js
return new MaterialApp(
  // 多语言实现代理
  localizationsDelegates: [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    MyLocalizationsDelegate.delegate,
  ],
  supportedLocales: [store.state.locale],
  locale: store.state.locale,
  theme: store.state.themeData,
  // 命名式路由
  // ‘/’和 MaterialApp 的 home 参数一个效果
  routes: {
    HomePage.routeName: (context) {
      _context = context;
      return NavigatorUtils.pageContainer(new HomePage());
    }
  },
);
```
## 2. APP主页面
**1. HomePage的定义**

## APP偏好设置载入，以及用户登录
这个涉及到 Shared-preference 的读取 和 Redux 中 Store 的初始化，以及 Login 的触发。

**1. `FlutterReduxApp ` 中 `Store` 默认设置初始化**
传入：一个所有属性都是 reducer 的 MyState对象、一个 middleware 列表、一个所有属性都是初始化好的state的 MyState 对象。
注意：这里的初始化，初始的是默认值，不是软件的偏好设置值，还没到读取缓存设置偏好值那一步。

**2. 进入欢迎页 `WelcomePage`，设置本地缓存的历史设置；判断是否有登录历史，选择跳转到 登录界面 还是 主页**

使用 `Store<MyState> store = StoreProvider.of(context);` 获得 APP 的 store对象，然后读取本地缓存来进行设置 主题颜色、语言；

至于用户信息，需要 读取本地缓存的用户信息，和 配置中的TOKEN_KEY 来判断有没有历史登录，如果有的话，把用户信息存入store，并且跳转到HomePage；如果没有，则跳转到LoginPage。

