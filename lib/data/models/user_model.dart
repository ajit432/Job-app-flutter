import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import '../../core/constants/app_constants.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final int id;
  final String email;
  final bool isActive;
  final UserType? profileType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserProfileModel? profile;

  const UserModel({
    required this.id,
    required this.email,
    required this.isActive,
    this.profileType,
    required this.createdAt,
    required this.updatedAt,
    this.profile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      email: json['email'] as String,
      isActive: json['isActive'] == 1 || json['isActive'] == true,
      profileType: json['profileType'] != null ? 
        UserTypeExtension.fromString(json['profileType'] as String) : null,
      createdAt: _parseDateTime(json['createdAt'] as String),
      updatedAt: _parseDateTime(json['updatedAt'] as String),
      profile: json['profile'] != null ? 
        UserProfileModel.fromJson(json['profile'] as Map<String, dynamic>) : null,
    );
  }

  // Helper method to parse date strings with different formats
  static DateTime _parseDateTime(String dateString) {
    try {
      // Try to parse as ISO format first
      return DateTime.parse(dateString);
    } catch (e) {
      try {
        // Handle the specific format from backend: "2025-08-20  01:05"
        // Replace double spaces with single space and add seconds if missing
        String normalizedDate = dateString.replaceAll('  ', ' ');
        if (normalizedDate.split(' ').length == 2) {
          normalizedDate += ':00'; // Add seconds if missing
        }
        return DateTime.parse(normalizedDate);
      } catch (e) {
        // If all parsing fails, return current time as fallback
        return DateTime.now();
      }
    }
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        email,
        isActive,
        profileType,
        createdAt,
        updatedAt,
        profile,
      ];

  UserModel copyWith({
    int? id,
    String? email,
    bool? isActive,
    UserType? profileType,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserProfileModel? profile,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      isActive: isActive ?? this.isActive,
      profileType: profileType ?? this.profileType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      profile: profile ?? this.profile,
    );
  }

  // Mock data for testing
  static UserModel mock() {
    return UserModel(
      id: 1,
      email: 'test@example.com',
      isActive: true,
      profileType: UserType.job_seeker,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
      profile: UserProfileModel.mock(),
    );
  }
}

@JsonSerializable()
class UserProfileModel extends Equatable {
  final int id;
  final int userId;
  final String? fullName;
  final String? profileImage;
  final String? bannerImage;
  final String? bio;
  final String? location;
  final String? preferredJobLocation;
  final String? phone;
  final String? website;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserProfileModel({
    required this.id,
    required this.userId,
    this.fullName,
    this.profileImage,
    this.bannerImage,
    this.bio,
    this.location,
    this.preferredJobLocation,
    this.phone,
    this.website,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        userId,
        fullName,
        profileImage,
        bannerImage,
        bio,
        location,
        preferredJobLocation,
        phone,
        website,
        createdAt,
        updatedAt,
      ];

  UserProfileModel copyWith({
    int? id,
    int? userId,
    String? fullName,
    String? profileImage,
    String? bannerImage,
    String? bio,
    String? location,
    String? preferredJobLocation,
    String? phone,
    String? website,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      profileImage: profileImage ?? this.profileImage,
      bannerImage: bannerImage ?? this.bannerImage,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      preferredJobLocation: preferredJobLocation ?? this.preferredJobLocation,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static UserProfileModel mock() {
    return UserProfileModel(
      id: 1,
      userId: 1,
      fullName: 'John Doe',
      bio: 'Software Developer passionate about creating amazing user experiences.',
      location: 'San Francisco, CA',
      preferredJobLocation: 'Remote',
      phone: '+1 (555) 123-4567',
      website: 'https://johndoe.dev',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    );
  }
}

@JsonSerializable()
class JobSeekerProfileModel extends Equatable {
  final int id;
  final int userId;
  final String? resumeUrl;
  final int experienceYears;
  final double? currentSalary;
  final double? expectedSalary;
  final String availabilityStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  const JobSeekerProfileModel({
    required this.id,
    required this.userId,
    this.resumeUrl,
    required this.experienceYears,
    this.currentSalary,
    this.expectedSalary,
    required this.availabilityStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JobSeekerProfileModel.fromJson(Map<String, dynamic> json) =>
      _$JobSeekerProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobSeekerProfileModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        userId,
        resumeUrl,
        experienceYears,
        currentSalary,
        expectedSalary,
        availabilityStatus,
        createdAt,
        updatedAt,
      ];

  JobSeekerProfileModel copyWith({
    int? id,
    int? userId,
    String? resumeUrl,
    int? experienceYears,
    double? currentSalary,
    double? expectedSalary,
    String? availabilityStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return JobSeekerProfileModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      resumeUrl: resumeUrl ?? this.resumeUrl,
      experienceYears: experienceYears ?? this.experienceYears,
      currentSalary: currentSalary ?? this.currentSalary,
      expectedSalary: expectedSalary ?? this.expectedSalary,
      availabilityStatus: availabilityStatus ?? this.availabilityStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

@JsonSerializable()
class RecruiterProfileModel extends Equatable {
  final int id;
  final int userId;
  final int? companyId;
  final String? position;
  final bool isCompanyOwner;
  final String? department;
  final String hiringAuthorityLevel;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RecruiterProfileModel({
    required this.id,
    required this.userId,
    this.companyId,
    this.position,
    required this.isCompanyOwner,
    this.department,
    required this.hiringAuthorityLevel,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RecruiterProfileModel.fromJson(Map<String, dynamic> json) =>
      _$RecruiterProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecruiterProfileModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        userId,
        companyId,
        position,
        isCompanyOwner,
        department,
        hiringAuthorityLevel,
        createdAt,
        updatedAt,
      ];

  RecruiterProfileModel copyWith({
    int? id,
    int? userId,
    int? companyId,
    String? position,
    bool? isCompanyOwner,
    String? department,
    String? hiringAuthorityLevel,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RecruiterProfileModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      companyId: companyId ?? this.companyId,
      position: position ?? this.position,
      isCompanyOwner: isCompanyOwner ?? this.isCompanyOwner,
      department: department ?? this.department,
      hiringAuthorityLevel: hiringAuthorityLevel ?? this.hiringAuthorityLevel,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

extension UserTypeExtension on UserType {
  String get value {
    switch (this) {
      case UserType.job_seeker:
        return 'job_seeker';
      case UserType.recruiter:
        return 'recruiter';
      case UserType.companies:
        return 'companies';
    }
  }

  static UserType fromString(String value) {
    switch (value) {
      case 'job_seeker':
        return UserType.job_seeker;
      case 'recruiter':
        return UserType.recruiter;
      case 'companies':
        return UserType.companies;
      default:
        return UserType.job_seeker;
    }
  }
}
