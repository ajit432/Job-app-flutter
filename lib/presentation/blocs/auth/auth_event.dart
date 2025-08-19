part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String? password;
  final String? otp;
  final String loginType; // 'password' or 'otp'

  const AuthLoginRequested({
    required this.email,
    this.password,
    this.otp,
    required this.loginType,
  });

  const AuthLoginRequested.withPassword({
    required this.email,
    required String password,
  }) : password = password,
       otp = null,
       loginType = 'password';

  const AuthLoginRequested.withOtp({
    required this.email,
    required String otp,
  }) : password = null,
       otp = otp,
       loginType = 'otp';

  @override
  List<Object?> get props => [email, password, otp, loginType];
}

class AuthRegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String? fullName;

  const AuthRegisterRequested({
    required this.email,
    required this.password,
    this.fullName,
  });

  @override
  List<Object?> get props => [email, password, fullName];
}

class AuthOtpSendRequested extends AuthEvent {
  final String email;
  final String type; // 'login' or 'reset'

  const AuthOtpSendRequested({
    required this.email,
    this.type = 'login',
  });

  @override
  List<Object?> get props => [email, type];
}

class AuthOtpVerifyRequested extends AuthEvent {
  final String email;
  final String otp;

  const AuthOtpVerifyRequested({
    required this.email,
    required this.otp,
  });

  @override
  List<Object?> get props => [email, otp];
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

class AuthRefreshTokenRequested extends AuthEvent {
  const AuthRefreshTokenRequested();
}
