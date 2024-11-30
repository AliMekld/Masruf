import 'package:collection/collection.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:masrof/core/theme/typography.dart';
import 'package:masrof/utilites/extensions.dart';
import 'package:masrof/widgets/Dialogs/settings_dialog.dart';
import 'package:masrof/widgets/DialogsHelper/dialog_widget.dart';
import 'package:masrof/widgets/GenericTable/table_helper.dart';
import 'package:masrof/widgets/GenericTable/table_widget.dart';
import 'package:masrof/models/expense_model.dart';

// ignore: must_be_immutable
class ExpenseTable<T extends ExpensesModel> extends StatefulWidget {
  /// todo nrmy da fe el zebala wncreate table ndeef b3d manzakr ezay el tables bttcreate
  List<ExpensesModel> expensesList;
  final BuildContext context;

  ExpenseTable({
    required this.context,
    super.key,
    required this.expensesList,
  });

  @override
  State<ExpenseTable> createState() => _ExpenseTableState();
}

class _ExpenseTableState<T extends ExpensesModel>
    extends State<ExpenseTable<T>> {
  /// a columns List
  List<CustomDataColumn> get culumnsList => [
        CustomDataColumn(
          title: "id",
          columnSize: ColumnSize.S,
          numeric: true,
          onSort: (index, asend) {
            setState(() {
              widget.expensesList.sort.call((a, b) {
                final aId = a.id ?? 0;
                final bId = b.id ?? 0;
                return asend ? aId.compareTo(bId) : bId.compareTo(aId);
              });
            });
          },
        ),
        CustomDataColumn(title: "expenseName", columnSize: ColumnSize.L),
        CustomDataColumn(title: "expenseValue", columnSize: ColumnSize.L),
        CustomDataColumn(title: "expenseDate", columnSize: ColumnSize.L),
        CustomDataColumn(title: "category", columnSize: ColumnSize.L),
      ];

  @override
  Widget build(BuildContext context) {
    return GenericTableWidget<ExpensesModel>(
      minWidth: widget.expensesList.length * 180,
      onSelectAll: (v) {
        widget.expensesList =
            widget.expensesList.map((e) => e.copyWith(isSelected: v)).toList();
        setState(() {});
      },
      columnsList: culumnsList,
      rowsList: _getRows(),
    );
  }

  List<DataRow2> _getRows() {
    return widget.expensesList
        .mapIndexed((i, e) => TableHelper<ExpensesModel>(
              context: context,
              onDoubleTap: (index) {
                const DialogHelper.customDialog(child: SettingsDialog())
                    .showDialog(context);
              },
              isSelected: widget.expensesList[i].isSelected,
              onSelect: (v) {
                widget.expensesList[i].isSelected = v;
                setState(() {});
              },
              dataList: widget.expensesList,
              getCells: (w) => _getCells(w, widget.context),
            ).getRow(i))
        .toList();
  }

  List<DataCell> _getCells(ExpensesModel expenseModel, BuildContext context) {
    return [
      DataCell(
        Text(
          "${expenseModel.id?.toString().trim()}",
          style: TextStyleHelper.of(context).bodyLarge16R,
          textAlign: TextAlign.center,
        ).centerWhen(true),
      ),
      DataCell(
        Text(expenseModel.expenseName?.trim() ?? "",
                style: TextStyleHelper.of(context).bodyLarge16R,
                textAlign: TextAlign.center)
            .centerWhen(true),
      ),
      DataCell(
        Text("${expenseModel.expenseValue?.toString().trim()}",
                style: TextStyleHelper.of(context).bodyLarge16R,
                textAlign: TextAlign.center)
            .centerWhen(true),
      ),
      DataCell(
        Text(expenseModel.expenseDate?.dmy.toString() ?? "",
                style: TextStyleHelper.of(context).bodyLarge16R,
                textAlign: TextAlign.center)
            .centerWhen(true),
      ),
      DataCell(
        Text(expenseModel.category?.trim() ?? "",
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
