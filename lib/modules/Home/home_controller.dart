import 'package:flutter/material.dart';
import 'package:masrof/models/expense_model.dart';
import 'package:masrof/models/test_statistics_model.dart';
import 'package:masrof/modules/Categories/categories_data_hadler.dart';
import 'package:masrof/modules/Expenses/expenses_data_hadler.dart';
import 'package:masrof/modules/Home/home_dataHandler.dart';
import 'package:masrof/widgets/DialogsHelper/dialog_widget.dart';
import 'package:state_extended/state_extended.dart';

class HomeController extends StateXController {
  ///SingleTone
  HomeController._();
  static final HomeController _instance = HomeController._();
  factory HomeController() => _instance;
  StatisticsModel? statisticsModel;
  Future<void> getStatistics() async {
    final result = await HomeDataHandler.getStatisticsData();
    result.fold(
      (l) {
        print("from handle error in conroller $l ");
      },
      (r) {
        statisticsModel = r;
        print("${r.toJson()}");
      },
    );
    setState(() {});
  }

  Future<void> testAPI(BuildContext context) async {
    final result = await CategoriesDataHadler.getData();
    result.fold((l) {
      print(l.model.message.toString());
      DialogHelper.error(message: l.model.toString())
          .errorDialog(context: context, message: l.model.statusMessage);
    }, (r) {
      debugPrint(r.toString());
    });
  }

  List<ExpensesModel> expensesList = [];
  bool isLoading = false;
  Future getExpensesTableList(
    BuildContext context,
  ) async {
    setState(() => isLoading = true);
    final result = await ExpensesDataHadler.getExpensesFromLocalDataBase();
    result.fold((l) {}, (r) => expensesList = r);
    setState(() => isLoading = false);
  }
}
