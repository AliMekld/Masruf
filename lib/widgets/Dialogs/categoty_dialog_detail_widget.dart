// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:masrof/core/Language/app_localization.dart';
import 'package:masrof/core/theme/color_pallete.dart';
import 'package:masrof/core/theme/typography.dart';
import 'package:masrof/models/drop_down_model.dart';
import 'package:masrof/modules/Categories/categories_data_hadler.dart';
import 'package:masrof/utilites/constants/Strings.dart';
import 'package:masrof/utilites/extensions.dart';
import 'package:masrof/widgets/DialogsHelper/dialog_widget.dart';
import 'package:masrof/widgets/custom_text_field_widget.dart';
import 'package:masrof/widgets/cutom_button_widget.dart';

class CategoryDialogDetailWidget extends StatefulWidget {
  /// todo get this model from local storage and pass only id
  final int? id;
  final Function(DropdownModel) onEditCategory;
  const CategoryDialogDetailWidget({
    super.key,
    this.id,
    required this.onEditCategory,
  });

  @override
  State<CategoryDialogDetailWidget> createState() =>
      _CategoryDialogDetailWidgetState();
}

class _CategoryDialogDetailWidgetState
    extends State<CategoryDialogDetailWidget> {
  late TextEditingController categoryNumberController,
      categoryNameController,
      categoryEnameConroller;

  @override
  void initState() {
    super.initState();
    categoryNumberController = TextEditingController();
    categoryNameController = TextEditingController();
    categoryEnameConroller = TextEditingController();
    Future.microtask(() async => await getCategoryById());
  }

  Future getCategoryById() async {
    if (widget.id == null) return;
    final result = await CategoriesDataHadler.getCategoryByID(widget.id!);
    result.fold((l) {
      DialogHelper.error(message: l.toString()).showDialog(context);
    }, (r) {
      model = r;
      setCategoryData(r);
    });
    setState(() {});
  }
  // on SearchItem

  DropdownModel? model;
  setCategoryData(DropdownModel m) {
    categoryNumberController.text = m.id?.toString() ?? "";
    categoryNameController.text = m.name ?? "";
    categoryEnameConroller.text = m.eName ?? "";
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    categoryNumberController.dispose();
    categoryNameController.dispose();
    categoryEnameConroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations.of(context)?.translate(Strings.expenseDetails);
    return SizedBox(
      height: 400.h,
      width: 400.w,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // alignment: AlignmentDirectional.topStart,
            children: [
              Text(
                Strings.categoryData.tr,
                style: TextStyleHelper.of(context).headlineSmall24R,
                textAlign: TextAlign.start,
              ),
              IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(
                    Icons.cancel,
                    color:
                        ColorsPalette.of(context).errorColor .withValues(alpha:0.8),
                    size: 32.r,
                  ))
            ],
          ),
          Divider(
            color: ColorsPalette.of(context).dividerColor,
          ).addPaddingAll(padding: 4.r),
          16.h.heightBox,
          SingleChildScrollView(
            child: Wrap(
              spacing: 16.w,
              runSpacing: 16.h,
              children: [
                CustomTextFieldWidget(
                  enabled: false,
                  controller: categoryNumberController,
                  lableText: Strings.id.tr,
                  width: 400.w,
                ),
                CustomTextFieldWidget(
                  width: 400.w,
                  controller: categoryNameController,
                  lableText: Strings.expenseName.tr,
                ),
                CustomTextFieldWidget(
                  width: 400.w,
                  controller: categoryEnameConroller,
                  lableText: Strings.eName.tr,
                ),
              ],
            ),
          ).expand,
          40.h.heightBox,
          CustomButtonWidget.primary(
            context: context,
            buttonTitle: Strings.confirm.tr,
            onTap: () {
              model ??= DropdownModel();
              model = model?.copyWith(
                id: int.tryParse(categoryNumberController.text),
                name: categoryNameController.text,
                eName: categoryEnameConroller.text,
                // id:
              );
              widget.onEditCategory(model!);
              context.pop();
            },
          )
        ],
      ),
    );
  }
}
