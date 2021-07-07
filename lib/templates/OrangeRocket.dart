import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Common.dart';
import '../main.dart';
import 'package:auto_size_text/auto_size_text.dart';

/// ![](https://raw.githubusercontent.com/jaweii/Flutter_beautiful_popup/master/img/bg/rocket_orange.png)
class TemplateOrangeRocket extends BeautifulPopupTemplate {
  final BeautifulPopup options;
  TemplateOrangeRocket(this.options) : super(options);

  @override
  final illustrationPath = 'img/bg/rocket_orange.png';
  @override
  Color get primaryColor => options.primaryColor ?? Color(0xffdf3428);
  @override
  final maxWidth = 400;
  @override
  final maxHeight = 380;
  @override
  final bodyMargin = 30;
  Widget get title {
    if (options.title is Widget) {
      return SizedBox(
        width: percentW(40),
        height: percentH(10),
        child: options.title,
      );
    }
    return SizedBox(
      width: percentW(40),
      child: Opacity(
        opacity: 0.8,
        child: AutoSizeText(
          options.title,
          maxLines: 1,
          style: TextStyle(
            // fontSize: Theme.of(options.context).textTheme.display1?.fontSize,
            fontSize: 200,
            color: primaryColor,
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
        top: percentH(20),
        left: percentW(10),
        child: title,
      ),
      Positioned(
        top: percentH(50),
        left: percentW(6),
        right: percentW(6),
        height: percentH(actions == null ? 46 : 34),
        child: content,
      ),
      Positioned(
        bottom: percentW(5),
        left: percentW(5),
        right: percentW(5),
        child: actions ?? Container(),
      ),
    ];
  }
}
