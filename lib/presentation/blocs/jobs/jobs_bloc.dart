import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/post_model.dart';
import '../../../data/models/job_application_model.dart';
import '../../../core/constants/app_constants.dart';

part 'jobs_event.dart';
part 'jobs_state.dart';

class JobsBloc extends Bloc<JobsEvent, JobsState> {
  JobsBloc() : super(JobsInitial()) {
    on<JobsLoadRequested>(_onJobsLoadRequested);
    on<JobsRefreshRequested>(_onJobsRefreshRequested);
    on<JobsLoadMoreRequested>(_onJobsLoadMoreRequested);
    on<JobsFilterChanged>(_onJobsFilterChanged);
    on<JobsSearchRequested>(_onJobsSearchRequested);
    on<JobApplicationSubmitted>(_onJobApplicationSubmitted);
    on<JobApplicationWithdrawn>(_onJobApplicationWithdrawn);
    on<JobBookmarked>(_onJobBookmarked);
    on<JobUnbookmarked>(_onJobUnbookmarked);
    on<MyApplicationsLoadRequested>(_onMyApplicationsLoadRequested);
    on<ApplicationStatusUpdated>(_onApplicationStatusUpdated);
  }

  Future<void> _onJobsLoadRequested(
    JobsLoadRequested event,
    Emitter<JobsState> emit,
  ) async {
    emit(JobsLoading());
    
    try {
      // TODO: Load jobs from repository
      await Future.delayed(const Duration(seconds: 1)); // Mock delay
      
      final jobPosts = [
        JobPostModel.mock(),
        JobPostModel.mock().copyWith(
          id: 2,
          title: 'React Native Developer',
          description: 'Looking for an experienced React Native developer...',
          salaryMin: 70000,
          salaryMax: 100000,
          location: 'Remote',
          isRemote: true,
        ),
        JobPostModel.mock().copyWith(
          id: 3,
          title: 'iOS Developer',
          description: 'Join our mobile team as an iOS developer...',
          salaryMin: 90000,
          salaryMax: 130000,
          location: 'New York, NY',
          isRemote: false,
        ),
      ];
      
      emit(JobsLoaded(
        jobs: jobPosts,
        hasReachedMax: false,
        currentPage: 1,
        filters: const JobFilters(),
      ));
    } catch (e) {
      emit(JobsError(message: e.toString()));
    }
  }

