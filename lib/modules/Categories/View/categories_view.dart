import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrof/core/Language/app_localization.dart';
import 'package:masrof/core/theme/typography.dart';
import 'package:masrof/modules/Categories/Controller/categories_controller.dart';
import 'package:masrof/utilities/extensions.dart';
import 'package:masrof/widgets/custom_text_field_widget.dart';
import 'package:masrof/widgets/loading_widget.dart';
import 'package:masrof/widgets/tables/categories_table.dart';
import 'package:state_extended/state_extended.dart';

import '../../../utilities/constants/Strings.dart';
import '../../../widgets/custom_drop_down_widget.dart';

class CategoriesScreen extends StatefulWidget {
  static const String routerName = 'CategoriesScreen';
  const CategoriesScreen({super.key});

  @override
  StateX<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends StateX<CategoriesScreen> {
  _CategoriesScreenState() : super(controller: CategoriesController()) {
    con = CategoriesController();
  }
  @override
  initState() {
    super.initState();
    Future.microtask(() async {
      if (mounted) {
        await con.getIncomeTableList(context);
      }
    });
  }

  late CategoriesController con;

  @override
  Widget build(BuildContext context) {
    AppLocalizations.of(context)?.translate(Strings.appName);
    return LoadingWidget(
      isLoading: con.loading,
      child: Column(
        children: [
          context.isTabletOrMobile
              ? Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runAlignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      Strings.expensesCategories.tr,
                      style: TextStyleHelper.of(context).bodyLarge16R,
                    ),
                    CustomTextFieldWidget(
                      hintText: Strings.search.tr,
                      width: 220,
                      controller: con.searchController,
                      onSaved: (v) async {
                        if (v?.isEmpty ?? false) {
                          await con.getIncomeTableList(context);
                        } else {
                          await con.getFilteredTableList(context, v);
                        }
                      },
                    ),
                    CustomDropdownWidget(
                      width: 220,
                      items: CategoresKeyType.values
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.keyName.tr,
                              )))
                          .toList(),
                      onChanged: (v) {
                        con.keyType = v!;
                        setState(() {});
                      },
                      selectedItem: con.keyType,
                      bgColor: Colors.white,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.expensesCategories.tr,
                      style: TextStyleHelper.of(context).headlineSmall24R,
                    ),
                    const Spacer(),
                    CustomTextFieldWidget(
                      hintText: Strings.search.tr,
                      width: 320.w,
                      controller: con.searchController,
                      onChanged: (v) async {
                        if (v?.isEmpty ?? false) {
                          await con.getIncomeTableList(context);
                        } else {
                          await con.getFilteredTableList(context, v);
                        }
                      },
                    ),
                    16.0.widthBox,
                    CustomDropdownWidget(
                      width: 180.w,
                      items: CategoresKeyType.values
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.keyName.tr,
                              )))
                          .toList(),
                      onChanged: (v) {
                        con.keyType = v!;
                        setState(() {});
                      },
                      selectedItem: con.keyType,
                      bgColor: Colors.white,
                    ),
                  ],
                ),
          16.0.heightBox,
          CategoriesTable(
            onDeleteCategory: (id) async => await con.onDeleteCategory(id),
            onEditCategory: (model) async =>
                await con.onAddUpdateCategory(model),
            categoriesList: con.tableList,
            context: context,
          ).expand,
        ],
      ),
    );
  }
}
