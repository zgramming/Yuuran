import 'package:dio/dio.dart';

import '../../model/user/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> login({
    required String username,
    required String password,
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  const UserRemoteDataSourceImpl({
    required this.dioClient,
  });

  final Dio dioClient;

  @override
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    final formData = FormData.fromMap({
      "username": username,
      "password": password,
    });

    final result = await dioClient.post("/login", data: formData);
    final response = result.data as Map<String, dynamic>;
    final user = UserModel.fromJson(response['data']);
    return user;
  }
}
