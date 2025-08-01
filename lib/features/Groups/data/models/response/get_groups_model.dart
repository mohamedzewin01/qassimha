import 'package:json_annotation/json_annotation.dart';
import 'package:qassimha/features/Groups/domain/entities/groups_entities.dart';

part 'get_groups_model.g.dart';

@JsonSerializable()
class GetGroupsModel {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "created_groups")
  final List<CreatedGroups>? createdGroups;
  @JsonKey(name: "active_groups")
  final List<dynamic>? activeGroups;
  @JsonKey(name: "inactive_groups")
  final List<InactiveGroups>? inactiveGroups;

  GetGroupsModel ({
    this.status,
    this.createdGroups,
    this.activeGroups,
    this.inactiveGroups,
  });

  factory GetGroupsModel.fromJson(Map<String, dynamic> json) {
    return _$GetGroupsModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetGroupsModelToJson(this);
  }
  GetGroupsEntity toEntity() {
    return GetGroupsEntity(
      status: status,
      createdGroups: createdGroups,
      activeGroups: activeGroups,
      inactiveGroups: inactiveGroups,
    );
  }
}

@JsonSerializable()
class CreatedGroups {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "created_by")
  final String? createdBy;
  @JsonKey(name: "group_type")
  final String? groupType;
  @JsonKey(name: "currency")
  final String? currency;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "is_active")
  final int? isActive;
  @JsonKey(name: "members")
  final List<Members>? members;

  CreatedGroups ({
    this.id,
    this.name,
    this.description,
    this.createdBy,
    this.groupType,
    this.currency,
    this.createdAt,
    this.isActive,
    this.members,
  });

  factory CreatedGroups.fromJson(Map<String, dynamic> json) {
    return _$CreatedGroupsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CreatedGroupsToJson(this);
  }
}

@JsonSerializable()
class Members {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "group_id")
  final String? groupId;
  @JsonKey(name: "user_id")
  final String? userId;
  @JsonKey(name: "joined_date")
  final String? joinedDate;
  @JsonKey(name: "left_date")
  final String? leftDate;
  @JsonKey(name: "is_active")
  final int? isActive;
  @JsonKey(name: "role")
  final String? role;
  @JsonKey(name: "created_at")
  final String? createdAt;

  Members ({
    this.id,
    this.groupId,
    this.userId,
    this.joinedDate,
    this.leftDate,
    this.isActive,
    this.role,
    this.createdAt,
  });

  factory Members.fromJson(Map<String, dynamic> json) {
    return _$MembersFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MembersToJson(this);
  }
}

@JsonSerializable()
class InactiveGroups {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "created_by")
  final String? createdBy;
  @JsonKey(name: "group_type")
  final String? groupType;
  @JsonKey(name: "currency")
  final String? currency;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "is_active")
  final int? isActive;
  @JsonKey(name: "members")
  final List<Members>? members;

  InactiveGroups ({
    this.id,
    this.name,
    this.description,
    this.createdBy,
    this.groupType,
    this.currency,
    this.createdAt,
    this.isActive,
    this.members,
  });

  factory InactiveGroups.fromJson(Map<String, dynamic> json) {
    return _$InactiveGroupsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$InactiveGroupsToJson(this);
  }
}

// @JsonSerializable()
// class Members {
//   @JsonKey(name: "id")
//   final String? id;
//   @JsonKey(name: "group_id")
//   final String? groupId;
//   @JsonKey(name: "user_id")
//   final String? userId;
//   @JsonKey(name: "joined_date")
//   final String? joinedDate;
//   @JsonKey(name: "left_date")
//   final String? leftDate;
//   @JsonKey(name: "is_active")
//   final int? isActive;
//   @JsonKey(name: "role")
//   final String? role;
//   @JsonKey(name: "created_at")
//   final String? createdAt;
//
//   Members ({
//     this.id,
//     this.groupId,
//     this.userId,
//     this.joinedDate,
//     this.leftDate,
//     this.isActive,
//     this.role,
//     this.createdAt,
//   });
//
//   factory Members.fromJson(Map<String, dynamic> json) {
//     return _$MembersFromJson(json);
//   }
//
//   Map<String, dynamic> toJson() {
//     return _$MembersToJson(this);
//   }
// }


