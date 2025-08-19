import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'experience_model.g.dart';

@JsonSerializable()
class ExperienceModel extends Equatable {
  final int id;
  final int userId;
  final String companyName;
  final String jobTitle;
  final String employmentType;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isCurrent;
  final String? description;
  final String? location;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ExperienceModel({
    required this.id,
    required this.userId,
    required this.companyName,
    required this.jobTitle,
    required this.employmentType,
    required this.startDate,
    this.endDate,
    required this.isCurrent,
    this.description,
    this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) =>
      _$ExperienceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        userId,
        companyName,
        jobTitle,
        employmentType,
        startDate,
        endDate,
        isCurrent,
        description,
        location,
        createdAt,
        updatedAt,
      ];

  ExperienceModel copyWith({
    int? id,
    int? userId,
    String? companyName,
    String? jobTitle,
    String? employmentType,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrent,
    String? description,
    String? location,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ExperienceModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      companyName: companyName ?? this.companyName,
      jobTitle: jobTitle ?? this.jobTitle,
      employmentType: employmentType ?? this.employmentType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCurrent: isCurrent ?? this.isCurrent,
      description: description ?? this.description,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static ExperienceModel mock() {
    return ExperienceModel(
      id: 1,
      userId: 1,
      companyName: 'Tech Corp',
      jobTitle: 'Software Developer',
      employmentType: 'full_time',
      startDate: DateTime(2022, 1, 15),
      endDate: DateTime(2023, 12, 31),
      isCurrent: false,
      description: 'Developed mobile applications using Flutter and backend APIs.',
      location: 'San Francisco, CA',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    );
  }

  String get formattedDuration {
    final start = startDate;
    final end = endDate ?? DateTime.now();
    final difference = end.difference(start);
    final years = (difference.inDays / 365).floor();
    final months = ((difference.inDays % 365) / 30).floor();
    
    if (years > 0 && months > 0) {
      return '$years yr $months mo';
    } else if (years > 0) {
      return '$years yr';
    } else if (months > 0) {
      return '$months mo';
    } else {
      return '< 1 mo';
    }
  }
}

enum EmploymentType {
  fullTime,
  partTime,
  contract,
  internship,
  freelance,
}

extension EmploymentTypeExtension on EmploymentType {
  String get displayName {
    switch (this) {
      case EmploymentType.fullTime:
        return 'Full-time';
      case EmploymentType.partTime:
        return 'Part-time';
      case EmploymentType.contract:
        return 'Contract';
      case EmploymentType.internship:
        return 'Internship';
      case EmploymentType.freelance:
        return 'Freelance';
    }
  }

  String get value {
    switch (this) {
      case EmploymentType.fullTime:
        return 'full_time';
      case EmploymentType.partTime:
        return 'part_time';
      case EmploymentType.contract:
        return 'contract';
      case EmploymentType.internship:
        return 'internship';
      case EmploymentType.freelance:
        return 'freelance';
    }
  }

  static EmploymentType fromString(String value) {
    return EmploymentType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => EmploymentType.fullTime,
    );
  }
}
