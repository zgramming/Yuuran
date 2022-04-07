import 'package:dio/dio.dart';

import '../../model/user/user_model.dart';

abstract class CitizenRemoteDataSource {
  Future<List<UserModel>> get();
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
}
