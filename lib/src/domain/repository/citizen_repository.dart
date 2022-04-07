import 'package:dartz/dartz.dart';

import '../../data/model/user/user_model.dart';
import '../../utils/utils.dart';

abstract class CitizenRepository {
  Future<Either<Failure, List<UserModel>>> get();
}
