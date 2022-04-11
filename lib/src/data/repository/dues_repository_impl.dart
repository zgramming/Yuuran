import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/repository/dues_repository.dart';
import '../../utils/utils.dart';
import '../datasource/remote/dues_remote_datasource.dart';
import '../model/dues_category/dues_category_model.dart';
import '../model/dues_citizen/dues_citizen_model.dart';
import '../model/dues_detail/dues_detail_model.dart';
import '../model/dues_statistics/dues_statistics_model.dart';

class DuesRepositoryImpl implements DuesRepository {
  const DuesRepositoryImpl({
    required this.remoteDataSource,
  });

  final DuesRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, DuesCitizenModel>> getByUsername({
    required String name,
    int? month,
    int? year,
    int? duesCategoryId,
  }) async {
    try {
      final result = await remoteDataSource.getByUsername(
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
  Future<Either<Failure, List<DuesCategoryModel>>> getCategory() async {
    try {
      final result = await remoteDataSource.getCategory();
      return Right(result);
    } on DioError catch (error) {
      return Left(dioUtils.onError(error));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DuesCategoryModel?>> getCategoryByID(int duesCategoryID) async {
    try {
      final result = await remoteDataSource.getCategoryByID(duesCategoryID);
      return Right(result);
    } on DioError catch (error) {
      return Left(dioUtils.onError(error));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveDues(
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
    try {
      final result = await remoteDataSource.save(
        duesDetailId,
        duesCategoryId: duesCategoryId,
        usersId: usersId,
        month: month,
        year: year,
        amount: amount,
        status: status,
        paidBySomeoneElse: paidBySomeoneElse,
        createdBy: createdBy,
        description: description,
      );
      return Right(result);
    } on DioError catch (error) {
      return Left(dioUtils.onError(error));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveCategory({
    int? duesCategoryId,
    required String code,
    required String name,
    required int amount,
    String? description,
  }) async {
    try {
      final result = await remoteDataSource.saveCategory(
        code: code,
        name: name,
        amount: amount,
        description: description,
        duesCategoryId: duesCategoryId,
      );

      return Right(result);
    } on DioError catch (error) {
      return Left(dioUtils.onError(error));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DuesDetailModel?>> getDetailByID(String duesDetailID) async {
    try {
      final result = await remoteDataSource.getDetailByID(duesDetailID);
      return Right(result);
    } on DioError catch (error) {
      return Left(dioUtils.onError(error));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }
}
