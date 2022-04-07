import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/repository/dues_repository.dart';
import '../../utils/utils.dart';
import '../datasource/remote/dues_remote_datasource.dart';
import '../model/dues_category/dues_category_model.dart';
import '../model/dues_detail/dues_detail_model.dart';
import '../model/dues_statistics/dues_statistics_model.dart';

class DuesRepositoryImpl implements DuesRepository {
  const DuesRepositoryImpl({
    required this.remoteDataSource,
  });

  final DuesRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<DuesDetailModel>>> getDuesByUsername({
    required String name,
    int? month,
    int? year,
    int? duesCategoryId,
  }) async {
    try {
      final result = await remoteDataSource.getDuesByUsername(
        name: name,
        duesCategoryId: duesCategoryId,
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

  @override
  Future<Either<Failure, DuesStatisticsModel>> getStatistics({int? month, int? year}) async {
    try {
      final result = await remoteDataSource.getStatistics(month: month, year: year);
      return Right(result);
    } on DioError catch (error) {
      return Left(dioUtils.onError(error));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DuesDetailModel>>> getRecentActivity(
      {int? month, int? year, int? limit}) async {
    try {
      final result = await remoteDataSource.getRecentActivity(
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

  @override
  Future<Either<Failure, List<DuesDetailModel>>> getCalendarActivity({
    int? month,
    int? year,
  }) async {
    try {
      final result = await remoteDataSource.getCalendarActivity(
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

  @override
  Future<Either<Failure, List<DuesCategoryModel>>> getDuesCategory() async {
    try {
      final result = await remoteDataSource.getDuesCategory();
      return Right(result);
    } on DioError catch (error) {
      return Left(dioUtils.onError(error));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }
}
