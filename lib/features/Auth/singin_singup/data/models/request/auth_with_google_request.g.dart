// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_with_google_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthWithGoogleRequest _$AuthWithGoogleRequestFromJson(
        Map<String, dynamic> json) =>
    AuthWithGoogleRequest(
      id: json['id'] as String?,
      email: json['email'] as String?,
      displayName: json['display_name'] as String?,
      phone: json['phone'] as String?,
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$AuthWithGoogleRequestToJson(
        AuthWithGoogleRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'display_name': instance.displayName,
      'phone': instance.phone,
      'avatar_url': instance.avatarUrl,
    };
