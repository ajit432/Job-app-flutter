import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import '../../core/constants/app_constants.dart';
import 'user_model.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel extends Equatable {
  final int id;
  final int userId;
  final String title;
  final String content;
  final NotificationType notificationType;
  final int? relatedId;
  final bool isRead;
  final DateTime createdAt;
  final UserModel? relatedUser;
  final Map<String, dynamic>? metadata;

  const NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.notificationType,
    this.relatedId,
    required this.isRead,
    required this.createdAt,
    this.relatedUser,
    this.metadata,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        content,
        notificationType,
        relatedId,
        isRead,
        createdAt,
        relatedUser,
        metadata,
      ];

  NotificationModel copyWith({
    int? id,
    int? userId,
    String? title,
    String? content,
    NotificationType? notificationType,
    int? relatedId,
    bool? isRead,
    DateTime? createdAt,
    UserModel? relatedUser,
    Map<String, dynamic>? metadata,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
      notificationType: notificationType ?? this.notificationType,
      relatedId: relatedId ?? this.relatedId,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      relatedUser: relatedUser ?? this.relatedUser,
      metadata: metadata ?? this.metadata,
    );
  }

  static NotificationModel mock() {
    return NotificationModel(
      id: 1,
      userId: 1,
      title: 'New Job Application',
      content: 'John Doe applied for the Flutter Developer position.',
      notificationType: NotificationType.jobApplication,
      relatedId: 1,
      isRead: false,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      relatedUser: UserModel.mock().copyWith(
        id: 2,
        email: 'applicant@example.com',
        profile: UserModel.mock().profile?.copyWith(
          id: 2,
          userId: 2,
          fullName: 'John Doe',
        ),
      ),
      metadata: {
        'job_title': 'Flutter Developer',
        'application_id': 1,
      },
    );
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  String get typeDisplayName {
    switch (notificationType) {
      case NotificationType.jobApplication:
        return 'Job Application';
      case NotificationType.interviewScheduled:
        return 'Interview Scheduled';
      case NotificationType.newFollower:
        return 'New Follower';
      case NotificationType.postInteraction:
        return 'Post Interaction';
      case NotificationType.message:
        return 'Message';
      case NotificationType.system:
        return 'System';
    }
  }

  String get iconName {
    switch (notificationType) {
      case NotificationType.jobApplication:
        return 'work';
      case NotificationType.interviewScheduled:
        return 'calendar';
      case NotificationType.newFollower:
        return 'person_add';
      case NotificationType.postInteraction:
        return 'favorite';
      case NotificationType.message:
        return 'message';
      case NotificationType.system:
        return 'info';
    }
  }

  bool get isToday {
    final now = DateTime.now();
    return now.day == createdAt.day && 
           now.month == createdAt.month && 
           now.year == createdAt.year;
  }

  bool get isActionable => notificationType == NotificationType.jobApplication || 
                          notificationType == NotificationType.interviewScheduled ||
                          notificationType == NotificationType.message;
}

@JsonSerializable()
class NotificationSettingsModel extends Equatable {
  final int id;
  final int userId;
  final bool jobApplications;
  final bool interviewSchedules;
  final bool newFollowers;
  final bool postInteractions;
  final bool messages;
  final bool system;
  final bool emailNotifications;
  final bool pushNotifications;
  final DateTime createdAt;
  final DateTime updatedAt;

  const NotificationSettingsModel({
    required this.id,
    required this.userId,
    required this.jobApplications,
    required this.interviewSchedules,
    required this.newFollowers,
    required this.postInteractions,
    required this.messages,
    required this.system,
    required this.emailNotifications,
    required this.pushNotifications,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationSettingsModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        userId,
        jobApplications,
        interviewSchedules,
        newFollowers,
        postInteractions,
        messages,
        system,
        emailNotifications,
        pushNotifications,
        createdAt,
        updatedAt,
      ];

  NotificationSettingsModel copyWith({
    int? id,
    int? userId,
    bool? jobApplications,
    bool? interviewSchedules,
    bool? newFollowers,
    bool? postInteractions,
    bool? messages,
    bool? system,
    bool? emailNotifications,
    bool? pushNotifications,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NotificationSettingsModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      jobApplications: jobApplications ?? this.jobApplications,
      interviewSchedules: interviewSchedules ?? this.interviewSchedules,
      newFollowers: newFollowers ?? this.newFollowers,
      postInteractions: postInteractions ?? this.postInteractions,
      messages: messages ?? this.messages,
      system: system ?? this.system,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static NotificationSettingsModel defaultSettings() {
    return NotificationSettingsModel(
      id: 1,
      userId: 1,
      jobApplications: true,
      interviewSchedules: true,
      newFollowers: true,
      postInteractions: true,
      messages: true,
      system: true,
      emailNotifications: true,
      pushNotifications: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  bool isNotificationTypeEnabled(NotificationType type) {
    switch (type) {
      case NotificationType.jobApplication:
        return jobApplications;
      case NotificationType.interviewScheduled:
        return interviewSchedules;
      case NotificationType.newFollower:
        return newFollowers;
      case NotificationType.postInteraction:
        return postInteractions;
      case NotificationType.message:
        return messages;
      case NotificationType.system:
        return system;
    }
  }
}
