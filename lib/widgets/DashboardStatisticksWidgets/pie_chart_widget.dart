import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrof/core/theme/typography.dart';
import 'package:masrof/models/statistics_model.dart';
import 'package:masrof/models/test_statistics_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomPieChartWidget extends StatelessWidget {
  final StatisticsModel data;
  const CustomPieChartWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      tooltipBehavior: TooltipBehavior(),
      backgroundColor: Colors.transparent,
      legend: Legend(
        isVisible: true,
        alignment: ChartAlignment.center,
        isResponsive: true,
        itemPadding: 8,
        iconHeight: 24.h,
        iconWidth: 24.w,
        position: LegendPosition.top,
        textStyle: TextStyleHelper.of(context).bodySmall12R,
      ),
      series: [
        PieSeries<StatisticsDetailModel, String>(
          explodeIndex: 0,
          explode: true,
          initialSelectedDataIndexes: const [0],
          animationDuration: 1200,
          xValueMapper: (item, index) => item.lable,
          yValueMapper: (item, index) => item.totalValue,
          dataLabelMapper: (StatisticsDetailModel data, _) =>
              data.totalValue?.toString(),
          dataLabelSettings: DataLabelSettings(
              showZeroValue: true,
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              textStyle: TextStyleHelper.of(context)
                  .lableSmall11M
                  .copyWith(color: Colors.white),
              useSeriesColor: true),
          dataSource: data.detailslist,
          enableTooltip: true,
        ),
      ],
    );
    //   backgroundColor: Colors.transparent,
  }
}
