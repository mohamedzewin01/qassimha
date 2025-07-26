
import 'package:injectable/injectable.dart';
import 'package:qassimha/core/common/api_result.dart';

import 'package:qassimha/features/Auth/singin_singup/data/datasources/Auth_datasource_repo.dart';
import 'package:qassimha/features/Auth/singin_singup/domain/entities/user_entity.dart';
import '../../domain/repositories/Auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasourceRepo _authDatasourceRepo;

  AuthRepositoryImpl(this._authDatasourceRepo);

  @override
  Future<Result<AuthWithGoogleEntity?>> signInWithGoogle() {
    return _authDatasourceRepo.signInWithGoogle();
  }



}
