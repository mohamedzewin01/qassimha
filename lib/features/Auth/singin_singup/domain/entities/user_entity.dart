



import 'package:qassimha/features/Auth/singin_singup/data/models/response/auth_with_google_dto.dart';

class AuthWithGoogleEntity {

  final String? status;

  final String? message;

  final UserData? user;

  AuthWithGoogleEntity ({
    this.status,
    this.message,
    this.user,
  });


}