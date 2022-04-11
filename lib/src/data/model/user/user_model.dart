import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../user_group/user_group_model.dart';

part 'user_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel extends Equatable {
  const UserModel({
    this.id,
    this.appGroupUserId,
    this.username = '',
    this.name = '',
    this.email = '',
    this.emailVerifiedAt,
    this.status = '',
    this.profileImage,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.userGroup = const UserGroup(),
  });

  final int? id;
  final int? appGroupUserId;
  final String username;
  final String name;
  final String email;
  final DateTime? emailVerifiedAt;
  final String status;
  final String? profileImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? createdBy;
  final int? updatedBy;
  final UserGroup userGroup;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      appGroupUserId,
      username,
      name,
      email,
      emailVerifiedAt,
      status,
      profileImage,
      createdAt,
      updatedAt,
      createdBy,
      updatedBy,
      userGroup,
    ];
  }

  @override
  String toString() {
    return 'UserModel(id: $id, appGroupUserId: $appGroupUserId, username: $username, name: $name, email: $email, emailVerifiedAt: $emailVerifiedAt, status: $status, profileImage: $profileImage, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy, userGroup: $userGroup)';
  }

  UserModel copyWith({
    int? id,
    int? appGroupUserId,
    String? username,
    String? name,
    String? email,
    DateTime? emailVerifiedAt,
    String? status,
    String? profileImage,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? createdBy,
    int? updatedBy,
    UserGroup? userGroup,
  }) {
    return UserModel(
      id: id ?? this.id,
      appGroupUserId: appGroupUserId ?? this.appGroupUserId,
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      status: status ?? this.status,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      userGroup: userGroup ?? this.userGroup,
    );
  }
}
