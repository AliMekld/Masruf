import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrof/modules/Home/home_controller.dart';
import 'package:masrof/modules/Home/home_screen.dart';
import 'package:masrof/utilites/extensions.dart';
import 'package:state_extended/state_extended.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/theme/typography.dart';

class SmallHomeScreen extends StatefulWidget {
  const SmallHomeScreen({super.key});

  @override
  StateX<SmallHomeScreen> createState() => _SmallHomeScreenState();
}

class _SmallHomeScreenState extends StateX<SmallHomeScreen> {
  _SmallHomeScreenState() : super(controller: HomeController()) {
    con = HomeController();
  }
  late HomeController con;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Small Dashboard",
          style: TextStyleHelper.of(context).headlineSmall24R,
        ),
        16.h.heightBox,
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          runSpacing: 16,
          children: [
            CardWidget(
              width: 1.sw,
              height: 300.h,
              child: Center(
                child: SfCircularChart(
                  title: const ChartTitle(text: 'Expensses Tracker'),
                  legend: const Legend(isVisible: true),
                  series: <PieSeries<PieData, String>>[
                    PieSeries<PieData, String>(
                        explode: true,
                        explodeIndex: 0,
                        dataSource: dataList,
                        xValueMapper: (PieData data, _) => data.xData,
                        yValueMapper: (PieData data, _) => data.yData,
                        dataLabelMapper: (PieData data, _) => data.text,
                        dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            labelPosition: ChartDataLabelPosition.outside)),
                  ],
                ),
              ),
            ),
            CardWidget(
              width: 1.sw,
              height: 300.h,
              child: Center(
                  child: SfCartesianChart(
                title: const ChartTitle(text: 'Flutter Chart'),
                legend: const Legend(isVisible: true),
                series: getDefaultData(),
                // tooltipBehavior: _tooltipBehavior,
              )),
            ),
            CardWidget(
              width: 1.sw,
              height: 300.h,
              child: const Text(''),
            ),
            CardWidget(
              width: 1.sw,
              height: 300.h,
              child: const Text(''),
            ),
          ],
        ).addPaddingAll(padding: 8),
      ],
    ).withVerticalScroll.expand;
  }
}
