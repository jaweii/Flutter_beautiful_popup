import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../main.dart';

/// ![](https://raw.githubusercontent.com/jaweii/Flutter_beautiful_popup/master/img/bg/fail.png)
class TemplateFail extends TemplateSuccess {
  final BeautifulPopup options;
  TemplateFail(this.options) : super(options);

  @override
  final illustrationPath = 'img/bg/fail.png';
  @override
  Color get primaryColor => options.primaryColor ?? Color(0xffF77273);
}
