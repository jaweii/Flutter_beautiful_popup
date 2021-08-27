import 'dart:ui' as ui;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../main.dart';

typedef Widget BeautifulPopupButton({
  required String label,
  required void Function() onPressed,
  TextStyle labelStyle,
  bool outline,
  bool flat,
});

/// You can extend this class to custom your own template.
abstract class BeautifulPopupTemplate extends StatefulWidget {
  final BeautifulPopup options;
  BeautifulPopupTemplate(this.options);

  final State<StatefulWidget> state = BeautifulPopupTemplateState();

  @override
  State<StatefulWidget> createState() => state;

  Size get size {
    double screenWidth = MediaQuery.of(options.context).size.width;
    double screenHeight = MediaQuery.of(options.context).size.height;
    double height = screenHeight > maxHeight ? maxHeight : screenHeight;
    double width;
    height = height - bodyMargin * 2;
    if ((screenHeight - height) < 140) {
      // For keep close button visible
      height = screenHeight - 140;
      width = height / maxHeight * maxWidth;
    } else {
      if (screenWidth > maxWidth) {
        width = maxWidth - bodyMargin * 2;
      } else {
        width = screenWidth - bodyMargin * 2;
      }
      height = width / maxWidth * maxHeight;
    }
    return Size(width, height);
  }

  double get width => size.width;
  double get height => size.height;

  double get maxWidth;
  double get maxHeight;
  double get bodyMargin;

  /// The path of the illustration asset.
  String get illustrationPath => '';
  String get illustrationKey =>
      'packages/flutter_beautiful_popup/$illustrationPath';
  Color get primaryColor;

  double percentW(double n) {
    return width * n / 100;
  }

  double percentH(double n) {
    return height * n / 100;
  }

  Widget get close {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      minWidth: 45,
      height: 45,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Icon(Icons.close, color: Colors.white70, size: 26),
      ),
      padding: EdgeInsets.all(0),
      onPressed: Navigator.of(options.context).pop,
    );
  }

  Widget get background {
    return options.illustration == null
        ? Image.asset(
            illustrationKey,
            width: percentW(100),
            height: percentH(100),
            fit: BoxFit.fill,
          )
        : CustomPaint(
            size: Size(percentW(100), percentH(100)),
            painter: ImageEditor(
              image: options.illustration,
            ),
          );
  }

  Widget get title {
    if (options.title is Widget) {
      return Container(
        width: percentW(100),
        height: percentH(10),
        alignment: Alignment.center,
        child: options.title,
      );
    }
    return Container(
      alignment: Alignment.center,
      width: percentW(100),
      height: percentH(10),
      child: Opacity(
        opacity: 0.95,
        child: AutoSizeText(
          options.title,
          maxLines: 1,
          style: TextStyle(
            fontSize: Theme.of(options.context).textTheme.headline4!.fontSize,
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget? get content {
    return options.content is String
        ? AutoSizeText(
            options.content,
            minFontSize:
                Theme.of(options.context).textTheme.subtitle1!.fontSize!,
            style: TextStyle(
              color: Colors.black87,
            ),
          )
        : options.content;
  }

  Widget? get actions {
    if (options.actions == null || options.actions!.length == 0) return null;
    return Flex(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      direction: Axis.horizontal,
      children: options.actions!
          .map(
            (button) => Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: button,
              ),
            ),
          )
          .toList(),
    );
  }

  BeautifulPopupButton get button {
    return ({
      required String label,
      required void Function() onPressed,
      bool outline = false,
      bool flat = false,
      TextStyle labelStyle = const TextStyle(),
    }) {
      final gradient = LinearGradient(colors: [
        primaryColor.withOpacity(0.5),
        primaryColor,
      ]);
      final double elevation = (outline || flat) ? 0 : 2;
      final labelColor =
          (outline || flat) ? primaryColor : Colors.white.withOpacity(0.95);
      final decoration = BoxDecoration(
        gradient: (outline || flat) ? null : gradient,
        borderRadius: BorderRadius.all(Radius.circular(80.0)),
        border: Border.all(
          color: outline ? primaryColor : Colors.transparent,
          width: (outline && !flat) ? 1 : 0,
        ),
      );
      final minHeight = 40.0 - (outline ? 2 : 0);
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.transparent,
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          onSurface: Colors.transparent,
          elevation: elevation,
        ),
        child: Ink(
          decoration: decoration,
          child: Container(
            constraints: BoxConstraints(
              minWidth: 100,
              minHeight: minHeight,
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                color: labelColor,
              ).merge(labelStyle),
            ),
          ),
        ),
        onPressed: onPressed,
      );
    };
  }

  List<Positioned> get layout;
}

class BeautifulPopupTemplateState extends State<BeautifulPopupTemplate> {
  OverlayEntry? closeEntry;
  @override
  void initState() {
    super.initState();

    // Display close button
    Future.delayed(Duration.zero, () {
      closeEntry = OverlayEntry(
        builder: (ctx) {
          final bottom = (MediaQuery.of(context).size.height -
                      widget.height -
                      widget.bodyMargin * 2) /
                  4 -
              20;
          return Stack(
            children: <Widget>[
              Positioned(
                child: Container(
                  alignment: Alignment.center,
                  child: widget.options.close ?? Container(),
                ),
                left: 0,
                right: 0,
                bottom: bottom,
              )
            ],
          );
        },
      );
      Overlay.of(context)!.insert(closeEntry!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Material(
          color: Colors.transparent,
          child: Container(
            margin: EdgeInsets.all(widget.bodyMargin),
            height: widget.height,
            width: widget.width,
            child: Stack(children: widget.layout),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    closeEntry?.remove();
    super.dispose();
  }
}

class ImageEditor extends CustomPainter {
  ui.Image? image;
  ImageEditor({
    required this.image,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImageRect(
      image!,
      Rect.fromLTRB(0, 0, image!.width.toDouble(), image!.height.toDouble()),
      Rect.fromLTRB(0, 0, size.width, size.height),
      new Paint(),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
