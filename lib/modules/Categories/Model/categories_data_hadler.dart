import 'package:dartz/dartz.dart';
import 'package:masrof/core/Api/generic_request.dart';
import 'package:masrof/core/Api/request_Methods.dart';
import 'package:masrof/core/LocalDataBase/generic_local_crud_methods.dart';
import 'package:masrof/core/LocalDataBase/sql_queries.dart';
import 'package:masrof/models/drop_down_model.dart';
import 'package:masrof/utilities/api_end_points.dart';

import '../../../core/Api/Errors/exceptions.dart';

class CategoriesDataHadler {
  ///todo test this
  static Future<Either<NetworkFailure, List<DropdownModel>>> getData() async {
    try {
      final response = await GenericRequest<DropdownModel>(
              fromMap: DropdownModel.fromJson,
              method: RequestMethod.get(url: ApiEndPoint.products))
          .getList();
      return Right(response);
    } on NetworkFailure catch (e) {
      return Left(ServerException(e.model));
    }
  }

  /// get All without Filtering
  static Future<Either<Exception, List<DropdownModel>>>
      getCategoriesFromLocalDataBase({
    String? key,
     Object? value,
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
        key: 'id',
        value: id,
      );
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  static Future<Either<Exception, List<DropdownModel>>> onSearch({
    required String key,
    required Object? value,
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
