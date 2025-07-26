import 'package:json_annotation/json_annotation.dart';
import 'package:qassimha/features/Groups/domain/entities/groups_entities.dart';

part 'get_groups_model.g.dart';

@JsonSerializable()
class GetGroupsModel {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "groups")
  final List<Groups>? groups;

  GetGroupsModel ({
    this.status,
    this.groups,
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
      groups: groups,
    );
  }
}

@JsonSerializable()
class Groups {
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

  Groups ({
    this.id,
    this.name,
    this.description,
    this.createdBy,
    this.groupType,
    this.currency,
    this.createdAt,
    this.isActive,
  });

  factory Groups.fromJson(Map<String, dynamic> json) {
    return _$GroupsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GroupsToJson(this);
  }
}


