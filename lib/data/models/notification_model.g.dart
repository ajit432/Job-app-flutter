// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
      notificationType:
          $enumDecode(_$NotificationTypeEnumMap, json['notificationType']),
      relatedId: (json['relatedId'] as num?)?.toInt(),
      isRead: json['isRead'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      relatedUser: json['relatedUser'] == null
          ? null
          : UserModel.fromJson(json['relatedUser'] as Map<String, dynamic>),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'content': instance.content,
      'notificationType': _$NotificationTypeEnumMap[instance.notificationType]!,
      'relatedId': instance.relatedId,
      'isRead': instance.isRead,
      'createdAt': instance.createdAt.toIso8601String(),
      'relatedUser': instance.relatedUser,
      'metadata': instance.metadata,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.jobApplication: 'jobApplication',
  NotificationType.interviewScheduled: 'interviewScheduled',
  NotificationType.newFollower: 'newFollower',
  NotificationType.postInteraction: 'postInteraction',
  NotificationType.message: 'message',
  NotificationType.system: 'system',
};

NotificationSettingsModel _$NotificationSettingsModelFromJson(
        Map<String, dynamic> json) =>
    NotificationSettingsModel(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      jobApplications: json['jobApplications'] as bool,
      interviewSchedules: json['interviewSchedules'] as bool,
      newFollowers: json['newFollowers'] as bool,
      postInteractions: json['postInteractions'] as bool,
      messages: json['messages'] as bool,
      system: json['system'] as bool,
      emailNotifications: json['emailNotifications'] as bool,
      pushNotifications: json['pushNotifications'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$NotificationSettingsModelToJson(
        NotificationSettingsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'jobApplications': instance.jobApplications,
      'interviewSchedules': instance.interviewSchedules,
      'newFollowers': instance.newFollowers,
      'postInteractions': instance.postInteractions,
      'messages': instance.messages,
      'system': instance.system,
      'emailNotifications': instance.emailNotifications,
      'pushNotifications': instance.pushNotifications,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
