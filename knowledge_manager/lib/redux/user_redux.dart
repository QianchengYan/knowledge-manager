import 'package:knowledge_manager/common/dao/user_dao.dart';
import 'package:knowledge_manager/redux/middleware/epic.dart';
import 'package:knowledge_manager/redux/middleware/epic_store.dart';
import 'package:knowledge_manager/redux/my_state.dart';
import 'package:knowledge_manager/model/User.dart';
import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';

/**
 * 用户相关 Redux
 */
// 定义一个 UpdateUserAction，用于发起 userInfo 改变的请求
// 类名随意，只要通过 TypedReducer 绑定就好
class UpdateUserAction {
  final User userInfo;
  UpdateUserAction(this.userInfo);
}

// 如果有 UpdateUserAction 发起一个请求时
// 就会调用到 _updateLoaded
// _updateLoaded 接受一个新的 userInfo，并返回
User _updateLoaded(User user, action) {
  user = action.userInfo;
  return user;
} 

// redux 的 combineReducers，通过 TypedReducer 将 UpdateUserAction 与 reducers 关联起来
final UserReducer = combineReducers<User>([
  TypedReducer<User, UpdateUserAction>(_updateLoaded),
]);





class FetchUserAction {

}

class UserInfoMiddleware implements MiddlewareClass<MyState> {
  @override
  void call(Store<MyState> store, dynamic action, NextDispatcher next) {
    if(action is UpdateUserAction) {
      print("****** UserInfoMiddleware ******");
    }
    next(action);
  }
}

class UserInfoEpic implements EpicClass<MyState> {
  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<MyState> store) {
    return Observable(actions)
      // to UpdateUserAction actions
      .whereType<FetchUserAction>()
      // Don't start until the 10ms
      .debounce(((_) => TimerStream(true, const Duration(milliseconds: 10))))
      .switchMap((action) => _loadUserInfo());
  }

  // User the async* function to make easier
  Stream<dynamic> _loadUserInfo() async* {
    print("****** userInfoEpic _loadUserInfo ******");
    // var res = await UserDao.getUserInfo(null);
    // yield UpdateUserAction(res.data);
  }
}