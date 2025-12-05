import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/Language/app_localization.dart';
import 'Model/Models/statistics_model.dart';
import '../../../utilities/constants/Strings.dart';
import '../../../utilities/extensions.dart';
import '../../../widgets/DashboardStatisticksWidgets/linear_analatical_widget.dart';
import '../../../widgets/DashboardStatisticksWidgets/pie_chart_widget.dart';
import '../../../widgets/loading_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/theme/typography.dart';
import 'Controller/home_bloc.dart';
import 'Model/Models/test_statistics_model.dart';
import 'View/Widgets/card_widget.dart';

class HomeScreen extends StatelessWidget {
  static const String routerName = 'homeScreen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) =>  HomeBloc()..init(),
     child: BlocConsumer<HomeBloc, HomeState>(listener: (context, state) => context.read<HomeBloc>().handleListener(),
     builder: (context, state) {
       final con = context.read<HomeBloc>();
       return LoadingWidget(
       isLoading:state .isLoading,
       child:Column(
         spacing: 16.h,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           TextButton(
             child: Text(
               Strings.dashboard.tr,
               style: TextStyleHelper.of(context).headlinelarge32R,
             ),
             onPressed: ()  {
             },
           ),
           Wrap(
             alignment: WrapAlignment.center,
             crossAxisAlignment: WrapCrossAlignment.center,
             spacing: 16.w,
             runSpacing: 16.h,
             children: [
               FractionallySizedBox(
                 widthFactor: 0.4,
                 child: CardWidget(
                     width: context.width,
                     height: 382.h,
                     child: CustomPieChartWidget(
                       data: state.statisticsModel?.copyWith(
                         detailslist: [
                           StatisticsDetailModel(
                             id: 1,
                             lable: Strings.income.tr,
                             totalValue:
                             state.statisticsModel?.totalIncome ?? 0,
                           ),
                           StatisticsDetailModel(
                             id: 2,
                             lable: Strings.expenses.tr,
                             totalValue:
                             state.statisticsModel?.totalExpenses ?? 0,
                           )
                         ],
                       ) ??
                           StatisticsModel(),
                     )),
               ),
               FractionallySizedBox(
                 widthFactor: 0.58,
                 child: CardWidget(
                   width: context.width,
                   height: 382.h,
                   child: LinerAnalyticsWidget(
                     tooltipBehavior: TooltipBehavior(),
                     series: const [],
                     titles: const [],
                   ).addPaddingAll(padding: 8.r),
                 ),
               ),
               FractionallySizedBox(
                 widthFactor: 0.58,
                 child: CardWidget(
                   width: context.width,
                   height: 382.h,
                   child: LinerAnalyticsWidget(
                     tooltipBehavior: TooltipBehavior(),
                     series: const [],
                     titles: const [],
                   ).addPaddingAll(padding: 8.r),
                 ),
               ),
               FractionallySizedBox(
                 widthFactor: 0.4,
                 child: CardWidget(
                     width:context.width,
                     height: 382.h,
                     child: CustomPieChartWidget(
                       data: state.statisticsModel?.copyWith(
                         detailslist: [
                           StatisticsDetailModel(
                             id: 1,
                             lable: Strings.income.tr,
                             totalValue:
                             state.statisticsModel?.totalIncome ?? 0,
                           ),
                           StatisticsDetailModel(
                             id: 2,
                             lable: Strings.expenses.tr,
                             totalValue:
                             state.statisticsModel?.totalExpenses ?? 0,
                           )
                         ],
                       ) ??
                           StatisticsModel(),
                     )),
               ),
             ],
           ),
         ],
       ).withVerticalScrollWhen(true),
     );
     }

     ),
    );
  }
}
