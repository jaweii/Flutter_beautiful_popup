# flutter_beautiful_popup

beautiful_popup, 承包你的应用弹窗。[Live Demo](https://jaweii.github.io/Flutter_beautiful_popup/example/build/web/#/)

## 效果图:

<img src="https://raw.githubusercontent.com/jaweii/Flutter_beautiful_popup/master/example/images/show.gif" style="max-height: 600px;">

## 使用

添加依赖项到 `pubspec.yaml`:

```
dependencies:
    flutter_beautiful_popup: ^1.4.1
```

引入依赖项:

```
import 'package:beautiful_popup/main.dart';
```

然后你就可以用指定的模板，显示一个漂亮的弹窗:

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

插件有给插图重新上色的功能，只需要调用`recolor`方法就可以了。但是这个方法需要花一点时间(通常2秒左右)去计算和偏移颜色通道。

```
final newColor = Colors.red.withOpacity(0.5);
await popup.recolor(newColor);
```

所有的可用模板，轻参考[Demo](https://jaweii.github.io/Flutter_beautiful_popup/example/build/web/#/).

## 定制你自己的模板

你可以通过继承 `BeautifulPopupTemplate` 类来定制你自己的模板:

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

用你自己的模板显示弹窗:

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

## 贡献

## 协议

[MIT](http://opensource.org/licenses/MIT)

