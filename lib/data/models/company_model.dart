import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'company_model.g.dart';

@JsonSerializable()
class CompanyModel extends Equatable {
  final int id;
  final String name;
  final String? description;
  final String? website;
  final String? logoUrl;
  final String? bannerUrl;
  final String? industry;
  final String? companySize;
  final String? location;
  final int? foundedYear;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? followersCount;
  final bool? isFollowing;

  const CompanyModel({
    required this.id,
    required this.name,
    this.description,
    this.website,
    this.logoUrl,
    this.bannerUrl,
    this.industry,
    this.companySize,
    this.location,
    this.foundedYear,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
    this.followersCount,
    this.isFollowing,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        website,
        logoUrl,
        bannerUrl,
        industry,
        companySize,
        location,
        foundedYear,
        isVerified,
        createdAt,
        updatedAt,
        followersCount,
        isFollowing,
      ];

  CompanyModel copyWith({
    int? id,
    String? name,
    String? description,
    String? website,
    String? logoUrl,
    String? bannerUrl,
    String? industry,
    String? companySize,
    String? location,
    int? foundedYear,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? followersCount,
    bool? isFollowing,
  }) {
    return CompanyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      website: website ?? this.website,
      logoUrl: logoUrl ?? this.logoUrl,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      industry: industry ?? this.industry,
      companySize: companySize ?? this.companySize,
      location: location ?? this.location,
      foundedYear: foundedYear ?? this.foundedYear,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      followersCount: followersCount ?? this.followersCount,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }

  static CompanyModel mock() {
    return CompanyModel(
      id: 1,
      name: 'Google',
      description: 'Technology company specializing in Internet-related services and products.',
      website: 'https://google.com',
      industry: 'Technology',
      companySize: '1000+',
      location: 'Mountain View, CA',
      foundedYear: 1998,
      isVerified: true,
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
      updatedAt: DateTime.now(),
      followersCount: 150000,
      isFollowing: false,
    );
  }
}

enum CompanySize {
  micro, // 1-10
  small, // 11-50
  medium, // 51-200
  large, // 201-500
  xlarge, // 501-1000
  enterprise, // 1000+
}

extension CompanySizeExtension on CompanySize {
  String get displayName {
    switch (this) {
      case CompanySize.micro:
        return '1-10 employees';
      case CompanySize.small:
        return '11-50 employees';
      case CompanySize.medium:
        return '51-200 employees';
      case CompanySize.large:
        return '201-500 employees';
      case CompanySize.xlarge:
        return '501-1000 employees';
      case CompanySize.enterprise:
        return '1000+ employees';
    }
  }

  String get value {
    switch (this) {
      case CompanySize.micro:
        return '1-10';
      case CompanySize.small:
        return '11-50';
      case CompanySize.medium:
        return '51-200';
      case CompanySize.large:
        return '201-500';
      case CompanySize.xlarge:
        return '501-1000';
      case CompanySize.enterprise:
        return '1000+';
    }
  }

  static CompanySize fromString(String value) {
    return CompanySize.values.firstWhere(
      (e) => e.value == value,
      orElse: () => CompanySize.medium,
    );
  }
}
