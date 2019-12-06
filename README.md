# flutter_beautiful_popup [中文](https://github.com/jaweii/Flutter_beautiful_popup/blob/master/README_CN.md)

A flutter package to help you beautify your app popups, can be used in all platform.[Live Demo](https://jaweii.github.io/Flutter_beautiful_popup/example/build/web/#/).

## Preview:

<img src="https://raw.githubusercontent.com/jaweii/Flutter_beautiful_popup/master/example/images/show.gif" style="max-height: 600px;">

## Getting Started

Add dependency to you `pubspec.yaml`:

```
dependencies:
    flutter_beautiful_popup: ^1.2.1
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
  ]
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
emm...
To be added later...

```

## Contribution

## Licence

[MIT](http://opensource.org/licenses/MIT)
