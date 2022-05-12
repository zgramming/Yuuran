import 'package:dartz/dartz.dart';

import '../../data/model/authentication/authentication_response.dart';
import '../../utils/utils.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, AuthenticationResponse>> login({
    required String username,
    required String password,
  });
}
