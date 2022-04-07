// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dues_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DuesCategoryModel _$DuesCategoryModelFromJson(Map<String, dynamic> json) =>
    DuesCategoryModel(
      id: json['id'] as int? ?? 0,
      code: json['code'] as String? ?? '',
      name: json['name'] as String? ?? '',
      amount: json['amount'] as int? ?? 0,
      description: json['description'] as String? ?? '',
      status: json['status'] as String? ?? '',
      createdBy: json['created_by'] as int?,
      updatedBy: json['updated_by'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      duesDetail: (json['dues_detail'] as List<dynamic>?)
              ?.map((e) => DuesDetailModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$DuesCategoryModelToJson(DuesCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'amount': instance.amount,
      'description': instance.description,
      'status': instance.status,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'dues_detail': instance.duesDetail,
    };
