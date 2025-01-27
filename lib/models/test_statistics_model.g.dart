// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_statistics_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StatisticsModelCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// StatisticsModel(...).copyWith(id: 12, name: "My name")
  /// ````
  StatisticsModel call({
    int? id,
    DateTime? lastUpdated,
    double? netSavings,
    double? totalExpenses,
    double? totalIncome,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStatisticsModel.copyWith(...)`.
class _$StatisticsModelCWProxyImpl implements _$StatisticsModelCWProxy {
  const _$StatisticsModelCWProxyImpl(this._value);

  final StatisticsModel _value;

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// StatisticsModel(...).copyWith(id: 12, name: "My name")
  /// ````
  StatisticsModel call({
    Object? id = const $CopyWithPlaceholder(),
    Object? lastUpdated = const $CopyWithPlaceholder(),
    Object? netSavings = const $CopyWithPlaceholder(),
    Object? totalExpenses = const $CopyWithPlaceholder(),
    Object? totalIncome = const $CopyWithPlaceholder(),
  }) {
    return StatisticsModel(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      lastUpdated: lastUpdated == const $CopyWithPlaceholder()
          ? _value.lastUpdated
          // ignore: cast_nullable_to_non_nullable
          : lastUpdated as DateTime?,
      netSavings: netSavings == const $CopyWithPlaceholder()
          ? _value.netSavings
          // ignore: cast_nullable_to_non_nullable
          : netSavings as double?,
      totalExpenses: totalExpenses == const $CopyWithPlaceholder()
          ? _value.totalExpenses
          // ignore: cast_nullable_to_non_nullable
          : totalExpenses as double?,
      totalIncome: totalIncome == const $CopyWithPlaceholder()
          ? _value.totalIncome
          // ignore: cast_nullable_to_non_nullable
          : totalIncome as double?,
    );
  }
}

extension $StatisticsModelCopyWith on StatisticsModel {
  /// Returns a callable class that can be used as follows: `instanceOfStatisticsModel.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$StatisticsModelCWProxy get copyWith => _$StatisticsModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticsModel _$StatisticsModelFromJson(Map<String, dynamic> json) =>
    StatisticsModel(
      id: (json['id'] as num?)?.toInt(),
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
      netSavings: (json['netSavings'] as num?)?.toDouble(),
      totalExpenses: (json['totalExpenses'] as num?)?.toDouble(),
      totalIncome: (json['totalIncome'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StatisticsModelToJson(StatisticsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'totalIncome': instance.totalIncome,
      'totalExpenses': instance.totalExpenses,
      'netSavings': instance.netSavings,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
    };
