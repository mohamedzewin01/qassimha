import 'package:json_annotation/json_annotation.dart';

part 'create_group_request.g.dart';

@JsonSerializable()
class CreateGroupRequest {
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

  CreateGroupRequest ({
    this.name,
    this.description,
    this.groupType,
    this.currency,
    this.isActive,
  });

  factory CreateGroupRequest.fromJson(Map<String, dynamic> json) {
    return _$CreateGroupRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CreateGroupRequestToJson(this);
  }
}


