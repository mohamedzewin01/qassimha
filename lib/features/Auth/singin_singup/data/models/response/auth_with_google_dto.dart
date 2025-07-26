import 'package:json_annotation/json_annotation.dart';
import 'package:qassimha/features/Auth/singin_singup/domain/entities/user_entity.dart';

part 'auth_with_google_dto.g.dart';

@JsonSerializable()
class AuthWithGoogleDto {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final UserData? user;

  AuthWithGoogleDto ({
    this.status,
    this.message,
    this.user,
  });

  factory AuthWithGoogleDto.fromJson(Map<String, dynamic> json) {
    return _$AuthWithGoogleDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AuthWithGoogleDtoToJson(this);
  }
  AuthWithGoogleEntity toEntity() {
    return AuthWithGoogleEntity(
      status: status,
      message: message,
      user: user,
    );
  }
}

@JsonSerializable()
class UserData {
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
  @JsonKey(name: "api_token")
  final String? apiToken;
  @JsonKey(name: "token_expires_at")
  final String? tokenExpiresAt;

  UserData ({
    this.id,
    this.email,
    this.displayName,
    this.phone,
    this.avatarUrl,
    this.createdAt,
    this.apiToken,
    this.tokenExpiresAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return _$UserDataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserDataToJson(this);
  }
}


