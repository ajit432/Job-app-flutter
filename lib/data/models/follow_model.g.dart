// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowModel _$FollowModelFromJson(Map<String, dynamic> json) => FollowModel(
      id: (json['id'] as num).toInt(),
      followerId: (json['followerId'] as num).toInt(),
      followingId: (json['followingId'] as num).toInt(),
      followingType: json['followingType'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      follower: json['follower'] == null
          ? null
          : UserModel.fromJson(json['follower'] as Map<String, dynamic>),
      followingUser: json['followingUser'] == null
          ? null
          : UserModel.fromJson(json['followingUser'] as Map<String, dynamic>),
      followingCompany: json['followingCompany'] == null
          ? null
          : CompanyModel.fromJson(
              json['followingCompany'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FollowModelToJson(FollowModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'followerId': instance.followerId,
      'followingId': instance.followingId,
      'followingType': instance.followingType,
      'createdAt': instance.createdAt.toIso8601String(),
      'follower': instance.follower,
      'followingUser': instance.followingUser,
      'followingCompany': instance.followingCompany,
    };

FollowStatsModel _$FollowStatsModelFromJson(Map<String, dynamic> json) =>
    FollowStatsModel(
      followersCount: (json['followersCount'] as num).toInt(),
      followingCount: (json['followingCount'] as num).toInt(),
      followingUsersCount: (json['followingUsersCount'] as num).toInt(),
      followingCompaniesCount: (json['followingCompaniesCount'] as num).toInt(),
    );

Map<String, dynamic> _$FollowStatsModelToJson(FollowStatsModel instance) =>
    <String, dynamic>{
      'followersCount': instance.followersCount,
      'followingCount': instance.followingCount,
      'followingUsersCount': instance.followingUsersCount,
      'followingCompaniesCount': instance.followingCompaniesCount,
    };

SuggestedUserModel _$SuggestedUserModelFromJson(Map<String, dynamic> json) =>
    SuggestedUserModel(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      reason: json['reason'] as String,
      mutualConnections: (json['mutualConnections'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      mutualConnectionsCount: (json['mutualConnectionsCount'] as num).toInt(),
    );

Map<String, dynamic> _$SuggestedUserModelToJson(SuggestedUserModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'reason': instance.reason,
      'mutualConnections': instance.mutualConnections,
      'mutualConnectionsCount': instance.mutualConnectionsCount,
    };
