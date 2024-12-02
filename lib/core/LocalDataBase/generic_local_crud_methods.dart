// this class is responsible for creating a generic crud methods on local data base
// it works now for get / get all

import 'package:masrof/core/LocalDataBase/database_helper.dart';

class GenericLocalCrudMethods<T> {
  final T Function(Map<String, dynamic>) fromMap;

  GenericLocalCrudMethods({required this.fromMap});
  Future<List<T>> getListFrom({required String tableName}) async {
    List<T> tList = [];
    try {
      DatabaseHelper databaseHelper = DatabaseHelper();
      List<Map<String, dynamic>> dynamicList =
          await databaseHelper.seleectFrom(tableName: tableName);
      tList = List<T>.from(dynamicList.map((e) => fromMap(e))).toList();
      return tList;
    } catch (e) {
      throw Exception(e);
    }
  }
}
