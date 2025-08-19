// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      content: json['content'] as String,
      postType: $enumDecode(_$PostTypeEnumMap, json['postType']),
      mediaUrls: (json['mediaUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isCommentsEnabled: json['isCommentsEnabled'] as bool,
      visibility: json['visibility'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      company: json['company'] == null
          ? null
          : CompanyModel.fromJson(json['company'] as Map<String, dynamic>),
      interactions: json['interactions'] == null
          ? null
          : PostInteractionsModel.fromJson(
              json['interactions'] as Map<String, dynamic>),
      jobPost: json['jobPost'] == null
          ? null
          : JobPostModel.fromJson(json['jobPost'] as Map<String, dynamic>),
      commentsCount: (json['commentsCount'] as num?)?.toInt(),
      isLiked: json['isLiked'] as bool?,
      isSaved: json['isSaved'] as bool?,
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'content': instance.content,
      'postType': _$PostTypeEnumMap[instance.postType]!,
      'mediaUrls': instance.mediaUrls,
      'isCommentsEnabled': instance.isCommentsEnabled,
      'visibility': instance.visibility,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'user': instance.user,
      'company': instance.company,
      'interactions': instance.interactions,
      'jobPost': instance.jobPost,
      'commentsCount': instance.commentsCount,
      'isLiked': instance.isLiked,
      'isSaved': instance.isSaved,
    };

const _$PostTypeEnumMap = {
  PostType.personal: 'personal',
  PostType.job: 'job',
  PostType.companyUpdate: 'companyUpdate',
};

PostInteractionsModel _$PostInteractionsModelFromJson(
        Map<String, dynamic> json) =>
    PostInteractionsModel(
      likesCount: (json['likesCount'] as num).toInt(),
      lovesCount: (json['lovesCount'] as num).toInt(),
      supportsCount: (json['supportsCount'] as num).toInt(),
      savesCount: (json['savesCount'] as num).toInt(),
      totalCount: (json['totalCount'] as num).toInt(),
    );

Map<String, dynamic> _$PostInteractionsModelToJson(
        PostInteractionsModel instance) =>
    <String, dynamic>{
      'likesCount': instance.likesCount,
      'lovesCount': instance.lovesCount,
      'supportsCount': instance.supportsCount,
      'savesCount': instance.savesCount,
      'totalCount': instance.totalCount,
    };

JobPostModel _$JobPostModelFromJson(Map<String, dynamic> json) => JobPostModel(
      id: (json['id'] as num).toInt(),
      postId: (json['postId'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      requirements: json['requirements'] as String?,
      companyId: (json['companyId'] as num?)?.toInt(),
      jobType: json['jobType'] as String,
      experienceLevel: json['experienceLevel'] as String,
      salaryMin: (json['salaryMin'] as num?)?.toDouble(),
      salaryMax: (json['salaryMax'] as num?)?.toDouble(),
      currency: json['currency'] as String,
      location: json['location'] as String?,
      isRemote: json['isRemote'] as bool,
      applicationDeadline: json['applicationDeadline'] == null
          ? null
          : DateTime.parse(json['applicationDeadline'] as String),
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      company: json['company'] == null
          ? null
          : CompanyModel.fromJson(json['company'] as Map<String, dynamic>),
      requiredSkills: (json['requiredSkills'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      applicationsCount: (json['applicationsCount'] as num?)?.toInt(),
      hasApplied: json['hasApplied'] as bool?,
    );

Map<String, dynamic> _$JobPostModelToJson(JobPostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'title': instance.title,
      'description': instance.description,
      'requirements': instance.requirements,
      'companyId': instance.companyId,
      'jobType': instance.jobType,
      'experienceLevel': instance.experienceLevel,
      'salaryMin': instance.salaryMin,
      'salaryMax': instance.salaryMax,
      'currency': instance.currency,
      'location': instance.location,
      'isRemote': instance.isRemote,
      'applicationDeadline': instance.applicationDeadline?.toIso8601String(),
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'company': instance.company,
      'requiredSkills': instance.requiredSkills,
      'applicationsCount': instance.applicationsCount,
      'hasApplied': instance.hasApplied,
    };
