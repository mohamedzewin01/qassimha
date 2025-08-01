import 'package:json_annotation/json_annotation.dart';
import 'package:qassimha/features/CreateGroup/domain/entities/members_entity.dart';

part 'get_members_model.g.dart';

@JsonSerializable()
class GetMembersModel {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "results")
  final List<Results>? results;

  GetMembersModel ({
    this.status,
    this.results,
  });

  factory GetMembersModel.fromJson(Map<String, dynamic> json) {
    return _$GetMembersModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetMembersModelToJson(this);
  }
  GetMembersEntity toEntity() {
    return GetMembersEntity(
      status: status,
      results: results,
    );
  }
}

@JsonSerializable()
class Results {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "display_name")
  final String? displayName;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "avatar_url")
  final String? avatarUrl;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "updated_at")
  final String? updatedAt;

  Results ({
    this.id,
    this.email,
    this.displayName,
    this.phone,
    this.avatarUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return _$ResultsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ResultsToJson(this);
  }
}


