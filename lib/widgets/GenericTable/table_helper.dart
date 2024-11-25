import 'package:flutter/material.dart';

class TableHelper<T> extends DataTableSource {
  final Function(bool value)? onSelect;
  final TextStyle? style;
  final bool isSelected;
  final List<T> dataList;
  final List<DataCell> Function(T item) getCells;

  TableHelper({
    this.onSelect,
    required this.dataList,
    required this.getCells,
    this.style,
    this.isSelected = false,
  });
  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(

      selected: isSelected,
      color: WidgetStatePropertyAll(
        isSelected ? Colors.amber : Colors.transparent,
      ),
      onSelectChanged: (v) {
        if (onSelect != null) {
          onSelect!(v!);
        }
      },
      index: index,
      cells: getCells(

        dataList[index],
      ),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataList.length;

  @override
  int get selectedRowCount => dataList.length;
}
