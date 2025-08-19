import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import '../../core/constants/app_constants.dart';
import 'user_model.dart';
import 'company_model.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel extends Equatable {
  final int id;
  final int userId;
  final String content;
  final PostType postType;
  final List<String>? mediaUrls;
  final bool isCommentsEnabled;
  final String visibility;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel? user;
  final CompanyModel? company;
  final PostInteractionsModel? interactions;
  final JobPostModel? jobPost;
  final int? commentsCount;
  final bool? isLiked;
  final bool? isSaved;

  const PostModel({
    required this.id,
    required this.userId,
    required this.content,
    required this.postType,
    this.mediaUrls,
    required this.isCommentsEnabled,
    required this.visibility,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    this.company,
    this.interactions,
    this.jobPost,
    this.commentsCount,
    this.isLiked,
    this.isSaved,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        userId,
        content,
        postType,
        mediaUrls,
        isCommentsEnabled,
        visibility,
        createdAt,
        updatedAt,
        user,
        company,
        interactions,
        jobPost,
        commentsCount,
        isLiked,
        isSaved,
      ];

  PostModel copyWith({
    int? id,
    int? userId,
    String? content,
    PostType? postType,
    List<String>? mediaUrls,
    bool? isCommentsEnabled,
    String? visibility,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserModel? user,
    CompanyModel? company,
    PostInteractionsModel? interactions,
    JobPostModel? jobPost,
    int? commentsCount,
    bool? isLiked,
    bool? isSaved,
  }) {
    return PostModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      postType: postType ?? this.postType,
      mediaUrls: mediaUrls ?? this.mediaUrls,
      isCommentsEnabled: isCommentsEnabled ?? this.isCommentsEnabled,
      visibility: visibility ?? this.visibility,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
      company: company ?? this.company,
      interactions: interactions ?? this.interactions,
      jobPost: jobPost ?? this.jobPost,
      commentsCount: commentsCount ?? this.commentsCount,
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  static PostModel mock() {
    return PostModel(
      id: 1,
      userId: 1,
      content: 'Excited to announce my new project! 🚀',
      postType: PostType.personal,
      isCommentsEnabled: true,
      visibility: 'followers',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
      user: UserModel.mock(),
      interactions: PostInteractionsModel.mock(),
      commentsCount: 5,
      isLiked: false,
      isSaved: false,
    );
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }
}

@JsonSerializable()
class PostInteractionsModel extends Equatable {
  final int likesCount;
  final int lovesCount;
  final int supportsCount;
  final int savesCount;
  final int totalCount;

  const PostInteractionsModel({
    required this.likesCount,
    required this.lovesCount,
    required this.supportsCount,
    required this.savesCount,
    required this.totalCount,
  });

  factory PostInteractionsModel.fromJson(Map<String, dynamic> json) =>
      _$PostInteractionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostInteractionsModelToJson(this);

  @override
  List<Object?> get props => [
        likesCount,
        lovesCount,
        supportsCount,
        savesCount,
        totalCount,
      ];

  PostInteractionsModel copyWith({
    int? likesCount,
    int? lovesCount,
    int? supportsCount,
    int? savesCount,
    int? totalCount,
  }) {
    return PostInteractionsModel(
      likesCount: likesCount ?? this.likesCount,
      lovesCount: lovesCount ?? this.lovesCount,
      supportsCount: supportsCount ?? this.supportsCount,
      savesCount: savesCount ?? this.savesCount,
      totalCount: totalCount ?? this.totalCount,
    );
  }

  static PostInteractionsModel mock() {
    return const PostInteractionsModel(
      likesCount: 15,
      lovesCount: 3,
      supportsCount: 8,
      savesCount: 2,
      totalCount: 28,
    );
  }
}

@JsonSerializable()
class JobPostModel extends Equatable {
  final int id;
  final int postId;
  final String title;
  final String description;
  final String? requirements;
  final int? companyId;
  final String jobType;
  final String experienceLevel;
  final double? salaryMin;
  final double? salaryMax;
  final String currency;
  final String? location;
  final bool isRemote;
  final DateTime? applicationDeadline;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final CompanyModel? company;
  final List<String>? requiredSkills;
  final int? applicationsCount;
  final bool? hasApplied;

  const JobPostModel({
    required this.id,
    required this.postId,
    required this.title,
    required this.description,
    this.requirements,
    this.companyId,
    required this.jobType,
    required this.experienceLevel,
    this.salaryMin,
    this.salaryMax,
    required this.currency,
    this.location,
    required this.isRemote,
    this.applicationDeadline,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.company,
    this.requiredSkills,
    this.applicationsCount,
    this.hasApplied,
  });

  factory JobPostModel.fromJson(Map<String, dynamic> json) =>
      _$JobPostModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobPostModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        postId,
        title,
        description,
        requirements,
        companyId,
        jobType,
        experienceLevel,
        salaryMin,
        salaryMax,
        currency,
        location,
        isRemote,
        applicationDeadline,
        isActive,
        createdAt,
        updatedAt,
        company,
        requiredSkills,
        applicationsCount,
        hasApplied,
      ];

  JobPostModel copyWith({
    int? id,
    int? postId,
    String? title,
    String? description,
    String? requirements,
    int? companyId,
    String? jobType,
    String? experienceLevel,
    double? salaryMin,
    double? salaryMax,
    String? currency,
    String? location,
    bool? isRemote,
    DateTime? applicationDeadline,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    CompanyModel? company,
    List<String>? requiredSkills,
    int? applicationsCount,
    bool? hasApplied,
  }) {
    return JobPostModel(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      title: title ?? this.title,
      description: description ?? this.description,
      requirements: requirements ?? this.requirements,
      companyId: companyId ?? this.companyId,
      jobType: jobType ?? this.jobType,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      salaryMin: salaryMin ?? this.salaryMin,
      salaryMax: salaryMax ?? this.salaryMax,
      currency: currency ?? this.currency,
      location: location ?? this.location,
      isRemote: isRemote ?? this.isRemote,
      applicationDeadline: applicationDeadline ?? this.applicationDeadline,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      company: company ?? this.company,
      requiredSkills: requiredSkills ?? this.requiredSkills,
      applicationsCount: applicationsCount ?? this.applicationsCount,
      hasApplied: hasApplied ?? this.hasApplied,
    );
  }

  String get salaryRange {
    if (salaryMin != null && salaryMax != null) {
      return '${_formatSalary(salaryMin!)} - ${_formatSalary(salaryMax!)} $currency';
    } else if (salaryMin != null) {
      return 'From ${_formatSalary(salaryMin!)} $currency';
    } else if (salaryMax != null) {
      return 'Up to ${_formatSalary(salaryMax!)} $currency';
    } else {
      return 'Salary not disclosed';
    }
  }

  String _formatSalary(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(0)}K';
    } else {
      return amount.toStringAsFixed(0);
    }
  }

  String get locationDisplay {
    if (isRemote && location != null) {
      return '$location (Remote)';
    } else if (isRemote) {
      return 'Remote';
    } else if (location != null) {
      return location!;
    } else {
      return 'Location not specified';
    }
  }

  static JobPostModel mock() {
    return JobPostModel(
      id: 1,
      postId: 1,
      title: 'Senior Flutter Developer',
      description: 'We are looking for an experienced Flutter developer to join our team...',
      requirements: 'Flutter, Dart, Firebase, REST APIs',
      companyId: 1,
      jobType: 'full_time',
      experienceLevel: 'senior',
      salaryMin: 80000,
      salaryMax: 120000,
      currency: 'USD',
      location: 'San Francisco, CA',
      isRemote: true,
      applicationDeadline: DateTime.now().add(const Duration(days: 30)),
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
      company: CompanyModel.mock(),
      requiredSkills: ['Flutter', 'Dart', 'Firebase'],
      applicationsCount: 25,
      hasApplied: false,
    );
  }
}

