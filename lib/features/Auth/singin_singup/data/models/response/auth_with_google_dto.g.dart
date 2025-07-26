// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_with_google_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthWithGoogleDto _$AuthWithGoogleDtoFromJson(Map<String, dynamic> json) =>
    AuthWithGoogleDto(
      status: json['status'] as String?,
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : UserData.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthWithGoogleDtoToJson(AuthWithGoogleDto instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'user': instance.user,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      id: json['id'] as String?,
      email: json['email'] as String?,
      displayName: json['display_name'] as String?,
      phone: json['phone'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      createdAt: json['created_at'] as String?,
      apiToken: json['api_token'] as String?,
      tokenExpiresAt: json['token_expires_at'] as String?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'display_name': instance.displayName,
      'phone': instance.phone,
      'avatar_url': instance.avatarUrl,
      'created_at': instance.createdAt,
      'api_token': instance.apiToken,
      'token_expires_at': instance.tokenExpiresAt,
    };
