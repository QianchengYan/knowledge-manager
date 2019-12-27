import 'package:flutter/material.dart';
import 'package:knowledge_manager/common/style/my_colors.dart';

/**
 * Card Widget
 * Created by guoshuyu
 * Date: 2018-07-16
 */
class MyCardItem extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final Color color;
  final RoundedRectangleBorder shape;
  final double elevation;

  MyCardItem(
      {@required this.child,
      this.margin,
      this.color,
      this.shape,
      this.elevation = 5.0});

  @override
  Widget build(BuildContext context) {
    EdgeInsets margin = this.margin;
    RoundedRectangleBorder shape = this.shape;
    Color color = this.color;
    margin ??=
        EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 10.0);
    shape ??= new RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)));
    color ??= MyColors.cardWhite;
    return new Card(
        elevation: elevation,
        shape: shape,
        color: color,
        margin: margin,
        child: child);
  }
}
