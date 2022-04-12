// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserGroup _$UserGroupFromJson(Map<String, dynamic> json) => UserGroup(
      id: json['id'] as int?,
      code: $enumDecodeNullable(_$UserGroupCodeEnumMap, json['code']) ??
          UserGroupCode.superadmin,
      name: json['name'] as String?,
      status: json['status'] as String?,
      createdBy: json['created_by'] as int?,
      updatedBy: json['updated_by'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$UserGroupToJson(UserGroup instance) => <String, dynamic>{
      'id': instance.id,
      'code': _$UserGroupCodeEnumMap[instance.code],
      'name': instance.name,
      'status': instance.status,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$UserGroupCodeEnumMap = {
  UserGroupCode.superadmin: 'superadmin',
  UserGroupCode.warga: 'warga',
  UserGroupCode.bendahara: 'bendahara',
};
