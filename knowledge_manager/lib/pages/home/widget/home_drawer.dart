import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:knowledge_manager/model/User.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new StoreBuilder(
        builder: (context, store) {
          User user = store.state.userInfo;
          
        },
      ),
    );
  }
}