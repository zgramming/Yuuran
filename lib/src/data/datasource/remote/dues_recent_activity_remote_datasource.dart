import 'package:dio/dio.dart';

import '../../model/dues_detail/dues_detail_model.dart';

abstract class DuesRecentActivityRemoteDataSource {
  Future<List<DuesDetailModel>> get({
    int? month,
    int? year,
    int? limit,
  });
}

class DuesRecentActivityRemoteDataSourceImpl implements DuesRecentActivityRemoteDataSource {
  const DuesRecentActivityRemoteDataSourceImpl({
    required this.dioClient,
  });
  final Dio dioClient;
  @override
  Future<List<DuesDetailModel>> get({
    int? month,
    int? year,
    int? limit,
  }) async {
    final result = await dioClient.get("/dues/recent-activity", queryParameters: {
      "month": month,
      "year": year,
      "limit": limit,
    });

    final response = result.data as Map<String, dynamic>;
    final list = List.from(response['data']);
    final listDuesDetail = list
        .map(
          (e) => DuesDetailModel.fromJson(Map<String, dynamic>.from(e)),
        )
        .toList();

    return listDuesDetail;
  }
}
