// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponseModel _$AuthResponseModelFromJson(Map<String, dynamic> json) =>
    AuthResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : AuthDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseModelToJson(AuthResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

AuthDataModel _$AuthDataModelFromJson(Map<String, dynamic> json) =>
    AuthDataModel(
      accessToken: json['accessToken'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthDataModelToJson(AuthDataModel instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'user': instance.user,
    };

OtpResponseModel _$OtpResponseModelFromJson(Map<String, dynamic> json) =>
    OtpResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : OtpDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OtpResponseModelToJson(OtpResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

OtpDataModel _$OtpDataModelFromJson(Map<String, dynamic> json) => OtpDataModel(
      expiresAt: DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$OtpDataModelToJson(OtpDataModel instance) =>
    <String, dynamic>{
      'expiresAt': instance.expiresAt.toIso8601String(),
    };

LoginRequestModel _$LoginRequestModelFromJson(Map<String, dynamic> json) =>
    LoginRequestModel(
      email: json['email'] as String,
      password: json['password'] as String?,
      otp: json['otp'] as String?,
      loginType: json['loginType'] as String,
    );

Map<String, dynamic> _$LoginRequestModelToJson(LoginRequestModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'otp': instance.otp,
      'loginType': instance.loginType,
    };

RegisterRequestModel _$RegisterRequestModelFromJson(
        Map<String, dynamic> json) =>
    RegisterRequestModel(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$RegisterRequestModelToJson(
        RegisterRequestModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

GoogleAuthRequestModel _$GoogleAuthRequestModelFromJson(
        Map<String, dynamic> json) =>
    GoogleAuthRequestModel(
      idToken: json['idToken'] as String,
      accessToken: json['accessToken'] as String?,
    );

Map<String, dynamic> _$GoogleAuthRequestModelToJson(
        GoogleAuthRequestModel instance) =>
    <String, dynamic>{
      'idToken': instance.idToken,
      'accessToken': instance.accessToken,
    };

RefreshTokenRequestModel _$RefreshTokenRequestModelFromJson(
        Map<String, dynamic> json) =>
    RefreshTokenRequestModel(
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$RefreshTokenRequestModelToJson(
        RefreshTokenRequestModel instance) =>
    <String, dynamic>{
      'refreshToken': instance.refreshToken,
    };

PasswordResetRequestModel _$PasswordResetRequestModelFromJson(
        Map<String, dynamic> json) =>
    PasswordResetRequestModel(
      email: json['email'] as String,
      otp: json['otp'] as String,
      newPassword: json['newPassword'] as String,
    );

Map<String, dynamic> _$PasswordResetRequestModelToJson(
        PasswordResetRequestModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'otp': instance.otp,
      'newPassword': instance.newPassword,
    };
