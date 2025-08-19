import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'user_model.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class AuthResponseModel extends Equatable {
  final bool success;
  final String message;
  final AuthDataModel? data;

  const AuthResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);

  @override
  List<Object?> get props => [
        success,
        message,
        data,
      ];

  AuthResponseModel copyWith({
    bool? success,
    String? message,
    AuthDataModel? data,
  }) {
    return AuthResponseModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  static AuthResponseModel successResponse({
    required String message,
    required AuthDataModel data,
  }) {
    return AuthResponseModel(
      success: true,
      message: message,
      data: data,
    );
  }

  static AuthResponseModel errorResponse({required String message}) {
    return AuthResponseModel(
      success: false,
      message: message,
    );
  }
}

@JsonSerializable()
class AuthDataModel extends Equatable {
  final String? accessToken; // Make accessToken optional
  final UserModel user;

  const AuthDataModel({
    this.accessToken, // Remove required
    required this.user,
  });

  factory AuthDataModel.fromJson(Map<String, dynamic> json) =>
      _$AuthDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthDataModelToJson(this);

  @override
  List<Object?> get props => [accessToken, user];

  AuthDataModel copyWith({
    String? accessToken,
    UserModel? user,
  }) {
    return AuthDataModel(
      accessToken: accessToken ?? this.accessToken,
      user: user ?? this.user,
    );
  }
}

// Add a separate model for registration responses
@JsonSerializable()
class RegistrationDataModel extends Equatable {
  final UserModel user;

  const RegistrationDataModel({
    required this.user,
  });

  factory RegistrationDataModel.fromJson(Map<String, dynamic> json) =>
      _$RegistrationDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationDataModelToJson(this);

  @override
  List<Object?> get props => [user];

  RegistrationDataModel copyWith({
    UserModel? user,
  }) {
    return RegistrationDataModel(
      user: user ?? this.user,
    );
  }
}

@JsonSerializable()
class OtpResponseModel extends Equatable {
  final bool success;
  final String message;
  final OtpDataModel? data;

  const OtpResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OtpResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtpResponseModelToJson(this);

  @override
  List<Object?> get props => [success, message, data];
}

@JsonSerializable()
class OtpDataModel extends Equatable {
  final DateTime expiresAt;

  const OtpDataModel({
    required this.expiresAt,
  });

  factory OtpDataModel.fromJson(Map<String, dynamic> json) =>
      _$OtpDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtpDataModelToJson(this);

  @override
  List<Object?> get props => [expiresAt];
}

@JsonSerializable()
class LoginRequestModel extends Equatable {
  final String email;
  final String? password;
  final String? otp;
  final String loginType; // 'password' or 'otp'

  const LoginRequestModel({
    required this.email,
    this.password,
    this.otp,
    required this.loginType,
  });

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);

  @override
  List<Object?> get props => [email, password, otp, loginType];

  LoginRequestModel copyWith({
    String? email,
    String? password,
    String? otp,
    String? loginType,
  }) {
    return LoginRequestModel(
      email: email ?? this.email,
      password: password ?? this.password,
      otp: otp ?? this.otp,
      loginType: loginType ?? this.loginType,
    );
  }

  static LoginRequestModel withPassword({
    required String email,
    required String password,
  }) {
    return LoginRequestModel(
      email: email,
      password: password,
      loginType: 'password',
    );
  }

  static LoginRequestModel withOtp({
    required String email,
    required String otp,
  }) {
    return LoginRequestModel(
      email: email,
      otp: otp,
      loginType: 'otp',
    );
  }
}

@JsonSerializable()
class RegisterRequestModel extends Equatable {
  final String email;
  final String password;

  const RegisterRequestModel({
    required this.email,
    required this.password,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);

  @override
  List<Object?> get props => [email, password];

  RegisterRequestModel copyWith({
    String? email,
    String? password,
  }) {
    return RegisterRequestModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

@JsonSerializable()
class GoogleAuthRequestModel extends Equatable {
  final String idToken;
  final String? accessToken;

  const GoogleAuthRequestModel({
    required this.idToken,
    this.accessToken,
  });

  factory GoogleAuthRequestModel.fromJson(Map<String, dynamic> json) =>
      _$GoogleAuthRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleAuthRequestModelToJson(this);

  @override
  List<Object?> get props => [idToken, accessToken];

  GoogleAuthRequestModel copyWith({
    String? idToken,
    String? accessToken,
  }) {
    return GoogleAuthRequestModel(
      idToken: idToken ?? this.idToken,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}

@JsonSerializable()
class RefreshTokenRequestModel extends Equatable {
  final String refreshToken;

  const RefreshTokenRequestModel({
    required this.refreshToken,
  });

  factory RefreshTokenRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenRequestModelToJson(this);

  @override
  List<Object?> get props => [refreshToken];

  RefreshTokenRequestModel copyWith({
    String? refreshToken,
  }) {
    return RefreshTokenRequestModel(
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}

@JsonSerializable()
class PasswordResetRequestModel extends Equatable {
  final String email;
  final String otp;
  final String newPassword;

  const PasswordResetRequestModel({
    required this.email,
    required this.otp,
    required this.newPassword,
  });

  factory PasswordResetRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PasswordResetRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordResetRequestModelToJson(this);

  @override
  List<Object?> get props => [email, otp, newPassword];

  PasswordResetRequestModel copyWith({
    String? email,
    String? otp,
    String? newPassword,
  }) {
    return PasswordResetRequestModel(
      email: email ?? this.email,
      otp: otp ?? this.otp,
      newPassword: newPassword ?? this.newPassword,
    );
  }
}

enum LoginType {
  password,
  otp,
}

extension LoginTypeExtension on LoginType {
  String get value {
    return name;
  }

  static LoginType fromString(String value) {
    return LoginType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => LoginType.password,
    );
  }
}

enum RegistrationType {
  email,
  google,
}

extension RegistrationTypeExtension on RegistrationType {
  String get value {
    return name;
  }

  static RegistrationType fromString(String value) {
    return RegistrationType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => RegistrationType.email,
    );
  }
}
