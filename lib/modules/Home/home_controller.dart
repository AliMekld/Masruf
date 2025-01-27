import 'package:masrof/models/test_statistics_model.dart';
import 'package:masrof/modules/Home/home_dataHandler.dart';
import 'package:state_extended/state_extended.dart';

class HomeController extends StateXController {
  ///SingleTone
  HomeController._();
  static final HomeController _instance = HomeController._();
  factory HomeController() => _instance;
  StatisticsModel? statisticsModel;
  Future<void> getStatistics() async {
    final result = await HomeDataHandler.getStatisticsData();
    result.fold(
      (l) {
        print("from handle error in conroller $l ");
      },
      (r) {
        statisticsModel = r;
        print("${r.toJson()}");
      },
    );
    setState(() {});
  }
}
