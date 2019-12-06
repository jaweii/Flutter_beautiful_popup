import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Common.dart';
import '../main.dart';

/// ![](https://raw.githubusercontent.com/jaweii/Flutter_beautiful_popup/master/img/bg/coin.png)
class TemplateCoin extends BeautifulPopupTemplate {
  final BeautifulPopup options;
  TemplateCoin({
    this.options,
  }) : super(options: options);

  @override
  final illustrationPath = 'img/bg/coin.png';
  @override
  Color get primaryColor => options.primaryColor ?? Color(0xffff8269);
  @override
  final maxWidth = 400;
  @override
  final maxHeight = 586;
  @override
  final bodyMargin = 0;
  @override
  get layout {
    return [
      Positioned(
        child: background,
      ),
      Positioned(
        top: percentH(46),
        child: title,
      ),
      Positioned(
        top: percentH(56),
        left: percentW(12),
        height: percentH(actions == null ? 38 : 26),
        width: percentW(76),
        child: content,
      ),
      Positioned(
        bottom: percentW(12),
        left: percentW(14),
        right: percentW(14),
        child: actions ?? Container(),
      ),
    ];
  }
}
