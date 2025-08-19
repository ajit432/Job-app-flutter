import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'education_model.g.dart';

@JsonSerializable()
class EducationModel extends Equatable {
  final int id;
  final int userId;
  final String institutionName;
  final String? degree;
  final String? fieldOfStudy;
  final String educationLevel;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? gradePercentage;
  final bool isCurrent;
  final DateTime createdAt;
  final DateTime updatedAt;

  const EducationModel({
    required this.id,
    required this.userId,
    required this.institutionName,
    this.degree,
    this.fieldOfStudy,
    required this.educationLevel,
    this.startDate,
    this.endDate,
    this.gradePercentage,
    required this.isCurrent,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) =>
      _$EducationModelFromJson(json);

  Map<String, dynamic> toJson() => _$EducationModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        userId,
        institutionName,
        degree,
        fieldOfStudy,
        educationLevel,
        startDate,
        endDate,
        gradePercentage,
        isCurrent,
        createdAt,
        updatedAt,
      ];

  EducationModel copyWith({
    int? id,
    int? userId,
    String? institutionName,
    String? degree,
    String? fieldOfStudy,
    String? educationLevel,
    DateTime? startDate,
    DateTime? endDate,
    double? gradePercentage,
    bool? isCurrent,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EducationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      institutionName: institutionName ?? this.institutionName,
      degree: degree ?? this.degree,
      fieldOfStudy: fieldOfStudy ?? this.fieldOfStudy,
      educationLevel: educationLevel ?? this.educationLevel,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      gradePercentage: gradePercentage ?? this.gradePercentage,
      isCurrent: isCurrent ?? this.isCurrent,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static EducationModel mock() {
    return EducationModel(
      id: 1,
      userId: 1,
      institutionName: 'XYZ University',
      degree: 'Bachelor of Technology',
      fieldOfStudy: 'Computer Science',
      educationLevel: 'bachelor',
      startDate: DateTime(2018, 8, 1),
      endDate: DateTime(2022, 6, 30),
      gradePercentage: 85.5,
      isCurrent: false,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    );
  }
}

enum EducationLevel {
  tenth,
  twelfth,
  diploma,
  bachelor,
  master,
  doctorate,
}

extension EducationLevelExtension on EducationLevel {
  String get displayName {
    switch (this) {
      case EducationLevel.tenth:
        return '10th Grade';
      case EducationLevel.twelfth:
        return '12th Grade';
      case EducationLevel.diploma:
        return 'Diploma';
      case EducationLevel.bachelor:
        return "Bachelor's Degree";
      case EducationLevel.master:
        return "Master's Degree";
      case EducationLevel.doctorate:
        return 'Doctorate';
    }
  }

  String get value {
    return name;
  }

  static EducationLevel fromString(String value) {
    return EducationLevel.values.firstWhere(
      (e) => e.value == value,
      orElse: () => EducationLevel.bachelor,
    );
  }
}
