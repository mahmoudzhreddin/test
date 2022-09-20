import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter/material.dart';
import 'package:footsteps/core/constants/app_colors.dart';
import 'package:footsteps/core/constants/app_theme.dart';
import 'package:footsteps/core/utils/shared_storage.dart';
import 'package:footsteps/features/catalog/controller/catalog_controller.dart';
import 'package:get/get.dart' hide Trans;

import '../../../core/widgets/dialog/util_dialog.dart';

class CatalogPage extends StatelessWidget {
  CatalogController? _catalogController;
  CatalogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _catalogController = Get.put(CatalogController());
    return PlatformScaffold(
      body: RefreshIndicator(
        onRefresh: _catalogController!.getData,
        child: Container(
          child: Obx(() {
            return _catalogController!.loadData
                ? ListView.builder(
                    itemCount: _catalogController!.listCatalog!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin:
                            const EdgeInsets.only(top: 16, left: 8, right: 8),
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
                                  ...[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _catalogController!
                                              .listCatalog![index].name!,
                                          style: AppTheme.headline6,
                                        ),
                                        _buildButtonBuyCatalog(context, index)
                                      ],
                                    ),
                                    Text('salary in SAR'.tr() +
                                        ' :  ${_catalogController!.listCatalog![index].salarySAR != null ? _catalogController!.listCatalog![index].salarySAR! : 'not Available'}'),
                                    Text('salary in health point'.tr() +
                                        ':   ${_catalogController!.listCatalog![index].salaryPoint!}'),
                                  ].expand(
                                    (widget) => [
                                      widget,
                                      const SizedBox(
                                        height: 8,
                                      )
                                    ],
                                  )
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
      ),
    );
  }

  _buildButtonBuyCatalog(context, index) {
    return PlatformIconButton(
      icon: Icon(
        Icons.add_shopping_cart_rounded,
        color: AppColors.secondaryMaterial[200],
      ),
      onPressed: () {
        UtilDialog.showAwesomeDialog(
          ok: () {
            if (SharedStorage.getHealthPoint() >
                _catalogController!.listCatalog![index].salaryPoint!) {
              _catalogController!.buyCatalog(
                  id: _catalogController!.listCatalog![index].id,
                  salaryPoint:
                      _catalogController!.listCatalog![index].salaryPoint!);
            }
          },
          cancel: () {},
          context: context,
          dialogType: (SharedStorage.getHealthPoint() >
                  _catalogController!.listCatalog![index].salaryPoint!)
              ? DialogType.info
              : DialogType.error,
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: (SharedStorage.getHealthPoint() >
                    _catalogController!.listCatalog![index].salaryPoint!)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'exchange your points'.tr(),
                      ),
                      Text(
                        '${_catalogController!.listCatalog![index].name!}',
                        style: AppTheme.headline5,
                      ),
                    ],
                  )
                : Text(
                    'less than the catalog price'.tr(),
                    style: AppTheme.subtitle1.copyWith(fontSize: 16),
                  ),
          ),
        );
      },
    );
  }
}
