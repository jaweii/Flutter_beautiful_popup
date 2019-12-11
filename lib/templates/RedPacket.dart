import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../main.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'Common.dart';

/// ![](https://raw.githubusercontent.com/jaweii/Flutter_beautiful_popup/master/img/bg/red_packet.png)
class TemplateRedPacket extends BeautifulPopupTemplate {
  final BeautifulPopup options;
  TemplateRedPacket(this.options) : super(options);

  @override
  final illustrationPath = 'img/bg/red_packet.png';
  @override
  Color get primaryColor => options.primaryColor ?? Color(0xfffa1a2c);
  @override
  final maxWidth = 400;
  @override
  final maxHeight = 620;
  @override
  final bodyMargin = 0;
  @override
  Widget get title {
    if (options.title is Widget) {
      return SizedBox(
        width: percentW(100),
        height: percentH(10),
        child: Center(
          child: options.title,
        ),
      );
    }
    return SizedBox(
      width: percentW(100),
      child: Center(
        child: Opacity(
          opacity: 0.95,
          child: AutoSizeText(
            options.title,
            maxLines: 1,
            style: TextStyle(
              fontSize: Theme.of(options.context).textTheme.display1.fontSize,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget get content {
    return options.content is String
        ? AutoSizeText(
            options.content,
            minFontSize: Theme.of(options.context).textTheme.subhead.fontSize,
            style: TextStyle(
              color: Colors.white.withOpacity(0.95),
            ),
          )
        : options.content;
  }

  @override
  BeautifulPopupButton get button {
    return ({
      @required String label,
      @required void Function() onPressed,
      bool outline = false,
      TextStyle labelStyle = const TextStyle(),
    }) {
      final gradient = LinearGradient(colors: [
        Colors.yellowAccent.withOpacity(0.75),
        Colors.yellowAccent.withOpacity(0.5),
      ]);
      final double elevation = outline ? 0 : 2;
      final decoration = BoxDecoration(
        gradient: outline ? null : gradient,
        borderRadius: BorderRadius.all(Radius.circular(80.0)),
        border: Border.all(
          color: outline ? Colors.white.withOpacity(0.95) : Colors.transparent,
          width: outline ? 2 : 0,
        ),
      );
      return RaisedButton(
        color: Colors.transparent,
        elevation: elevation,
        highlightElevation: 0,
        splashColor: Colors.transparent,
        child: Ink(
          decoration: decoration,
          child: Container(
            constraints: BoxConstraints(
              minWidth: 100,
              minHeight: 40.0 - (outline ? 4 : 0),
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.95),
                fontWeight: FontWeight.bold,
              ).merge(labelStyle),
            ),
          ),
        ),
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: onPressed,
      );
    };
  }

  @override
  get layout {
    return [
      Positioned(
        child: background,
      ),
      Positioned(
        top: percentH(10),
        child: title,
      ),
      Positioned(
        top: percentH(40),
        left: percentW(12),
        right: percentW(12),
        height: percentH(actions == null ? 56 : 42),
        child: content,
      ),
      Positioned(
        bottom: percentW(10),
        left: percentW(10),
        right: percentW(10),
        child: actions ?? Container(),
      ),
    ];
  }
}