enum JobType {
  fullTime,
  partTime,
  contract,
  internship,
  freelance,
}

extension JobTypeExtension on JobType {
  String get displayName {
    switch (this) {
      case JobType.fullTime:
        return 'Full-time';
      case JobType.partTime:
        return 'Part-time';
      case JobType.contract:
        return 'Contract';
      case JobType.internship:
        return 'Internship';
      case JobType.freelance:
        return 'Freelance';
    }
  }

  String get value {
    switch (this) {
      case JobType.fullTime:
        return 'full_time';
      case JobType.partTime:
        return 'part_time';
      case JobType.contract:
        return 'contract';
      case JobType.internship:
        return 'internship';
      case JobType.freelance:
        return 'freelance';
    }
  }

  static JobType fromString(String value) {
    return JobType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => JobType.fullTime,
    );
  }
}

enum ExperienceLevel {
  entry,
  mid,
  senior,
  lead,
  executive,
}

extension ExperienceLevelExtension on ExperienceLevel {
  String get displayName {
    switch (this) {
      case ExperienceLevel.entry:
        return 'Entry Level';
      case ExperienceLevel.mid:
        return 'Mid Level';
      case ExperienceLevel.senior:
        return 'Senior Level';
      case ExperienceLevel.lead:
        return 'Lead Level';
      case ExperienceLevel.executive:
        return 'Executive Level';
    }
  }

  String get value {
    return name;
  }

  static ExperienceLevel fromString(String value) {
    return ExperienceLevel.values.firstWhere(
      (e) => e.value == value,
      orElse: () => ExperienceLevel.mid,
    );
  }
}

enum PostVisibility {
  public,
  followers,
  private,
}

extension PostVisibilityExtension on PostVisibility {
  String get displayName {
    switch (this) {
      case PostVisibility.public:
        return 'Public';
      case PostVisibility.followers:
        return 'Followers';
      case PostVisibility.private:
        return 'Private';
    }
  }

  String get value {
    return name;
  }

  static PostVisibility fromString(String value) {
    return PostVisibility.values.firstWhere(
      (e) => e.value == value,
      orElse: () => PostVisibility.followers,
    );
  }
}
