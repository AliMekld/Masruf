import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'expense_model.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class ExpensesModel {
  bool isSelected;
  final int? id;
  final String? expenseName;
  final double? expenseValue;
  final DateTime? expenseDate;
  final String? category;

  ExpensesModel({
    this.id,
    this.expenseName,
    this.expenseValue,
    this.expenseDate,
    this.category,
    this.isSelected = false,
  });
  factory ExpensesModel.fromJson(Map<String, dynamic> json) =>
      _$ExpensesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExpensesModelToJson(this);
  Map<String, dynamic> toLocalJson() => {
        'id': id,
        'expenseName': expenseName,
        'expenseValue': expenseValue,
        'expenseDate': expenseDate?.toIso8601String(),
        'category': category,
      };
}
