import 'package:dio/dio.dart';

import '../../model/authentication/authentication_response.dart';
import '../../model/user/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<AuthenticationResponse> login({
    required String username,
    required String password,
  });
}

class AuthenticationRemoteDataSourceImpl implements AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSourceImpl({
    required this.dioClient,
  });

  final Dio dioClient;

  @override
  Future<AuthenticationResponse> login({
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
    final token = response['token'];
    final message = response['message'];
    return AuthenticationResponse(
      token: token,
      user: user,
      message: message,
    );
  }
}
