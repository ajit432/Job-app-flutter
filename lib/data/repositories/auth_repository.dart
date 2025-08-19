import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../core/network/api_client.dart';
import '../../core/constants/app_constants.dart';
import '../models/auth_model.dart';
import '../models/user_model.dart';

class AuthRepository {
  // final ApiClient _apiClient; // Removed as ApiClient methods are static
  final SharedPreferences _prefs;

  AuthRepository() :
    // _apiClient = ApiClient, // Removed as ApiClient methods are static
    _prefs = ApiClient.prefs;

  // Login with email and password
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await ApiClient.login({
        'email': email,
        'password': password,
        'loginType': 'password',
      });

      final authResponse = AuthResponseModel.fromJson(response.data);
      
      if (authResponse.success && authResponse.data != null) {
        // Store tokens and user info
        await _saveAuthData(authResponse.data!);
      }
      
      return authResponse;
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return AuthResponseModel.errorResponse(
        message: 'An unexpected error occurred',
      );
    }
  }

  // Login with OTP
  Future<AuthResponseModel> loginWithOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await ApiClient.login({
        'email': email,
        'otp': otp,
        'loginType': 'otp',
      });

      final authResponse = AuthResponseModel.fromJson(response.data);
      
      if (authResponse.success && authResponse.data != null) {
        await _saveAuthData(authResponse.data!);
      }
      
      return authResponse;
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return AuthResponseModel.errorResponse(
        message: 'An unexpected error occurred',
      );
    }
  }

  // Register new user
  Future<AuthResponseModel> register({
    required String email,
    required String password,
  }) async {
    try {
      final response = await ApiClient.register({
        'email': email,
        'password': password,
        'registrationType': 'email',
      });

      final authResponse = AuthResponseModel.fromJson(response.data);
      
      if (authResponse.success && authResponse.data != null) {
        await _saveAuthData(authResponse.data!);
      }
      
      return authResponse;
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return AuthResponseModel.errorResponse(
        message: 'An unexpected error occurred',
      );
    }
  }

  // Google Authentication
  Future<AuthResponseModel> googleAuth({
    required String idToken,
  }) async {
    try {
      final response = await ApiClient.googleAuth({
        'idToken': idToken,
      });

      final authResponse = AuthResponseModel.fromJson(response.data);
      
      if (authResponse.success && authResponse.data != null) {
        await _saveAuthData(authResponse.data!);
      }
      
      return authResponse;
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return AuthResponseModel.errorResponse(
        message: 'An unexpected error occurred',
      );
    }
  }

  // Request OTP
  Future<OtpResponseModel> requestOtp({
    required String email,
    String type = 'login',
  }) async {
    try {
      final response = await ApiClient.requestOtp({
        'email': email,
        'type': type,
      });

      return OtpResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      return OtpResponseModel(
        success: false,
        message: _getDioErrorMessage(e),
      );
    } catch (e) {
      return const OtpResponseModel(
        success: false,
        message: 'An unexpected error occurred',
      );
    }
  }

  // Verify OTP
  Future<AuthResponseModel> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await ApiClient.verifyOtp({
        'email': email,
        'otp': otp,
      });

      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return AuthResponseModel.errorResponse(
        message: 'An unexpected error occurred',
      );
    }
  }

  // Reset Password
  Future<AuthResponseModel> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      final response = await ApiClient.resetPassword({
        'email': email,
        'otp': otp,
        'newPassword': newPassword,
      });

      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return AuthResponseModel.errorResponse(
        message: 'An unexpected error occurred',
      );
    }
  }

  // Logout
  Future<AuthResponseModel> logout() async {
    try {
      final response = await ApiClient.logout();
      
      // Clear stored auth data
      await _clearAuthData();
      
      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      // Even if API call fails, clear local data
      await _clearAuthData();
      return _handleDioError(e);
    } catch (e) {
      await _clearAuthData();
      return AuthResponseModel.errorResponse(
        message: 'An unexpected error occurred',
      );
    }
  }

  // Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final token = _prefs.getString(AppConstants.accessTokenKey);
    return token != null && token.isNotEmpty;
  }

  // Get current user
  Future<UserModel?> getCurrentUser() async {
    try {
      final userJson = _prefs.getString(AppConstants.userProfileKey);
      if (userJson != null) {
        return UserModel.fromJson(jsonDecode(userJson));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Get stored access token
  String? getAccessToken() {
    return _prefs.getString(AppConstants.accessTokenKey);
  }

  // Private helper methods
  Future<void> _saveAuthData(AuthDataModel authData) async {
    await _prefs.setString(AppConstants.accessTokenKey, authData.accessToken);
    await _prefs.setInt(AppConstants.userIdKey, authData.user.id);
    await _prefs.setString(AppConstants.userProfileKey, jsonEncode(authData.user.toJson()));
  }

  Future<void> _clearAuthData() async {
    await _prefs.remove(AppConstants.accessTokenKey);
    await _prefs.remove(AppConstants.refreshTokenKey);
    await _prefs.remove(AppConstants.userIdKey);
    await _prefs.remove(AppConstants.userProfileKey);
  }

  AuthResponseModel _handleDioError(DioException e) {
    String message = 'An error occurred';
    
    if (e.response != null) {
      final data = e.response!.data;
      if (data is Map<String, dynamic> && data.containsKey('message')) {
        message = data['message'] as String;
      } else {
        switch (e.response!.statusCode) {
          case 400:
            message = 'Invalid request';
            break;
          case 401:
            message = 'Invalid credentials';
            break;
          case 403:
            message = 'Access denied';
            break;
          case 404:
            message = 'User not found';
            break;
          case 409:
            message = 'User already exists';
            break;
          case 500:
            message = 'Server error. Please try again later';
            break;
          default:
            message = 'An error occurred';
        }
      }
    } else if (e.type == DioExceptionType.connectionTimeout ||
               e.type == DioExceptionType.receiveTimeout) {
      message = 'Connection timeout. Please check your internet connection';
    } else if (e.type == DioExceptionType.unknown) {
      message = 'Network error. Please check your internet connection';
    }

    return AuthResponseModel.errorResponse(message: message);
  }

  String _getDioErrorMessage(DioException e) {
    if (e.response != null) {
      final data = e.response!.data;
      if (data is Map<String, dynamic> && data.containsKey('message')) {
        return data['message'] as String;
      }
    }
    return 'An error occurred';
  }
}
