import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../dues_detail/dues_detail_model.dart';

part 'dues_category_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class DuesCategoryModel extends Equatable {
  const DuesCategoryModel({
    this.id = 0,
    this.code = '',
    this.name = '',
    this.amount = 0,
    this.description = '',
    this.status = '',
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.duesDetail = const [],
  });

  final int id;
  final String code;
  final String name;
  final int amount;
  final String description;
  final String status;
  final int? createdBy;
  final int? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<DuesDetailModel> duesDetail;

  factory DuesCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$DuesCategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$DuesCategoryModelToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      code,
      name,
      amount,
      description,
      status,
      createdBy,
      updatedBy,
      createdAt,
      updatedAt,
      duesDetail,
    ];
  }

  @override
  String toString() {
    return 'DuesCategoryModel(id: $id, code: $code, name: $name, amount: $amount, description: $description, status: $status, createdBy: $createdBy, updatedBy: $updatedBy, createdAt: $createdAt, updatedAt: $updatedAt, duesDetail: $duesDetail)';
  }

  DuesCategoryModel copyWith({
    int? id,
    String? code,
    String? name,
    int? amount,
    String? description,
    String? status,
    int? createdBy,
    int? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<DuesDetailModel>? duesDetail,
  }) {
    return DuesCategoryModel(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      duesDetail: duesDetail ?? this.duesDetail,
    );
  }
}
