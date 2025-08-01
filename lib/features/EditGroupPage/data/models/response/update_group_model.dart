import 'package:json_annotation/json_annotation.dart';
import 'package:qassimha/features/EditGroupPage/domain/entities/update_group.dart';
import 'package:qassimha/features/Groups/domain/entities/groups_entities.dart';

part 'update_group_model.g.dart';

@JsonSerializable()
class UpdateGroupModel {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "message")
  final String? message;

  UpdateGroupModel ({
    this.status,
    this.message,
  });

  factory UpdateGroupModel.fromJson(Map<String, dynamic> json) {
    return _$UpdateGroupModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UpdateGroupModelToJson(this);
  }
  UpdateGroupEntity toEntity() {
    return UpdateGroupEntity(
      status: status,
      message: message,
    );
  }
}


