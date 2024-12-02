import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:masrof/core/Language/app_localization.dart';
import 'package:masrof/core/theme/color_pallete.dart';
import 'package:masrof/core/theme/typography.dart';
import 'package:masrof/utilites/constants/Strings.dart';
import 'package:masrof/utilites/extensions.dart';
import 'package:masrof/widgets/Dialogs/expenses_dialog_detail_widget.dart';
import 'package:masrof/widgets/DialogsHelper/dialog_widget.dart';
import 'package:masrof/widgets/GenericTable/table_helper.dart';
import 'package:masrof/widgets/GenericTable/table_widget.dart';
import 'package:masrof/models/expense_model.dart';

// ignore: must_be_immutable
class ExpenseTable<T extends ExpensesModel> extends StatefulWidget {
  /// todo nrmy da fe el zebala wncreate table ndeef b3d manzakr ezay el tables bttcreate
  List<ExpensesModel> expensesList;
  final BuildContext context;
  final Function(ExpensesModel) onEditExpense;
  final Function(int) onDeleteExpense;

  ExpenseTable({
    required this.context,
    super.key,
    required this.expensesList,
    required this.onEditExpense,
    required this.onDeleteExpense,
  });

  @override
  State<ExpenseTable> createState() => _ExpenseTableState();
}

class _ExpenseTableState<T extends ExpensesModel>
    extends State<ExpenseTable<T>> {
  /// a columns List
  List<CustomDataColumn> getCulumnsList(BuildContext context) => [
        CustomDataColumn(
          title:
              AppLocalizations.of(context)?.translate(Strings.expenseNumber) ??
                  "",
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
        CustomDataColumn(
            title: Strings.expenseName.tr, columnSize: ColumnSize.L),
        CustomDataColumn(
            title: Strings.expenseValue.tr, columnSize: ColumnSize.L),
        CustomDataColumn(
            title: Strings.expenseDate.tr, columnSize: ColumnSize.L),
        CustomDataColumn(
            title: Strings.expenseCategory.tr, columnSize: ColumnSize.L),
        CustomDataColumn(title: Strings.delete.tr, columnSize: ColumnSize.S),
      ];

  @override
  Widget build(BuildContext context) {
    return GenericTableWidget<ExpensesModel>(

      minWidth: widget.expensesList.length * 80,
      onSelectAll: (v) {
        widget.expensesList =
            widget.expensesList.map((e) => e.copyWith(isSelected: v)).toList();
        setState(() {});
      },
      columnsList: getCulumnsList(context),
      rowsList: _getRows(),
    );
  }

  List<DataRow2> _getRows() {
    return widget.expensesList
        .mapIndexed((i, e) => TableHelper<ExpensesModel>(
              context: context,
              onDoubleTap: (index) {
                DialogHelper.customDialog(
                    child: ExpensesDialogDetailWidget(
                  onEditExpense: (model) => widget.onEditExpense(model),
                  model: widget.expensesList[index],
                )).showDialog(context);
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
      ),
      DataCell(
        IconButton(
          hoverColor: ColorsPalette.of(context).errorColor,
          onPressed: () {
            if (expenseModel.id != null) {
              DialogHelper.delete(
                  message: Strings.deleteExpensesWarningMessage.tr,
                  onConfirm: () {
                    widget.onDeleteExpense(expenseModel.id!);
                    context.pop();
                  }).showDialog(context);
            }
          },
          icon: Icon(
            Icons.delete,
            size: 28.r,
            color: ColorsPalette.of(context).iconColor,
          ),
        ).centerWhen(true),
      )
    ];
  }
}

extension DateFormter on DateTime {
  String get dmy => DateFormat('yyyy-MM-dd').format(this);
}
