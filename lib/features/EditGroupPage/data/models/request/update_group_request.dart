import 'package:json_annotation/json_annotation.dart';

part 'update_group_request.g.dart';

@JsonSerializable()
class UpdateGroupRequest {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "group_type")
  final String? groupType;
  @JsonKey(name: "currency")
  final String? currency;
  @JsonKey(name: "is_active")
  final int? isActive;

  UpdateGroupRequest ({
    this.id,
    this.name,
    this.description,
    this.groupType,
    this.currency,
    this.isActive,
  });

  factory UpdateGroupRequest.fromJson(Map<String, dynamic> json) {
    return _$UpdateGroupRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UpdateGroupRequestToJson(this);
  }
}


