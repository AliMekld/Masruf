import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrof/core/Language/app_localization.dart';
import 'package:masrof/core/theme/color_pallete.dart';
import 'package:masrof/modules/Home/ScreenLayouts/m_home_screen.dart';
import 'package:masrof/modules/Home/ScreenLayouts/s_home_screen.dart';
import 'package:masrof/utilites/constants/Strings.dart';
import 'package:masrof/utilites/constants/constamts.dart';
import 'package:masrof/utilites/constants/mixins.dart';
import 'ScreenLayouts/l_home_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routerName = 'homeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with ResponsiveStatfullMixin {
  @override
  Widget build(BuildContext context) {
    return responsiveBuild(
      largeScreen: const LargeHomeScreen(),
      mediumScreen: const MediumHomeScreen(),
      smallScreen: const SmallHomeScreen(),
    );
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
  PieData(Strings.expenses.tr, 70),
  PieData(Strings.income, 30),
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
