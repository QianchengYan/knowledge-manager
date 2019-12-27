import 'package:flutter/material.dart';
import 'package:knowledge_manager/common/localization/default_localizations.dart';
import 'package:knowledge_manager/common/style/my_colors.dart';
import 'package:knowledge_manager/common/style/my_icons.dart';
import 'package:knowledge_manager/common/style/my_text_style.dart';
import 'package:knowledge_manager/widgets/my_card_item.dart';
import 'package:knowledge_manager/widgets/my_input_widget.dart';

class TaskEditDialog extends StatefulWidget {
  TaskEditDialog(this.dialogTitle, this.onTitleChanged, this.onContentChanged,
      this.onPressed,
      {this.titleController, this.contentController, this.needTitle = true});

  final String dialogTitle; // 弹窗标题
  final ValueChanged<String> onTitleChanged; // 标题改变回调函数
  final ValueChanged<String> onContentChanged; // 內容改变回调函数
  final VoidCallback onPressed; // 点击回调函数
  final TextEditingController titleController; // 标题编辑框控制器
  final TextEditingController contentController; // 內容编辑框控制器
  final bool needTitle;

  @override
  _TaskEditDialogState createState() => _TaskEditDialogState();
}

class _TaskEditDialogState extends State<TaskEditDialog> {
  _TaskEditDialogState();
  // 标题输入框
  _renderTitleInput() {
    return (widget.needTitle)
        ? new Padding(
            padding: new EdgeInsets.all(5.0),
            child: new MyInputWidget(
              onChanged: widget.onTitleChanged,
              controller: widget.titleController,
              hintText: "请输入",
              obscureText: false,
            ),
          )
        : new Container();
  }

  // 快速输入框
  _renderFastInputContainer() {
    // 因为时Column下包含了ListView，所以需要设置高度
    return Container(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return new RawMaterialButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
            constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            child: Icon(
              FAST_INPUT_LIST[index].iconData,
              size: 16,
            ),
            onPressed: () {
              String text = FAST_INPUT_LIST[index].content;
              String newText = "";
              if (widget.contentController.value != null) {
                newText = widget.contentController.value.text;
              }
              newText = newText + text;
              setState(() {
                widget.contentController.value =
                    new TextEditingValue(text: newText);
              });
              widget.onContentChanged?.call(newText);
            },
          );
        },
        itemCount: FAST_INPUT_LIST.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: new Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black12,
            // 触摸收起键盘
            child: new GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: new Center(
                child: new MyCardItem(
                  margin: EdgeInsets.only(left: 50.0, right: 50.0),
                  shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: new Padding(
                    padding: new EdgeInsets.all(12.0),
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ///dialog标题
                        new Padding(
                            padding:
                                new EdgeInsets.only(top: 5.0, bottom: 15.0),
                            child: new Center(
                              child: new Text(
                                widget.dialogTitle,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),

                        ///标题输入框
                        _renderTitleInput(),

                        ///内容输入框
                        new Container(
                          height: MediaQuery.of(context).size.width * 3 / 4,
                          decoration: new BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            color: MyColors.white,
                            border: new Border.all(
                                color: MyColors.subTextColor, width: .3),
                          ),
                          padding: new EdgeInsets.only(
                              left: 20.0, top: 12.0, right: 20.0, bottom: 12.0),
                          child: new Column(
                            children: <Widget>[
                              new Expanded(
                                child: new TextField(
                                  autofocus: false,
                                  maxLines: 999,
                                  onChanged: widget.onContentChanged,
                                  controller: widget.contentController,
                                  decoration: new InputDecoration.collapsed(
                                    hintText: "请输入",
                                    hintStyle: MyTextStyle.middleSubText,
                                  ),
                                  style: MyTextStyle.middleText,
                                ),
                              ),

                              ///快速输入框
                              // _renderFastInputContainer(),
                            ],
                          ),
                        ),
                        new Container(height: 10.0),
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ///取消
                            new Expanded(
                                child: new RawMaterialButton(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    padding: EdgeInsets.all(4.0),
                                    constraints: const BoxConstraints(
                                        minWidth: 0.0, minHeight: 0.0),
                                    child: new Text(
                                        MyLocalizations.i18n(context)
                                            .app_cancel,
                                        style: MyTextStyle.normalSubText),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })),
                            new Container(
                                width: 0.3,
                                height: 25.0,
                                color: MyColors.subTextColor),

                            ///确定
                            new Expanded(
                                child: new RawMaterialButton(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    padding: EdgeInsets.all(4.0),
                                    constraints: const BoxConstraints(
                                        minWidth: 0.0, minHeight: 0.0),
                                    child: new Text(
                                      MyLocalizations.i18n(context).app_ok,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: widget.onPressed)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FastInputIconModel {
  final IconData iconData;
  final String content;
  FastInputIconModel(this.iconData, this.content);
}

var FAST_INPUT_LIST = [
  FastInputIconModel(MyICons.ISSUE_EDIT_H1, "\n# "),
  FastInputIconModel(MyICons.ISSUE_EDIT_H2, "\n## "),
  FastInputIconModel(MyICons.ISSUE_EDIT_H3, "\n### "),
  FastInputIconModel(MyICons.ISSUE_EDIT_BOLD, "****"),
  FastInputIconModel(MyICons.ISSUE_EDIT_ITALIC, "__# "),
  FastInputIconModel(MyICons.ISSUE_EDIT_QUOTE, "``"),
  FastInputIconModel(MyICons.ISSUE_EDIT_CODE, "\n```\n\n```\n"),
  FastInputIconModel(MyICons.ISSUE_EDIT_LINK, "[](url)"),
];
