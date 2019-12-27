import 'package:flutter/material.dart';
import 'package:knowledge_manager/common/localization/default_localizations.dart';
import 'package:knowledge_manager/common/style/my_colors.dart';
import 'package:knowledge_manager/common/style/my_text_style.dart';
import 'package:knowledge_manager/pages/flag/edit_flag_container_dialog.dart';
import 'package:knowledge_manager/pages/schedule/task_edit_dialog.dart';
import 'package:knowledge_manager/widgets/my_card_item.dart';

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
   * 弹出日程编辑弹窗
   */
  static Future<Null> showTaskEditDialog(
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
          child: new TaskEditDialog(
            dialogTitle,
            onTitleChanged,
            onContentChanged,
            onPressed,
            titleController: titleController,
            contentController: contentController,
            needTitle: needTitle,
          ),
        );
      },
    );
  }

  /**
   * 弹出FlagContainer编辑弹窗
   */
  static Future<Null> showCardContainerEditDialog(
    BuildContext context,
    String dialogTitle,
    ValueChanged<String> onTitleChanged,
    ValueChanged<String> onValueChanged,
    ValueChanged<String> onContentChanged,
    VoidCallback onPressed, {
    TextEditingController titleController,
    TextEditingController valueController,
    TextEditingController contentController,
    bool needTitle = true,
  }) {
    return NavigatorUtils.showMyDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: new FlagContainerEditDialog(
            dialogTitle,
            onTitleChanged,
            onValueChanged,
            onContentChanged,
            onPressed,
            titleController: titleController,
            contentController: contentController,
            valueController: valueController,
            needTitle: needTitle,
          ),
        );
      },
    );
  }
}
