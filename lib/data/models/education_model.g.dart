// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EducationModel _$EducationModelFromJson(Map<String, dynamic> json) =>
    EducationModel(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      institutionName: json['institutionName'] as String,
      degree: json['degree'] as String?,
      fieldOfStudy: json['fieldOfStudy'] as String?,
      educationLevel: json['educationLevel'] as String,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      gradePercentage: (json['gradePercentage'] as num?)?.toDouble(),
      isCurrent: json['isCurrent'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$EducationModelToJson(EducationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'institutionName': instance.institutionName,
      'degree': instance.degree,
      'fieldOfStudy': instance.fieldOfStudy,
      'educationLevel': instance.educationLevel,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'gradePercentage': instance.gradePercentage,
      'isCurrent': instance.isCurrent,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
