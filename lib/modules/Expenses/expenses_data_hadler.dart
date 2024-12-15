import 'package:dartz/dartz.dart';
import 'package:masrof/core/LocalDataBase/generic_local_crud_methods.dart';
import 'package:masrof/core/LocalDataBase/sql_queries.dart';
import 'package:masrof/models/expense_model.dart';

class ExpensesDataHadler {
  /// get All without Filtering
  static Future<Either<Exception, List<ExpensesModel>>>
      getExpensesFromLocalDataBase({
    String? key,
    dynamic value,
  }) async {
    try {
      final response = await GenericLocalCrudMethods<ExpensesModel>(
        fromMap: (json) => ExpensesModel.fromJson(json),
      ).getListFrom(
        tableName: SqlQueries.expensesTable,
      );
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  static Future<Either<Exception, ExpensesModel>> getItemByID(int id) async {
    try {
      final response = await GenericLocalCrudMethods<ExpensesModel>(
        fromMap: (json) => ExpensesModel.fromJson(json),
      ).onSearchItem(
        tableName: SqlQueries.expensesTable,
        key: "id",
        value: id,
      );
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  static Future<Either<Exception, List<ExpensesModel>>> onSearch({
    required String key,
    required dynamic value,
  }) async {
    try {
      final response = await GenericLocalCrudMethods<ExpensesModel>(
        fromMap: (json) => ExpensesModel.fromJson(json),
      ).onSearch(
        tableName: SqlQueries.expensesTable,
        key: key,
        value: value,
      );
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
