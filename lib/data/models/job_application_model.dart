import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import '../../core/constants/app_constants.dart';
import 'user_model.dart';
import 'post_model.dart';

part 'job_application_model.g.dart';

@JsonSerializable()
class JobApplicationModel extends Equatable {
  final int id;
  final int jobPostId;
  final int applicantId;
  final String? coverLetter;
  final String? resumeUrl;
  final ApplicationStatus status;
  final DateTime appliedAt;
  final DateTime updatedAt;
  final UserModel? applicant;
  final JobPostModel? jobPost;
  final InterviewScheduleModel? interview;

  const JobApplicationModel({
    required this.id,
    required this.jobPostId,
    required this.applicantId,
    this.coverLetter,
    this.resumeUrl,
    required this.status,
    required this.appliedAt,
    required this.updatedAt,
    this.applicant,
    this.jobPost,
    this.interview,
  });

  factory JobApplicationModel.fromJson(Map<String, dynamic> json) =>
      _$JobApplicationModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobApplicationModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        jobPostId,
        applicantId,
        coverLetter,
        resumeUrl,
        status,
        appliedAt,
        updatedAt,
        applicant,
        jobPost,
        interview,
      ];

  JobApplicationModel copyWith({
    int? id,
    int? jobPostId,
    int? applicantId,
    String? coverLetter,
    String? resumeUrl,
    ApplicationStatus? status,
    DateTime? appliedAt,
    DateTime? updatedAt,
    UserModel? applicant,
    JobPostModel? jobPost,
    InterviewScheduleModel? interview,
  }) {
    return JobApplicationModel(
      id: id ?? this.id,
      jobPostId: jobPostId ?? this.jobPostId,
      applicantId: applicantId ?? this.applicantId,
      coverLetter: coverLetter ?? this.coverLetter,
      resumeUrl: resumeUrl ?? this.resumeUrl,
      status: status ?? this.status,
      appliedAt: appliedAt ?? this.appliedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      applicant: applicant ?? this.applicant,
      jobPost: jobPost ?? this.jobPost,
      interview: interview ?? this.interview,
    );
  }

  static JobApplicationModel mock() {
    return JobApplicationModel(
      id: 1,
      jobPostId: 1,
      applicantId: 1,
      coverLetter: 'I am very interested in this position and believe my skills in Flutter development would be a great fit...',
      resumeUrl: 'https://example.com/resume.pdf',
      status: ApplicationStatus.applied,
      appliedAt: DateTime.now().subtract(const Duration(days: 3)),
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
      applicant: UserModel.mock(),
      jobPost: JobPostModel.mock(),
    );
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(appliedAt);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  String get statusDisplayName {
    switch (status) {
      case ApplicationStatus.applied:
        return 'Applied';
      case ApplicationStatus.underReview:
        return 'Under Review';
      case ApplicationStatus.shortlisted:
        return 'Shortlisted';
      case ApplicationStatus.interviewScheduled:
        return 'Interview Scheduled';
      case ApplicationStatus.rejected:
        return 'Rejected';
      case ApplicationStatus.hired:
        return 'Hired';
    }
  }

  bool get canWithdraw => status == ApplicationStatus.applied || status == ApplicationStatus.underReview;
  bool get hasInterview => status == ApplicationStatus.interviewScheduled && interview != null;
  bool get isCompleted => status == ApplicationStatus.rejected || status == ApplicationStatus.hired;
}

@JsonSerializable()
class InterviewScheduleModel extends Equatable {
  final int id;
  final int applicationId;
  final int interviewerId;
  final String interviewType;
  final DateTime scheduledAt;
  final int durationMinutes;
  final String? meetingLink;
  final String? location;
  final String? notes;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel? interviewer;

  const InterviewScheduleModel({
    required this.id,
    required this.applicationId,
    required this.interviewerId,
    required this.interviewType,
    required this.scheduledAt,
    required this.durationMinutes,
    this.meetingLink,
    this.location,
    this.notes,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.interviewer,
  });

