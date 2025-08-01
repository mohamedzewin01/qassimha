import 'package:qassimha/features/CreateGroup/data/models/response/get_members_model.dart';

class GetMembersEntity {
  final String? status;

  final List<Results>? results;

  GetMembersEntity({this.status, this.results});
}
