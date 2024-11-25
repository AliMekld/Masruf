import 'package:collection/collection.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:masrof/core/theme/typography.dart';
import 'package:masrof/utilites/extensions.dart';
import 'package:masrof/widgets/GenericTable/table_helper.dart';
import 'package:masrof/widgets/GenericTable/table_widget.dart';
import 'package:masrof/models/expense_model.dart';

class ExpenseTable<T extends ExpensesModel> extends StatelessWidget {
  final List<ExpensesModel> dataList;
  final BuildContext context;

  final Function(int)? onDoubleTap;

  const ExpenseTable({
    required this.context,
    super.key,
    this.onDoubleTap,
    required this.dataList,
  });

  /// a columns List
  static List<CustomDataColumn> get culumnsList => [
        CustomDataColumn(title: "id", columnSize: ColumnSize.S, numeric: true),
        CustomDataColumn(title: "expenseName", columnSize: ColumnSize.L),
        CustomDataColumn(title: "expenseValue", columnSize: ColumnSize.L),
        CustomDataColumn(title: "expenseDate", columnSize: ColumnSize.L),
        CustomDataColumn(title: "category", columnSize: ColumnSize.L),
      ];

  @override
  Widget build(BuildContext context) {
    return GenericTableWidget<ExpensesModel>(
      columnsList: culumnsList,
      rowsList: _getRows(),
    );
  }

  List<DataRow> _getRows() {
    return dataList
        .mapIndexed((i, e) => TableHelper<ExpensesModel>(
              // isSelected: e.isSelected,
              // onSelect: (v) {
              //   dataList[i].isSelected = !dataList[i].isSelected;
              // },
              dataList: dataList,
              getCells: (w) => _getCells(w, context),
            ).getRow(i))
        .toList();
  }

  List<DataCell> _getCells(ExpensesModel s, BuildContext context) {
    return [
      DataCell(
        Text(
          "${s.id?.toString().trim()}",
          style: TextStyleHelper.of(context).bodyLarge16R,
          textAlign: TextAlign.center,
        ).centerWhen(true),
      ),
      DataCell(
        Text(s.expenseName?.trim() ?? "",
                style: TextStyleHelper.of(context).bodyLarge16R,
                textAlign: TextAlign.center)
            .centerWhen(true),
      ),
      DataCell(
        Text("${s.expenseValue?.toString().trim()}",
                style: TextStyleHelper.of(context).bodyLarge16R,
                textAlign: TextAlign.center)
            .centerWhen(true),
      ),
      DataCell(
        Text(s.expenseDate?.dmy.toString() ?? "",
                style: TextStyleHelper.of(context).bodyLarge16R,
                textAlign: TextAlign.center)
            .centerWhen(true),
      ),
      DataCell(
        Text(s.category?.trim() ?? "",
                style: TextStyleHelper.of(context).bodyLarge16R,
                textAlign: TextAlign.center)
            .centerWhen(true),
      )
    ];
  }
}

extension DateFormter on DateTime {
  String get dmy => DateFormat('yyyy-MM-dd').format(this);
}