  factory InterviewScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$InterviewScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$InterviewScheduleModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        applicationId,
        interviewerId,
        interviewType,
        scheduledAt,
        durationMinutes,
        meetingLink,
        location,
        notes,
        status,
        createdAt,
        updatedAt,
        interviewer,
      ];

  InterviewScheduleModel copyWith({
    int? id,
    int? applicationId,
    int? interviewerId,
    String? interviewType,
    DateTime? scheduledAt,
    int? durationMinutes,
    String? meetingLink,
    String? location,
    String? notes,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserModel? interviewer,
  }) {
    return InterviewScheduleModel(
      id: id ?? this.id,
      applicationId: applicationId ?? this.applicationId,
      interviewerId: interviewerId ?? this.interviewerId,
      interviewType: interviewType ?? this.interviewType,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      meetingLink: meetingLink ?? this.meetingLink,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      interviewer: interviewer ?? this.interviewer,
    );
  }

  static InterviewScheduleModel mock() {
    return InterviewScheduleModel(
      id: 1,
      applicationId: 1,
      interviewerId: 2,
      interviewType: 'video',
      scheduledAt: DateTime.now().add(const Duration(days: 5)),
      durationMinutes: 60,
      meetingLink: 'https://meet.google.com/xyz-abc-def',
      notes: 'Technical interview focusing on Flutter and mobile development.',
      status: 'scheduled',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
      interviewer: UserModel.mock().copyWith(
        id: 2,
        email: 'interviewer@company.com',
        profileType: UserType.recruiter,
        profile: UserModel.mock().profile?.copyWith(
          id: 2,
          userId: 2,
          fullName: 'Sarah Wilson',
        ),
      ),
    );
  }

  String get interviewTypeDisplayName {
    switch (interviewType) {
      case 'phone':
        return 'Phone Interview';
      case 'video':
        return 'Video Interview';
      case 'in_person':
        return 'In-Person Interview';
      case 'technical':
        return 'Technical Interview';
      case 'hr':
        return 'HR Interview';
      default:
        return 'Interview';
    }
  }

  String get statusDisplayName {
    switch (status) {
      case 'scheduled':
        return 'Scheduled';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      case 'rescheduled':
        return 'Rescheduled';
      default:
        return 'Unknown';
    }
  }

  String get timeUntilInterview {
    final now = DateTime.now();
    final difference = scheduledAt.difference(now);

    if (difference.isNegative) {
      return 'Past';
    } else if (difference.inDays > 0) {
      return 'In ${difference.inDays} days';
    } else if (difference.inHours > 0) {
      return 'In ${difference.inHours} hours';
    } else if (difference.inMinutes > 0) {
      return 'In ${difference.inMinutes} minutes';
    } else {
      return 'Starting soon';
    }
  }

  bool get isPast => DateTime.now().isAfter(scheduledAt);
  bool get isToday => DateTime.now().day == scheduledAt.day && 
                     DateTime.now().month == scheduledAt.month && 
                     DateTime.now().year == scheduledAt.year;
  bool get canJoin => status == 'scheduled' && !isPast && meetingLink != null;
}

enum InterviewType {
  phone,
  video,
  inPerson,
  technical,
  hr,
}

extension InterviewTypeExtension on InterviewType {
  String get displayName {
    switch (this) {
      case InterviewType.phone:
        return 'Phone Interview';
      case InterviewType.video:
        return 'Video Interview';
      case InterviewType.inPerson:
        return 'In-Person Interview';
      case InterviewType.technical:
        return 'Technical Interview';
      case InterviewType.hr:
        return 'HR Interview';
    }
  }

  String get value {
    switch (this) {
      case InterviewType.phone:
        return 'phone';
      case InterviewType.video:
        return 'video';
      case InterviewType.inPerson:
        return 'in_person';
      case InterviewType.technical:
        return 'technical';
      case InterviewType.hr:
        return 'hr';
    }
  }

  static InterviewType fromString(String value) {
    return InterviewType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => InterviewType.video,
    );
  }
}

enum InterviewStatus {
  scheduled,
  completed,
  cancelled,
  rescheduled,
}

extension InterviewStatusExtension on InterviewStatus {
  String get displayName {
    switch (this) {
      case InterviewStatus.scheduled:
        return 'Scheduled';
      case InterviewStatus.completed:
        return 'Completed';
      case InterviewStatus.cancelled:
        return 'Cancelled';
      case InterviewStatus.rescheduled:
        return 'Rescheduled';
    }
  }

  String get value {
    return name;
  }

  static InterviewStatus fromString(String value) {
    return InterviewStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => InterviewStatus.scheduled,
    );
  }
}
