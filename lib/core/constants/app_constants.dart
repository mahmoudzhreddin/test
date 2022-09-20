import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Keys {
  static  GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  static final scaffoldKey = GlobalKey<ScaffoldState>();
}

const Map<String, Locale> LANGUAGES = {
  'ar': Locale('ar'),
  'en': Locale('en'),
};

class AppScrollBehavior extends MaterialScrollBehavior {
  /// just to provide scroll to web and windows
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
