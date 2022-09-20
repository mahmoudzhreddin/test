import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:footsteps/features/main_page/controller/my_health_point_controller.dart';
import 'package:get/get.dart' hide Trans;

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_theme.dart';

class MyHealthPointPage extends StatelessWidget {
  MyHealthPointPage({Key? key}) : super(key: key);
  MyHealthPointController? _myHealthPointController;

  @override
  Widget build(BuildContext context) {
    _myHealthPointController = Get.put(MyHealthPointController());
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('my health point'.tr()),
      ),
      body: RefreshIndicator(
        onRefresh: _myHealthPointController!.getMyHealthPoint,
        child: Obx(() {
          return _myHealthPointController!.loadData
              ? ListView.builder(
                  itemCount: _myHealthPointController!
                      .listMyHealthPointCatalog!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.only(top: 16, left: 8, right: 8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.run_circle,
                              size: 100,
                              color: AppColors.primarySwatch[400],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _myHealthPointController!
                                      .listMyHealthPointCatalog![index]
                                      .countHealthPoint!
                                      .toString(),
                                  style: AppTheme.headline6,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  _myHealthPointController!
                                      .listMyHealthPointCatalog![index].date!
                                      .split('.')[0]
                                      .split(' ')[0],
                                ),
                                Text(
                                  _myHealthPointController!
                                      .listMyHealthPointCatalog![index].date!
                                      .split('.')[0]
                                      .split(' ')[1],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  })
              : Container();
        }),
      ),
    );
  }
}
