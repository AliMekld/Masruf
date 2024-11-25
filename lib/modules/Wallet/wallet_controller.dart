import 'package:masrof/models/expense_model.dart';
import 'package:state_extended/state_extended.dart';

class WalletController extends StateXController {
  ///singleTone
  WalletController._();
  static final WalletController _instance = WalletController._();
  factory WalletController() => _instance;


  List<ExpensesModel> get tableList => [
      ExpensesModel(
        category: "cccc",
        expenseDate: DateTime.now(),
        expenseName: "school expenses",
        expenseValue: 500,
        id: 1,
      ),
      ExpensesModel(
        category: "cccc",
        expenseDate: DateTime.now(),
        expenseName: "school expenses",
        expenseValue: 500,
        id: 2,
      ),
      ExpensesModel(
        category: "cccc",
        expenseDate: DateTime.now(),
        expenseName: "school expenses",
        expenseValue: 500,
        id: 3,
      ),
      ExpensesModel(
        category: "cccc",
        expenseDate: DateTime.now(),
        expenseName: "school expenses",
        expenseValue: 500,
        id: 4,
      ),
      ExpensesModel(
        category: "cccc",
        expenseDate: DateTime.now(),
        expenseName: "school expenses",
        expenseValue: 500,
        id: 5,
      ),

    ];
}
