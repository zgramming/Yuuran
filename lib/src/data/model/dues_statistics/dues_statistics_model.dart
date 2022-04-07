import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../dues_category/dues_category_model.dart';

part 'dues_statistics_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class DuesStatisticsModel extends Equatable {
  const DuesStatisticsModel({
    this.totalCitizen = 0,
    this.duesCategory = const [],
  });

  final int totalCitizen;
  final List<DuesCategoryModel> duesCategory;

  factory DuesStatisticsModel.fromJson(Map<String, dynamic> json) =>
      _$DuesStatisticsModelFromJson(json);
  Map<String, dynamic> toJson() => _$DuesStatisticsModelToJson(this);

  @override
  List<Object> get props => [totalCitizen, duesCategory];

  @override
  String toString() =>
      'DuesStatisticsModel(totalCitizen: $totalCitizen, duesCategory: $duesCategory)';

  DuesStatisticsModel copyWith({
    int? totalCitizen,
    List<DuesCategoryModel>? duesCategory,
  }) {
    return DuesStatisticsModel(
      totalCitizen: totalCitizen ?? this.totalCitizen,
      duesCategory: duesCategory ?? this.duesCategory,
    );
  }
}
