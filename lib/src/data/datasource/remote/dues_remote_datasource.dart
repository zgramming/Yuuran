import 'package:dio/dio.dart';

import '../../model/dues_category/dues_category_model.dart';
import '../../model/dues_detail/dues_detail_model.dart';
import '../../model/dues_statistics/dues_statistics_model.dart';

abstract class DuesRemoteDataSource {
  Future<List<DuesDetailModel>> getDuesByUsername({
    required String name,
    int? month,
    int? year,
    int? duesCategoryId,
  });

  Future<DuesStatisticsModel> getStatistics({int? month, int? year});

  Future<List<DuesDetailModel>> getRecentActivity({int? month, int? year, int? limit});

  Future<List<DuesDetailModel>> getCalendarActivity({int? month, int? year});

  Future<List<DuesCategoryModel>> getDuesCategory();

  Future<String> saveDues(
    String duesDetailId, {
    required int duesCategoryId,
    required int usersId,
    required int month,
    required int year,
    required int amount,
    required StatusPaid status,
    required bool paidBySomeoneElse,
    required int createdBy,
    String? description,
  });
}

class DuesRemoteDataSourceImpl implements DuesRemoteDataSource {
  const DuesRemoteDataSourceImpl({
    required this.dioClient,
  });

  final Dio dioClient;

  @override
  Future<List<DuesDetailModel>> getDuesByUsername({
    required String name,
    int? month,
    int? year,
    int? duesCategoryId,
  }) async {
    final result = await dioClient.get("/dues/citizen/$name", queryParameters: {
      "month": month,
      "year": year,
      "duesCategory": duesCategoryId,
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

  @override
  Future<DuesStatisticsModel> getStatistics({int? month, int? year}) async {
    final result = await dioClient.get("/dues/statistics", queryParameters: {
      "month": month,
      "year": year,
    });

    final response = result.data as Map<String, dynamic>;
    final duesStatistics = DuesStatisticsModel.fromJson(response['data']);
    return duesStatistics;
  }

  @override
  Future<List<DuesDetailModel>> getRecentActivity({int? month, int? year, int? limit}) async {
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

  @override
  Future<List<DuesDetailModel>> getCalendarActivity({int? month, int? year}) async {
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

  @override
  Future<List<DuesCategoryModel>> getDuesCategory() async {
    final result = await dioClient.get("/duesCategory");
    final response = result.data as Map<String, dynamic>;
    final list = List.from(response['data']);
    final listCategory = list
        .map(
          (e) => DuesCategoryModel.fromJson(Map<String, dynamic>.from(e)),
        )
        .toList();

    return listCategory;
  }

  @override
  Future<String> saveDues(
    String duesDetailId, {
    required int duesCategoryId,
    required int usersId,
    required int month,
    required int year,
    required int amount,
    required StatusPaid status,
    required bool paidBySomeoneElse,
    required int createdBy,
    String? description,
  }) async {
    final formData = FormData.fromMap({
      "dues_category_id": duesCategoryId,
      "users_id": usersId,
      "month": month,
      "year": year,
      "amount": amount,
      "status": getStatusPaidText(status),
      "paid_by_someone_else": paidBySomeoneElse ? 1 : 0,
      "description": description,
      "created_by": createdBy,
    });

    final result = await dioClient.post(
      "/dues/save/$duesDetailId",
      data: formData,
    );
    final response = result.data as Map<String, dynamic>;
    final message = response['message'];
    return message;
  }
}
