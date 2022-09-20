import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'core/constants/constant.dart';
import 'core/utils/custom_easy_loading.dart';
import 'core/utils/shared_storage.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:footsteps/features/register/view/register.dart';
import 'package:footsteps/features/main_page/view/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await SharedStorage.init();
  runApp(
    EasyLocalization(
      child: Phoenix(child: const MyApp()),
      supportedLocales: LANGUAGES.values.toList(),
      path: 'assets/locales',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      saveLocale: true,
    ),
  );
  CustomEasyLoading.configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.appTheme,
      child: PlatformProvider(
        settings: PlatformSettingsData(iosUsesMaterialWidgets: true),
        builder: (context) => PlatformApp(
          navigatorKey: Keys.navigatorKey,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: LANGUAGES.values.toList(),
          builder: EasyLoading.init(),
          locale: context.locale,
          title: 'FootSteps',
          home: SharedStorage.hasUserId() ? MainPage() : RegisterPage(),
          material: (_, __) => MaterialAppData(
            scrollBehavior: AppScrollBehavior(),
            theme: AppTheme.appTheme,
            darkTheme: ThemeData.dark(),
            debugShowCheckedModeBanner: AppSettings.isDebug,
          ),
          cupertino: (_, __) => CupertinoAppData(
            scrollBehavior: AppScrollBehavior(),
            theme: AppTheme.appThemeCupertino,
            debugShowCheckedModeBanner: AppSettings.isDebug,
          ),
        ),
      ),
    );
  }
}
