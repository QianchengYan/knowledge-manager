import 'package:knowledge_manager/redux/my_state.dart';
import 'package:redux/redux.dart';
import 'package:knowledge_manager/model/User.dart';

/**
 * 用户相关 Redux
 */

// redux 的 combineReducers，通过 TypedReducer 将 UpdateUserAction 与 reducers 关联起来
final UserReducer = combineReducers<User>([
  TypedReducer<User, UpdateUserAction>(_updateLoaded),
]);

// 如果有 UpdateUserAction 发起一个请求时
// 就会调用到 _updateLoaded
// _updateLoaded 接受一个新的 userInfo，并返回
User _updateLoaded(User user, action) {
  user = action.userInfo,
  return user;
} 

// 定义一个 UpdateUserAction，用于发起 userInfo 改变的请求
// 类名随意，只要通过上面的 TypedReducer 绑定就好
class UpdateUserAction {
  final User userInfo;
  UpdateUserAction(this.userInfo);
}

class FetchUserAction {

}

class UserInfoMiddleware implements MiddlewareClass<MyState> {
  @override
  void call(Store<MyState) store, dynamic action, NextDispatcher next) {
    if(action is UpdateUserAction) {
      print("****** UserInfoMiddleware ******");
    }
    next(action);
  }
}