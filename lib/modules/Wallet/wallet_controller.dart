import 'package:masrof/models/expense_model.dart';
import 'package:state_extended/state_extended.dart';

class WalletController extends StateXController {
  ///singleTone
  WalletController._();
  static final WalletController _instance = WalletController._();
  factory WalletController() => _instance;
  onAddUpdateExpense(ExpensesModel model) {
    int currentIndex = tableList.indexWhere((e) => e.id == model.id);
    if (currentIndex != -1) {
      tableList[currentIndex] = model;
    } else {
      tableList.add(model);
    }
    setState(() {});
  }

  List<ExpensesModel> tableList = [
    ExpensesModel(
      category: "cccc",
      expenseDate: DateTime.now(),
      expenseName: "school expenses",
      expenseValue: 240,
      id: 1,
    ),
    ExpensesModel(
      category: "cccc",
      expenseDate: DateTime.now(),
      expenseName: "home expenses",
      expenseValue: 500,
      id: 2,
    ),
    ExpensesModel(
      category: "cccc",
      expenseDate: DateTime.now(),
      expenseName: "child expenses",
      expenseValue: 250,
      id: 3,
    ),
    ExpensesModel(
      category: "cccc",
      expenseDate: DateTime.now(),
      expenseName: "rent expenses",
      expenseValue: 2000,
      id: 4,
    ),
    ExpensesModel(
      category: "cccc",
      expenseDate: DateTime.now(),
      expenseName: "mariage expenses",
      expenseValue: 50000,
      id: 5,
    ),
  ];
}
