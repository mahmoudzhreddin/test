import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../constants/constant.dart';

class CustomEasyLoading {
  static void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = AppColors.white
      ..backgroundColor = AppColors.primaryColor
      ..indicatorColor = AppColors.white
      ..textColor = AppColors.white
      ..maskColor = AppColors.primaryColor.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false
      ..maskType = EasyLoadingMaskType.black
      ..animationStyle = EasyLoadingAnimationStyle.opacity
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..toastPosition = EasyLoadingToastPosition.top
      ..customAnimation = CustomAnimation();

  }
}

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}
