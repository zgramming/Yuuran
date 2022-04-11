// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dues_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DuesDetailModel _$DuesDetailModelFromJson(Map<String, dynamic> json) =>
    DuesDetailModel(
      id: json['id'] as String?,
      duesCategoryId: json['dues_category_id'] as int? ?? 0,
      usersId: json['users_id'] as int? ?? 0,
      month: json['month'] as int? ?? 0,
      year: json['year'] as int? ?? 0,
      amount: json['amount'] as int? ?? 0,
      status: $enumDecodeNullable(_$StatusPaidEnumMap, json['status']) ??
          StatusPaid.none,
      paidBySomeoneElse: json['paid_by_someone_else'] as int? ?? 0,
      description: json['description'] as String? ?? '',
      createdBy: json['created_by'] as int?,
      updatedBy: json['updated_by'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      duesCategory: json['dues_category'] == null
          ? null
          : DuesCategoryModel.fromJson(
              json['dues_category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DuesDetailModelToJson(DuesDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dues_category_id': instance.duesCategoryId,
      'users_id': instance.usersId,
      'month': instance.month,
      'year': instance.year,
      'amount': instance.amount,
      'status': _$StatusPaidEnumMap[instance.status],
      'paid_by_someone_else': instance.paidBySomeoneElse,
      'description': instance.description,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'user': instance.user,
      'dues_category': instance.duesCategory,
    };

const _$StatusPaidEnumMap = {
  StatusPaid.paidOff: 'paid_off',
  StatusPaid.notPaidOff: 'not_paid_off',
  StatusPaid.none: 'none',
};
