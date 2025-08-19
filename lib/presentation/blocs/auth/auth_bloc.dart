import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/auth_model.dart';
import '../../../data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({AuthRepository? authRepository}) 
      : _authRepository = authRepository ?? AuthRepository(),
        super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthOtpSendRequested>(_onOtpSendRequested);
    on<AuthOtpVerifyRequested>(_onOtpVerifyRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthRefreshTokenRequested>(_onRefreshTokenRequested);
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      AuthResponseModel result;
      
      if (event.loginType == 'password') {
        result = await _authRepository.login(
          email: event.email,
          password: event.password!,
        );
      } else {
        result = await _authRepository.loginWithOtp(
          email: event.email,
          otp: event.otp!,
        );
      }
      
      if (result.success && result.data != null) {
        emit(AuthAuthenticated(user: result.data!.user));
      } else {
        emit(AuthError(message: result.message));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final result = await _authRepository.register(
        email: event.email,
        password: event.password,
      );
      
      if (result.success && result.data != null) {
        emit(AuthAuthenticated(user: result.data!.user));
      } else {
        emit(AuthError(message: result.message));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onOtpSendRequested(
    AuthOtpSendRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final result = await _authRepository.requestOtp(
        email: event.email,
        type: event.type,
      );
      
      if (result.success) {
        emit(AuthOtpSent(email: event.email));
      } else {
        emit(AuthError(message: result.message));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onOtpVerifyRequested(
    AuthOtpVerifyRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final result = await _authRepository.verifyOtp(
        email: event.email,
        otp: event.otp,
      );
      
      if (result.success) {
        emit(AuthOtpVerified(email: event.email));
      } else {
        emit(AuthError(message: result.message));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authRepository.logout();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final isAuthenticated = await _authRepository.isAuthenticated();
      if (isAuthenticated) {
        final user = await _authRepository.getCurrentUser();
        if (user != null) {
          emit(AuthAuthenticated(user: user));
        } else {
          emit(AuthUnauthenticated());
        }
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onRefreshTokenRequested(
    AuthRefreshTokenRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      // Token refresh is handled automatically in the API client interceptor
      // This method is kept for future manual refresh needs
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
