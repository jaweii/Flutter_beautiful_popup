library beautiful_popup;

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart';
import 'templates/Common.dart';
import 'templates/OrangeRocket.dart';
import 'templates/GreenRocket.dart';
import 'templates/OrangeRocket2.dart';
import 'templates/Coin.dart';
import 'templates/BlueRocket.dart';
import 'templates/Thumb.dart';
import 'templates/Gift.dart';
import 'templates/Camera.dart';
import 'templates/Notification.dart';
import 'templates/Geolocation.dart';
import 'templates/Success.dart';
import 'templates/Fail.dart';
import 'templates/Authentication.dart';
import 'templates/Term.dart';
import 'templates/RedPacket.dart';
export 'templates/OrangeRocket.dart';
export 'templates/GreenRocket.dart';
export 'templates/OrangeRocket2.dart';
export 'templates/Coin.dart';
export 'templates/BlueRocket.dart';
export 'templates/Thumb.dart';
export 'templates/Gift.dart';
export 'templates/Camera.dart';
export 'templates/Notification.dart';
export 'templates/Geolocation.dart';
export 'templates/Success.dart';
export 'templates/Fail.dart';
export 'templates/Authentication.dart';
export 'templates/Term.dart';
export 'templates/RedPacket.dart';

class BeautifulPopup {
  final BuildContext context;

  final Type template;

  dynamic title = '';
  dynamic content = '';
  List<Widget> actions = [];
  Widget close;
  bool barrierDismissible;

  BeautifulPopupTemplate get instance {
    switch (template) {
      case TemplateOrangeRocket:
        return TemplateOrangeRocket(options: this);
      case TemplateGreenRocket:
        return TemplateGreenRocket(options: this);
      case TemplateOrangeRocket2:
        return TemplateOrangeRocket2(options: this);
      case TemplateCoin:
        return TemplateCoin(options: this);
      case TemplateBlueRocket:
        return TemplateBlueRocket(options: this);
      case TemplateThumb:
        return TemplateThumb(options: this);
      case TemplateGift:
        return TemplateGift(options: this);
      case TemplateCamera:
        return TemplateCamera(options: this);
      case TemplateNotification:
        return TemplateNotification(options: this);
      case TemplateGeolocation:
        return TemplateGeolocation(options: this);
      case TemplateSuccess:
        return TemplateSuccess(options: this);
      case TemplateFail:
        return TemplateFail(options: this);
      case TemplateAuthentication:
        return TemplateAuthentication(options: this);
      case TemplateTerm:
        return TemplateTerm(options: this);
      case TemplateRedPacket:
        return TemplateRedPacket(options: this);
      default:
        throw ErrorDescription("Unexpected template $template");
    }
  }

  Color primaryColor;
  ui.Image illustration;

  BeautifulPopup({
    @required this.context,
    @required this.template,
  }) {
    this.primaryColor =
        instance?.primaryColor; // Get the default primary color.
  }

  /// Recolor the BeautifulPopup.
  /// This method is  kind of slow.
  Future<BeautifulPopup> recolor(Color color) async {
    this.primaryColor = color;
    final illustrationData = await rootBundle.load(instance.illustrationKey);
    final buffer = illustrationData.buffer.asUint8List();
    img.Image asset;
    asset = img.readPng(buffer);

    img.adjustColor(
      asset,
      saturation: 0,
      // hue: 0,
    );
    img.colorOffset(
      asset,
      red: primaryColor.red,
      // I don't know why the effect is nicer with the number ╮(╯▽╰)╭
      green: primaryColor.green ~/ 3,
      blue: primaryColor.blue ~/ 2,
      alpha: 0,
    );

    final paint = await PaintingBinding.instance
        .instantiateImageCodec(asset != null ? img.encodePng(asset) : buffer);
    final nextFrame = await paint.getNextFrame();
    illustration = nextFrame.image;
    return this;
  }

  /// `title`: Must be a `String` or `Widget`. Defaults to `''`.
  ///
  /// `content`: Must be a `String` or `Widget`. Defaults to `''`.
  ///
  /// `actions`: The set of actions that are displaed at bottom of the dialog,
  ///
  ///  Typically this is a list of [BeautifulPopup.button]. Defaults to `[]`.
  ///
  /// `barrierDismissible`: Determine whether this dialog can be dismissed. Default to `False`.
  ///
  /// `close`: Close widget.
  show({
    dynamic title,
    dynamic content,
    List<Widget> actions,
    bool barrierDismissible = false,
    Widget close,
  }) {
    this.title = title;
    this.content = content;
    this.actions = actions;
    this.barrierDismissible = barrierDismissible;
    this.close = close ?? instance.close;

    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (ctx) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(barrierDismissible);
          },
          child: instance,
        );
      },
    );
  }

  BeautifulPopupButton get button => instance.button;
}
