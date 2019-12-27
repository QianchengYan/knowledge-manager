import 'package:flutter/material.dart';
import 'package:knowledge_manager/common/localization/default_localizations.dart';

import 'navigator_utils.dart';

class ShowDialogUtils {

  /**
   * 简单提示框
   */
  static showHintDialog(BuildContext context, alertTitle, alertContent) {
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

  /**
   * 弹出编辑弹窗
   */
  static Future<Null> showEditDialog(
    BuildContext context,
    String dialogTitle,
    ValueChanged<String> onTitleChanged,
    ValueChanged<String> onContentChanged,
    VoidCallback onPressed, {
    TextEditingController titleController,
    TextEditingController contentController,
    bool needTitle = true,
  }) {
    return NavigatorUtils.showMyDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
              // child: new IssueEditDialog(
              //   dialogTitle,

              // ),
              );
        });
  }

  
}