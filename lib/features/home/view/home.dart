import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:footsteps/features/home/controller/home_controller.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController? _homeController;
  @override
  Widget build(BuildContext context) {
    _homeController = Get.put(HomeController());
    return PlatformScaffold(
      body: SizedBox(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(() {
              // showTopSnackBar(
              //   context,
              //   const CustomSnackBar.success(
              //     message:
              //         "Good job, your release is successful. Have a nice day",
              //   ),
              // );
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'health point'.tr() + ': ${_homeController!.healthPoint}',
                  style: GoogleFonts.darkerGrotesque(
                      fontSize: 30, color: AppColors.primarySwatch[400]),
                ),
              );
            }),
            Column(
              children: [
                Obx(() {
                  return gradientShaderMask(
                    child: Text(
                      _homeController!.todaySteps?.toString() ?? '0',
                      style: GoogleFonts.darkerGrotesque(
                        fontSize: 80,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  );
                }),
                Text(
                  "steps today".tr(),
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget gradientShaderMask({@required Widget? child}) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          AppColors.primaryColor,
          AppColors.primaryColor.shade900,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: child,
    );
  }
}
