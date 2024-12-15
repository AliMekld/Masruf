import 'package:dartz/dartz.dart';
import 'package:masrof/core/LocalDataBase/generic_local_crud_methods.dart';
import 'package:masrof/core/LocalDataBase/sql_queries.dart';
import 'package:masrof/models/drop_down_model.dart';

class CategoriesDataHadler {
  /// get All without Filtering
  static Future<Either<Exception, List<DropdownModel>>>
      getCategoriesFromLocalDataBase({
    String? key,
    dynamic value,
  }) async {
    try {
      final response = await GenericLocalCrudMethods<DropdownModel>(
        fromMap: (json) => DropdownModel.fromJson(json),
      ).getListFrom(
        tableName: SqlQueries.categoriesTable,
      );
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  static Future<Either<Exception, DropdownModel>> getCategoryByID(
      int id) async {
    try {
      final response = await GenericLocalCrudMethods<DropdownModel>(
        fromMap: (json) => DropdownModel.fromJson(json),
      ).onSearchItem(
        tableName: SqlQueries.categoriesTable,
        key: "id",
        value: id,
      );
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  static Future<Either<Exception, List<DropdownModel>>> onSearch({
    required String key,
    required dynamic value,
  }) async {
    try {
      final response = await GenericLocalCrudMethods<DropdownModel>(
        fromMap: (json) => DropdownModel.fromJson(json),
      ).onSearch(
        tableName: SqlQueries.categoriesTable,
        key: key,
        value: value,
      );
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
