import 'package:json_annotation/json_annotation.dart';
import 'package:qassimha/features/CreateGroup/domain/entities/create_group.dart';
import 'package:qassimha/features/Groups/domain/entities/groups_entities.dart';

part 'create_group_model.g.dart';

@JsonSerializable()
class CreateGroupModel {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "message")
  final String? message;

  CreateGroupModel ({
    this.status,
    this.message,
  });

  factory CreateGroupModel.fromJson(Map<String, dynamic> json) {
    return _$CreateGroupModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CreateGroupModelToJson(this);
  }
  CreateGroupEntity toEntity() {
    return CreateGroupEntity(
      status: status,
      message: message,
    );
  }
}


