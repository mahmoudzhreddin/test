import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../custom_button.dart';
import '../loading.dart';

class UtilDialog {
  static showInformation(
    BuildContext context, {
    String? title,
    String? content,
    Function()? onClose,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title ?? "message_for_you".tr(),
          ),
          content: Text(content!.tr()),
          actions: <Widget>[
            TextButton(
              child: Text(
                "close".tr(),
              ),
              onPressed: onClose ?? () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  }

  static showWaiting(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 150,
            alignment: Alignment.center,
            child: const LoadingWidget(),
          ),
        );
      },
    );
  }

  static hideWaiting(BuildContext context) {
    Navigator.pop(context);
  }

  static Future<bool?> showConfirmation(BuildContext context,
      {String? title,
      required Widget content,
      String confirmButtonText = "yes",
      VoidCallback? confirmonPressed}) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title == null ? "confirm" : title.tr(),
            style: Theme.of(context).textTheme.bodyText2,
          ),
          content: content,
          actions: <Widget>[
            CustomTextButton(
              title: 'cancel',
              color: AppColors.grey,
              onPressed: () => Navigator.pop(context, false),
            ),
            CustomTextButton(
                title: confirmButtonText,
                onPressed: () {
                  confirmonPressed!();
                  Navigator.pop(context, true);
                }),
          ],
        );
      },
    );
  }

  static showAwesomeDialog({
    context,
    Function()? ok,
    Function()? cancel,
    DialogType? dialogType,
    Widget? body,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: dialogType ?? DialogType.info,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      btnCancelOnPress: cancel,
      btnOkOnPress: ok,
      btnCancelText: "no",
      btnOkText: "yes",
      body: body,
    ).show();
  }
}
