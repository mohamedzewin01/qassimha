import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:qassimha/core/api/api_constants.dart';
import 'package:qassimha/features/Auth/singin_singup/data/models/request/auth_with_google_request.dart';
import 'package:qassimha/features/Auth/singin_singup/data/models/response/auth_with_google_dto.dart';
import 'package:qassimha/features/CreateGroup/data/models/request/create_group_request.dart';
import 'package:qassimha/features/CreateGroup/data/models/response/get_members_model.dart';
import 'package:qassimha/features/EditGroupPage/data/models/request/update_group_request.dart';
import 'package:qassimha/features/CreateGroup/data/models/response/create_group_model.dart';
import 'package:qassimha/features/Groups/data/models/response/get_groups_model.dart';
import 'package:qassimha/features/EditGroupPage/data/models/response/update_group_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_manager.g.dart';

@injectable
@singleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  @FactoryMethod()
  factory ApiService(Dio dio) = _ApiService;

  @POST(ApiConstants.singWithGoogle)
  Future<AuthWithGoogleDto?> authWithGoogle(
    @Body() AuthWithGoogleRequest userModelRequest,
  );

  @POST(ApiConstants.getGroups)
  Future<GetGroupsModel?> getGroups(
    @Header(ApiConstants.authToken) String token,
  );

  @POST(ApiConstants.createGroup)
  Future<CreateGroupModel?> createGroup(
    @Body() CreateGroupRequest createGroupRequest,
    @Header(ApiConstants.authToken) String token,
  );

  @POST(ApiConstants.updateGroup)
  Future<UpdateGroupModel?> updateGroup(
    @Body() UpdateGroupRequest updateGroupRequest,
    @Header(ApiConstants.authToken) String token,
  );

  @GET(ApiConstants.getMembers)
  Future<GetMembersModel?> getMembers(
    @Query("search") String search,
    @Header(ApiConstants.authToken) String token,
  );
}
