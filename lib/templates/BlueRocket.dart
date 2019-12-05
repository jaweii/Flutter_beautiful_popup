import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Common.dart';
import '../main.dart';
import 'package:auto_size_text/auto_size_text.dart';

/// ![](https://raw.githubusercontent.com/jaweii/Flutter_beautiful_popup/master/img/bg/rocket_blue.png)
class TemplateBlueRocket extends BeautifulPopupTemplate {
  final BeautifulPopup options;
  TemplateBlueRocket({
    this.options,
  }) : super(options: options);

  @override
  final illustrationPath = 'img/bg/rocket_blue.png';
  @override
  Color get primaryColor => options.primaryColor ?? Color(0xff4aa3f9);
  @override
  final maxWidth = 400;
  @override
  final maxHeight = 512;
  @override
  final bodyMargin = 0;

  @override
  Widget get title {
    if (options.title is Widget) {
      return SizedBox(
        width: percentW(54),
        height: percentH(10),
        child: options.title,
      );
    }
    return SizedBox(
      width: percentW(100),
      child: Opacity(
        opacity: 0.9,
        child: AutoSizeText(
          options.title,
          maxLines: 1,
          style: TextStyle(
            fontSize: Theme.of(state.context).textTheme.display1.fontSize,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  get layout {
    return [
      Positioned(
        child: background,
      ),
      Positioned(
        top: percentH(13),
        left: percentW(10),
        child: title,
      ),
      Positioned(
        top: percentH(40),
        left: percentW(10),
        height: percentH(actions == null ? 50 : 38),
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
