part of 'jobs_bloc.dart';

abstract class JobsState extends Equatable {
  const JobsState();

  @override
  List<Object?> get props => [];
}

class JobsInitial extends JobsState {}

class JobsLoading extends JobsState {}

class JobsLoaded extends JobsState {
  final List<JobPostModel> jobs;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final bool isRefreshing;
  final bool isFiltering;
  final bool isSearching;
  final int currentPage;
  final JobFilters filters;
  final String searchQuery;
  final List<int> bookmarkedJobIds;
  final String? error;

  const JobsLoaded({
    required this.jobs,
    required this.hasReachedMax,
    this.isLoadingMore = false,
    this.isRefreshing = false,
    this.isFiltering = false,
    this.isSearching = false,
    this.currentPage = 1,
    this.filters = const JobFilters(),
    this.searchQuery = '',
    this.bookmarkedJobIds = const [],
    this.error,
  });

  @override
  List<Object?> get props => [
        jobs,
        hasReachedMax,
        isLoadingMore,
        isRefreshing,
        isFiltering,
        isSearching,
        currentPage,
        filters,
        searchQuery,
        bookmarkedJobIds,
        error,
      ];

  JobsLoaded copyWith({
    List<JobPostModel>? jobs,
    bool? hasReachedMax,
    bool? isLoadingMore,
    bool? isRefreshing,
    bool? isFiltering,
    bool? isSearching,
    int? currentPage,
    JobFilters? filters,
    String? searchQuery,
    List<int>? bookmarkedJobIds,
    String? error,
  }) {
    return JobsLoaded(
      jobs: jobs ?? this.jobs,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isFiltering: isFiltering ?? this.isFiltering,
      isSearching: isSearching ?? this.isSearching,
      currentPage: currentPage ?? this.currentPage,
      filters: filters ?? this.filters,
      searchQuery: searchQuery ?? this.searchQuery,
      bookmarkedJobIds: bookmarkedJobIds ?? this.bookmarkedJobIds,
      error: error,
    );
  }

  bool get isEmpty => jobs.isEmpty;
  bool get isNotEmpty => jobs.isNotEmpty;
  int get totalJobs => jobs.length;
  bool get hasFilters => filters.hasActiveFilters;
  bool get hasSearch => searchQuery.isNotEmpty;
  bool isJobBookmarked(int jobId) => bookmarkedJobIds.contains(jobId);
}

class ApplicationsLoading extends JobsState {}

class ApplicationsLoaded extends JobsState {
  final List<JobApplicationModel> applications;
  final String? error;

  const ApplicationsLoaded({
    required this.applications,
    this.error,
  });

  @override
  List<Object?> get props => [applications, error];

  ApplicationsLoaded copyWith({
    List<JobApplicationModel>? applications,
    String? error,
  }) {
    return ApplicationsLoaded(
      applications: applications ?? this.applications,
      error: error,
    );
  }

  bool get isEmpty => applications.isEmpty;
  bool get isNotEmpty => applications.isNotEmpty;
  int get totalApplications => applications.length;
  
  List<JobApplicationModel> get pendingApplications =>
      applications.where((app) => 
        app.status == ApplicationStatus.applied ||
        app.status == ApplicationStatus.underReview
      ).toList();
  
  List<JobApplicationModel> get activeApplications =>
      applications.where((app) => 
        app.status == ApplicationStatus.shortlisted ||
        app.status == ApplicationStatus.interviewScheduled
      ).toList();
  
  List<JobApplicationModel> get completedApplications =>
      applications.where((app) => 
        app.status == ApplicationStatus.hired ||
        app.status == ApplicationStatus.rejected
      ).toList();
}

class JobsError extends JobsState {
  final String message;

  const JobsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class JobFilters extends Equatable {
  final String? jobType;
  final String? experienceLevel;
  final String? location;
  final bool? isRemote;
  final double? minSalary;
  final double? maxSalary;
  final List<String>? skills;
  final String? companySize;

  const JobFilters({
    this.jobType,
    this.experienceLevel,
    this.location,
    this.isRemote,
    this.minSalary,
    this.maxSalary,
    this.skills,
    this.companySize,
  });

  @override
  List<Object?> get props => [
        jobType,
        experienceLevel,
        location,
        isRemote,
        minSalary,
        maxSalary,
        skills,
        companySize,
      ];

  JobFilters copyWith({
    String? jobType,
    String? experienceLevel,
    String? location,
    bool? isRemote,
    double? minSalary,
    double? maxSalary,
    List<String>? skills,
    String? companySize,
  }) {
    return JobFilters(
      jobType: jobType ?? this.jobType,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      location: location ?? this.location,
      isRemote: isRemote ?? this.isRemote,
      minSalary: minSalary ?? this.minSalary,
      maxSalary: maxSalary ?? this.maxSalary,
      skills: skills ?? this.skills,
      companySize: companySize ?? this.companySize,
    );
  }

  bool get hasActiveFilters =>
      jobType != null ||
      experienceLevel != null ||
      location != null ||
      isRemote != null ||
      minSalary != null ||
      maxSalary != null ||
      (skills != null && skills!.isNotEmpty) ||
      companySize != null;

  int get activeFiltersCount {
    int count = 0;
    if (jobType != null) count++;
    if (experienceLevel != null) count++;
    if (location != null) count++;
    if (isRemote != null) count++;
    if (minSalary != null || maxSalary != null) count++;
    if (skills != null && skills!.isNotEmpty) count++;
    if (companySize != null) count++;
    return count;
  }

  JobFilters clear() {
    return const JobFilters();
  }

  Map<String, dynamic> toJson() {
    return {
      'jobType': jobType,
      'experienceLevel': experienceLevel,
      'location': location,
      'isRemote': isRemote,
      'minSalary': minSalary,
      'maxSalary': maxSalary,
      'skills': skills,
      'companySize': companySize,
    };
  }

  factory JobFilters.fromJson(Map<String, dynamic> json) {
    return JobFilters(
      jobType: json['jobType'],
      experienceLevel: json['experienceLevel'],
      location: json['location'],
      isRemote: json['isRemote'],
      minSalary: json['minSalary']?.toDouble(),
      maxSalary: json['maxSalary']?.toDouble(),
      skills: json['skills']?.cast<String>(),
      companySize: json['companySize'],
    );
  }
}
