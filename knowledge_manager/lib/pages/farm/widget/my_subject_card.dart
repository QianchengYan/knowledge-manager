import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:knowledge_manager/common/style/my_images.dart';

class MySubjectCard extends StatefulWidget {
  String name;
  String description;
  int plantValue;
  int waterValue;

  MySubjectCard(this.name,
      {this.description = '', this.plantValue = 0, this.waterValue = 0});

  @override
  _MySubjectCardState createState() => _MySubjectCardState();
}


class _MySubjectCardState extends State<MySubjectCard> {
  @override
  Widget build(BuildContext context) {
    double iconSize = 10;
    double sliderHeight = 5;
    double sliderWidth = 35;
    double valueFontSize = 8;

    double nameFontSize = 20;
    double descriptionFontSize = 10;

    return new Stack(
      // fit: StackFit.loose,
      fit: StackFit.expand,
      alignment: Alignment.topLeft,
      overflow: Overflow.clip,
      children: <Widget>[
        new Container(
          decoration: BoxDecoration(
              border: new Border.all(
                  color: Color(0xFFFFFF00), width: 0.5), // 边色与边宽度
              boxShadow: [
                BoxShadow(
                    color: Color(0x99FFFF00),
                    offset: Offset(1.0, 1.0),
                    blurRadius: 1.0,
                    spreadRadius: 1.0),
              ],
              borderRadius: new BorderRadius.circular(5),
              image: DecorationImage(
                image: AssetImage(MyImages.DEFAULT_USER_AVATAR),
                fit: BoxFit.cover,
              )),
        ),
        new Align(
          alignment: Alignment.topRight,
          child: Opacity(
            opacity: 0.85,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.only(right: 5, left: 5, top: 4),
                  child: new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Icon(
                        FontAwesomeIcons.envira,
                        color: Colors.green,
                        size: iconSize,
                      ),
                      new SizedBox(
                        //限制进度条的高度
                        height: sliderHeight,
                        //限制进度条的宽度
                        width: sliderWidth,
                        child: new LinearProgressIndicator(
                            //0~1的浮点数，用来表示进度多少;如果 value 为 null 或空，则显示一个动画，否则显示一个定值
                            value: widget.plantValue / 100,
                            //背景颜色
                            backgroundColor: Colors.yellow,
                            //进度颜色
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.red)),
                      ),
                      new Text("${widget.plantValue}%",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: valueFontSize,
                          )),
                    ],
                  ),
                ),

                // SizedBox(
                //   height: 2,
                // ),
                new Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  child: new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Icon(
                        FontAwesomeIcons.tint,
                        color: Colors.blue,
                        size: iconSize,
                      ),
                      new SizedBox(
                        //限制进度条的高度
                        height: sliderHeight,
                        //限制进度条的宽度
                        width: sliderWidth,
                        child: new LinearProgressIndicator(
                            //0~1的浮点数，用来表示进度多少;如果 value 为 null 或空，则显示一个动画，否则显示一个定值
                            value: widget.waterValue / 100,
                            //背景颜色
                            backgroundColor: Colors.yellow,
                            //进度颜色
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.red)),
                      ),
                      new Text(
                        "${widget.waterValue}%",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: valueFontSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        new Align(
          alignment: Alignment.bottomLeft,
          child: new Padding(
            padding: EdgeInsets.only(right: 7, left: 3, bottom: 4),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  "${widget.name}",
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: nameFontSize,
                  ),
                ),
                new SizedBox(
                  height: 5,
                ),
                new Text(
                  "${widget.description}",
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: descriptionFontSize,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
