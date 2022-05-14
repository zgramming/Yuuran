import 'package:dartz/dartz.dart';

import '../../data/model/dues_category/dues_category_model.dart';
import '../../data/model/dues_citizen/dues_citizen_model.dart';
import '../../data/model/dues_detail/dues_detail_model.dart';
import '../../data/model/dues_response/dues_response_model.dart';
import '../../data/model/dues_statistics/dues_statistics_model.dart';
import '../../utils/utils.dart';

abstract class DuesRepository {
  /// [GET] Request
  Future<Either<Failure, DuesCitizenModel>> getByUsername({
    required String name,
    int? month,
    int? year,
    int? duesCategoryId,
  });

  Future<Either<Failure, DuesStatisticsModel>> getStatistics({
    int? month,
    int? year,
  });

  Future<Either<Failure, List<DuesDetailModel>>> getRecentActivity({
    int? month,
    int? year,
    int? limit,
  });

  Future<Either<Failure, Map<DateTime, List<DuesDetailModel>>>> getCalendarActivity({
    int? month,
    int? year,
  });

  Future<Either<Failure, List<DuesCategoryModel>>> getCategory();

  Future<Either<Failure, DuesCategoryModel?>> getCategoryByID(int duesCategoryID);

  Future<Either<Failure, DuesDetailModel?>> getDetailByID(String duesDetailID);

  /// [POST] Request
  Future<Either<Failure, DuesResponse>> saveDues(
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

  Future<Either<Failure, List<DuesCategoryModel>>> saveCategory({
    int? duesCategoryId,
    required String code,
    required String name,
    required int amount,
    String? description,
  });
}
