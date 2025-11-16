import 'package:dartz/dartz.dart';

import '../../../../core/Api/Errors/exceptions.dart';
import '../../../../models/drop_down_model.dart';

abstract class CategoriesRepository{
  ///================>> GET CATEGORIES DATA
  Future<Either<NetworkFailure, List<DropdownModel>>> getData();
  ///================>> GET CATEGORY BY ID
  Future<Either<Exception, DropdownModel>> getCategoryByID(
      int id);
}