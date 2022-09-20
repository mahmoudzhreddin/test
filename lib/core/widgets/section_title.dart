import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../constants/constant.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final GestureTapCallback? onSeeAllTap;

  const SectionTitle({Key? key, required this.title, this.onSeeAllTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //
          Text(
            title,
            style: AppTheme.headline6.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          if (onSeeAllTap != null)
            InkWell(
              child: Text('see_all'.tr(),
                  style: const TextStyle(
                      color: AppColors.primaryColor,
                      decoration: TextDecoration.underline)),
              onTap: onSeeAllTap,
            )
        ],
      ),
    );
  }
}
