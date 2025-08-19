// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpModel _$OtpModelFromJson(Map<String, dynamic> json) => OtpModel(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      otp: json['otp'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$OtpModelToJson(OtpModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'otp': instance.otp,
      'expiresAt': instance.expiresAt.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };

OtpVerificationRequestModel _$OtpVerificationRequestModelFromJson(
        Map<String, dynamic> json) =>
    OtpVerificationRequestModel(
      email: json['email'] as String,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$OtpVerificationRequestModelToJson(
        OtpVerificationRequestModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'otp': instance.otp,
    };

OtpSendRequestModel _$OtpSendRequestModelFromJson(Map<String, dynamic> json) =>
    OtpSendRequestModel(
      email: json['email'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$OtpSendRequestModelToJson(
        OtpSendRequestModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'type': instance.type,
    };

OtpResponseModel _$OtpResponseModelFromJson(Map<String, dynamic> json) =>
    OtpResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      token: json['token'] as String?,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$OtpResponseModelToJson(OtpResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'token': instance.token,
      'expiresAt': instance.expiresAt?.toIso8601String(),
    };
