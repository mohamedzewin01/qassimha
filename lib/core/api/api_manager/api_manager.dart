

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:qassimha/core/api/api_constants.dart';
import 'package:qassimha/features/Auth/singin_singup/data/models/request/auth_with_google_request.dart';
import 'package:qassimha/features/Auth/singin_singup/data/models/response/auth_with_google_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'api_manager.g.dart';

@injectable
@singleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  @FactoryMethod()
  factory ApiService(Dio dio) = _ApiService;

  @POST(ApiConstants.signUp)
  Future<AuthWithGoogleDto?> authWithGoogle(
    @Body() AuthWithGoogleRequest userModelRequest,
  );
}

//  @MultiPart()
