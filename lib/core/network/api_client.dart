import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class ApiClient {
  static late Dio _dio;
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    
    _dio = Dio(BaseOptions(
      baseUrl: '${AppConstants.baseUrl}/v1',
      connectTimeout: const Duration(milliseconds: AppConstants.connectTimeout),
      receiveTimeout: const Duration(milliseconds: AppConstants.receiveTimeout),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Add interceptors
    _dio.interceptors.add(_AuthInterceptor());
    
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
      ));
    }
  }

  static Dio get dio => _dio;
  static SharedPreferences get prefs => _prefs;

  // Auth methods
  static Future<Response> login(Map<String, dynamic> data) async {
    return await _dio.post('/auth/login', data: data);
  }

  static Future<Response> register(Map<String, dynamic> data) async {
    return await _dio.post('/auth/register', data: data);
  }

  static Future<Response> googleAuth(Map<String, dynamic> data) async {
    return await _dio.post('/auth/google', data: data);
  }

  static Future<Response> requestOtp(Map<String, dynamic> data) async {
    return await _dio.post('/auth/request-otp', data: data);
  }

  static Future<Response> verifyOtp(Map<String, dynamic> data) async {
    return await _dio.post('/auth/verify-otp', data: data);
  }

  static Future<Response> resetPassword(Map<String, dynamic> data) async {
    return await _dio.post('/auth/reset-password', data: data);
  }

  static Future<Response> refreshToken(Map<String, dynamic> data) async {
    return await _dio.post('/auth/refresh-token', data: data);
  }

  static Future<Response> logout() async {
    return await _dio.post('/auth/logout');
  }

  // User methods
  static Future<Response> getUserProfile() async {
    return await _dio.get('/user/profile');
  }

  static Future<Response> updateProfile(Map<String, dynamic> data) async {
    return await _dio.put('/user/profile', data: data);
  }
}

class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = ApiClient.prefs.getString(AppConstants.accessTokenKey);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token expired, try to refresh
      try {
        final refreshToken = ApiClient.prefs.getString(AppConstants.refreshTokenKey);
        if (refreshToken != null) {
          final response = await ApiClient.refreshToken({'refreshToken': refreshToken});
          if (response.statusCode == 200) {
            final data = response.data;
            if (data['success'] == true) {
              final newToken = data['data']['accessToken'];
              await ApiClient.prefs.setString(AppConstants.accessTokenKey, newToken);
              
              // Retry the original request
              final opts = err.requestOptions;
              opts.headers['Authorization'] = 'Bearer $newToken';
              final cloneReq = await ApiClient.dio.fetch(opts);
              handler.resolve(cloneReq);
              return;
            }
          }
        }
        
        // If refresh fails, clear tokens and redirect to login
        await _clearTokens();
      } catch (e) {
        await _clearTokens();
      }
    }
    handler.next(err);
  }

  Future<void> _clearTokens() async {
    await ApiClient.prefs.remove(AppConstants.accessTokenKey);
    await ApiClient.prefs.remove(AppConstants.refreshTokenKey);
    await ApiClient.prefs.remove(AppConstants.userIdKey);
  }
}
