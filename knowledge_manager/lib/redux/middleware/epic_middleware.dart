
import 'dart:async';

import 'package:knowledge_manager/redux/middleware/epic.dart';
import 'package:knowledge_manager/redux/middleware/epic_store.dart';
import 'package:redux/redux.dart';
import 'package:rxdart/transformers.dart';


class EpicMiddleware<State> extends MiddlewareClass<State> {
  final StreamController<dynamic> _action = 
    new StreamController<dynamic>.broadcast();
  final StreamController<Epic<State>> _epics = 
    new StreamController.broadcast(sync: true);

  final bool supportAsyncGenerators;
  Epic<State> _epic;
  bool _isSubscribed = false;

  EpicMiddleware(Epic<State> epic, {this.supportAsyncGenerators = true}):_epic = epic;

  @override
  void call(Store<State> store, action, NextDispatcher next) {
    if(!_isSubscribed) {
      _epics.stream.transform<dynamic>(
        new SwitchMapStreamTransformer<Epic<State>, dynamic>(
          (epic) => epic(_action.stream, new EpicStore(store))
        )
      ).listen(store.dispatch);

      _epics.add(_epic);
      _isSubscribed = true;
    }
  }
}