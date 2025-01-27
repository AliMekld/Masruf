import 'package:flutter/material.dart';
import 'package:masrof/core/LocalDataBase/database_helper.dart';
import 'package:masrof/models/expense_model.dart';
import 'package:masrof/modules/Expenses/expenses_data_hadler.dart';
import 'package:masrof/widgets/DialogsHelper/dialog_widget.dart';
import 'package:state_extended/state_extended.dart';

import '../../core/LocalDataBase/sql_queries.dart';

class ExpensesController extends StateXController {
  ///singleTone
  ExpensesController._();
  static final ExpensesController _instance = ExpensesController._();
  factory ExpensesController() => _instance;
  late TextEditingController searchController;
  List<ExpensesModel> tableList = [];

  onDeleteExpense(int id) async {
    if (id == -1) return;
    DatabaseHelper databaseHelper = DatabaseHelper();

    int response = await databaseHelper.deleteFrom(
        tableName: SqlQueries.expensesTable, whereKey: "id", whereValue: id);
    if (response != 0) {
      tableList.removeWhere((e) => e.id == id);
    }
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  dispose() {
    super.dispose();
    searchController.dispose();
  }

  onAddUpdateExpense(ExpensesModel model) async {
    DatabaseHelper databaseHelper = DatabaseHelper();

    int currentIndex = tableList.indexWhere((e) => e.id == model.id);
    if (currentIndex != -1) {
      setState(() => loading = true);

      int response = await databaseHelper.update(
        whereKey: "id",
        whereValue: "${model.id!}",
        model: model.toLocalJson(),
        tableName: SqlQueries.expensesTable,
      );
      if (response != 0) {
        tableList[currentIndex] = model;
      }
    } else {
      int response = await databaseHelper.insert(
        model: model.toLocalJson(),
        tableName: SqlQueries.expensesTable,
      );
      if (response != 0) {
        tableList.add(model.copyWith(id: response));
      }
    }
    setState(() => loading = false);
  }

  bool loading = false;

  /// get all data
  Future getExpensesTableList(
    BuildContext context,
  ) async {
    setState(() => loading = true);
    final result = await ExpensesDataHadler.getExpensesFromLocalDataBase();
    result.fold((l) {
      DialogHelper.error(
        message: l.toString(),
      ).showDialog(
        context,
      );
    }, (r) => tableList = r);
    setState(() => loading = false);
  }

  KeyType type = KeyType.id;

  /// onsearch
  Future getFilteredTableList(
    BuildContext context,
    dynamic value,
  ) async {
    setState(() => loading = true);

    final result = await ExpensesDataHadler.onSearch(
      key: type.keyName,
      value: value,
    );

    result.fold((l) {
      DialogHelper.error(
        message: l.toString(),
      ).showDialog(
        context,
      );
    }, (r) => tableList = r);

    setState(() => loading = false);
  }
}

/// todo
enum KeyType {
  id(keyName: "id"),
  name(keyName: "expenseName"),
  value(keyName: "expenseValue"),
  date(keyName: "expenseDate"),
  category(keyName: "categoryID");

  final String keyName;

  const KeyType({required this.keyName});
}
