import 'package:firebase_auth/firebase_auth.dart';
import 'package:qassimha/core/common/api_result.dart';
import 'package:qassimha/features/Auth/singin_singup/domain/entities/user_entity.dart';


abstract class AuthRepository {
  Future<Result<AuthWithGoogleEntity?>> signInWithGoogle();

}
