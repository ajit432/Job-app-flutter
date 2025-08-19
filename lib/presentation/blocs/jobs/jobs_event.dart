part of 'jobs_bloc.dart';

abstract class JobsEvent extends Equatable {
  const JobsEvent();

  @override
  List<Object?> get props => [];
}

class JobsLoadRequested extends JobsEvent {
  const JobsLoadRequested();
}

class JobsRefreshRequested extends JobsEvent {
  const JobsRefreshRequested();
}

class JobsLoadMoreRequested extends JobsEvent {
  const JobsLoadMoreRequested();
}

class JobsFilterChanged extends JobsEvent {
  final JobFilters filters;

  const JobsFilterChanged({required this.filters});

  @override
  List<Object?> get props => [filters];
}

class JobsSearchRequested extends JobsEvent {
  final String query;

  const JobsSearchRequested({required this.query});

  @override
  List<Object?> get props => [query];
}

class JobApplicationSubmitted extends JobsEvent {
  final int jobId;
  final String? coverLetter;
  final String? resumeUrl;

  const JobApplicationSubmitted({
    required this.jobId,
    this.coverLetter,
    this.resumeUrl,
  });

  @override
  List<Object?> get props => [jobId, coverLetter, resumeUrl];
}

class JobApplicationWithdrawn extends JobsEvent {
  final int jobId;
  final int applicationId;

  const JobApplicationWithdrawn({
    required this.jobId,
    required this.applicationId,
  });

  @override
  List<Object?> get props => [jobId, applicationId];
}

class JobBookmarked extends JobsEvent {
  final int jobId;

  const JobBookmarked({required this.jobId});

  @override
  List<Object?> get props => [jobId];
}

class JobUnbookmarked extends JobsEvent {
  final int jobId;

  const JobUnbookmarked({required this.jobId});

  @override
  List<Object?> get props => [jobId];
}

class MyApplicationsLoadRequested extends JobsEvent {
  const MyApplicationsLoadRequested();
}

class ApplicationStatusUpdated extends JobsEvent {
  final int applicationId;
  final ApplicationStatus newStatus;

  const ApplicationStatusUpdated({
    required this.applicationId,
    required this.newStatus,
  });

  @override
  List<Object?> get props => [applicationId, newStatus];
}
