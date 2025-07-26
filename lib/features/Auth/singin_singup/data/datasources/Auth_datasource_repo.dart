


import 'package:qassimha/core/common/api_result.dart';
import 'package:qassimha/features/Auth/singin_singup/domain/entities/user_entity.dart';

abstract class AuthDatasourceRepo {
  // Future<Result<UserSignUpEntity?>> signIn(String email, String password);
  // Future<Result<UserSignUpEntity?>> signUp(String? firstName,String? lastName,String email, String password);

  Future<Result<AuthWithGoogleEntity?>> signInWithGoogle();

}
