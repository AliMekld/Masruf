import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrof/modules/Home/home_screen.dart';
import 'package:masrof/utilites/extensions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/theme/typography.dart';

class LargeHomeScreen extends StatefulWidget {
  const LargeHomeScreen({super.key});

  @override
  State<LargeHomeScreen> createState() => _LargeHomeScreenState();
}

class _LargeHomeScreenState extends State<LargeHomeScreen> {
  @override
  Widget build(BuildContext context) {
     
  return   Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Large Dashboard",
              style: TextStyleHelper.of(context).headlinelarge32R,
            ),
            16.h.heightBox,
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              runSpacing: 16,
              children: [
                ///TODO Make Custom Widgets For Those Charts
                CardWidget(
                  width: !context.isDeskTop ? 0.7.sw  : 320.w,
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
                  width: !context.isDeskTop ? 0.7.sw  * 1 : 500.w,
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
                  width: !context.isDeskTop ?0.7.sw : 500.w,
                  height: 300.h,
                  child:const Text(''),
                ),
                CardWidget(
                  width: !context.isDeskTop ? 0.7.sw  : 320.w,
                  height: 300.h,
                  child:const Text(''),
                ),
              ],
            ),
          ],
        ).widthBox(!context.isDeskTop ? 0.7.sw : 0.6.sw),
        if (context.isDeskTop)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Expenses",
                style: TextStyleHelper.of(context).headlinelarge32R,
              ),
              16.h.heightBox,
              CardWidget(
                width:  320.w,
                height: 632.h,
                child:Column(children: [

                   ...[1,2,3,4,5,6,7].map( (e)=> ListTile(title:Text(e.toString()),))

                ],),
              ),
            ],
          )
      ],
    ).withVerticalScroll;
  }
}