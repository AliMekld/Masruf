import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrof/core/theme/color_pallete.dart';
import 'package:masrof/core/theme/typography.dart';
import 'package:masrof/utilites/constants/constamts.dart';
import 'package:masrof/utilites/extensions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
///TODO : decide creating three screen or make one screen responsive
class HomeScreen extends StatefulWidget {
  static const String routerName = 'homeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dashboard",
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

class CardWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final Widget child;
  const CardWidget({
    super.key,
    this.height,
    this.width,
    this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 600.h,
      width: width ?? 400.w,
      decoration: BoxDecoration(
        borderRadius: Constants.kBorderRaduis16,
        boxShadow: [
          BoxShadow(
              blurRadius: 1,
              spreadRadius: 1,
              blurStyle: BlurStyle.normal,
              color: ColorsPalette.of(context).dividerColor)
        ],
        color: color ?? ColorsPalette.of(context).surfaceColor,
      ),
      child: child,
    );
  }
}

class PieData {
  PieData(
    this.xData,
    this.yData, {
    this.text,
  });
  final String xData;
  final num yData;
  String? text;
}

List<PieData> dataList = [
  PieData("expense", 70),
  PieData('income', 30),
];

class SalesData {
  final DateTime time;
  final String country;
  final double value1;
  final double value2;
  final double value3;
  final double value4;
  final double value5;

  SalesData(this.time, this.country, this.value1, this.value2, this.value3,
      this.value4, this.value5);
}

List<LineSeries<SalesData, num>> getDefaultData() {
  const bool isDataLabelVisible = true,
      isMarkerVisible = true,
      isTooltipVisible = true;
  double? lineWidth, markerWidth, markerHeight;
  final List<SalesData> chartData = <SalesData>[
    SalesData(DateTime(2005, 0, 1), 'India', 1.5, 21, 28, 680, 760),
    SalesData(DateTime(2006, 0, 1), 'China', 2.2, 24, 44, 550, 880),
    SalesData(DateTime(2007, 0, 1), 'USA', 3.32, 36, 48, 440, 788),
    SalesData(DateTime(2008, 0, 1), 'Japan', 4.56, 38, 50, 350, 560),
    SalesData(DateTime(2009, 0, 1), 'Russia', 5.87, 54, 66, 444, 566),
    SalesData(DateTime(2010, 0, 1), 'France', 6.8, 57, 78, 780, 650),
    SalesData(DateTime(2011, 0, 1), 'Germany', 8.5, 70, 84, 450, 800)
  ];
  return <LineSeries<SalesData, num>>[
    LineSeries<SalesData, num>(
        enableTooltip: true,
        dataSource: chartData,
        xValueMapper: (SalesData sales, _) => sales.value1,
        yValueMapper: (SalesData sales, _) => sales.value1,
        width: lineWidth ?? 2,
        markerSettings: MarkerSettings(
            isVisible: isMarkerVisible,
            height: markerWidth ?? 4,
            width: markerHeight ?? 4,
            shape: DataMarkerType.circle,
            borderWidth: 3,
            borderColor: Colors.red),
        dataLabelSettings:const DataLabelSettings(
            isVisible: isDataLabelVisible,
            labelAlignment: ChartDataLabelAlignment.auto)),
    LineSeries<SalesData, num>(
        enableTooltip: isTooltipVisible,
        dataSource: chartData,
        width: lineWidth ?? 2,
        xValueMapper: (SalesData sales, _) => sales.value3,
        yValueMapper: (SalesData sales, _) => sales.value4,
        markerSettings: MarkerSettings(
            isVisible: isMarkerVisible,
            height: markerWidth ?? 4,
            width: markerHeight ?? 4,
            shape: DataMarkerType.circle,
            borderWidth: 3,
            borderColor: Colors.black),
        dataLabelSettings: const DataLabelSettings(
            isVisible: isDataLabelVisible,
            labelAlignment: ChartDataLabelAlignment.auto))
  ];
}
