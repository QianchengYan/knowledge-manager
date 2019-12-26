import 'package:flutter/material.dart';
import 'package:knowledge_manager/common/localization/default_localizations.dart';

class DialogUtils {
  static showMyDialog(BuildContext context, alertTitle, alertContent) {
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text(alertTitle),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text(alertContent),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(MyLocalizations.i18n(context).app_ok),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((val) {
      print(val);
    });
  }
  
}