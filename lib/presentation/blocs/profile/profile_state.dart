part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;
  final List<UserSkillModel> skills;
  final List<EducationModel> education;
  final List<ExperienceModel> experience;
  final bool isUpdating;
  final String? error;

  const ProfileLoaded({
    required this.user,
    required this.skills,
    required this.education,
    required this.experience,
    this.isUpdating = false,
    this.error,
  });

  @override
  List<Object?> get props => [
        user,
        skills,
        education,
        experience,
        isUpdating,
        error,
      ];

  ProfileLoaded copyWith({
    UserModel? user,
    List<UserSkillModel>? skills,
    List<EducationModel>? education,
    List<ExperienceModel>? experience,
    bool? isUpdating,
    String? error,
  }) {
    return ProfileLoaded(
      user: user ?? this.user,
      skills: skills ?? this.skills,
      education: education ?? this.education,
      experience: experience ?? this.experience,
      isUpdating: isUpdating ?? this.isUpdating,
      error: error,
    );
  }

  bool get hasProfileType => user.profileType != null;
  bool get isJobSeeker => user.profileType == UserType.job_seeker;
  bool get isRecruiter => user.profileType == UserType.recruiter;
  bool get hasCompleteProfile => 
      user.profile?.fullName != null &&
      user.profile?.bio != null &&
      user.profile?.location != null;
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}

class ProfileTypeSelectionRequired extends ProfileState {
  final UserModel user;

  const ProfileTypeSelectionRequired({required this.user});

  @override
  List<Object?> get props => [user];
}
