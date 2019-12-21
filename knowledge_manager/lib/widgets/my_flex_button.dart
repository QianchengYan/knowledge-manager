import 'package:flutter/material.dart';

/**
 * 充满的button
 */
class MyFlexButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onPress;
  final double fontSize;
  final int maxLines;
  final MainAxisAlignment mainAxisAlignment;

  MyFlexButton({
    Key key,
    this.text,
    this.color,
    this.textColor,
    this.onPress,
    this.fontSize = 20,
    this.maxLines = 1,
    this.mainAxisAlignment = MainAxisAlignment.center
  }): super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: new EdgeInsets.only(
        left: 20, top: 10, right: 20, bottom: 10
      ),
      textColor: textColor,
      color: color,
      child: new Flex(
        mainAxisAlignment: mainAxisAlignment,
        direction: Axis.horizontal,
        children: <Widget>[
          new Expanded(
            child: new Text(
              text,
              style: new TextStyle(fontSize: fontSize),
              textAlign: TextAlign.center,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
      onPressed: (){
        this.onPress?.call();
      },
    );
  }
}