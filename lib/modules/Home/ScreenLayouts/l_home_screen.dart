import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrof/core/Language/app_localization.dart';
import 'package:masrof/models/statistics_model.dart';
import 'package:masrof/models/test_statistics_model.dart';
import 'package:masrof/modules/Home/home_controller.dart';
import 'package:masrof/modules/Home/home_screen.dart';
import 'package:masrof/utilites/constants/Strings.dart';
import 'package:masrof/utilites/extensions.dart';
import 'package:masrof/utilites/shared_pref.dart';
import 'package:masrof/widgets/DashboardStatisticksWidgets/linear_analatical_widget.dart';
import 'package:masrof/widgets/DashboardStatisticksWidgets/pie_chart_widget.dart';
import 'package:masrof/widgets/loading_widget.dart';
import 'package:state_extended/state_extended.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/theme/typography.dart';

class LargeHomeScreen extends StatefulWidget {
  const LargeHomeScreen({super.key});

  @override
  StateX<LargeHomeScreen> createState() => _LargeHomeScreenState();
}

class _LargeHomeScreenState extends StateX<LargeHomeScreen> {
  _LargeHomeScreenState() : super(controller: HomeController()) {
    con = HomeController();
  }

  late HomeController con;
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      Future.wait([
        con.getStatistics(),
        if (mounted) con.getExpensesTableList(context),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      isLoading: con.isLoading,
      child: LayoutBuilder(builder: (context, constraints) {
        bool isExpended() {
          return SharedPref.getIsSideBarExpanded();
        }

        double _width = context.appWidth - (isExpended() ? 180 : 80);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.dashboard.tr,
              style: TextStyleHelper.of(context).headlinelarge32R,
            ),
            16.h.heightBox,
            Wrap(
              // alignment: WrapAlignment.center,
              // crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16.w,
              runSpacing: 16.h,
              children: [
                CardWidget(
                    width: _width * (isExpended() ? 0.29 : 0.28),
                    height: 400.h,
                    child: CustomPieChartWidget(
                      data: con.statisticsModel?.copyWith(
                            detailslist: [
                              StatisticsDetailModel(
                                id: 1,
                                lable: Strings.income.tr,
                                totalValue:
                                    con.statisticsModel?.totalIncome ?? 0,
                              ),
                              StatisticsDetailModel(
                                id: 2,
                                lable: Strings.expenses.tr,
                                totalValue:
                                    con.statisticsModel?.totalExpenses ?? 0,
                              )
                            ],
                          ) ??
                          StatisticsModel(),
                    )),
                CardWidget(
                  width: _width * (isExpended() ? 0.6 : 0.68),
                  height: 400.h,
                  child: LinerAnalyticsWidget(
                    tooltipBehavior: TooltipBehavior(),
                    series: [],
                    titles: [],
                  ).addPaddingAll(padding: 8.r),
                ),
                CardWidget(
                  width: _width * (isExpended() ? 0.6 : 0.68),
                  height: 400.h,
                  child: LinerAnalyticsWidget(
                    tooltipBehavior: TooltipBehavior(),
                    series: [],
                    titles: [],
                  ).addPaddingAll(padding: 8.r),
                ),
                CardWidget(
                    width: _width * (isExpended() ? 0.29 : 0.28),
                    height: 400.h,
                    child: CustomPieChartWidget(
                      data: con.statisticsModel?.copyWith(
                            detailslist: [
                              StatisticsDetailModel(
                                id: 1,
                                lable: Strings.income.tr,
                                totalValue:
                                    con.statisticsModel?.totalIncome ?? 0,
                              ),
                              StatisticsDetailModel(
                                id: 2,
                                lable: Strings.expenses.tr,
                                totalValue:
                                    con.statisticsModel?.totalExpenses ?? 0,
                              )
                            ],
                          ) ??
                          StatisticsModel(),
                    )),
              ],
            ),
            // if (context.isDeskTop)
            16.0.widthBox,
          ],
        ).withVerticalScroll;
      }),
    );
  }
}
