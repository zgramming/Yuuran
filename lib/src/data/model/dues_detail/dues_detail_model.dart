import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../dues_category/dues_category_model.dart';
import '../user/user_model.dart';

part 'dues_detail_model.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum StatusPaid {
  @JsonValue("paid_off")
  paidOff,
  @JsonValue("not_paid_off")
  notPaidOff,
  @JsonValue("none")
  none,
}

String getStatusPaidText(StatusPaid status) {
  switch (status) {
    case StatusPaid.notPaidOff:
      return 'not_paid_off';
    case StatusPaid.paidOff:
      return 'paid_off';
    default:
      return 'none';
  }
}

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class DuesDetailModel extends Equatable {
  const DuesDetailModel({
    this.id,
    this.duesCategoryId,
    this.usersId,
    this.month,
    this.year,
    this.amount = 0,
    this.status = StatusPaid.notPaidOff,
    this.description = "",
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.duesCategory,
  });

  final String? id;
  final int? duesCategoryId;
  final int? usersId;
  final int? month;
  final int? year;
  final int amount;
  final StatusPaid status;
  final String description;
  final int? createdBy;
  final int? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserModel? user;
  final DuesCategoryModel? duesCategory;

  factory DuesDetailModel.fromJson(Map<String, dynamic> json) => _$DuesDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$DuesDetailModelToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      duesCategoryId,
      usersId,
      month,
      year,
      amount,
      status,
      description,
      createdBy,
      updatedBy,
      createdAt,
      updatedAt,
      user,
      duesCategory,
    ];
  }

  @override
  String toString() {
    return 'DuesDetailModel(id: $id, duesCategoryId: $duesCategoryId, usersId: $usersId, month: $month, year: $year, amount: $amount, status: $status, description: $description, createdBy: $createdBy, updatedBy: $updatedBy, createdAt: $createdAt, updatedAt: $updatedAt, user: $user, duesCategory: $duesCategory)';
  }

  DuesDetailModel copyWith({
    String? id,
    int? duesCategoryId,
    int? usersId,
    int? month,
    int? year,
    int? amount,
    StatusPaid? status,
    String? description,
    int? createdBy,
    int? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserModel? user,
    DuesCategoryModel? duesCategory,
  }) {
    return DuesDetailModel(
      id: id ?? this.id,
      duesCategoryId: duesCategoryId ?? this.duesCategoryId,
      usersId: usersId ?? this.usersId,
      month: month ?? this.month,
      year: year ?? this.year,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
      duesCategory: duesCategory ?? this.duesCategory,
    );
  }
}
