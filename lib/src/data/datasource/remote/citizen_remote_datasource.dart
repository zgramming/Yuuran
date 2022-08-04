import 'package:dio/dio.dart';

import '../../model/user/user_model.dart';

abstract class CitizenRemoteDataSource {
  Future<List<UserModel>> get();
  Future<UserModel?> getByID(int id);

  Future<String> saveCitizen({
    required int? id,
    required String username,
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  });
}

class CitizenRemoteDataSourceImpl implements CitizenRemoteDataSource {
  const CitizenRemoteDataSourceImpl({
    required this.dioClient,
  });
  final Dio dioClient;

  @override
  Future<List<UserModel>> get() async {
    final result = await dioClient.get("/citizen");
    final response = result.data as Map<String, dynamic>;
    final list = List.from(response['data']);
    final citizenList = list
        .map(
          (e) => UserModel.fromJson(Map<String, dynamic>.from(e)),
        )
        .toList();

    return citizenList;
  }

  @override
  Future<UserModel?> getByID(int id) async {
    final result = await dioClient.get("/citizen/$id");
    final response = result.data as Map<String, dynamic>;
    if (response['data'] == null) return null;

    final user = UserModel.fromJson(Map<String, dynamic>.from(response['data']));
    return user;
  }

  @override
  Future<String> saveCitizen({
    required int? id,
    required String username,
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    final url = "/citizen/save/${id ?? 0}";
    final formData = FormData.fromMap({
      "username": username,
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
    });
    final result = await dioClient.post(url, data: formData);
    final response = result.data as Map<String, dynamic>;
    final message = response['message'] as String;
    return message;
  }
}
