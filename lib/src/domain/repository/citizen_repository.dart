import 'package:dartz/dartz.dart';

import '../../data/model/user/user_model.dart';
import '../../utils/utils.dart';

abstract class CitizenRepository {
  Future<Either<Failure, List<UserModel>>> get();

  Future<Either<Failure, UserModel?>> getByID(int id);

  Future<Either<Failure, String>> saveCitizen({
    required int? id,
    required String username,
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  });
}
