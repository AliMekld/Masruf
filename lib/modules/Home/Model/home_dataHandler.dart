// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import '../../../core/LocalDataBase/generic_local_crud_methods.dart';
import '../../../core/LocalDataBase/sql_queries.dart';
import 'Models/test_statistics_model.dart';

class HomeDataHandler {
  static Future<Either<Exception, StatisticsModel>> getStatisticsData() async {
    try {
      final response =
          await GenericLocalCrudMethods(fromMap: StatisticsModel.fromJson)
              .getItem(
        tableName: SqlQueries.statisticsTable,
      );
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
