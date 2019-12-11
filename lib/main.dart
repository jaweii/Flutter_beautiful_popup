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

export 'templates/Common.dart';
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
  BuildContext _context;
  BuildContext get context => _context;

  Type _template;
  Type get template => _template;

  BeautifulPopupTemplate Function(BeautifulPopup options) _build;
  BeautifulPopupTemplate get instance {
    if (_build != null) return _build(this);
    switch (template) {
      case TemplateOrangeRocket:
        return TemplateOrangeRocket(this);
        break;
      case TemplateGreenRocket:
        return TemplateGreenRocket(this);
        break;
      case TemplateOrangeRocket2:
        return TemplateOrangeRocket2(this);
        break;
      case TemplateCoin:
        return TemplateCoin(this);
        break;
      case TemplateBlueRocket:
        return TemplateBlueRocket(this);
        break;
      case TemplateThumb:
        return TemplateThumb(this);
        break;
      case TemplateGift:
        return TemplateGift(this);
        break;
      case TemplateCamera:
        return TemplateCamera(this);
        break;
      case TemplateNotification:
        return TemplateNotification(this);
        break;
      case TemplateGeolocation:
        return TemplateGeolocation(this);
        break;
      case TemplateSuccess:
        return TemplateSuccess(this);
        break;
      case TemplateFail:
        return TemplateFail(this);
        break;
      case TemplateAuthentication:
        return TemplateAuthentication(this);
        break;
      case TemplateTerm:
        return TemplateTerm(this);
        break;
      case TemplateRedPacket:
        return TemplateRedPacket(this);
        break;
      default:
        return null;
    }
  }

  ui.Image _illustration;
  ui.Image get illustration => _illustration;

  dynamic title = '';
  dynamic content = '';
  List<Widget> actions = [];
  Widget close;
  bool barrierDismissible;

  Color primaryColor;

  BeautifulPopup({
    @required BuildContext context,
    @required Type template,
  }) {
    _context = context;
    _template = template;
    primaryColor = instance?.primaryColor; // Get the default primary color.
  }

  static BeautifulPopup customize({
    @required BuildContext context,
    @required BeautifulPopupTemplate Function(BeautifulPopup options) build,
  }) {
    final popup = BeautifulPopup(
      context: context,
      template: null,
    );
    popup._build = build;
    return popup;
  }

  /// Recolor the BeautifulPopup.
  /// This method is  kind of slow.R
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
    _illustration = nextFrame.image;
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
  Future<T> show<T>({
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
    final child = WillPopScope(
      onWillPop: () {
        return Future.value(barrierDismissible);
      },
      child: instance,
    );
    return showGeneralDialog<T>(
      barrierColor: Colors.black38,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierDismissible ? 'beautiful_popup' : null,
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return child;
      },
      transitionDuration: Duration(milliseconds: 150),
      transitionBuilder: (ctx, a1, a2, child) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: child,
          ),
        );
      },
    );
  }

  BeautifulPopupButton get button => instance.button;
}
