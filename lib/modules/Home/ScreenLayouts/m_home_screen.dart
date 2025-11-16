import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../home_controller.dart';
import '../home_screen.dart';
import '../../../utilities/extensions.dart';
import '../../../widgets/DashboardStatisticksWidgets/linear_analatical_widget.dart';
import 'package:state_extended/state_extended.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/theme/typography.dart';

class MediumHomeScreen extends StatefulWidget {
  const MediumHomeScreen({super.key});

  @override
  StateX<MediumHomeScreen> createState() => _MediumHomeScreenState();
}

class _MediumHomeScreenState extends StateX<MediumHomeScreen> {
  _MediumHomeScreenState() : super(controller: HomeController()) {
    con = HomeController();
  }
  late HomeController con;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Medium Dashboard',
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
                  child: LinerAnalyticsWidget(
                tooltipBehavior: TooltipBehavior(),
                series: const [],
                titles: const [],
              )),
            ),
            // CardWidget(
            //   width: 0.39.sw,
            //   height: 300.h,
            //   child: Center(
            //       child: SfCartesianChart(
            //     title: const ChartTitle(text: 'Flutter Chart'),
            //     legend: const Legend(isVisible: true),
            //     series: getDefaultData(),
            //     // tooltipBehavior: _tooltipBehavior,
            //   )),
            // ),
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
