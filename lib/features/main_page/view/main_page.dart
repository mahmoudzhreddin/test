import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter/material.dart';
import 'package:footsteps/features/catalog/view/catalog.dart';
import 'package:footsteps/features/home/view/home.dart';
import 'package:footsteps/features/main_page/controller/main_page_controller.dart';
import 'package:footsteps/features/main_page/controller/my_catalog_controller.dart';
import 'package:footsteps/features/main_page/view/myCatalog.dart';
import 'package:footsteps/features/main_page/view/my_health_point.dart';
import 'package:get/get.dart' hide Trans;
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_theme.dart';
import '../../../core/utils/navigation.dart';
import '../../../core/utils/shared_storage.dart';
import '../../../core/widgets/dialog/util_dialog.dart';
import 'settings_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PageController controller;
  late CupertinoTabController _cupertinoTabController;
  late int _selectedIndex;
  late List<BottomNavigationBarItem> itemsBottomNavigationBar;
  List<Widget> pages = [
    HomePage(),
    CatalogPage(),
  ];
  @override
  initState() {
    super.initState();
    itemsBottomNavigationBar = [
      _buildItemNavigationBar(
        index: 0,
        icon: const Icon(Icons.home),
        label: 'home'.tr(),
      ),
      _buildItemNavigationBar(
        index: 1,
        icon: const Icon(Icons.add_shopping_cart_rounded),
        label: 'catalog'.tr(),
      ),
    ];
    controller = PageController(
      initialPage: 0,
    );
    _cupertinoTabController = CupertinoTabController(
      initialIndex: 0,
    );
    _selectedIndex = 0;
  }

  MainPageController? _mainPageController;
  @override
  Widget build(BuildContext context) {
    _mainPageController = Get.put(MainPageController());
    return PlatformScaffold(
      body: PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text(itemsBottomNavigationBar[_selectedIndex].label!.tr()),
        ),
        body: WillPopScope(
          onWillPop: () async {
            _exitButton(context);
            return true;
          },
          child: PageView(
            scrollDirection: Axis.horizontal,
            controller: controller,
            onPageChanged: (page) {
              setState(() {
                _selectedIndex = page;
              });
            },
            children: pages,
          ),
        ),
        material: (_, __) {
          return MaterialScaffoldData(
            drawer: Drawer(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Icon(
                      Icons.add_shopping_cart_rounded,
                      size: 200,
                      color: AppColors.secondaryMaterial[200],
                    ),
                    const Divider(
                      thickness: 1.2,
                    ),
                    ListTile(
                      onTap: () {
                        Navigation.popThenPush(context, const SettingsPage());
                      },
                      isThreeLine: false,
                      leading: Icon(
                        Icons.settings,
                        color: AppColors.secondaryMaterial[200],
                      ),
                      title: Text(
                        'setting'.tr(),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigation.popThenPush(context, MyCatalogPage());
                      },
                      isThreeLine: false,
                      leading: Icon(
                        Icons.add_shopping_cart_rounded,
                        color: AppColors.secondaryMaterial[200],
                      ),
                      title: Text(
                        'my catalog'.tr(),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigation.popThenPush(context, MyHealthPointPage());
                      },
                      isThreeLine: false,
                      leading: Icon(
                        Icons.run_circle,
                        color: AppColors.secondaryMaterial[200],
                      ),
                      title: Text(
                        'my health point'.tr(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavBar: _buildBottomNavBar(),
          );
        },
        cupertino: (_, __) {
          return CupertinoPageScaffoldData(
            body: CupertinoTabScaffold(
              controller: _cupertinoTabController,
              tabBar: CupertinoTabBar(
                items: itemsBottomNavigationBar,
                backgroundColor: Colors.white,
                currentIndex: _selectedIndex,
                activeColor: AppColors.primaryColor,
                onTap: _onItemTapped,
                inactiveColor: Colors.grey,
              ),
              tabBuilder: (context, index) {
                return CupertinoTabView(
                  builder: (context) {
                    return pages[index];
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  _buildBottomNavBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      items: itemsBottomNavigationBar,
      currentIndex: _selectedIndex,
      selectedItemColor: AppColors.primaryColor,
      onTap: _onItemTapped,
      unselectedItemColor: const Color.fromRGBO(63, 63, 63, 1),
      showUnselectedLabels: true,
      unselectedFontSize: 11,
      selectedFontSize: 12,
      enableFeedback: true,
    );
  }

  _onItemTapped(int index) {
    setState(() {
      if (isCupertino(context)) {
        _cupertinoTabController.index = index;
      }
      if (!isCupertino(context)) {
        if ((_selectedIndex - index).abs() <= 1) {
          controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        } else {
          controller.jumpToPage(index);
        }
      }
      _selectedIndex = index;
    });
  }

  _buildItemNavigationBar({int? index, Icon? icon, String? label}) {
    return BottomNavigationBarItem(
      icon: icon!,
      label: label!.tr(),
    );
  }

  _exitButton(context) {
    UtilDialog.showAwesomeDialog(
      ok: () {
        _mainPageController!.sendPoitnToFireStroe();
        SystemNavigator.pop();
      },
      cancel: () {},
      context: context,
      dialogType: DialogType.warning,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Text(
          'Do you want to exit the application ? The current session points will be stored in the database'
              .tr(),
          style: AppTheme.subtitle1.copyWith(fontSize: 16),
        ),
      ),
    );
  }
}
