import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../core/Language/app_localization.dart';
import '../../core/Language/language_provider.dart';
import '../../core/theme/color_pallete.dart';
import '../../core/theme/theme_provider.dart';
import '../../core/theme/typography.dart';
import '../Categories/View/categories_view.dart';
import '../Categories/Controller/categories_controller.dart';
import '../Home/home_screen.dart';
import '../Income/income_controller.dart';
import '../Income/income_screen.dart';
import '../Profile/profile_screen.dart';
import '../Expenses/expenses_controller.dart';
import '../Expenses/expenses_screen.dart';
import '../../utilities/constants/Strings.dart';
import '../../utilities/extensions.dart';
import '../Categories/View/Widgets/categoty_dialog_detail_widget.dart';
import '../../widgets/Dialogs/expenses_dialog_detail_widget.dart';
import '../../widgets/Dialogs/income_dialog_detail_widget.dart';
import '../../widgets/Dialogs/settings_dialog.dart';
import '../../widgets/DialogsHelper/dialog_widget.dart';
import '../../widgets/custom_side_bar_widget.dart';
import 'package:provider/provider.dart';

import '../../utilities/constants/assets.dart';

class MainLayout extends StatefulWidget {
  final String routeName;
  final Widget child;
  const MainLayout({
    super.key,
    required this.routeName,
    required this.child,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

int currentIndex = 0;

class _MainLayoutState extends State<MainLayout> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    AppLocalizations.of(context)?.translate(Strings.appName);
    return Consumer2<ThemeProvider, LanguageProvider>(
        builder: (context, theme, lang, w) {
      return Scaffold(
        backgroundColor: ColorsPalette.of(context).backgroundColor,
        appBar: context.isTabletOrMobile
            ? AppBar(
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.settings,
                      size: 28.r,
                    ),
                    onPressed: () {
                      const DialogHelper.customDialog(child: SettingsDialog())
                          .showDialog(context);
                    },
                  )
                ],
              )
            : null,
        body: context.isMobile
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.child,
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomNavigationRail(
                    currentIndex: currentIndex,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 24, top: 24, left: 16, right: 16),
                    child: widget.child,
                  ).expand
                ],
              ),
        floatingActionButtonLocation:
            context.isMobile ? FloatingActionButtonLocation.centerDocked : null,
        floatingActionButton:
            currentIndex == 1 || currentIndex == 2 || currentIndex == 3
                ? FloatingActionButton(
                    onPressed: () {
                      if (currentIndex == 1) {
                        DialogHelper.customDialog(
                            child: ExpensesDialogDetailWidget(
                          onEditExpense: (model) =>
                              ExpensesController().onAddUpdateExpense(model),
                        )).showDialog(context);
                        return;
                      }
                      if (currentIndex == 2) {
                        DialogHelper.customDialog(
                            child: CategoryDialogDetailWidget(
                          onEditCategory: (model) =>
                              CategoriesController().onAddUpdateCategory(model),
                        )).showDialog(context);
                        return;
                      }
                      if (currentIndex == 3) {
                        DialogHelper.customDialog(
                            child: IncomeDialogDetailWidget(
                          onEditIcome: (model) =>
                              IncomeController().onAddUpdateIncom(model),
                        )).showDialog(context);
                        return;
                      }
                    },
                    child: const Icon(Icons.add),
                  )
                : null,
        bottomNavigationBar: context.isMobile
            ? BottomNavigationBar(
                elevation: 0.5,
                backgroundColor: ColorsPalette.of(context).primaryColor,
                currentIndex: currentIndex,
                selectedItemColor: ColorsPalette.of(context).primaryTextColor,
                unselectedItemColor:
                    ColorsPalette.of(context).secondaryTextColor,
                unselectedLabelStyle: TextStyleHelper.of(context)
                    .bodySmall12R
                    .copyWith(color: ColorsPalette.of(context).iconColor),
                selectedLabelStyle: TextStyleHelper.of(context)
                    .bodyMedium14R
                    .copyWith(
                        color: ColorsPalette.of(context).primaryTextColor),
                onTap: (v) {
                  setState(() {
                    currentIndex = v;
                  });
                  context.goNamed(menuList[currentIndex].route);
                },
                items: [
                  ...menuList.map(
                    (e) => BottomNavigationBarItem(
                      backgroundColor: ColorsPalette.of(context).buttonColor,
                      icon: SvgPicture.asset(
                        e.imgSvg,
                        height: 24.h,
                        width: 24.w,
                        colorFilter: ColorFilter.mode(
                          ColorsPalette.of(context).buttonColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      label: e.title.tr,
                    ),
                  ),
                ],
              )
            : null,
      );
    });
  }
}

List<MenuModel> get menuList => _menuList;
List<MenuModel> _menuList = [
  MenuModel(
    index: 0,
    title: Strings.home,
    imgSvg: Assets.imagesHome,
    route: HomeScreen.routerName,
  ),
  MenuModel(
    index: 1,
    title: Strings.expenses,
    imgSvg: Assets.imagesExpenses,
    route: ExpensesScreen.routerName,
  ),
  MenuModel(
    index: 2,
    title: Strings.expensesCategories,
    imgSvg: Assets.imagesMenu,
    route: CategoriesScreen.routerName,
  ),
  MenuModel(
    index: 3,
    title: Strings.income,
    imgSvg: Assets.imagesIncome,
    route: IncomeScreen.routerName,
  ),
  MenuModel(
    index: 4,
    title: Strings.profile,
    imgSvg: Assets.imagesProfile,
    route: ProfileScreen.routerName,
  ),
];

class MenuModel {
  final int index;
  final String route;
  final String title;
  final String imgSvg;

  MenuModel(
      {required this.index,
      required this.route,
      required this.title,
      required this.imgSvg});
}
