import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/Language/app_localization.dart';
import '../../core/theme/color_pallete.dart';
import '../../core/theme/typography.dart';
import 'expenses_controller.dart';
import '../../utilities/PDFHelper/pdf_builder.dart';
import '../../utilities/Reports/expenses_reports.dart';
import '../../utilities/constants/Strings.dart';
import '../../utilities/extensions.dart';
import '../../widgets/custom_drop_down_widget.dart';
import '../../widgets/custom_text_field_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/tables/expense_table.dart';
import 'package:state_extended/state_extended.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ExpensesScreen extends StatefulWidget {
  static const String routerName = 'expensesScreen';
  const ExpensesScreen({super.key});

  @override
  StateX<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends StateX<ExpensesScreen> {
  _ExpensesScreenState() : super(controller: ExpensesController()) {
    con = ExpensesController();
  }
  @override
  initState() {
    super.initState();
    Future.microtask(() async {
      if (mounted) {
        await con.getExpensesTableList(context);
      }
    });
  }

  late ExpensesController con;
  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      isLoading: con.loading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          context.isTabletOrMobile
              ? Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runAlignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      Strings.expenses.tr,
                      style: TextStyleHelper.of(context).bodyLarge16R,
                    ),
                    CustomTextFieldWidget(
                      hintText: Strings.search.tr,
                      width: 220,
                      controller: con.searchController,
                      onSaved: (v) async {
                        if (v?.isEmpty ?? false) {
                          await con.getExpensesTableList(context);
                        } else {
                          await con.getFilteredTableList(context, v);
                        }
                      },
                    ),
                    CustomDropdownWidget(
                      width: 220,
                      items: KeyType.values
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.keyName.tr,
                              )))
                          .toList(),
                      onChanged: (v) {
                        con.type = v!;
                        setState(() {});
                      },
                      selectedItem: con.type,
                      bgColor: Colors.white,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.expenses.tr,
                      style: TextStyleHelper.of(context).headlineSmall24R,
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () async {
                          ExpensesReportsBuilder expensesReportsBuilder =
                              ExpensesReportsBuilder(
                            expensesList: con.tableList,
                          );
                          await expensesReportsBuilder
                              .buildReportPage()
                              .then((f) {
                            PdfBuilder.createPDF(f);
                          });
                        },
                        icon: Icon(
                          Icons.print,
                          color: ColorsPalette.of(context).secondaryColor,
                        )),
                    CustomTextFieldWidget(
                      hintText: Strings.search.tr,
                      width: 320.w,
                      controller: con.searchController,
                      onChanged: (v) async {
                        if (v?.isEmpty ?? false) {
                          await con.getExpensesTableList(context);
                        } else {
                          await con.getFilteredTableList(context, v);
                        }
                      },
                    ),
                    16.0.widthBox,
                    CustomDropdownWidget(
                      width: 160.w,
                      items: KeyType.values
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.keyName.tr,
                              )))
                          .toList(),
                      onChanged: (v) {
                        con.type = v!;
                        setState(() {});
                      },
                      selectedItem: con.type,
                      bgColor: Colors.white,
                    ),
                  ],
                ),
          16.0.heightBox,
          ExpenseTable(
            onDeleteExpense: (id) async => await con.onDeleteExpense(id),
            onEditExpense: (model) async => await con.onAddUpdateExpense(model),
            expensesList: con.tableList,
            context: context,
          ).expand,
        ],
      ),
    );
  }
}

class CustomPdfViewer extends StatelessWidget {
  final File filePath;

  const CustomPdfViewer({super.key, required this.filePath});
  @override
  Widget build(BuildContext context) {
    return SfPdfViewer.file(filePath);
  }
}
