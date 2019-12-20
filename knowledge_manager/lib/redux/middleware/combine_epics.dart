
import 'package:knowledge_manager/redux/middleware/epic.dart';
import 'package:knowledge_manager/redux/middleware/epic_store.dart';
import 'package:rxdart/rxdart.dart';

Epic<State> combineEpics<State>(List<Epic<State>> epics) {
  return (Stream<dynamic> actions, EpicStore<State> store) {
    return new MergeStream<dynamic>(epics.map((epic) => epic(actions, store)));
  };
} 