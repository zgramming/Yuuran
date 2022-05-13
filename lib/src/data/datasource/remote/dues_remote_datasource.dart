import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../model/dues_category/dues_category_model.dart';
import '../../model/dues_citizen/dues_citizen_model.dart';
import '../../model/dues_detail/dues_detail_model.dart';
import '../../model/dues_statistics/dues_statistics_model.dart';

abstract class DuesRemoteDataSource {
  /// [GET] Request
  Future<DuesCitizenModel> getByUsername({
    required String name,
    int? month,
    int? year,
    int? duesCategoryId,
  });

  Future<DuesStatisticsModel> getStatistics({int? month, int? year});

  Future<List<DuesDetailModel>> getRecentActivity({int? month, int? year, int? limit});

  Future<Map<DateTime, List<DuesDetailModel>>> getCalendarActivity({int? month, int? year});

  Future<DuesDetailModel?> getDetailByID(String duesDetailID);

  Future<List<DuesCategoryModel>> getCategory();

  Future<DuesCategoryModel?> getCategoryByID(int duesCategoryID);

  /// [POST] Request
  Future<String> save(
    String duesDetailId, {
    required int duesCategoryId,
    required int usersId,
    required int month,
    required int year,
    required int amount,
    required StatusPaid status,
    required int createdBy,
    String? description,
  });

  Future<List<DuesCategoryModel>> saveCategory({
    required String code,
    required String name,
    required int amount,
    String? description,
    int? duesCategoryId,
  });
}

class DuesRemoteDataSourceImpl implements DuesRemoteDataSource {
  const DuesRemoteDataSourceImpl({
    required this.dioClient,
  });

  final Dio dioClient;

  @override
  Future<DuesCitizenModel> getByUsername({
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
    final dues = DuesCitizenModel.fromJson(response['data']);
    return dues;
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
  Future<Map<DateTime, List<DuesDetailModel>>> getCalendarActivity({int? month, int? year}) async {
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

    /// Convert List<T> => Map<DateTime,List<T>>
    final myCalendar = LinkedHashMap<DateTime, List<DuesDetailModel>>(
      equals: isSameDay,
      hashCode: (date) => date.day * 1000000 + date.month * 10000 + date.year,
    );

    for (var item in listCalendar) {
      final date = DateTime.utc(
        item.createdAt!.year,
        item.createdAt!.month,
        item.createdAt!.day,
      );
      final isExist = myCalendar[date];
      if (isExist == null) myCalendar[date] = [];

      myCalendar[date]?.add(item);
    }

    return myCalendar;
  }

  @override
  Future<List<DuesCategoryModel>> getCategory() async {
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
  Future<DuesCategoryModel?> getCategoryByID(int duesCategoryID) async {
    final result = await dioClient.get("/duesCategory/$duesCategoryID");
    final response = result.data as Map<String, dynamic>;
    if (response['data'] == null) return null;
    final category = DuesCategoryModel.fromJson(Map<String, dynamic>.from(response['data']));

    return category;
  }

  @override
  Future<DuesDetailModel?> getDetailByID(String duesDetailID) async {
    final result = await dioClient.get("/dues/$duesDetailID");
    final response = result.data as Map<String, dynamic>;

    if (response['data'] == null) return null;

    final dues = DuesDetailModel.fromJson(Map<String, dynamic>.from(response['data']));
    return dues;
  }

  /// [POST] Request
  @override
  Future<String> save(
    String duesDetailId, {
    required int duesCategoryId,
    required int usersId,
    required int month,
    required int year,
    required int amount,
    required StatusPaid status,
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

  @override
  Future<List<DuesCategoryModel>> saveCategory({
    int? duesCategoryId,
    required String code,
    required String name,
    required int amount,
    String? description,
  }) async {
    final formData = FormData.fromMap({
      "code": code,
      "name": name,
      "amount": "$amount",
      "description": description,
    });
    final url = "/duesCategory/save/${duesCategoryId ?? 0}";
    await dioClient.post(url, data: formData);

    /// When success create data, call api to get all category
    final categories = await getCategory();
    return categories;
  }
}
