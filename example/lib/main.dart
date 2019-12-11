import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github-gist.dart';
import 'dart:js' as js;
import 'MyTemplate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter_beautiful_popup',
      theme: ThemeData(primaryColor: Colors.blue),
      home: MyHomePage(title: 'Flutter_Beautiful_Popup'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  initState() {
    super.initState();
    final templates = [
      TemplateGift,
      TemplateCamera,
      TemplateNotification,
      TemplateGeolocation,
      TemplateSuccess,
      TemplateFail,
      // TemplateOrangeRocket,
      TemplateGreenRocket,
      TemplateOrangeRocket2,
      TemplateCoin,
      TemplateBlueRocket,
      TemplateThumb,
      TemplateAuthentication,
      TemplateTerm,
      TemplateRedPacket,
    ];

    demos = templates.map((template) {
      return BeautifulPopup(
        context: context,
        template: template,
      );
    }).toList();
  }

  List<BeautifulPopup> demos = [];

  BeautifulPopup activeDemo;

  Widget get showcases {
    final popup = BeautifulPopup.customize(
      context: context,
      build: (options) => MyTemplate(options),
    );
    return Flex(
      mainAxisSize: MainAxisSize.max,
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(20, 20, 10, 10),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.white,
                width: 1,
              ),
            ),
          ),
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Text(
                'All Templates:',
                style: Theme.of(context).textTheme.title.merge(
                      TextStyle(
                        backgroundColor: Colors.transparent,
                      ),
                    ),
              ),
              Spacer(),
              FlatButton(
                child: Text('Customize'),
                onPressed: () {
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
                        labelStyle: TextStyle(),
                        onPressed: () {
                          js.context.callMethod('open', [
                            'https://github.com/jaweii/Flutter_beautiful_popup/blob/master/example/lib/MyTemplate.dart'
                          ]);
                        },
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 20,
              runSpacing: 30,
              children: demos.map((demo) {
                final i = demos.indexWhere((d) => d.template == demo.template);
                return InkWell(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    constraints: BoxConstraints(minWidth: 160),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: demo.primaryColor.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          demo.instance.illustrationKey,
                          height: 54,
                          width: 100,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Demo-${i + 1}\n${demo?.instance?.runtimeType}',
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    openDemo(demo: demo);
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget get body {
    final exampleCode = ''' 
final popup = BeautifulPopup(
  context: context,
  template: ${activeDemo?.instance?.runtimeType ?? '// Select a template in right'},
);
                                                                  
popup.show(
  title: 'String',
  content: 'BeautifulPopup is a flutter package that is responsible for beautify your app popups.',
  actions: [
    popup.button(
      label: 'Close',
      onPressed: Navigator.of(context).pop,
    ),
  ],
);
    ''';
    if (MediaQuery.of(context).size.width > 1024) {
      return Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              color: activeDemo?.primaryColor?.withOpacity(0.25) ??
                  Theme.of(context).primaryColor.withOpacity(0.25),
              child: Flex(
                mainAxisSize: MainAxisSize.max,
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 10, 10),
                    child: Text(
                      '# Usage',
                      style: Theme.of(context).textTheme.title.merge(
                            TextStyle(
                              color: Colors.black54,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: HighlightView(
                        exampleCode,
                        language: 'dart',
                        theme: githubGistTheme,
                        padding: EdgeInsets.all(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: showcases,
          ),
        ],
      );
    } else {
      return showcases;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
        backgroundColor:
            activeDemo?.primaryColor ?? Theme.of(context).primaryColor,
        actions: <Widget>[
          FlatButton(
            child: Image.asset(
              'images/github.png',
              width: 32,
              height: 32,
            ),
            onPressed: () {
              js.context.callMethod('open',
                  ['https://github.com/jaweii/Flutter_beautiful_popup']);
            },
          ),
        ],
      ),
      body: body,
    );
  }

  changeColor(
    BeautifulPopup demo,
    void Function(Color color) callback,
  ) {
    Color color = demo.primaryColor.withOpacity(0.5);
    showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: color,
            onColorChanged: (c) => color = c,
            enableLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Got it'),
            onPressed: () async {
              callback(color);
            },
          ),
        ],
      ),
    );
  }

  openDemo({
    @required BeautifulPopup demo,
    dynamic title = 'String',
    dynamic content =
        'BeautifulPopup is a flutter package that is responsible for beautify your app popups.',
  }) {
    assert(title is Widget || title is String);
    setState(() {
      activeDemo = demo;
    });
    demo.show(
      title: title,
      content: content,
      actions: <Widget>[
        demo.button(
          label: 'Recolor',
          onPressed: () {
            changeColor(demo, (color) async {
              demo = await BeautifulPopup(
                context: context,
                template: demo.template,
              ).recolor(color);
              Navigator.of(context).popUntil((route) {
                if (route.settings.name == '/') return true;
                return false;
              });
              openDemo(demo: demo);
            });
          },
        ),
        demo.button(
          label: 'Show more',
          outline: true,
          onPressed: () {
            Navigator.of(context).pop();
            if (title is Widget) {
              return openDemo(demo: demo);
            }
            getTitle() {
              return Opacity(
                opacity: 0.95,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '[Widget]',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: demo.primaryColor,
                        backgroundColor: Colors.white70,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Icon(
                        Icons.star,
                        color: demo.primaryColor.withOpacity(0.75),
                        size: 10,
                      ),
                    )
                  ],
                ),
              );
            }

            getContent() {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                ),
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CupertinoButton(
                          child: Text('Remove all buttons'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            demo = BeautifulPopup(
                              context: context,
                              template: demo.template,
                            );
                            demo.show(
                              title: getTitle(),
                              content: getContent(),
                              actions: [],
                            );
                          },
                        ),
                        CupertinoButton(
                          child: Text('Keep one button'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            demo = BeautifulPopup(
                              context: context,
                              template: demo.template,
                            );
                            demo.show(
                              title: getTitle(),
                              content: getContent(),
                              actions: [
                                demo.button(
                                  label: 'One button',
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        CupertinoButton(
                          child: Text('Remove Close button'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            demo = BeautifulPopup(
                              context: context,
                              template: demo.template,
                            );
                            demo.show(
                              title: getTitle(),
                              content: getContent(),
                              close: Container(),
                              barrierDismissible: true,
                              actions: [
                                demo.button(
                                  label: 'Close',
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        CupertinoButton(
                          child: Text('Change button direction'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            demo = BeautifulPopup(
                              context: context,
                              template: demo.template,
                            );
                            demo.show(
                              title: getTitle(),
                              content: Flex(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                direction: Axis.vertical,
                                children: <Widget>[
                                  Text('1. blabla... \n2. blabla...'),
                                  Spacer(),
                                  demo.button(
                                    label: 'Accpet',
                                    onPressed: () {},
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: FlatButton(
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: Text('Close'),
                                      onPressed: Navigator.of(context).pop,
                                    ),
                                  ),
                                ],
                              ),
                              barrierDismissible: true,
                              actions: [],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            }

            openDemo(
              demo: demo,
              title: getTitle(),
              content: getContent(),
            );
          },
        )
      ],
    );
  }
}
