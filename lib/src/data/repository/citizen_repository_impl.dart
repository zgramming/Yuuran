import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/repository/citizen_repository.dart';
import '../../utils/utils.dart';
import '../datasource/remote/citizen_remote_datasource.dart';
import '../model/user/user_model.dart';

class CitizenRepositoryImpl implements CitizenRepository {
  const CitizenRepositoryImpl({
    required this.remoteDataSource,
  });

  final CitizenRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<UserModel>>> get() async {
    try {
      final result = await remoteDataSource.get();
      return Right(result);
    } on DioError catch (error) {
      return Left(dioUtils.onError(error));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveCitizen({
    required int? id,
    required String username,
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final result = await remoteDataSource.saveCitizen(
        id: id,
        username: username,
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      return Right(result);
    } on DioError catch (error) {
      return Left(dioUtils.onError(error));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getByID(int id) async {
    try {
      final result = await remoteDataSource.getByID(id);
      return Right(result);
    } on DioError catch (error) {
      return Left(dioUtils.onError(error));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }
}
