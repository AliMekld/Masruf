import 'package:dartz/dartz.dart';
import 'package:masrof/core/LocalDataBase/generic_local_crud_methods.dart';
import 'package:masrof/core/LocalDataBase/sql_queries.dart';
import 'package:masrof/models/income_model.dart';

class IncomeDataHadler {
  /// get All without Filtering
  static Future<Either<Exception, List<IncomeModel>>>
      getIncomeFromLocalDataBase({
    String? key,
    dynamic value,
  }) async {
    try {
      final response = await GenericLocalCrudMethods<IncomeModel>(
        fromMap: (json) => IncomeModel.fromJson(json),
      ).getListFrom(
        tableName: SqlQueries.incomeTable,
      );
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  static Future<Either<Exception, IncomeModel>> getIncomeByID(int id) async {
    try {
      final response = await GenericLocalCrudMethods<IncomeModel>(
        fromMap: (json) => IncomeModel.fromJson(json),
      ).onSearchItem(
        tableName: SqlQueries.incomeTable,
        key: "id",
        value: id,
      );
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  static Future<Either<Exception, List<IncomeModel>>> onSearch({
    required String key,
    required dynamic value,
  }) async {
    try {
      final response = await GenericLocalCrudMethods<IncomeModel>(
        fromMap: (json) => IncomeModel.fromJson(json),
      ).onSearch(
        tableName: SqlQueries.incomeTable,
        key: key,
        value: value,
      );
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
