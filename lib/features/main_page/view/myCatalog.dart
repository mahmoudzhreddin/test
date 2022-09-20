import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:footsteps/features/main_page/controller/my_catalog_controller.dart';
import 'package:get/get.dart' hide Trans;
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_theme.dart';

class MyCatalogPage extends StatelessWidget {
  MyCatalogController? _myCatalogController;
  MyCatalogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _myCatalogController = Get.put(MyCatalogController());
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('my catalog'.tr()),
      ),
      body: RefreshIndicator(
        onRefresh: _myCatalogController!.refreshPage,
        child: Obx(() {
          if (_myCatalogController!.loadData) {
            _myCatalogController!.mergeList();
          }
          return _myCatalogController!.listMyCatalog!.isNotEmpty
              ? ListView.builder(
                  itemCount: _myCatalogController!.listMyCatalog!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.only(top: 16, left: 8, right: 8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.wallet_giftcard,
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
                                  _myCatalogController!
                                      .listMyCatalog![index].name!,
                                  style: AppTheme.headline6,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  _myCatalogController!
                                      .listMyCatalog![index].date!
                                      .split('.')[0]
                                      .split(' ')[0],
                                ),
                                Text(
                                  _myCatalogController!
                                      .listMyCatalog![index].date!
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
