import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constant.dart';

class AppTheme {
  AppTheme._();

  static const cardShadowColor = Color(0xFFd3d1d1);
  static const borderLine = Color(0xffc0c0c0);
  static const double iconSize = 20;
  static ThemeData appTheme = ThemeData(
    iconTheme: const IconThemeData(color: AppColors.black, size: iconSize),
    primaryColor: AppColors.primaryColor,
    fontFamily: AppSettings.appFont,
    appBarTheme: _appBarTheme,
    textTheme: _textTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    inputDecorationTheme: _inputDecorationTheme,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
    ),
    cupertinoOverrideTheme: appThemeCupertino,
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: AppColors.secondaryColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          backgroundColor: AppColors.primaryColor,
          minimumSize: const Size(double.infinity, 44),
          textStyle: button),
    ),
    primarySwatch: Colors.green,
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
      primary: AppColors.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      side: const BorderSide(color: AppColors.primaryColor, width: 1),
    )),
  );

  static CupertinoThemeData appThemeCupertino = const CupertinoThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.white,
      textTheme: CupertinoTextThemeData(
          textStyle: bodyText1,
          actionTextStyle: bodyText1,
          dateTimePickerTextStyle: bodyText1,
          navActionTextStyle: bodyText1,
          navLargeTitleTextStyle: bodyText1,
          navTitleTextStyle: bodyText1,
          pickerTextStyle: bodyText1,
          tabLabelTextStyle: bodyText1,
          primaryColor: AppColors.white)
      // textTheme: _textTheme,
      );

  static const _appBarTheme = AppBarTheme(
    color: AppColors.primaryColor,
    shadowColor: cardShadowColor,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    iconTheme: IconThemeData(color: AppColors.white, size: iconSize),
    actionsIconTheme:
        IconThemeData(color: AppColors.primaryColor, size: iconSize),
    centerTitle: true,
  );

  static const _inputDecorationTheme = InputDecorationTheme(
    contentPadding: EdgeInsets.all(8),
    fillColor: Colors.transparent,
    filled: true,
    prefixIconColor: AppColors.primaryColor,
  );

  static final inputDecoration = InputDecoration(
    contentPadding: const EdgeInsets.all(8),
    fillColor: Colors.transparent,
    filled: true,
    prefixIconColor: AppColors.primaryColor,
    disabledBorder: AppStyles.inputDecorationBorder.copyWith(
      borderSide: const BorderSide(
          style: BorderStyle.solid, width: 0.2, color: Colors.grey),
    ),
    border: AppStyles.inputDecorationBorder,
    enabledBorder: AppStyles.inputDecorationBorder.copyWith(
      borderSide: const BorderSide(
          style: BorderStyle.solid, width: 0.4, color: AppColors.primaryColor),
    ),
    focusedBorder: AppStyles.inputDecorationBorder.copyWith(
      borderSide: const BorderSide(color: AppColors.primaryColor, width: 1),
    ),
    errorBorder: AppStyles.inputDecorationBorder.copyWith(
      borderSide: const BorderSide(color: Colors.red, width: 1),
    ),
    focusedErrorBorder: AppStyles.inputDecorationBorder.copyWith(
      borderSide: const BorderSide(color: AppColors.primaryColor, width: 1),
    ),
  );

  static const _textTheme = TextTheme(
      bodyText1: bodyText1,
      bodyText2: bodyText2,
      button: button,
      subtitle1: subtitle1,
      subtitle2: subtitle2,
      headline5: headline5,
      headline6: headline6);

  static const TextStyle bodyText1 = TextStyle(fontSize: 12);
  static const TextStyle bodyText2 = TextStyle(
      fontSize: 12,
      // letterSpacing: 1,
      fontWeight: FontWeight.w600); // default for Text() widget
  static const TextStyle button = TextStyle(fontSize: 12);
  static const TextStyle subtitle1 = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600); // default for ListTile(title:) widget style
  static const TextStyle subtitle2 = TextStyle(fontSize: 12);
  static const TextStyle headline5 =
      TextStyle(fontSize: 20, fontWeight: FontWeight.normal);
  static const TextStyle headline6 =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
}
