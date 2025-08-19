import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'otp_model.g.dart';

@JsonSerializable()
class OtpModel extends Equatable {
  final int id;
  final String email;
  final String otp;
  final DateTime expiresAt;
  final DateTime createdAt;

  const OtpModel({
    required this.id,
    required this.email,
    required this.otp,
    required this.expiresAt,
    required this.createdAt,
  });

  factory OtpModel.fromJson(Map<String, dynamic> json) =>
      _$OtpModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtpModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        email,
        otp,
        expiresAt,
        createdAt,
      ];

  OtpModel copyWith({
    int? id,
    String? email,
    String? otp,
    DateTime? expiresAt,
    DateTime? createdAt,
  }) {
    return OtpModel(
      id: id ?? this.id,
      email: email ?? this.email,
      otp: otp ?? this.otp,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  static OtpModel mock() {
    return OtpModel(
      id: 1,
      email: 'test@example.com',
      otp: '123456',
      expiresAt: DateTime.now().add(const Duration(minutes: 10)),
      createdAt: DateTime.now(),
    );
  }

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  Duration get timeUntilExpiry {
    final now = DateTime.now();
    if (now.isAfter(expiresAt)) {
      return Duration.zero;
    }
    return expiresAt.difference(now);
  }

  String get formattedTimeRemaining {
    final remaining = timeUntilExpiry;
    if (remaining == Duration.zero) {
      return 'Expired';
    }

    final minutes = remaining.inMinutes;
    final seconds = remaining.inSeconds % 60;
    
    if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }
}

@JsonSerializable()
class OtpVerificationRequestModel extends Equatable {
  final String email;
  final String otp;

  const OtpVerificationRequestModel({
    required this.email,
    required this.otp,
  });

  factory OtpVerificationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$OtpVerificationRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtpVerificationRequestModelToJson(this);

  @override
  List<Object?> get props => [email, otp];

  OtpVerificationRequestModel copyWith({
    String? email,
    String? otp,
  }) {
    return OtpVerificationRequestModel(
      email: email ?? this.email,
      otp: otp ?? this.otp,
    );
  }
}

@JsonSerializable()
class OtpSendRequestModel extends Equatable {
  final String email;
  final String type; // 'login', 'register', 'password_reset'

  const OtpSendRequestModel({
    required this.email,
    required this.type,
  });

  factory OtpSendRequestModel.fromJson(Map<String, dynamic> json) =>
      _$OtpSendRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtpSendRequestModelToJson(this);

  @override
  List<Object?> get props => [email, type];

  OtpSendRequestModel copyWith({
    String? email,
    String? type,
  }) {
    return OtpSendRequestModel(
      email: email ?? this.email,
      type: type ?? this.type,
    );
  }
}

@JsonSerializable()
class OtpResponseModel extends Equatable {
  final bool success;
  final String message;
  final String? token;
  final DateTime? expiresAt;

  const OtpResponseModel({
    required this.success,
    required this.message,
    this.token,
    this.expiresAt,
  });

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OtpResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtpResponseModelToJson(this);

  @override
  List<Object?> get props => [success, message, token, expiresAt];

  OtpResponseModel copyWith({
    bool? success,
    String? message,
    String? token,
    DateTime? expiresAt,
  }) {
    return OtpResponseModel(
      success: success ?? this.success,
      message: message ?? this.message,
      token: token ?? this.token,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  static OtpResponseModel successful({
    required String message,
    String? token,
    DateTime? expiresAt,
  }) {
    return OtpResponseModel(
      success: true,
      message: message,
      token: token,
      expiresAt: expiresAt,
    );
  }

  static OtpResponseModel failureResponse({required String message}) {
    return OtpResponseModel(
      success: false,
      message: message,
    );
  }
}

enum OtpType {
  login,
  register,
  passwordReset,
}

extension OtpTypeExtension on OtpType {
  String get displayName {
    switch (this) {
      case OtpType.login:
        return 'Login';
      case OtpType.register:
        return 'Registration';
      case OtpType.passwordReset:
        return 'Password Reset';
    }
  }

  String get value {
    switch (this) {
      case OtpType.login:
        return 'login';
      case OtpType.register:
        return 'register';
      case OtpType.passwordReset:
        return 'password_reset';
    }
  }

  static OtpType fromString(String value) {
    return OtpType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => OtpType.login,
    );
  }
}
