import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../main.dart';
import 'Common.dart';

/// ![](https://raw.githubusercontent.com/jaweii/Flutter_beautiful_popup/master/img/bg/authentication.png)
class TemplateAuthentication extends BeautifulPopupTemplate {
  final BeautifulPopup options;
  TemplateAuthentication(this.options) : super(options);

  @override
  final illustrationPath = 'img/bg/authentication.png';
  @override
  Color get primaryColor => options.primaryColor ?? Color(0xff15c0ec);
  @override
  final maxWidth = 400;
  @override
  final maxHeight = 617;
  @override
  final bodyMargin = 0;
  @override
  get layout {
    return [
      Positioned(
        child: background,
      ),
      Positioned(
        top: percentH(32),
        child: title,
      ),
      Positioned(
        top: percentH(44),
        left: percentW(10),
        right: percentW(10),
        height: percentH(actions == null ? 52 : 38),
        child: content!,
      ),
      Positioned(
        bottom: percentW(8),
        left: percentW(8),
        right: percentW(8),
        child: actions ?? Container(),
      ),
    ];
  }
}
