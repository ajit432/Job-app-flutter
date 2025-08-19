// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      isActive: json['isActive'] as bool,
      profileType: $enumDecodeNullable(_$UserTypeEnumMap, json['profileType']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      profile: json['profile'] == null
          ? null
          : UserProfileModel.fromJson(json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'isActive': instance.isActive,
      'profileType': _$UserTypeEnumMap[instance.profileType],
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'profile': instance.profile,
    };

const _$UserTypeEnumMap = {
  UserType.jobSeeker: 'jobSeeker',
  UserType.recruiter: 'recruiter',
};

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      fullName: json['fullName'] as String?,
      profileImage: json['profileImage'] as String?,
      bannerImage: json['bannerImage'] as String?,
      bio: json['bio'] as String?,
      location: json['location'] as String?,
      preferredJobLocation: json['preferredJobLocation'] as String?,
      phone: json['phone'] as String?,
      website: json['website'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'fullName': instance.fullName,
      'profileImage': instance.profileImage,
      'bannerImage': instance.bannerImage,
      'bio': instance.bio,
      'location': instance.location,
      'preferredJobLocation': instance.preferredJobLocation,
      'phone': instance.phone,
      'website': instance.website,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

JobSeekerProfileModel _$JobSeekerProfileModelFromJson(
        Map<String, dynamic> json) =>
    JobSeekerProfileModel(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      resumeUrl: json['resumeUrl'] as String?,
      experienceYears: (json['experienceYears'] as num).toInt(),
      currentSalary: (json['currentSalary'] as num?)?.toDouble(),
      expectedSalary: (json['expectedSalary'] as num?)?.toDouble(),
      availabilityStatus: json['availabilityStatus'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$JobSeekerProfileModelToJson(
        JobSeekerProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'resumeUrl': instance.resumeUrl,
      'experienceYears': instance.experienceYears,
      'currentSalary': instance.currentSalary,
      'expectedSalary': instance.expectedSalary,
      'availabilityStatus': instance.availabilityStatus,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

RecruiterProfileModel _$RecruiterProfileModelFromJson(
        Map<String, dynamic> json) =>
    RecruiterProfileModel(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      companyId: (json['companyId'] as num?)?.toInt(),
      position: json['position'] as String?,
      isCompanyOwner: json['isCompanyOwner'] as bool,
      department: json['department'] as String?,
      hiringAuthorityLevel: json['hiringAuthorityLevel'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$RecruiterProfileModelToJson(
        RecruiterProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'companyId': instance.companyId,
      'position': instance.position,
      'isCompanyOwner': instance.isCompanyOwner,
      'department': instance.department,
      'hiringAuthorityLevel': instance.hiringAuthorityLevel,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
