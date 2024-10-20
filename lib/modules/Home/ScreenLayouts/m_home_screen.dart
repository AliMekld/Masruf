import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrof/modules/Home/home_screen.dart';
import 'package:masrof/utilites/extensions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/theme/typography.dart';

class MediumHomeScreen extends StatefulWidget {
  const MediumHomeScreen({super.key});

  @override
  State<MediumHomeScreen> createState() => _MediumHomeScreenState();
}

class _MediumHomeScreenState extends State<MediumHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Medium Dashboard",
          style: TextStyleHelper.of(context).headlinelarge32R,
        ),
        16.h.heightBox,
        Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          runSpacing: 16,
          children: [
            CardWidget(
              width: 0.39.sw,
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
              width: 0.39.sw,
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
              width: 0.39.sw,
              height: 300.h,
              child: const Text(''),
            ),
            CardWidget(
              width: 0.39.sw,
              height: 300.h,
              child: const Text(''),
            ),
          ],
        ),
      ],
    ).withVerticalScroll;
  }
}
