import 'package:dartz/dartz.dart';

import '../../data/model/user/user_model.dart';
import '../../utils/utils.dart';

abstract class UserRepository {
  Future<Either<Failure, UserModel>> login({
    required String username,
    required String password,
  });
}
