import 'package:flutter/material.dart';
import '../../models/expense_model.dart';
import '../../models/test_statistics_model.dart';
import '../Categories/Model/categories_data_hadler.dart';
import '../Expenses/expenses_data_hadler.dart';
import 'home_dataHandler.dart';
import '../../widgets/DialogsHelper/dialog_widget.dart';
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
        debugPrint('from handle error in conroller $l ');
      },
      (r) {
        statisticsModel = r;
        debugPrint('${r.toJson()}');
      },
    );
    setState(() {});
  }

  Future<void> testAPI(BuildContext context) async {
    final result = await CategoriesDataHadler.getData();
    result.fold((l) {
      debugPrint(l.model.message.toString());
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
