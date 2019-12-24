import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:knowledge_manager/common/config/config.dart';
import 'package:knowledge_manager/common/local/local_storage.dart';
import 'package:knowledge_manager/common/localization/default_localizations.dart';
import 'package:knowledge_manager/common/net/address.dart';
import 'package:knowledge_manager/common/style/my_colors.dart';
import 'package:knowledge_manager/common/style/my_text_style.dart';
import 'package:knowledge_manager/common/utils/navigator_utils.dart';
import 'package:knowledge_manager/redux/locale_redux.dart';
import 'package:knowledge_manager/redux/my_state.dart';
import 'package:knowledge_manager/redux/theme_redux.dart';
import 'package:knowledge_manager/widgets/my_flex_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

/**
 * 通用逻辑
 */
class CommonUtils {
  static final double MILLIS_LIMIT = 1000;
  static final double SECONDS_LIMIT = 60 * MILLIS_LIMIT;
  static final double MINUTES_LIMIT = 60 * SECONDS_LIMIT;
  static final double HOURS_LIMIT = 24 * MINUTES_LIMIT;
  static final double DAYS_LIMIT = 30 * HOURS_LIMIT;
  static Locale currentLocale;

  static String getDateStr(DateTime date) {
    if (date == null || date.toString() == null) {
      return "";
    } else if (date.toString().length < 10) {
      return date.toString();
    } else {
      return date.toString().substring(0, 10);
    }
  }

  // 日期格式转换
  static String getNewsTimeStr(DateTime date) {
    int subTimes =
        DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;
    if (subTimes < MILLIS_LIMIT) {
      return (currentLocale != null)
          ? (currentLocale.languageCode != "zh") ? "right now" : "刚刚"
          : "刚刚";
    } else if (subTimes < SECONDS_LIMIT) {
      return (subTimes / MILLIS_LIMIT).round().toString() +
          ((currentLocale != null)
              ? (currentLocale.languageCode != "zh") ? " seconds ago" : " 秒前"
              : " 秒前");
    } else if (subTimes < MINUTES_LIMIT) {
      return (subTimes / SECONDS_LIMIT).round().toString() +
          ((currentLocale != null)
              ? (currentLocale.languageCode != "zh") ? " min ago" : " 分钟前"
              : " 分钟前");
    } else if (subTimes < HOURS_LIMIT) {
      return (subTimes / MINUTES_LIMIT).round().toString() +
          ((currentLocale != null)
              ? (currentLocale.languageCode != "zh") ? " hours ago" : " 小时前"
              : " 小时前");
    } else if (subTimes < DAYS_LIMIT) {
      return (subTimes / HOURS_LIMIT).round().toString() +
          ((currentLocale != null)
              ? (currentLocale.languageCode != "zh") ? " days ago" : " 天前"
              : " 天前");
    } else {
      return getDateStr(date);
    }
  }

