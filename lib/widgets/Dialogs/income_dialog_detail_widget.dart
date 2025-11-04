// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:masrof/core/Language/app_localization.dart';
import 'package:masrof/core/theme/color_pallete.dart';
import 'package:masrof/core/theme/typography.dart';
import 'package:masrof/models/income_model.dart';
import 'package:masrof/modules/Income/income_data_hadler.dart';
import 'package:masrof/utilites/constants/Strings.dart';
import 'package:masrof/utilites/extensions.dart';
import 'package:masrof/widgets/DialogsHelper/dialog_widget.dart';
import 'package:masrof/widgets/custom_date_text_field.dart';
import 'package:masrof/widgets/custom_text_field_widget.dart';
import 'package:masrof/widgets/cutom_button_widget.dart';
import 'package:masrof/widgets/tables/expense_table.dart';

class IncomeDialogDetailWidget extends StatefulWidget {
  /// todo get this model from local storage and pass only id
  final int? id;
  final Function(IncomeModel) onEditIcome;
  const IncomeDialogDetailWidget({
    super.key,
    this.id,
    required this.onEditIcome,
  });

  @override
  State<IncomeDialogDetailWidget> createState() =>
      _IncomeDialogDetailWidgetState();
}

class _IncomeDialogDetailWidgetState extends State<IncomeDialogDetailWidget> {
  final TextEditingController incomeNumberController = TextEditingController(),
      incomeNameController = TextEditingController(),
      incomeDateController = TextEditingController(),
      incomeValueConroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async => await getIncomeById());
  }

  Future getIncomeById() async {
    if (widget.id == null) return;
    final result = await IncomeDataHadler.getIncomeByID(widget.id!);
    result.fold((l) {
      DialogHelper.error(message: l.toString()).showDialog(context);
    }, (r) {
      model = r;
      setCategoryData(r);
    });
    setState(() {});
  }
  // on SearchItem

  IncomeModel? model;
  setCategoryData(IncomeModel m) {
    incomeNumberController.text = m.id?.toString() ?? "";
    incomeNameController.text = m.incomeName ?? "";
    incomeValueConroller.text = m.incomeValue?.toString() ?? "";
    incomeDateController.text = m.incomeDate?.dmy ?? "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations.of(context)?.translate(Strings.expenseDetails);
    return SizedBox(
      height: 500.h,
      width: 400.w,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // alignment: AlignmentDirectional.topStart,
            children: [
              Text(
                Strings.income.tr,
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
                  controller: incomeNumberController,
                  lableText: Strings.id.tr,
                  width: 400.w,
                ),
                CustomTextFieldWidget(
                  width: 400.w,
                  controller: incomeNameController,
                  lableText: Strings.incomeName.tr,
                ),
                CustomDateTextField(
                  width: 400.w,
                  controller: incomeDateController,
                  label: Strings.incomeDate.tr,
                ),
                CustomTextFieldWidget(
                  width: 400.w,
                  controller: incomeValueConroller,
                  lableText: Strings.incomeValue.tr,
                ),
              ],
            ),
          ).expand,
          40.h.heightBox,
          CustomButtonWidget.primary(
            context: context,
            buttonTitle: Strings.confirm.tr,
            onTap: () {
              model ??= IncomeModel();
              model = model?.copyWith(
                  id: int.tryParse(incomeNumberController.text),
                  incomeName: incomeNameController.text,
                  incomeValue: double.tryParse(incomeValueConroller.text),
                  incomeDate: incomeDateController.text.toDateTime());
              widget.onEditIcome(model!);
              context.pop();
            },
          )
        ],
      ),
    );
  }
}
