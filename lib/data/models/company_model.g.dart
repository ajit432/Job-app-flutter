// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) => CompanyModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      website: json['website'] as String?,
      logoUrl: json['logoUrl'] as String?,
      bannerUrl: json['bannerUrl'] as String?,
      industry: json['industry'] as String?,
      companySize: json['companySize'] as String?,
      location: json['location'] as String?,
      foundedYear: (json['foundedYear'] as num?)?.toInt(),
      isVerified: json['isVerified'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      followersCount: (json['followersCount'] as num?)?.toInt(),
      isFollowing: json['isFollowing'] as bool?,
    );

Map<String, dynamic> _$CompanyModelToJson(CompanyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'website': instance.website,
      'logoUrl': instance.logoUrl,
      'bannerUrl': instance.bannerUrl,
      'industry': instance.industry,
      'companySize': instance.companySize,
      'location': instance.location,
      'foundedYear': instance.foundedYear,
      'isVerified': instance.isVerified,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'followersCount': instance.followersCount,
      'isFollowing': instance.isFollowing,
    };
