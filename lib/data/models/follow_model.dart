import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'user_model.dart';
import 'company_model.dart';

part 'follow_model.g.dart';

@JsonSerializable()
class FollowModel extends Equatable {
  final int id;
  final int followerId;
  final int followingId;
  final String followingType; // 'user' or 'company'
  final DateTime createdAt;
  final UserModel? follower;
  final UserModel? followingUser;
  final CompanyModel? followingCompany;

  const FollowModel({
    required this.id,
    required this.followerId,
    required this.followingId,
    required this.followingType,
    required this.createdAt,
    this.follower,
    this.followingUser,
    this.followingCompany,
  });

  factory FollowModel.fromJson(Map<String, dynamic> json) =>
      _$FollowModelFromJson(json);

  Map<String, dynamic> toJson() => _$FollowModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        followerId,
        followingId,
        followingType,
        createdAt,
        follower,
        followingUser,
        followingCompany,
      ];

  FollowModel copyWith({
    int? id,
    int? followerId,
    int? followingId,
    String? followingType,
    DateTime? createdAt,
    UserModel? follower,
    UserModel? followingUser,
    CompanyModel? followingCompany,
  }) {
    return FollowModel(
      id: id ?? this.id,
      followerId: followerId ?? this.followerId,
      followingId: followingId ?? this.followingId,
      followingType: followingType ?? this.followingType,
      createdAt: createdAt ?? this.createdAt,
      follower: follower ?? this.follower,
      followingUser: followingUser ?? this.followingUser,
      followingCompany: followingCompany ?? this.followingCompany,
    );
  }

  static FollowModel mock() {
    return FollowModel(
      id: 1,
      followerId: 1,
      followingId: 2,
      followingType: 'user',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      follower: UserModel.mock(),
      followingUser: UserModel.mock().copyWith(
        id: 2,
        email: 'following@example.com',
        profile: UserModel.mock().profile?.copyWith(
          id: 2,
          userId: 2,
          fullName: 'Jane Doe',
        ),
      ),
    );
  }

  bool get isFollowingUser => followingType == 'user';
  bool get isFollowingCompany => followingType == 'company';

  String get followingName {
    if (isFollowingUser && followingUser != null) {
      return followingUser!.profile?.fullName ?? followingUser!.email;
    } else if (isFollowingCompany && followingCompany != null) {
      return followingCompany!.name;
    }
    return 'Unknown';
  }

  String? get followingProfileImage {
    if (isFollowingUser && followingUser != null) {
      return followingUser!.profile?.profileImage;
    } else if (isFollowingCompany && followingCompany != null) {
      return followingCompany!.logoUrl;
    }
    return null;
  }
}

@JsonSerializable()
class FollowStatsModel extends Equatable {
  final int followersCount;
  final int followingCount;
  final int followingUsersCount;
  final int followingCompaniesCount;

  const FollowStatsModel({
    required this.followersCount,
    required this.followingCount,
    required this.followingUsersCount,
    required this.followingCompaniesCount,
  });

  factory FollowStatsModel.fromJson(Map<String, dynamic> json) =>
      _$FollowStatsModelFromJson(json);

  Map<String, dynamic> toJson() => _$FollowStatsModelToJson(this);

  @override
  List<Object?> get props => [
        followersCount,
        followingCount,
        followingUsersCount,
        followingCompaniesCount,
      ];

  FollowStatsModel copyWith({
    int? followersCount,
    int? followingCount,
    int? followingUsersCount,
    int? followingCompaniesCount,
  }) {
    return FollowStatsModel(
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      followingUsersCount: followingUsersCount ?? this.followingUsersCount,
      followingCompaniesCount: followingCompaniesCount ?? this.followingCompaniesCount,
    );
  }

  static FollowStatsModel mock() {
    return const FollowStatsModel(
      followersCount: 150,
      followingCount: 89,
      followingUsersCount: 75,
      followingCompaniesCount: 14,
    );
  }
}

@JsonSerializable()
class SuggestedUserModel extends Equatable {
  final UserModel user;
  final String reason; // 'mutual_connections', 'same_company', 'similar_skills', etc.
  final List<UserModel>? mutualConnections;
  final int mutualConnectionsCount;

  const SuggestedUserModel({
    required this.user,
    required this.reason,
    this.mutualConnections,
    required this.mutualConnectionsCount,
  });

  factory SuggestedUserModel.fromJson(Map<String, dynamic> json) =>
      _$SuggestedUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$SuggestedUserModelToJson(this);

  @override
  List<Object?> get props => [
        user,
        reason,
        mutualConnections,
        mutualConnectionsCount,
      ];

  SuggestedUserModel copyWith({
    UserModel? user,
    String? reason,
    List<UserModel>? mutualConnections,
    int? mutualConnectionsCount,
  }) {
    return SuggestedUserModel(
      user: user ?? this.user,
      reason: reason ?? this.reason,
      mutualConnections: mutualConnections ?? this.mutualConnections,
      mutualConnectionsCount: mutualConnectionsCount ?? this.mutualConnectionsCount,
    );
  }

  String get reasonDisplay {
    switch (reason) {
      case 'mutual_connections':
        return '$mutualConnectionsCount mutual connections';
      case 'same_company':
        return 'Works at same company';
      case 'similar_skills':
        return 'Similar skills';
      case 'location':
        return 'Same location';
      default:
        return 'Suggested for you';
    }
  }

  static SuggestedUserModel mock() {
    return SuggestedUserModel(
      user: UserModel.mock().copyWith(
        id: 3,
        email: 'suggested@example.com',
        profile: UserModel.mock().profile?.copyWith(
          id: 3,
          userId: 3,
          fullName: 'Alice Johnson',
        ),
      ),
      reason: 'mutual_connections',
      mutualConnectionsCount: 5,
    );
  }
}

enum FollowingType {
  user,
  company,
}

extension FollowingTypeExtension on FollowingType {
  String get value {
    return name;
  }

  static FollowingType fromString(String value) {
    return FollowingType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => FollowingType.user,
    );
  }
}
