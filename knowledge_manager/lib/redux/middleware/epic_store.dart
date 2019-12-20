
import 'package:redux/redux.dart';

class EpicStore<State> {
  final Store<State> _store;
  EpicStore(this._store);

  State get state => _store.state;

  Stream<State> get onChange => _store.onChange;

  void dispatch(dynamic action) {
    _store.dispatch(action);
  }
}