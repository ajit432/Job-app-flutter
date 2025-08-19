import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'api_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponseModel<T> extends Equatable {
  final bool success;
  final String message;
  final T? data;
  final String? error;
  final int? statusCode;
  final PaginationModel? pagination;

  const ApiResponseModel({
    required this.success,
    required this.message,
    this.data,
    this.error,
    this.statusCode,
    this.pagination,
  });

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiResponseModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiResponseModelToJson(this, toJsonT);

  @override
  List<Object?> get props => [
        success,
        message,
        data,
        error,
        statusCode,
        pagination,
      ];

  ApiResponseModel<T> copyWith({
    bool? success,
    String? message,
    T? data,
    String? error,
    int? statusCode,
    PaginationModel? pagination,
  }) {
    return ApiResponseModel<T>(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
      error: error ?? this.error,
      statusCode: statusCode ?? this.statusCode,
      pagination: pagination ?? this.pagination,
    );
  }

  static ApiResponseModel<T> successResponse<T>({
    required String message,
    T? data,
    PaginationModel? pagination,
  }) {
    return ApiResponseModel<T>(
      success: true,
      message: message,
      data: data,
      statusCode: 200,
      pagination: pagination,
    );
  }

  static ApiResponseModel<T> errorResponse<T>({
    required String message,
    String? error,
    int? statusCode,
  }) {
    return ApiResponseModel<T>(
      success: false,
      message: message,
      error: error,
      statusCode: statusCode ?? 400,
    );
  }

  bool get isSuccess => success && error == null;
  bool get hasData => data != null;
  bool get hasPagination => pagination != null;
}

@JsonSerializable()
class PaginationModel extends Equatable {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const PaginationModel({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);

  @override
  List<Object?> get props => [
        currentPage,
        totalPages,
        totalItems,
        itemsPerPage,
        hasNextPage,
        hasPreviousPage,
      ];

  PaginationModel copyWith({
    int? currentPage,
    int? totalPages,
    int? totalItems,
    int? itemsPerPage,
    bool? hasNextPage,
    bool? hasPreviousPage,
  }) {
    return PaginationModel(
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
    );
  }

  static PaginationModel mock() {
    return const PaginationModel(
      currentPage: 1,
      totalPages: 10,
      totalItems: 100,
      itemsPerPage: 10,
      hasNextPage: true,
      hasPreviousPage: false,
    );
  }

  String get displayText => 'Page $currentPage of $totalPages';
  int get startIndex => (currentPage - 1) * itemsPerPage + 1;
  int get endIndex {
    final end = currentPage * itemsPerPage;
    return end > totalItems ? totalItems : end;
  }

  String get itemsDisplayText => '$startIndex-$endIndex of $totalItems items';
}

@JsonSerializable()
class ErrorModel extends Equatable {
  final String code;
  final String message;
  final String? field;
  final Map<String, dynamic>? details;

  const ErrorModel({
    required this.code,
    required this.message,
    this.field,
    this.details,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorModelToJson(this);

  @override
  List<Object?> get props => [code, message, field, details];

  ErrorModel copyWith({
    String? code,
    String? message,
    String? field,
    Map<String, dynamic>? details,
  }) {
    return ErrorModel(
      code: code ?? this.code,
      message: message ?? this.message,
      field: field ?? this.field,
      details: details ?? this.details,
    );
  }

  static ErrorModel validation({
    required String message,
    String? field,
  }) {
    return ErrorModel(
      code: 'validation_error',
      message: message,
      field: field,
    );
  }

  static ErrorModel network({String? message}) {
    return ErrorModel(
      code: 'network_error',
      message: message ?? 'Network error occurred',
    );
  }

  static ErrorModel server({String? message}) {
    return ErrorModel(
      code: 'server_error',
      message: message ?? 'Server error occurred',
    );
  }

  static ErrorModel unauthorized({String? message}) {
    return ErrorModel(
      code: 'unauthorized',
      message: message ?? 'Unauthorized access',
    );
  }

  static ErrorModel notFound({String? message}) {
    return ErrorModel(
      code: 'not_found',
      message: message ?? 'Resource not found',
    );
  }

  bool get isValidationError => code == 'validation_error';
  bool get isNetworkError => code == 'network_error';
  bool get isServerError => code == 'server_error';
  bool get isUnauthorizedError => code == 'unauthorized';
  bool get isNotFoundError => code == 'not_found';
}

// Helper extension for common API response handling
extension ApiResponseExtension<T> on ApiResponseModel<T> {
  /// Returns the data if success, throws exception if error
  T get requireData {
    if (!success || data == null) {
      throw Exception(error ?? message);
    }
    return data!;
  }

  /// Returns data or null
  T? get dataOrNull => success ? data : null;

  /// Returns error message
  String get errorMessage => error ?? message;
}
