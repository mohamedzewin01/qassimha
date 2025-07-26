
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qassimha/core/api/api_extentions.dart';
import 'package:qassimha/core/api/api_manager/api_manager.dart';
import 'package:qassimha/core/common/api_result.dart';
import 'package:qassimha/features/Auth/singin_singup/data/models/request/auth_with_google_request.dart';
import 'package:qassimha/features/Auth/singin_singup/domain/entities/user_entity.dart';
import 'Auth_datasource_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthDatasourceRepo)
class AuthDatasourceRepoImpl implements AuthDatasourceRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final ApiService _apiService;

  AuthDatasourceRepoImpl(this._apiService);



  @override
  Future<Result<AuthWithGoogleEntity?>> signInWithGoogle() {
    return executeApi(() async {
      // خطوة تسجيل الدخول باستخدام Google
      final googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // تسجيل الدخول إلى Firebase باستخدام بيانات Google
        final userCredential = await _firebaseAuth.signInWithCredential(credential);

        if (userCredential.user != null) {
          final user = userCredential.user!;
          AuthWithGoogleRequest userModelRequest = AuthWithGoogleRequest(
            id: user.uid,
            displayName: googleUser.displayName ?? '',

            email: user.email,
            avatarUrl: user.photoURL,
          );

          final userEntity = await _apiService.authWithGoogle(userModelRequest);
          return userEntity?.toEntity();
        } else {
          throw Exception('Google Sign-In failed: User is null.');
        }
      } else {
        throw Exception('Google Sign-In was cancelled by the user.');
      }
    });
  }



}
