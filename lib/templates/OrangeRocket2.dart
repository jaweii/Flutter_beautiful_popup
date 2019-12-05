import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Common.dart';
import '../main.dart';

class TemplateOrangeRocket2 extends BeautifulPopupTemplate {
  final BeautifulPopup options;
  TemplateOrangeRocket2({
    this.options,
  }) : super(options: options);

  @override
  final illustrationPath = 'img/bg/rocket_orange_2.png';
  @override
  Color get primaryColor => options.primaryColor ?? Color(0xffff902b);
  @override
  final maxWidth = 350;
  @override
  final maxHeight = 488;
  @override
  final bodyMargin = 0;
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
        top: percentH(52),
        left: percentW(10),
        height: percentH(actions == null ? 40 : 26),
        width: percentW(80),
        child: content,
      ),
      Positioned(
        bottom: percentW(12),
        left: percentW(10),
        right: percentW(10),
        child: actions ?? Container(),
      ),
    ];
  }
}
