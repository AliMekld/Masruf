import 'package:dartz/dartz.dart';
import 'package:masrof/core/LocalDataBase/database_helper.dart';
import 'package:masrof/core/LocalDataBase/generic_local_crud_methods.dart';
import 'package:masrof/models/expense_model.dart';

class WalletDataHadler {
  /// get All without Filtering
  static Future<Either<Exception, List<ExpensesModel>>>
      getExpensesFromLocalDataBase() async {
    try {
      final response = await GenericLocalCrudMethods<ExpensesModel>(
        fromMap: (json) => ExpensesModel.fromJson(json),
      ).getListFrom(
        tableName: DatabaseHelper.expensesTable,
      );
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }
  
}
