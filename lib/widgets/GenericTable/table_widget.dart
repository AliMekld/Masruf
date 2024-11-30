import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrof/core/theme/color_pallete.dart';
import 'package:masrof/core/theme/typography.dart';
import 'package:masrof/utilites/extensions.dart';

///todo make this widget generic but first lets create normal one
/// package data_table_2: ^2.5.15

///what this widget needs
/// 1- some model that represents rows
/// 2- some model that represents columns
/// 3-decoration of table
/// 4-maybe pagination
class GenericTableWidget<T> extends StatefulWidget {
  final List<DataRow> rowsList;
  final List<CustomDataColumn> columnsList;

  const GenericTableWidget({
    super.key,
    required this.rowsList,
    required this.columnsList,
  });

  @override
  State<StatefulWidget> createState() => _GenericTableWidgetState();
}

class _GenericTableWidgetState extends State<GenericTableWidget> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(dataTableTheme: const DataTableThemeData()),
      child: DataTable2(
        scrollController: ScrollController(),
        showBottomBorder: false,
        showHeadingCheckBox: false,
        columnSpacing: 4,
        empty: Text(
          "Empty!",
          style: TextStyleHelper.of(context).bodyLarge16R,
        ),

        /// Decorations
        isHorizontalScrollBarVisible: true,

        // headingRowHeight: 60.h,
        minWidth: ((widget.columnsList.length - 1) * 120.w),
        headingRowDecoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        headingRowColor: WidgetStatePropertyAll(
          ColorsPalette.of(context).primaryColor,
        ),
        border: TableBorder.all(
          color: ColorsPalette.of(context).primaryTextColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),

        /// mapping model into table culumn
        columns: widget.columnsList
            .map(
              (e) => DataColumn2(

                label: Text(
                  e.title,
                  style: TextStyleHelper.of(context)
                      .bodyLarge16R
                      .copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ).centerWhen(true),
                numeric: e.numeric ?? false,
                fixedWidth: e.fixedWidth,
                size: e.columnSize ?? ColumnSize.M,
                onSort: e.onSort,
              ),
            )
            .toList(),
        rows: widget.rowsList,
      ),
    );
  }
}

class CustomDataColumn {
  final ColumnSize? columnSize;
  final String title;
  final bool? numeric;
  final Function(int index, bool ascn)? onSort;
  final double? fixedWidth;

  CustomDataColumn({
    required this.title,
    this.numeric = false,
    this.onSort,
    this.columnSize,
    this.fixedWidth,
  });
}
