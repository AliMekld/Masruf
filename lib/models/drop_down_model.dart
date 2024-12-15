import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'drop_down_model.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class DropdownModel {
  @JsonKey(includeToJson: false, includeFromJson: false)
  bool selected;
  final int? id;
  final String? name;
  final String? eName;

  DropdownModel({
    this.id,
    this.name,
    this.eName,
    this.selected = false,
  });
  factory DropdownModel.fromJson(Map<String, dynamic> json) =>
      _$DropdownModelFromJson(json);

  Map<String, dynamic> toJson() => _$DropdownModelToJson(this);

  // factory DropdownModel.fromJson(Map<String, dynamic> json) => DropdownModel(
  //       id: json["id"] as int?,
  //       eName: json["eName"] as String?,
  //       name: json["name"] as String?,
  //     );
  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "name": name,
  //       "eName": eName,
  //     };
}
