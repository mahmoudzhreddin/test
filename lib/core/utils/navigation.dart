import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class Navigation {
  static Future popThenPush(BuildContext context, Widget page) async {
    Navigation.pop(context);
    return await Navigation.push(context, page);
  }

  static Future push(BuildContext context, Widget page) async {
    return await Navigator.of(context).push(
      platformPageRoute(
        context: context,
        builder: (context) => page,
      ),
    );
  }

  static bool canPop(BuildContext context, {dynamic value}) {
    return Navigator.canPop(context);
  }

  static pop(BuildContext context, {dynamic value}) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context, value);
    }
  }

  static popAll(BuildContext context, {dynamic value}) {
    while (Navigator.canPop(context)) {
      Navigator.pop(context, value);
    }
  }

  static pushReplacement(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      platformPageRoute(
        context: context,
        builder: (context) => page,
      ),
    );
  }

  static pushAndRemoveUntil(BuildContext context, Widget page) async {
    return await Navigator.of(context).pushAndRemoveUntil(
        platformPageRoute(
          context: context,
          builder: (context) => page,
        ),
        (Route<dynamic> route) => false);
  }
}
