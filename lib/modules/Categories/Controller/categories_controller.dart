import 'package:flutter/material.dart';
import '../../../core/LocalDataBase/database_helper.dart';
import '../../../models/drop_down_model.dart';
import '../Model/categories_data_hadler.dart';
import '../../../widgets/DialogsHelper/dialog_widget.dart';
import 'package:state_extended/state_extended.dart';

import '../../../core/LocalDataBase/sql_queries.dart';

class CategoriesController extends StateXController {
  ///singleTone
  CategoriesController._();
  static final CategoriesController _instance = CategoriesController._();
  factory CategoriesController() => _instance;
  late TextEditingController searchController;
  List<DropdownModel> tableList = [];

  onDeleteCategory(int id) async {
    if (id == -1) return;
    DatabaseHelper databaseHelper = DatabaseHelper();

    int response = await databaseHelper.deleteFrom(
      tableName: SqlQueries.categoriesTable,
      whereKey: 'id',
      whereValue: id,
    );
    if (response != 0) {
      tableList.removeWhere((e) => e.id == id);
    }
    setState(() {});
  }

  CategoresKeyType keyType = CategoresKeyType.id;
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

  onAddUpdateCategory(DropdownModel model) async {
    DatabaseHelper databaseHelper = DatabaseHelper();

    int currentIndex = tableList.indexWhere((e) => e.id == model.id);
    if (currentIndex != -1) {
      setState(() => loading = true);

      int response = await databaseHelper.update(
        whereKey: 'id',
        whereValue: '${model.id!}',
        model: model.toJson(),
        tableName: SqlQueries.categoriesTable,
      );
      if (response != 0) {
        await databaseHelper.onCloseDataBase();
        tableList[currentIndex] = model;
      }
    } else {
      int response = await databaseHelper.insert(
        model: model.toJson(),
        tableName: SqlQueries.categoriesTable,
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
    final result = await CategoriesDataHadler.getCategoriesFromLocalDataBase();
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
    Object? value,
  ) async {
    setState(() => loading = true);

    final result = await CategoriesDataHadler.onSearch(
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

enum CategoresKeyType {
  id(keyName: 'id'),
  name(keyName: 'name'),
  eName(keyName: 'eName');

  final String keyName;

  const CategoresKeyType({required this.keyName});
}
