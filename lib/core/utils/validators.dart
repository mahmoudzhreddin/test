import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Validator {
  static String? nameValidate(String value, context) {
    if (value.length < 2) {
      FocusManager.instance.primaryFocus!.unfocus();
      FocusManager.instance.primaryFocus!.requestFocus();
      return "required".tr();
    } else {
      return null;
    }
  }
}
