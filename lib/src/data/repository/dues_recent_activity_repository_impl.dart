import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/repository/dues_recent_activity_repository.dart';
import '../../utils/utils.dart';
import '../datasource/remote/dues_recent_activity_remote_datasource.dart';
import '../model/dues_detail/dues_detail_model.dart';

class DuesRecentActivityRepositoryImpl implements DuesRecentActivityRepository {
  const DuesRecentActivityRepositoryImpl({
    required this.remoteDatasource,
  });

  final DuesRecentActivityRemoteDataSource remoteDatasource;
  @override
  Future<Either<Failure, List<DuesDetailModel>>> get({
    int? month,
    int? year,
    int? limit,
  }) async {
    try {
      final result = await remoteDatasource.get(
        limit: limit,
        month: month,
        year: year,
      );
      return Right(result);
    } on DioError catch (error) {
      return Left(dioUtils.onError(error));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }
}
