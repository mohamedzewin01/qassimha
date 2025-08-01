import 'package:qassimha/features/Groups/data/models/response/get_groups_model.dart';
import 'package:qassimha/features/Groups/data/models/response/get_groups_model.dart';

// class GetGroupsEntity {
//
//   final String? status;
//
//   final List<Groups>? groups;
//
//   GetGroupsEntity ({
//     this.status,
//     this.groups,
//   });
//
//
// }
//


class GetGroupsEntity{

  final String? status;

  final List<CreatedGroups>? createdGroups;

  final List<dynamic>? activeGroups;

  final List<InactiveGroups>? inactiveGroups;

  GetGroupsEntity({
    this.status,
    this.createdGroups,
    this.activeGroups,
    this.inactiveGroups,
  });


}