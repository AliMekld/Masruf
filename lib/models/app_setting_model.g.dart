// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_setting_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AppSettingsCWProxy {
  AppSettings appName(String? appName);

  AppSettings path(String? path);

  AppSettings host(String? host);

  AppSettings schema(String? schema);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AppSettings(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AppSettings(...).copyWith(id: 12, name: "My name")
  /// ````
  AppSettings call({
    String? appName,
    String? path,
    String? host,
    String? schema,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAppSettings.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAppSettings.copyWith.fieldName(...)`
class _$AppSettingsCWProxyImpl implements _$AppSettingsCWProxy {
  const _$AppSettingsCWProxyImpl(this._value);

  final AppSettings _value;

  @override
  AppSettings appName(String? appName) => this(appName: appName);

  @override
  AppSettings path(String? path) => this(path: path);

  @override
  AppSettings host(String? host) => this(host: host);

  @override
  AppSettings schema(String? schema) => this(schema: schema);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AppSettings(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AppSettings(...).copyWith(id: 12, name: "My name")
  /// ````
  AppSettings call({
    Object? appName = const $CopyWithPlaceholder(),
    Object? path = const $CopyWithPlaceholder(),
    Object? host = const $CopyWithPlaceholder(),
    Object? schema = const $CopyWithPlaceholder(),
  }) {
    return AppSettings(
      appName: appName == const $CopyWithPlaceholder()
          ? _value.appName
          // ignore: cast_nullable_to_non_nullable
          : appName as String?,
      path: path == const $CopyWithPlaceholder()
          ? _value.path
          // ignore: cast_nullable_to_non_nullable
          : path as String?,
      host: host == const $CopyWithPlaceholder()
          ? _value.host
          // ignore: cast_nullable_to_non_nullable
          : host as String?,
      schema: schema == const $CopyWithPlaceholder()
          ? _value.schema
          // ignore: cast_nullable_to_non_nullable
          : schema as String?,
    );
  }
}

extension $AppSettingsCopyWith on AppSettings {
  /// Returns a callable class that can be used as follows: `instanceOfAppSettings.copyWith(...)` or like so:`instanceOfAppSettings.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AppSettingsCWProxy get copyWith => _$AppSettingsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) => AppSettings(
      appName: json['appName'] as String?,
      path: json['path'] as String?,
      host: json['host'] as String?,
      schema: json['schema'] as String?,
    );

Map<String, dynamic> _$AppSettingsToJson(AppSettings instance) =>
    <String, dynamic>{
      'appName': instance.appName,
      'schema': instance.schema,
      'host': instance.host,
      'path': instance.path,
    };
