import 'package:flutter/material.dart';
import 'package:knowledge_manager/common/localization/default_localizations.dart';
import 'package:knowledge_manager/common/style/my_colors.dart';
import 'package:knowledge_manager/common/style/my_icons.dart';
import 'package:knowledge_manager/common/style/my_text_style.dart';
import 'package:knowledge_manager/widgets/my_card_item.dart';
import 'package:knowledge_manager/widgets/my_input_widget.dart';

class FlagContainerEditDialog extends StatefulWidget {
  FlagContainerEditDialog(this.dialogTitle, this.onTitleChanged,
      this.onValueChanged, this.onContentChanged, this.onPressed,
      {this.titleController,
      this.valueController,
      this.contentController,
      this.needTitle = true});

  final String dialogTitle; // 弹窗标题
  final ValueChanged<String> onTitleChanged; // 标题改变回调函数
  final ValueChanged<String> onValueChanged; // 数值改变回调函数
  final ValueChanged<String> onContentChanged; // 內容改变回调函数
  final VoidCallback onPressed; // 点击回调函数
  final TextEditingController titleController; // 标题编辑框控制器
  final TextEditingController valueController; // 数值编辑框控制器
  final TextEditingController contentController; // 內容编辑框控制器
  final bool needTitle;

  @override
  _FlagContainerEditDialogState createState() =>
      _FlagContainerEditDialogState();
}

class _FlagContainerEditDialogState extends State<FlagContainerEditDialog> {
  _FlagContainerEditDialogState();
  // 标题输入框
  _renderTitleInput() {
    return new Padding(
      padding: new EdgeInsets.all(5.0),
      child: new MyInputWidget(
        onChanged: widget.onTitleChanged,
        controller: widget.titleController,
        hintText: "请输入标题（不能为空）",
        obscureText: false,
      ),
    );
  }

  // 时长输入框
  _renderDaysInput() {
    return new Padding(
        padding: new EdgeInsets.all(5.0),
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("天数："),
            new SizedBox(
              height: 30,
              width: 100,
              child: new MyInputWidget(
                onChanged: widget.onValueChanged,
                controller: widget.valueController,
                hintText: "请输入",
                obscureText: false,
              ),
            ),
            Text("天"),
          ],
        ));
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

                        ///天数输入框
                        _renderDaysInput(),

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
                                    hintText: "请输入描述（不能为空）",
                                    hintStyle: MyTextStyle.middleSubText,
                                  ),
                                  style: MyTextStyle.middleText,
                                ),
                              ),
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
