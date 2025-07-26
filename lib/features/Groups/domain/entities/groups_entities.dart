import 'package:qassimha/features/Groups/data/models/response/get_groups_model.dart';

class GetGroupsEntity {

  final String? status;

  final List<Groups>? groups;

  GetGroupsEntity ({
    this.status,
    this.groups,
  });


}


class CreateGroupEntity {

  final String? status;

  final String? message;

  CreateGroupEntity({
    this.status,
    this.message,
  });
}

class UpdateGroupEntity {
  final String? status;
  final String? message;

  UpdateGroupEntity ({
    this.status,
    this.message,
  });

}