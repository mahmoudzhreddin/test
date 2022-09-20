import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter/material.dart';
import 'package:footsteps/core/constants/app_colors.dart';
import 'package:footsteps/core/constants/app_theme.dart';
import 'package:footsteps/core/utils/validators.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;
import 'package:footsteps/features/register/controller/register_controller.dart';
import 'package:footsteps/core/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  RegisterController? _registerController;
  RegisterPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _registerController = Get.put(RegisterController());
    return PlatformScaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...[
                Text(
                  'Welcome To Foot Steps',
                  style: AppTheme.headline5
                      .copyWith(color: AppColors.primaryColor, fontSize: 28),
                ),
                Icon(
                  Icons.directions_run_outlined,
                  size: 100,
                  color: AppColors.secondaryMaterial[200],
                ),
                CustomTextField(
                  controller:
                      TextEditingController(text: _registerController!.name),
                  labelText: 'name'.tr(),
                  hintText: 'mahmoud',
                  onChanged: (value) {
                    print('value : ${value}');
                    _registerController!.name = value;
                  },
                  validator: (value) => Validator.nameValidate(value!, context),
                  icon: context.platformIcons.person,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  general: false,
                ),
                _buildLoginButton(context, _registerController!.name),
              ].expand(
                (widget) => [
                  widget,
                  const SizedBox(
                    height: 16,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildLoginButton(context, name) {
    return PlatformElevatedButton(
      child: Text('register'.tr()),
      onPressed: () {
        _registerController!.register(context, name);
      },
    );
  }
}
