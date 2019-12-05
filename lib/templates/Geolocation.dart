import '../main.dart';

class TemplateGeolocation extends TemplateCamera {
  final BeautifulPopup options;
  TemplateGeolocation({
    this.options,
  }) : super(options: options);

  @override
  final illustrationPath = 'img/bg/geolocation.png';
}
