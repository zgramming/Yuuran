import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_group_model.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum UserGroupCode {
  @JsonValue("superadmin")
  superadmin,
  @JsonValue("warga")
  warga,
  @JsonValue("bendahara")
  bendahara
}

String getUserGroupCodeText(UserGroupCode type) {
  switch (type) {
    case UserGroupCode.bendahara:
      return "bendahara";
    case UserGroupCode.warga:
      return "warga";
    case UserGroupCode.superadmin:
      return "superadmin";
    default:
      return "";
  }
}

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class UserGroup extends Equatable {
  const UserGroup({
    this.id,
    this.code = UserGroupCode.superadmin,
    this.name,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final UserGroupCode code;
  final String? name;
  final String? status;
  final int? createdBy;
  final int? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory UserGroup.fromJson(Map<String, dynamic> json) => _$UserGroupFromJson(json);
  Map<String, dynamic> toJson() => _$UserGroupToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      code,
      name,
      status,
      createdBy,
      updatedBy,
      createdAt,
      updatedAt,
    ];
  }

  @override
  String toString() {
    return 'UserGroup(id: $id, code: $code, name: $name, status: $status, createdBy: $createdBy, updatedBy: $updatedBy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  UserGroup copyWith({
    int? id,
    UserGroupCode? code,
    String? name,
    String? status,
    int? createdBy,
    int? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserGroup(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
