import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../dues_detail/dues_detail_model.dart';
import '../user/user_model.dart';

part 'dues_citizen_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class DuesCitizenModel extends Equatable {
  const DuesCitizenModel({
    this.citizen = const UserModel(),
    this.dues = const [],
  });

  final UserModel citizen;
  final List<DuesDetailModel> dues;

  factory DuesCitizenModel.fromJson(Map<String, dynamic> json) => _$DuesCitizenModelFromJson(json);
  Map<String, dynamic> toJson() => _$DuesCitizenModelToJson(this);

  @override
  List<Object> get props => [citizen, dues];

  @override
  String toString() => 'DuesCitizenModel(citizen: $citizen, dues: $dues)';

  DuesCitizenModel copyWith({
    UserModel? citizen,
    List<DuesDetailModel>? dues,
  }) {
    return DuesCitizenModel(
      citizen: citizen ?? this.citizen,
      dues: dues ?? this.dues,
    );
  }
}
