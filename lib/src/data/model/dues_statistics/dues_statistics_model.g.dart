// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dues_statistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DuesStatisticsModel _$DuesStatisticsModelFromJson(Map<String, dynamic> json) =>
    DuesStatisticsModel(
      totalCitizen: json['total_citizen'] as int? ?? 0,
      duesCategory: (json['dues_category'] as List<dynamic>?)
              ?.map(
                  (e) => DuesCategoryModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$DuesStatisticsModelToJson(
        DuesStatisticsModel instance) =>
    <String, dynamic>{
      'total_citizen': instance.totalCitizen,
      'dues_category': instance.duesCategory,
    };
