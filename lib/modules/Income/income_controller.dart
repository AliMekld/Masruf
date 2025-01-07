import 'package:flutter/material.dart';
import 'package:masrof/core/LocalDataBase/database_helper.dart';
import 'package:masrof/models/income_model.dart';
import 'package:masrof/modules/Income/income_data_hadler.dart';
import 'package:masrof/widgets/DialogsHelper/dialog_widget.dart';
import 'package:state_extended/state_extended.dart';

import '../../core/LocalDataBase/sql_queries.dart';

class IncomeController extends StateXController {
  ///singleTone
  IncomeController._();
  static final IncomeController _instance = IncomeController._();
  factory IncomeController() => _instance;
  late TextEditingController searchController;
  List<IncomeModel> tableList = [];

  onDeleteIncome(int id) async {
    if (id == -1) return;
    DatabaseHelper databaseHelper = DatabaseHelper();

    int response = await databaseHelper.deleteFrom(
      tableName: SqlQueries.incomeTable,
      whereKey: "id",
      whereValue: id,
    );
    if (response != 0) {
      tableList.removeWhere((e) => e.id == id);
    }
    setState(() {});
  }

  IncomeKeyType keyType = IncomeKeyType.id;
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

  onAddUpdateIncom(IncomeModel model) async {
    DatabaseHelper databaseHelper = DatabaseHelper();

    int currentIndex = tableList.indexWhere((e) => e.id == model.id);
    if (currentIndex != -1) {
      setState(() => loading = true);

      int response = await databaseHelper.update(
        whereKey: "id",
        whereValue: "${model.id!}",
        model: model.toJson(),
        tableName: SqlQueries.incomeTable,
      );
      if (response != 0) {
        tableList[currentIndex] = model;
      }
    } else {
      int response = await databaseHelper.insert(
        model: model.toJson(),
        tableName: SqlQueries.incomeTable,
      );
      if (response != 0) {
        tableList.add(model.copyWith(id: response));
      }
    }
    setState(() => loading = false);
  }

  bool loading = false;

  /// get all data
  Future getIncomeTableList(
    BuildContext context,
  ) async {
    setState(() => loading = true);
    final result = await IncomeDataHadler.getIncomeFromLocalDataBase();
    result.fold((l) {
      DialogHelper.error(
        message: l.toString(),
      ).showDialog(
        context,
      );
    }, (r) {
      tableList = r;
    });
    setState(() => loading = false);
  }

  /// onsearch
  Future getFilteredTableList(
    BuildContext context,
    dynamic value,
  ) async {
    setState(() => loading = true);

    final result = await IncomeDataHadler.onSearch(
      key: keyType.keyName,
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

enum IncomeKeyType {
  id(keyName: "id"),
  incomeName(keyName: "incomeName"),
  incomeDate(keyName: "incomeDate"),
  incomeValue(keyName: "incomeValue");

  final String keyName;

  const IncomeKeyType({required this.keyName});
}
