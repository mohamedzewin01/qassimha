import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:injectable/injectable.dart';
import 'package:qassimha/core/common/api_result.dart';
import 'package:qassimha/core/utils/cashed_data_shared_preferences.dart';
import 'package:qassimha/features/Auth/singin_singup/domain/entities/user_entity.dart';

import '../../domain/useCases/Auth_useCase_repo.dart';

part 'Auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authUseCaseRepo) : super(AuthInitial());
  final AuthUseCaseRepo _authUseCaseRepo;



  Future<void> signInWithGoogle() async{
    emit(AuthLoginLoading());
    final result = await _authUseCaseRepo.signInWithGoogle();
    switch (result) {
      case Success<AuthWithGoogleEntity?>():
        {
          if (!isClosed) {
            CacheService.setData(key: CacheKeys.userId, value: result.data!.user?.id);
            CacheService.setData(key: CacheKeys.userPhoto, value: result.data!.user?.avatarUrl);
            CacheService.setData(key: CacheKeys.displayName, value: result.data!.user?.displayName);
            CacheService.setData(key: CacheKeys.displayName, value: result.data!.user?.displayName);
            CacheService.setData(key: CacheKeys.token, value: result.data!.user?.apiToken);
            // await CacheService.setData(key: CacheKeys.refreshToken, value: result.data!.refreshToken);

            CacheService.setData(key: CacheKeys.userEmail, value: result.data!.user?.email);
            CacheService.setData(key: CacheKeys.userActive, value: true);
            emit(AuthLoginSuccess(result.data!));
          }
        }
        break;
      case Fail<AuthWithGoogleEntity?>():
        {
          if (!isClosed) {
            emit(AuthLoginFailure(result.exception));
          }
        }
        break;
    }
  }


}
