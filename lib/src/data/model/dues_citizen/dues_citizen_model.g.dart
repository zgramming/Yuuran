// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dues_citizen_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DuesCitizenModel _$DuesCitizenModelFromJson(Map<String, dynamic> json) =>
    DuesCitizenModel(
      citizen: json['citizen'] == null
          ? const UserModel()
          : UserModel.fromJson(json['citizen'] as Map<String, dynamic>),
      dues: (json['dues'] as List<dynamic>?)
              ?.map((e) => DuesDetailModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$DuesCitizenModelToJson(DuesCitizenModel instance) =>
    <String, dynamic>{
      'citizen': instance.citizen,
      'dues': instance.dues,
    };
