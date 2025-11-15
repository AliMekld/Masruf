import 'package:collection/collection.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:masrof/core/Language/app_localization.dart';
import 'package:masrof/core/theme/color_pallete.dart';
import 'package:masrof/core/theme/typography.dart';
import 'package:masrof/models/drop_down_model.dart';
import 'package:masrof/utilities/constants/Strings.dart';
import 'package:masrof/utilities/extensions.dart';
import 'package:masrof/widgets/Dialogs/categoty_dialog_detail_widget.dart';
import 'package:masrof/widgets/DialogsHelper/dialog_widget.dart';
import 'package:masrof/widgets/GenericTable/table_helper.dart';
import 'package:masrof/widgets/GenericTable/table_widget.dart';
import 'package:masrof/models/expense_model.dart';

// ignore: must_be_immutable
class CategoriesTable<T extends DropdownModel> extends StatefulWidget {
  /// todo nrmy da fe el zebala wncreate table ndeef b3d manzakr ezay el tables bttcreate
  List<DropdownModel> categoriesList;
  final BuildContext context;
  final Function(DropdownModel) onEditCategory;
  final Function(int) onDeleteCategory;

  CategoriesTable({
    required this.context,
    super.key,
    required this.categoriesList,
    required this.onEditCategory,
    required this.onDeleteCategory,
  });

  @override
  State<CategoriesTable> createState() => _CategoriesTableState();
}

class _CategoriesTableState<T extends DropdownModel>
    extends State<CategoriesTable<T>> {
  /// a columns List
  List<CustomDataColumn> getCulumnsList(BuildContext context) => [
        CustomDataColumn(
          title: AppLocalizations.of(context)?.translate(Strings.id) ?? "",
          columnSize: ColumnSize.S,
          numeric: true,
          onSort: (index, asend) {
            setState(() {
              widget.categoriesList.sort.call((a, b) {
                final aId = a.id ?? 0;
                final bId = b.id ?? 0;
                return asend ? aId.compareTo(bId) : bId.compareTo(aId);
              });
            });
          },
        ),
        CustomDataColumn(title: Strings.name.tr, columnSize: ColumnSize.L),
        CustomDataColumn(title: Strings.eName.tr, columnSize: ColumnSize.L),
        CustomDataColumn(title: Strings.delete.tr, columnSize: ColumnSize.S),
      ];

  @override
  Widget build(BuildContext context) {
    return GenericTableWidget<ExpensesModel>(
      minWidth: getCulumnsList(context).length * 96.w,
      onSelectAll: (v) {
        widget.categoriesList =
            widget.categoriesList.map((e) => e.copyWith(selected: v)).toList();
        setState(() {});
      },
      columnsList: getCulumnsList(context),
      rowsList: _getRows(),
    );
  }

  List<DataRow2> _getRows() {
    return widget.categoriesList
        .mapIndexed((i, e) => TableHelper<DropdownModel>(
              context: context,
              onDoubleTap: (index) {
                if (widget.categoriesList[index].id != null) {
                  DialogHelper.customDialog(
                      child: CategoryDialogDetailWidget(
                    onEditCategory: (model) => widget.onEditCategory(model),
                    id: widget.categoriesList[index].id,
                  )).showDialog(context);
                }
              },
              isSelected: widget.categoriesList[i].selected,
              onSelect: (v) {
                widget.categoriesList[i].selected = v;
                setState(() {});
              },
              dataList: widget.categoriesList,
              getCells: (w) => _getCells(w, widget.context),
            ).getRow(i))
        .toList();
  }

  List<DataCell> _getCells(DropdownModel expenseModel, BuildContext context) {
    return [
      DataCell(
        Text(
          "${expenseModel.id?.toString().trim()}",
          style: TextStyleHelper.of(context).bodyLarge16R,
          textAlign: TextAlign.center,
        ).centerWhen(true),
      ),
      DataCell(
        Text(expenseModel.name ?? "",
                style: TextStyleHelper.of(context).bodyLarge16R,
                textAlign: TextAlign.center)
            .centerWhen(true),
      ),
      DataCell(
        Text(expenseModel.eName ?? "",
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
                  message: Strings.deleteCategoryWarningMessage.tr,
                  onConfirm: () {
                    widget.onDeleteCategory(expenseModel.id!);
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
