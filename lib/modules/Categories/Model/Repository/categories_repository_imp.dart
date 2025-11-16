import 'package:dartz/dartz.dart';

import 'package:masrof/core/Api/Errors/exceptions.dart';

import 'package:masrof/models/drop_down_model.dart';

import 'categories_repository.dart';

class CategoriesRepositoryImp implements CategoriesRepository{
  @override
  Future<Either<Exception, DropdownModel>> getCategoryByID(int id) {
    // TODO: implement getCategoryByID
    throw UnimplementedError();
  }

  @override
  Future<Either<NetworkFailure, List<DropdownModel>>> getData() {
    // TODO: implement getData
    throw UnimplementedError();
  }
}