import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Common.dart';
import '../main.dart';

/// ![](https://raw.githubusercontent.com/jaweii/Flutter_beautiful_popup/master/img/bg/camera.png)
class TemplateCamera extends BeautifulPopupTemplate {
  final BeautifulPopup options;
  TemplateCamera(this.options) : super(options);

  @override
  final illustrationPath = 'img/bg/camera.png';
  @override
  Color get primaryColor => options.primaryColor ?? Color(0xff72b2e0);
  @override
  final maxWidth = 400;
  @override
  final maxHeight = 500;
  @override
  final bodyMargin = 20;
  @override
  get layout {
    return [
      Positioned(
        child: background,
      ),
      Positioned(
        top: percentH(42),
        child: title,
      ),
      Positioned(
        top: percentH(54),
        height: percentH(actions == null ? 40 : 24),
        left: percentW(8),
        right: percentW(8),
        child: content,
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
