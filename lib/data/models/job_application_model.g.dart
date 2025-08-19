// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobApplicationModel _$JobApplicationModelFromJson(Map<String, dynamic> json) =>
    JobApplicationModel(
      id: (json['id'] as num).toInt(),
      jobPostId: (json['jobPostId'] as num).toInt(),
      applicantId: (json['applicantId'] as num).toInt(),
      coverLetter: json['coverLetter'] as String?,
      resumeUrl: json['resumeUrl'] as String?,
      status: $enumDecode(_$ApplicationStatusEnumMap, json['status']),
      appliedAt: DateTime.parse(json['appliedAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      applicant: json['applicant'] == null
          ? null
          : UserModel.fromJson(json['applicant'] as Map<String, dynamic>),
      jobPost: json['jobPost'] == null
          ? null
          : JobPostModel.fromJson(json['jobPost'] as Map<String, dynamic>),
      interview: json['interview'] == null
          ? null
          : InterviewScheduleModel.fromJson(
              json['interview'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JobApplicationModelToJson(
        JobApplicationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jobPostId': instance.jobPostId,
      'applicantId': instance.applicantId,
      'coverLetter': instance.coverLetter,
      'resumeUrl': instance.resumeUrl,
      'status': _$ApplicationStatusEnumMap[instance.status]!,
      'appliedAt': instance.appliedAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'applicant': instance.applicant,
      'jobPost': instance.jobPost,
      'interview': instance.interview,
    };

const _$ApplicationStatusEnumMap = {
  ApplicationStatus.applied: 'applied',
  ApplicationStatus.underReview: 'underReview',
  ApplicationStatus.shortlisted: 'shortlisted',
  ApplicationStatus.interviewScheduled: 'interviewScheduled',
  ApplicationStatus.rejected: 'rejected',
  ApplicationStatus.hired: 'hired',
};

InterviewScheduleModel _$InterviewScheduleModelFromJson(
        Map<String, dynamic> json) =>
    InterviewScheduleModel(
      id: (json['id'] as num).toInt(),
      applicationId: (json['applicationId'] as num).toInt(),
      interviewerId: (json['interviewerId'] as num).toInt(),
      interviewType: json['interviewType'] as String,
      scheduledAt: DateTime.parse(json['scheduledAt'] as String),
      durationMinutes: (json['durationMinutes'] as num).toInt(),
      meetingLink: json['meetingLink'] as String?,
      location: json['location'] as String?,
      notes: json['notes'] as String?,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      interviewer: json['interviewer'] == null
          ? null
          : UserModel.fromJson(json['interviewer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InterviewScheduleModelToJson(
        InterviewScheduleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'applicationId': instance.applicationId,
      'interviewerId': instance.interviewerId,
      'interviewType': instance.interviewType,
      'scheduledAt': instance.scheduledAt.toIso8601String(),
      'durationMinutes': instance.durationMinutes,
      'meetingLink': instance.meetingLink,
      'location': instance.location,
      'notes': instance.notes,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'interviewer': instance.interviewer,
    };
