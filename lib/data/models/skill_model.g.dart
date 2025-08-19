// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkillModel _$SkillModelFromJson(Map<String, dynamic> json) => SkillModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      category: json['category'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$SkillModelToJson(SkillModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'createdAt': instance.createdAt.toIso8601String(),
    };

UserSkillModel _$UserSkillModelFromJson(Map<String, dynamic> json) =>
    UserSkillModel(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      skillId: (json['skillId'] as num).toInt(),
      proficiencyLevel: json['proficiencyLevel'] as String,
      yearsOfExperience: (json['yearsOfExperience'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      skill: json['skill'] == null
          ? null
          : SkillModel.fromJson(json['skill'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserSkillModelToJson(UserSkillModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'skillId': instance.skillId,
      'proficiencyLevel': instance.proficiencyLevel,
      'yearsOfExperience': instance.yearsOfExperience,
      'createdAt': instance.createdAt.toIso8601String(),
      'skill': instance.skill,
    };
