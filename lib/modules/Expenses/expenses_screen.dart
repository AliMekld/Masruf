import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrof/core/Language/app_localization.dart';
import 'package:masrof/core/theme/typography.dart';
import 'package:masrof/modules/Expenses/expenses_controller.dart';
import 'package:masrof/utilites/constants/Strings.dart';
import 'package:masrof/utilites/extensions.dart';
import 'package:masrof/widgets/custom_drop_down_widget.dart';
import 'package:masrof/widgets/custom_text_field_widget.dart';
import 'package:masrof/widgets/tables/expense_table.dart';
import 'package:state_extended/state_extended.dart';

class ExpensesScreen extends StatefulWidget {
  static const String routerName = 'expensesScreen';
  const ExpensesScreen({super.key});

  @override
  StateX<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends StateX<ExpensesScreen> {
  _ExpensesScreenState() : super(controller: ExpensesController()) {
    con = ExpensesController();
  }
  @override
  initState() {
    super.initState();
    Future.microtask(() async {
      if (mounted) {
        await con.getExpensesTableList(context);
      }
    });
  }

  late ExpensesController con;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                    Strings.expenses.tr,
                    style: TextStyleHelper.of(context).bodyLarge16R,
                  ),
                  CustomTextFieldWidget(
                    hintText: Strings.search.tr,
                    width: 220,
                    controller: con.searchController,
                    onSaved: (_) async {
                      if (_?.isEmpty ?? false) {
                        await con.getExpensesTableList(context);
                      } else {
                        await con.getFilteredTableList(context, _);
                      }
                    },
                  ),
                  CustomDropdownWidget(
                    width: 220,
                    items: KeyType.values
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.keyName.tr,
                            )))
                        .toList(),
                    onChanged: (v) {
                      con.type = v!;
                      setState(() {});
                    },
                    selectedItem: con.type,
                    bgColor: Colors.white,
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.expenses.tr,
                    style: TextStyleHelper.of(context).headlineSmall24R,
                  ),
                  const Spacer(),
                  CustomTextFieldWidget(
                    hintText: Strings.search.tr,
                    width: 320.w,
                    controller: con.searchController,
                    onChanged: (_) async {
                      await con.getFilteredTableList(context, _);
                    },
                  ),
                  16.0.widthBox,
                  CustomDropdownWidget(
                    width: 160.w,
                    items: KeyType.values
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.keyName.tr,
                            )))
                        .toList(),
                    onChanged: (v) {
                      con.type = v!;
                      setState(() {});
                    },
                    selectedItem: con.type,
                    bgColor: Colors.white,
                  ),
                ],
              ),
        16.0.heightBox,
        ExpenseTable(
          onDeleteExpense: (id) async => await con.onDeleteExpense(id),
          onEditExpense: (model) async => await con.onAddUpdateExpense(model),
          expensesList: con.tableList,
          context: context,
        ).expand,
      ],
    );
  }
}
