import 'package:dio/dio.dart';

import '../../model/dues_statistics/dues_statistics_model.dart';

abstract class DuesStatisticsRemoteDataSource {
  Future<DuesStatisticsModel> get({
    int? month,
    int? year,
  });
}

class DuesStatisticsRemoteDataSourceImpl implements DuesStatisticsRemoteDataSource {
  const DuesStatisticsRemoteDataSourceImpl({
    required this.dioClient,
  });

  final Dio dioClient;

  @override
  Future<DuesStatisticsModel> get({
    int? month,
    int? year,
  }) async {
    final result = await dioClient.get("/dues/statistics", queryParameters: {
      "month": month,
      "year": year,
    });

    final response = result.data as Map<String, dynamic>;
    final duesStatistics = DuesStatisticsModel.fromJson(response['data']);
    return duesStatistics;
  }
}
