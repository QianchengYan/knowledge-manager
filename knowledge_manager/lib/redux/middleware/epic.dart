
import 'dart:async';

import 'package:knowledge_manager/redux/middleware/epic_store.dart';

typedef Stream<dynamic> Epic<State>(
  Stream<dynamic> actions, EpicStore<State> store
);

abstract class EpicClass<State> {
  Stream<dynamic> call(
    Stream<dynamic> actions,
    EpicStore<State> store,
  );
}

class TypedEpic<State, Action> extends EpicClass<State> {
  final Stream<dynamic> Function(
    Stream<Action> action,
    EpicStore<State> store,
  ) epic;

  TypedEpic(this.epic);

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<State> store) {
    return epic(
      actions.transform(new StreamTransformer<dynamic, Action>.fromHandlers(
        handleData: (dynamic action, EventSink<Action> sink) {
          if(action is Action) {
            sink.add(action);
          }
        },
      )),
      store,
    );
  }
}