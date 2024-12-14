import 'package:flutter/material.dart';
import 'package:masrof/core/Language/app_localization.dart';
import 'package:masrof/core/theme/typography.dart';
import 'package:masrof/modules/Expenses/expenses_controller.dart';
import 'package:masrof/utilites/constants/Strings.dart';
import 'package:masrof/utilites/extensions.dart';
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
        Text(
          Strings.expenses.tr,
          style: TextStyleHelper.of(context).headlineSmall24R,
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
