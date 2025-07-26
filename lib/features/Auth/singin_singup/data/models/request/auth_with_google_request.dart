import 'package:json_annotation/json_annotation.dart';

part 'auth_with_google_request.g.dart';

@JsonSerializable()
class AuthWithGoogleRequest {
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

  AuthWithGoogleRequest ({
    this.id,
    this.email,
    this.displayName,
    this.phone,
    this.avatarUrl,
  });

  factory AuthWithGoogleRequest.fromJson(Map<String, dynamic> json) {
    return _$AuthWithGoogleRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AuthWithGoogleRequestToJson(this);
  }
}


