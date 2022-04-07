import 'package:dio/dio.dart';

import '../../model/dues_detail/dues_detail_model.dart';

abstract class DuesCalendarRemoteDataSource {
  Future<List<DuesDetailModel>> get({
    int? month,
    int? year,
  });
}

class DuesCalendarRemoteDataSourceImpl implements DuesCalendarRemoteDataSource {
  const DuesCalendarRemoteDataSourceImpl({
    required this.dioClient,
  });
  final Dio dioClient;

  @override
  Future<List<DuesDetailModel>> get({
    int? month,
    int? year,
  }) async {
    final result = await dioClient.get(
      "/dues/calendar",
      queryParameters: {
        "month": month,
        "year": year,
      },
    );

    final response = result.data as Map<String, dynamic>;
    final list = List.from(response['data']);
    final listCalendar = list
        .map(
          (e) => DuesDetailModel.fromJson(Map<String, dynamic>.from(e)),
        )
        .toList();
    return listCalendar;
  }
}