  Future<void> _onJobsRefreshRequested(
    JobsRefreshRequested event,
    Emitter<JobsState> emit,
  ) async {
    if (state is! JobsLoaded) return;
    
    final currentState = state as JobsLoaded;
    emit(currentState.copyWith(isRefreshing: true));
    
    try {
      // TODO: Refresh jobs from repository
      await Future.delayed(const Duration(seconds: 1)); // Mock delay
      
      final jobPosts = [
        JobPostModel.mock().copyWith(
          id: 999,
          title: 'New Job Posting!',
          description: 'Fresh opportunity just posted...',
        ),
        ...currentState.jobs,
      ];
      
      emit(currentState.copyWith(
        jobs: jobPosts,
        isRefreshing: false,
        currentPage: 1,
      ));
    } catch (e) {
      emit(currentState.copyWith(
        isRefreshing: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onJobsLoadMoreRequested(
    JobsLoadMoreRequested event,
    Emitter<JobsState> emit,
  ) async {
    if (state is! JobsLoaded) return;
    
    final currentState = state as JobsLoaded;
    if (currentState.hasReachedMax || currentState.isLoadingMore) return;
    
    emit(currentState.copyWith(isLoadingMore: true));
    
    try {
      // TODO: Load more jobs from repository
      await Future.delayed(const Duration(seconds: 1)); // Mock delay
      
      final moreJobs = [
        JobPostModel.mock().copyWith(
          id: currentState.jobs.length + 1,
          title: 'Job ${currentState.jobs.length + 1}',
        ),
      ];
      
      final allJobs = [...currentState.jobs, ...moreJobs];
      final hasReachedMax = allJobs.length >= 20; // Mock limit
      
      emit(currentState.copyWith(
        jobs: allJobs,
        isLoadingMore: false,
        hasReachedMax: hasReachedMax,
        currentPage: currentState.currentPage + 1,
      ));
    } catch (e) {
      emit(currentState.copyWith(
        isLoadingMore: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onJobsFilterChanged(
    JobsFilterChanged event,
    Emitter<JobsState> emit,
  ) async {
    if (state is! JobsLoaded) return;
    
    final currentState = state as JobsLoaded;
    emit(currentState.copyWith(
      filters: event.filters,
      isFiltering: true,
    ));
    
    try {
      // TODO: Apply filters via repository
      await Future.delayed(const Duration(milliseconds: 500)); // Mock delay
      
      // Mock filtered results
      var filteredJobs = <JobPostModel>[...currentState.jobs];
      
      if (event.filters.jobType != null) {
        filteredJobs = filteredJobs
            .where((job) => job.jobType == event.filters.jobType)
            .toList();
      }
      
      if (event.filters.experienceLevel != null) {
        filteredJobs = filteredJobs
            .where((job) => job.experienceLevel == event.filters.experienceLevel)
            .toList();
      }
      
      if (event.filters.isRemote != null) {
        filteredJobs = filteredJobs
            .where((job) => job.isRemote == event.filters.isRemote)
            .toList();
      }
      
      emit(currentState.copyWith(
        jobs: filteredJobs,
        isFiltering: false,
        currentPage: 1,
        hasReachedMax: true, // Filtered results don't paginate
      ));
    } catch (e) {
      emit(currentState.copyWith(
        isFiltering: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onJobsSearchRequested(
    JobsSearchRequested event,
    Emitter<JobsState> emit,
  ) async {
    if (state is! JobsLoaded) return;
    
    final currentState = state as JobsLoaded;
    emit(currentState.copyWith(
      searchQuery: event.query,
      isSearching: true,
    ));
    
    try {
      // TODO: Search jobs via repository
      await Future.delayed(const Duration(milliseconds: 800)); // Mock delay
      
      var searchResults = <JobPostModel>[];
      
      if (event.query.isNotEmpty) {
        searchResults = currentState.jobs
            .where((job) =>
                job.title.toLowerCase().contains(event.query.toLowerCase()) ||
                job.description.toLowerCase().contains(event.query.toLowerCase()))
            .toList();
      } else {
        searchResults = currentState.jobs;
      }
      
      emit(currentState.copyWith(
        jobs: searchResults,
        isSearching: false,
        currentPage: 1,
        hasReachedMax: true, // Search results don't paginate
      ));
    } catch (e) {
      emit(currentState.copyWith(
        isSearching: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onJobApplicationSubmitted(
    JobApplicationSubmitted event,
    Emitter<JobsState> emit,
  ) async {
    if (state is! JobsLoaded) return;
    
    final currentState = state as JobsLoaded;
    
    try {
      // TODO: Submit application via repository
      await Future.delayed(const Duration(seconds: 1)); // Mock delay
      
      final updatedJobs = currentState.jobs.map((job) {
        if (job.id == event.jobId) {
          final currentCount = job.applicationsCount ?? 0;
          return job.copyWith(
            applicationsCount: currentCount + 1,
            hasApplied: true,
          );
        }
        return job;
      }).toList();
      
      emit(currentState.copyWith(jobs: updatedJobs));
    } catch (e) {
      emit(currentState.copyWith(error: e.toString()));
    }
  }

  Future<void> _onJobApplicationWithdrawn(
    JobApplicationWithdrawn event,
    Emitter<JobsState> emit,
  ) async {
    if (state is! JobsLoaded) return;
    
    final currentState = state as JobsLoaded;
    
    try {
      // TODO: Withdraw application via repository
      await Future.delayed(const Duration(seconds: 1)); // Mock delay
      
      final updatedJobs = currentState.jobs.map((job) {
        if (job.id == event.jobId) {
          final currentCount = job.applicationsCount ?? 0;
          return job.copyWith(
            applicationsCount: currentCount > 0 ? currentCount - 1 : 0,
            hasApplied: false,
          );
        }
        return job;
      }).toList();
      
      emit(currentState.copyWith(jobs: updatedJobs));
    } catch (e) {
      emit(currentState.copyWith(error: e.toString()));
    }
  }

  Future<void> _onJobBookmarked(
    JobBookmarked event,
    Emitter<JobsState> emit,
  ) async {
    if (state is! JobsLoaded) return;
    
    final currentState = state as JobsLoaded;
    
    try {
      // TODO: Bookmark job via repository
      
      // Update UI immediately for better UX
      emit(currentState.copyWith(
        bookmarkedJobIds: [...currentState.bookmarkedJobIds, event.jobId],
      ));
    } catch (e) {
      emit(currentState.copyWith(error: e.toString()));
    }
  }

  Future<void> _onJobUnbookmarked(
    JobUnbookmarked event,
    Emitter<JobsState> emit,
  ) async {
    if (state is! JobsLoaded) return;
    
    final currentState = state as JobsLoaded;
    
    try {
      // TODO: Unbookmark job via repository
      
      // Update UI immediately for better UX
      final updatedBookmarks = currentState.bookmarkedJobIds
          .where((id) => id != event.jobId)
          .toList();
      
      emit(currentState.copyWith(bookmarkedJobIds: updatedBookmarks));
    } catch (e) {
      emit(currentState.copyWith(error: e.toString()));
    }
  }

  Future<void> _onMyApplicationsLoadRequested(
    MyApplicationsLoadRequested event,
    Emitter<JobsState> emit,
  ) async {
    emit(ApplicationsLoading());
    
    try {
      // TODO: Load applications from repository
      await Future.delayed(const Duration(seconds: 1)); // Mock delay
      
      final applications = [
        JobApplicationModel.mock(),
        JobApplicationModel.mock().copyWith(
          id: 2,
          status: ApplicationStatus.underReview,
          appliedAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
        JobApplicationModel.mock().copyWith(
          id: 3,
          status: ApplicationStatus.interviewScheduled,
          appliedAt: DateTime.now().subtract(const Duration(days: 10)),
          interview: InterviewScheduleModel.mock(),
        ),
      ];
      
      emit(ApplicationsLoaded(applications: applications));
    } catch (e) {
      emit(JobsError(message: e.toString()));
    }
  }

  Future<void> _onApplicationStatusUpdated(
    ApplicationStatusUpdated event,
    Emitter<JobsState> emit,
  ) async {
    if (state is! ApplicationsLoaded) return;
    
    final currentState = state as ApplicationsLoaded;
    
    try {
      // TODO: Update application status via repository
      
      final updatedApplications = currentState.applications.map((app) {
        if (app.id == event.applicationId) {
          return app.copyWith(
            status: event.newStatus,
            updatedAt: DateTime.now(),
          );
        }
        return app;
      }).toList();
      
      emit(currentState.copyWith(applications: updatedApplications));
    } catch (e) {
      emit(currentState.copyWith(error: e.toString()));
    }
  }
}
