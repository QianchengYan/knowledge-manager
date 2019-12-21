import 'package:flutter/material.dart';

class MyInputWidget extends StatefulWidget {
  final bool obscureText; // 模糊 掩盖

  final String hintText;

  final IconData iconData;

  final ValueChanged<String> onChanged;

  final TextStyle textStyle;

  final TextEditingController controller;

  MyInputWidget({
    Key key,
    this.obscureText = false,
    this.hintText,
    this.iconData,
    this.onChanged,
    this.textStyle,
    this.controller,
  }) : super(key: key);

  @override
  _MyInputWidgetState createState() => _MyInputWidgetState();
}

class _MyInputWidgetState extends State<MyInputWidget> {
  @override
  Widget build(BuildContext context) {
    return new TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      decoration: new InputDecoration(
        hintText: widget.hintText,
        icon: widget.iconData == null ? null : new Icon(widget.iconData),
      ),
    );
  }
}