  static getLocalPath() async {
    Directory appDir;
    if (Platform.isIOS) {
      appDir = await getApplicationDocumentsDirectory();
    } else {
      appDir = await getExternalStorageDirectory();
    }
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (permission != PermissionStatus.granted) {
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.storage]);
      if (permissions[PermissionGroup.storage] != PermissionStatus.granted) {
        // 获取权限失败，返回
        return null;
      }
    }
    String appDocPath = appDir.path + "/knowledgeManager";
    Directory appPath = Directory(appDocPath);
    await appPath.create(recursive: true);
    return appPath;
  }

  // 没看懂这个方法干什么的
  static String removeTextTag(String description) {
    if (description != null) {
      String reg = "<g-emoji.*?>.+?</g-emoji>";
      RegExp tag = new RegExp(reg);
      Iterable<Match> tags = tag.allMatches(description);
      for (Match m in tags) {
        String match = m
            .group(0)
            .replaceAll(new RegExp("<g-emoji.*?>"), "")
            .replaceAll(new RegExp("</g-emoji>"), "");
        description = description.replaceAll(new RegExp(m.group(0)), match);
      }
    }
    return description;
  }

  static saveImage(String url) async {
    // 不明白这里再套一层函数的意义，发现作者特别喜欢函数里面套函数，不复用，只为了结构清晰
    Future<String> _findPath(String imageUrl) async {
      final file = await DefaultCacheManager().getSingleFile(url);
      if (file == null) {
        // 没有通过url获取到文件
        return null;
      }
      Directory localPath = await CommonUtils.getLocalPath();
      if (localPath == null) {
        // 获取本地地址失败
        return null;
      }
      final name = splitFileNameByPath(file.path);
      final result = await file.copy(localPath.path + name);
      return result.path;
    }

    return _findPath(url);
  }

  static splitFileNameByPath(String path) {
    return path.substring(path.lastIndexOf("/"));
  }

  /**
   * 通过 store 改变主题颜色
   */
  static changeThemeColor(Store store, int index) {
    ThemeData themeData;
    List<Color> colors = getThemeColorList();
    themeData = getThemeData(colors[index]);
    store.dispatch(new RefreshThemeDataAction(themeData));
  }

  static List<Color> getThemeColorList() {
    return [
      MyColors.primarySwatch,
      Colors.brown,
      Colors.blue,
      Colors.teal,
      Colors.amber,
      Colors.blueGrey,
      Colors.deepOrange,
    ];
  }

  static getThemeData(Color color) {
    return ThemeData(primaryColor: color, platform: TargetPlatform.android);
  }

  /**
   * 显示语言选择弹窗，切换语言
   */
  static showLanguageDialog(BuildContext context) {
    List<String> list = [
      MyLocalizations.i18n(context).home_language_default,
      MyLocalizations.i18n(context).home_language_zh,
      MyLocalizations.i18n(context).home_language_en,
    ];
    CommonUtils.showCommitOptionDialog(
      context,
      list,
      (index) {
        // 切换语言
        CommonUtils.changeLocale(StoreProvider.of<MyState>(context), index);
        // 保存设置
        LocalStorage.save(Config.LOCALE_INDEX, index.toString());
      },
      height: 150,
    );
  }

  // 切换语言
  static changeLocale(Store<MyState> store, int index) {
    Locale locale = store.state.platformLocale;
    if (Config.DEBUG) {
      print(store.state.platformLocale);
    }
    switch (index) {
      case 1:
        locale = Locale('zh', 'CH');
        break;
      case 2:
        locale = Locale('en', 'US');
        break;
    }
    currentLocale = locale;
    // 切换语言
    store.dispatch(RefreshLocaleAction(locale));
  }

  // 显示 列表item dialog
  static Future<Null> showCommitOptionDialog(
    BuildContext context,
    List<String> commitMaps,
    ValueChanged<int> onTap, {
    width = 250,
    height = 400,
    List<Color> colorList,
  }) {
    return NavigatorUtils.showMyDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: new Container(
              width: width,
              height: height,
              padding: new EdgeInsets.all(4),
              margin: new EdgeInsets.all(20),
              decoration: new BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: new ListView.builder(
                itemCount: commitMaps.length,
                itemBuilder: (context, index) {
                  return MyFlexButton(
                    maxLines: 1,
                    mainAxisAlignment: MainAxisAlignment.start,
                    fontSize: 14,
                    color: colorList != null
                        ? colorList[index]
                        : Theme.of(context).primaryColor,
                    text: commitMaps[index],
                    textColor: MyColors.white,
                    onPress: () {
                      // 关闭弹窗
                      Navigator.pop(context);
                      onTap(index);
                    },
                  );
                },
              ),
            ),
          );
        });
  }

  /**
   * 获取设备信息
   */
  static Future<String> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      return "";
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.model;
    }
  }

  /**
   * 判断是否是图片
   */
  static isImageEnd(String path) {
    const IMAGE_END = [".png", ".jpg", ".jpeg", ".gif", ".svg"];
    bool image = false;
    for (String item in IMAGE_END) {
      // 这里看不懂感觉不太对
      if (path.indexOf(item) + item.length == path.length) {
        image = true;
      }
    }
    return image;
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

  /**
   * 显示加载弹窗
   */
  static Future<Null> showLoadingDialog(BuildContext context) {
    return NavigatorUtils.showMyDialog(
        context: context,
        builder: (BuildContext context) {
          return new Material(
            color: Colors.transparent,
            child: WillPopScope(
              onWillPop: () => new Future.value(false),
              child: Center(
                child: new Container(
                  width: 200,
                  height: 200,
                  padding: new EdgeInsets.all(4),
                  decoration: new BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                          child: SpinKitCubeGrid(color: MyColors.white)),
                      new Container(height: 10),
                      new Container(
                          child: new Text(
                              MyLocalizations.i18n(context).loading_text,
                              style: MyTextStyle.normalTextWhite)),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  /**
   * 版本更新
   */
  static Future<Null> showUpdateDialog(
    BuildContext context,
    String content,
  ) {
    return NavigatorUtils.showMyDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(MyLocalizations.i18n(context).app_version_title),
            content: new Text(content),
            actions: <Widget>[
              new FlatButton(
                child: new Text(MyLocalizations.i18n(context).app_cancel),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              new FlatButton(
                child: new Text(MyLocalizations.i18n(context).app_ok),
                onPressed: () {
                  // 使用常规依赖库url_launcher
                  launch(Address.updateUrl);
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
