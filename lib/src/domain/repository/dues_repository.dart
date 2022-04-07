import 'package:dartz/dartz.dart';

import '../../data/model/dues_category/dues_category_model.dart';
import '../../data/model/dues_detail/dues_detail_model.dart';
import '../../data/model/dues_statistics/dues_statistics_model.dart';
import '../../utils/utils.dart';

abstract class DuesRepository {
  Future<Either<Failure, List<DuesDetailModel>>> getDuesByUsername({
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

  Future<Either<Failure, List<DuesDetailModel>>> getCalendarActivity({
    int? month,
    int? year,
  });

  Future<Either<Failure, List<DuesCategoryModel>>> getDuesCategory();
}
