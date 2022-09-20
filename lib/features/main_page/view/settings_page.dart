import 'package:easy_localization/easy_localization.dart' as t;
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../../../../core/constants/constant.dart';
import '../../../../core/utils/shared_storage.dart';
import '../../../../core/widgets/section_title.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late String local;

  @override
  Widget build(BuildContext context) {
    local = context.locale.toString();

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('setting'.tr()),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    debugPrint('local');
    debugPrint(local);
    return ListView(
      children: [
        SectionTitle(
          title: 'language'.tr(),
        ),
        ListTile(
          leading: const Icon(Icons.language, size: 20),
          title: Text('app_language'.tr()),
        ),
        ListTile(
          title: Row(
            children: LANGUAGES.keys.toList().map(
              (String value) {
                return Container(
                  width: 100,
                  height: 35,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: PlatformElevatedButton(
                      child: Text(value.tr()),
                      onPressed: () => local != value
                          ? setState(() async {
                              debugPrint(value);
                              local = value;
                              context.setLocale(LANGUAGES[local]!);
                              SharedStorage.writeLanguage(local);
                              Phoenix.rebirth(context);
                            })
                          : null,
                      material: (_, __) {
                        return MaterialElevatedButtonData(
                          style: ElevatedButton.styleFrom(
                            primary: local != value
                                ? AppColors.grey
                                : AppColors.primaryColor,
                          ),
                        );
                      },
                      cupertino: (_, __) {
                        return CupertinoElevatedButtonData(
                          color: local != value
                              ? AppColors.grey
                              : AppColors.primaryColor,
                        );
                      }),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
