// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:masrof/core/Language/app_localization.dart';
import 'package:masrof/core/theme/color_pallete.dart';
import 'package:masrof/core/theme/typography.dart';
import 'package:masrof/models/expense_model.dart';
import 'package:masrof/modules/Wallet/wallet_data_hadler.dart';
import 'package:masrof/utilites/constants/Strings.dart';
import 'package:masrof/utilites/extensions.dart';
import 'package:masrof/widgets/DialogsHelper/dialog_widget.dart';
import 'package:masrof/widgets/custom_date_text_field.dart';
import 'package:masrof/widgets/custom_text_field_widget.dart';
import 'package:masrof/widgets/cutom_button_widget.dart';

class ExpensesDialogDetailWidget extends StatefulWidget {
  /// todo get this model from local storage and pass only id
  final int? id;
  final Function(ExpensesModel) onEditExpense;
  const ExpensesDialogDetailWidget({
    super.key,
    this.id,
    required this.onEditExpense,
  });

  @override
  State<ExpensesDialogDetailWidget> createState() =>
      _ExpensesDialogDetailWidgetState();
}

class _ExpensesDialogDetailWidgetState
    extends State<ExpensesDialogDetailWidget> {
  late TextEditingController expenseNumberController,
      expenseNameController,
      expenseValueController,
      expenseDateController,
      expenseCategoryConroller;
  @override
  void initState() {
    super.initState();
    expenseNumberController = TextEditingController();
    expenseNameController = TextEditingController();
    expenseValueController = TextEditingController();
    expenseDateController = TextEditingController();
    expenseCategoryConroller = TextEditingController();
    Future.microtask(() async => await getExpenseById());
  }

  Future getExpenseById() async {
    if (widget.id == null) return;
    final result = await WalletDataHadler.onSearchItem(widget.id!);
    result.fold((l) {
      DialogHelper.error(message: l.toString()).showDialog(context);
    }, (r) {
      model = r;
      setExpenseData(r);
    });
    setState(() {});
  }
  // on SearchItem

  ExpensesModel? model;
  setExpenseData(ExpensesModel m) {
    expenseNumberController.text = m.id?.toString() ?? "";
    expenseNameController.text = m.expenseName ?? "";
    expenseValueController.text = m.expenseValue?.toString() ?? "";
    expenseDateController.text = m.expenseDate?.toDisplayFormat() ?? "";
    expenseCategoryConroller.text = m.category?.toString() ?? "";
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    expenseNumberController.dispose();
    expenseNameController.dispose();
    expenseValueController.dispose();
    expenseDateController.dispose();
    expenseCategoryConroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations.of(context)?.translate(Strings.expenseDetails);
    return SizedBox(
      height: context.isTabletOrMobile ? 600.h : 420.h,
      width: context.isTabletOrMobile ? 420.w : 660.w,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // alignment: AlignmentDirectional.topStart,
            children: [
              Text(
                Strings.expenseDetails.tr,
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
                        ColorsPalette.of(context).errorColor.withOpacity(0.8),
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
                  controller: expenseNumberController,
                  lableText: Strings.expenseNumber.tr,
                ).addPaddingAll(padding: 4.r),
                0.0.widthBox,
                CustomTextFieldWidget(
                  controller: expenseNameController,
                  lableText: Strings.expenseName.tr,
                ),
                CustomTextFieldWidget(
                  controller: expenseValueController,
                  lableText: Strings.expenseValue.tr,
                ),
                CustomDateTextField(
                  controller: expenseDateController,
                  label: Strings.expenseDate.tr,
                ),
                CustomTextFieldWidget(
                  controller: expenseCategoryConroller,
                  lableText: Strings.expenseCategory.tr,
                ),
              ],
            ),
          ).expand,
          40.h.heightBox,
          CustomButtonWidget.primary(
            context: context,
            buttonTitle: Strings.confirm.tr,
            onTap: () {
              model ??= ExpensesModel();
              model = model?.copyWith(
                id: int.tryParse(expenseNumberController.text),
                category: expenseCategoryConroller.text,
                expenseDate: expenseDateController.text.toDateTime(),
                expenseName: expenseNameController.text,
                expenseValue: double.tryParse(expenseValueController.text),
                // id:
              );
              widget.onEditExpense(model!);
              context.pop();
            },
          )
        ],
      ),
    );
  }
}
