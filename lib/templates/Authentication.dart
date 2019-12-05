import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../main.dart';
import 'Common.dart';

class TemplateAuthentication extends BeautifulPopupTemplate {
  final BeautifulPopup options;
  TemplateAuthentication({
    this.options,
  }) : super(options: options);

  @override
  final illustrationPath = 'img/bg/authentication.png';
  @override
  Color get primaryColor => options.primaryColor ?? Color(0xff15c0ec);
  @override
  final maxWidth = 400;
  @override
  final maxHeight = 617;
  @override
  final bodyMargin = 10;
  @override
  get layout {
    return [
      Positioned(
        child: background,
      ),
      Positioned(
        top: percentH(34),
        child: title,
      ),
      Positioned(
        top: percentH(44),
        left: percentW(8),
        height: percentH(actions == null ? 52 : 38),
        width: percentW(84),
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
