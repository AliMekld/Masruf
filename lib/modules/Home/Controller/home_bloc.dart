import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/expense_model.dart';
import '../../Expenses/expenses_data_hadler.dart';
import '../Model/Models/test_statistics_model.dart';
import '../Model/home_dataHandler.dart';
part 'home_state.dart';
part 'home_event.dart';
class HomeBloc extends Bloc<HomeEvents, HomeState > {
  HomeBloc():super(const HomeState());

  Future<void> getStatistics() async {
    final result = await HomeDataHandler.getStatisticsData();
    result.fold(
      (l) {
        debugPrint('from handle error in conroller $l ');
      },
      (r) {
        statisticsModel = r;
        debugPrint('${r.toJson()}');
      },
    );
  }
  handleListener(){}
init(){
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
    await Future.wait([
    getStatistics(),
     getExpensesTableList(),
    ]);
  });
}

  Future getExpensesTableList(
  ) async {
    final result = await ExpensesDataHadler.getExpensesFromLocalDataBase();
    result.fold((l) {}, (r) =>  = r);
  }
}
