import 'package:firebase_auth/firebase_auth.dart';
import 'package:qassimha/core/common/api_result.dart';
import 'package:qassimha/features/Auth/singin_singup/domain/entities/user_entity.dart';

import '../repositories/Auth_repository.dart';
import 'package:injectable/injectable.dart';
import '../useCases/Auth_useCase_repo.dart';

@Injectable(as: AuthUseCaseRepo)
class AuthUseCase implements AuthUseCaseRepo {
  final AuthRepository repository;

  AuthUseCase(this.repository);

  @override
  Future<Result<AuthWithGoogleEntity?>> signInWithGoogle() {
  return repository.signInWithGoogle();
  }





}
