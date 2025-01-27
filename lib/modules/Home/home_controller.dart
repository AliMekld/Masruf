import 'package:masrof/models/statistics_model.dart';
import 'package:state_extended/state_extended.dart';

class HomeController extends StateXController {
  ///SingleTone
  HomeController._();
  static final HomeController _instance = HomeController._();
  factory HomeController() => _instance;
  List<StatisticsDetailModel> expensesData = [];
}

enum ExpensesTaps {
  expense,
  income,
}
