# flutter_beautiful_popup [中文](https://github.com/jaweii/Flutter_beautiful_popup/blob/master/README_CN.md)

A flutter package to help you beautify your app popup, can be used in all platform.[Live Demo](https://jaweii.github.io/Flutter_beautiful_popup/example/build/web/#/).

## Preview:

<img src="https://raw.githubusercontent.com/jaweii/Flutter_beautiful_popup/master/example/images/show.gif" style="max-height: 600px;">

## Getting Started

Add dependency to you `pubspec.yaml`:

```
dependencies:
    flutter_beautiful_popup: ^1.4.0
```

Import the dependency:

```
import 'package:beautiful_popup/main.dart';
```

And then you can display a popup with certain template like this:

```
final popup = BeautifulPopup(
  context: context,
  template: TemplateGift,
);
popup.show(
  title: 'String or Widget',
  content: 'String or Widget',
  actions: [
    popup.button(
      label: 'Close',
      onPressed: Navigator.of(context).pop,
    ),
  ],
  // bool barrierDismissible = false,
  // Widget close,
);
```

If you wan to `recolor` the illustration of the template, you can call the `recolor` method, but this function takes a little time to caculate/offset the color cahnnel of the illustration:

```
final newColor = Colors.red.withOpacity(0.5);
await popup.recolor(newColor);
```

All available templates you can find in [Live Demo](https://jaweii.github.io/Flutter_beautiful_popup/example/build/web/#/).

## Customize your own BeautifulPopupTemplate

You can extend `BeautifulPopupTemplate` to customize your own template like this:

```
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';

class MyTemplate extends BeautifulPopupTemplate {
  final BeautifulPopup options;
  MyTemplate(this.options) : super(options);

  @override
  final illustrationKey = 'images/mytemplate.png';
  @override
  Color get primaryColor => options.primaryColor ?? Color(0xff000000); // The default primary color of the template is Colors.black.
  @override
  final maxWidth = 400; // In most situations, the value is the illustration size.
  @override
  final maxHeight = 600;
  @override
  final bodyMargin = 10;

  // You need to adjust the layout to fit into your illustration.
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
        height: percentH(actions == null ? 32 : 42),
        left: percentW(10),
        right: percentW(10),
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
```

To display a popup with your own template:

```
final popup = BeautifulPopup.customize(
  context: context,
  build: (options) => MyTemplate(options),
);
popup.show(
  title: 'Example',
  content: Container(
    color: Colors.black12,
    child: Text(
        'This popup shows you how to customize your own BeautifulPopupTemplate.'),
  ),
  actions: [
    popup.button(
      label: 'Code',
      onPressed: () {
        js.context.callMethod('open', [
          'https://github.com/jaweii/Flutter_beautiful_popup/blob/master/example/lib/MyTemplate.dart'
        ]);
      },
    ),
  ],
);
```

## Contribution

## Licence

[MIT](http://opensource.org/licenses/MIT)
