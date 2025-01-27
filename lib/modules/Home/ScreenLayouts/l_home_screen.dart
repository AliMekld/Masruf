import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrof/core/Language/app_localization.dart';
import 'package:masrof/modules/Home/home_controller.dart';
import 'package:masrof/modules/Home/home_screen.dart';
import 'package:masrof/utilites/constants/Strings.dart';
import 'package:masrof/utilites/extensions.dart';
import 'package:masrof/widgets/DashboardStatisticksWidgets/linear_analatical_widget.dart';
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
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.dashboard.tr,
              style: TextStyleHelper.of(context).headlinelarge32R,
            ),
            16.h.heightBox,
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 32.r,
              runSpacing: 32.r,
              children: [
                CardWidget(
                  width: 0.7.sw,
                  height: 400.h,
                  child: LinerAnalyticsWidget(
                    tooltipBehavior: TooltipBehavior(),
                    series: [],
                    titles: [],
                  ).addPaddingAll(padding: 8),
                ),
                CardWidget(
                  width: !context.isDeskTop ? 0.7.sw : 500.w,
                  height: 300.h,
                  child: const Text(''),
                ),
                CardWidget(
                  width: !context.isDeskTop ? 0.7.sw : 320.w,
                  height: 300.h,
                  child: const Text(''),
                ),
              ],
            ),
          ],
        ).widthBox(0.59.sw),
        // if (context.isDeskTop)
        16.0.widthBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.expenses.tr,
              style: TextStyleHelper.of(context).headlinelarge32R,
            ),
            16.h.heightBox,
            CardWidget(
              width: 320.w,
              height: 632.h,
              child: Column(
                children: [
                  ...[1, 2, 3, 4, 5, 6, 7].map((e) => ListTile(
                        title: Text(e.toString()),
                      ))
                ],
              ),
            ),
          ],
        )
      ],
    ).withVerticalScroll;
  }
}
