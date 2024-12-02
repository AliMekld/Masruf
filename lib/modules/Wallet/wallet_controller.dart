import 'package:flutter/material.dart';
import 'package:masrof/core/LocalDataBase/database_helper.dart';
import 'package:masrof/models/expense_model.dart';
import 'package:masrof/modules/Wallet/wallet_data_hadler.dart';
import 'package:masrof/widgets/DialogsHelper/dialog_widget.dart';
import 'package:state_extended/state_extended.dart';

class WalletController extends StateXController {
  ///singleTone
  WalletController._();
  static final WalletController _instance = WalletController._();
  factory WalletController() => _instance;
  onDeleteExpense(int id) async {
    if (id == -1) return;
    DatabaseHelper databaseHelper = DatabaseHelper();
    int response = await databaseHelper.deleteFrom(
        tableName: DatabaseHelper.expensesTable,
        whereKey: "id",
        whereValue: id);
    if (response != 0) {
      tableList.removeWhere((e) => e.id == id);
    }
    setState(() {});
  }

  onAddUpdateExpense(ExpensesModel model) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    print(await databaseHelper.database);
    // return;
    int currentIndex = tableList.indexWhere((e) => e.id == model.id);
    if (currentIndex != -1) {
      int response = await databaseHelper.update(
        whereKey: "id",
        whereValue: "${model.id!}",
        model: model.toLocalJson(),
        tableName: DatabaseHelper.expensesTable,
      );
      if (response != 0) {
        tableList[currentIndex] = model;
      }
    } else {
      int response = await databaseHelper.insert(
        model: model.toLocalJson(),
        tableName: DatabaseHelper.expensesTable,
      );
      if (response != 0) {
        tableList.add(model.copyWith(id: response));
      }
    }
    setState(() {});
  }

  List<ExpensesModel> tableList = [];

  ///get data
  Future getExpensesTableList(BuildContext context) async {
    print("from Get List");
    final result = await WalletDataHadler.getExpensesFromLocalDataBase();
    result.fold((l) {
      print("$l errror");

      DialogHelper.error(message: l.toString()).showDialog(context);
    }, (r) {
      print("$r ssssssssssssssssss");
      tableList = r;
    });

    setState(() {});
  }
  // insert
}
