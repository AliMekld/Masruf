import 'package:dartz/dartz.dart';

import '../../../../core/Api/Errors/exceptions.dart';

import '../../../../models/drop_down_model.dart';

import '../DataSource/categories_local_data_source.dart';
import '../DataSource/categories_remote_data_source.dart';
import 'categories_repository.dart';

class CategoriesRepositoryImp implements CategoriesRepository {
  final bool isConnected;
  final CategoriesRepository remote = CategoriesRemoteDataSource();
  final CategoriesRepository local = CategoriesLocalDataSource();
  CategoriesRepositoryImp({required this.isConnected});

  @override
  Future<Either<Exception, DropdownModel>> getCategoryByID(int id) =>
      isConnected == false
          ? remote.getCategoryByID(id)
          : local.getCategoryByID(id);

  @override
  Future<Either<Failure, List<DropdownModel>>> getData() =>
      isConnected == false ? remote.getData() : local.getData();

  @override
  Future<Either<Exception, List<DropdownModel>>> onSearch(
          {required String key, required Object? value}) =>
      isConnected == false
          ? remote.onSearch(key: key, value: value)
          : local.onSearch(key: key, value: value);

  @override
  Future<Either<Failure, DropdownModel>> insertCategory(DropdownModel model) =>
      isConnected == false
          ? remote.insertCategory(model)
          : local.insertCategory(model);

  @override
  Future<Either<Failure, DropdownModel>> updateCategory(
          {required DropdownModel model, required String key}) =>
      isConnected == false
          ? remote.updateCategory(model: model, key: key)
          : local.updateCategory(model: model, key: key);
}
