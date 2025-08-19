part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileLoadRequested extends ProfileEvent {
  final int? userId;

  const ProfileLoadRequested({this.userId});

  @override
  List<Object?> get props => [userId];
}

class ProfileUpdateRequested extends ProfileEvent {
  final UserProfileModel profile;

  const ProfileUpdateRequested({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class ProfileImageUploadRequested extends ProfileEvent {
  final String imagePath;

  const ProfileImageUploadRequested({required this.imagePath});

  @override
  List<Object?> get props => [imagePath];
}

class BannerImageUploadRequested extends ProfileEvent {
  final String imagePath;

  const BannerImageUploadRequested({required this.imagePath});

  @override
  List<Object?> get props => [imagePath];
}

class ProfileTypeSelected extends ProfileEvent {
  final UserType profileType;

  const ProfileTypeSelected({required this.profileType});

  @override
  List<Object?> get props => [profileType];
}

class SkillAdded extends ProfileEvent {
  final UserSkillModel skill;

  const SkillAdded({required this.skill});

  @override
  List<Object?> get props => [skill];
}

class SkillRemoved extends ProfileEvent {
  final int skillId;

  const SkillRemoved({required this.skillId});

  @override
  List<Object?> get props => [skillId];
}

class EducationAdded extends ProfileEvent {
  final EducationModel education;

  const EducationAdded({required this.education});

  @override
  List<Object?> get props => [education];
}

class EducationUpdated extends ProfileEvent {
  final EducationModel education;

  const EducationUpdated({required this.education});

  @override
  List<Object?> get props => [education];
}

class EducationRemoved extends ProfileEvent {
  final int educationId;

  const EducationRemoved({required this.educationId});

  @override
  List<Object?> get props => [educationId];
}

class ExperienceAdded extends ProfileEvent {
  final ExperienceModel experience;

  const ExperienceAdded({required this.experience});

  @override
  List<Object?> get props => [experience];
}

class ExperienceUpdated extends ProfileEvent {
  final ExperienceModel experience;

  const ExperienceUpdated({required this.experience});

  @override
  List<Object?> get props => [experience];
}

class ExperienceRemoved extends ProfileEvent {
  final int experienceId;

  const ExperienceRemoved({required this.experienceId});

  @override
  List<Object?> get props => [experienceId];
}
