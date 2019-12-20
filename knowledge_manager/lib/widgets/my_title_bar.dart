import 'package:flutter/material.dart';

const double RIGHT_ICON_SIZE = 19;

class MyTitleBar extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback onPressed;
  final bool needRightLocalIcon;
  final Widget rightWidget;

  MyTitleBar(this.title, this.iconData, this.onPressed, this.needRightLocalIcon,
      this.rightWidget);

  @override
  Widget build(BuildContext context) {
    Widget widget = rightWidget;
    if (rightWidget == null) {
      widget = (needRightLocalIcon)
          ? new IconButton(
              onPressed: onPressed,
              icon: new Icon(iconData, size: RIGHT_ICON_SIZE),
            )
          : new Container();
    }
    return Container(
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          widget
        ],
      ),
    );
  }
}
