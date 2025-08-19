import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/skill_model.dart';
import '../../../data/models/education_model.dart';
import '../../../data/models/experience_model.dart';
import '../../../core/constants/app_constants.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileLoadRequested>(_onProfileLoadRequested);
    on<ProfileUpdateRequested>(_onProfileUpdateRequested);
    on<ProfileImageUploadRequested>(_onProfileImageUploadRequested);
    on<BannerImageUploadRequested>(_onBannerImageUploadRequested);
    on<ProfileTypeSelected>(_onProfileTypeSelected);
    on<SkillAdded>(_onSkillAdded);
    on<SkillRemoved>(_onSkillRemoved);
    on<EducationAdded>(_onEducationAdded);
    on<EducationUpdated>(_onEducationUpdated);
    on<EducationRemoved>(_onEducationRemoved);
    on<ExperienceAdded>(_onExperienceAdded);
    on<ExperienceUpdated>(_onExperienceUpdated);
    on<ExperienceRemoved>(_onExperienceRemoved);
  }

  Future<void> _onProfileLoadRequested(
    ProfileLoadRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    
    try {
      // TODO: Load profile from repository
      await Future.delayed(const Duration(seconds: 1)); // Mock delay
      
      final user = UserModel.mock();
      final skills = [UserSkillModel.mock()];
      final education = [EducationModel.mock()];
      final experience = [ExperienceModel.mock()];
      
      emit(ProfileLoaded(
        user: user,
        skills: skills,
        education: education,
        experience: experience,
      ));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> _onProfileUpdateRequested(
    ProfileUpdateRequested event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is! ProfileLoaded) return;
    
    final currentState = state as ProfileLoaded;
    emit(currentState.copyWith(isUpdating: true));
    
    try {
      // TODO: Update profile via repository
      await Future.delayed(const Duration(seconds: 1)); // Mock delay
      
      final updatedUser = currentState.user.copyWith(
        profile: event.profile,
      );
      
      emit(currentState.copyWith(
        user: updatedUser,
        isUpdating: false,
      ));
    } catch (e) {
      emit(currentState.copyWith(
        isUpdating: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onProfileImageUploadRequested(
    ProfileImageUploadRequested event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is! ProfileLoaded) return;
    
    final currentState = state as ProfileLoaded;
    emit(currentState.copyWith(isUpdating: true));
    
    try {
      // TODO: Upload image via repository
      await Future.delayed(const Duration(seconds: 2)); // Mock delay
      
      final updatedProfile = currentState.user.profile?.copyWith(
        profileImage: event.imagePath,
      );
      
      final updatedUser = currentState.user.copyWith(profile: updatedProfile);
      
      emit(currentState.copyWith(
        user: updatedUser,
        isUpdating: false,
      ));
    } catch (e) {
      emit(currentState.copyWith(
        isUpdating: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onBannerImageUploadRequested(
    BannerImageUploadRequested event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is! ProfileLoaded) return;
    
    final currentState = state as ProfileLoaded;
    emit(currentState.copyWith(isUpdating: true));
    
    try {
      // TODO: Upload banner image via repository
      await Future.delayed(const Duration(seconds: 2)); // Mock delay
      
      final updatedProfile = currentState.user.profile?.copyWith(
        bannerImage: event.imagePath,
      );
      
      final updatedUser = currentState.user.copyWith(profile: updatedProfile);
      
      emit(currentState.copyWith(
        user: updatedUser,
        isUpdating: false,
      ));
    } catch (e) {
      emit(currentState.copyWith(
        isUpdating: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onProfileTypeSelected(
    ProfileTypeSelected event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is! ProfileLoaded) return;
    
    final currentState = state as ProfileLoaded;
    emit(currentState.copyWith(isUpdating: true));
    
    try {
      // TODO: Update profile type via repository
      await Future.delayed(const Duration(seconds: 1)); // Mock delay
      
      final updatedUser = currentState.user.copyWith(
        profileType: event.profileType,
      );
      
      emit(currentState.copyWith(
        user: updatedUser,
        isUpdating: false,
      ));
    } catch (e) {
      emit(currentState.copyWith(
        isUpdating: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onSkillAdded(
    SkillAdded event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is! ProfileLoaded) return;
    
    final currentState = state as ProfileLoaded;
    
    try {
      // TODO: Add skill via repository
      await Future.delayed(const Duration(milliseconds: 500)); // Mock delay
      
      final updatedSkills = [...currentState.skills, event.skill];
      
      emit(currentState.copyWith(skills: updatedSkills));
    } catch (e) {
      emit(currentState.copyWith(error: e.toString()));
    }
  }

  Future<void> _onSkillRemoved(
    SkillRemoved event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is! ProfileLoaded) return;
    
    final currentState = state as ProfileLoaded;
    
    try {
      // TODO: Remove skill via repository
      await Future.delayed(const Duration(milliseconds: 500)); // Mock delay
      
      final updatedSkills = currentState.skills
          .where((skill) => skill.id != event.skillId)
          .toList();
      
      emit(currentState.copyWith(skills: updatedSkills));
    } catch (e) {
      emit(currentState.copyWith(error: e.toString()));
    }
  }

  Future<void> _onEducationAdded(
    EducationAdded event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is! ProfileLoaded) return;
    
    final currentState = state as ProfileLoaded;
    
    try {
      // TODO: Add education via repository
      await Future.delayed(const Duration(milliseconds: 500)); // Mock delay
      
      final updatedEducation = [...currentState.education, event.education];
      
      emit(currentState.copyWith(education: updatedEducation));
    } catch (e) {
      emit(currentState.copyWith(error: e.toString()));
    }
  }

  Future<void> _onEducationUpdated(
    EducationUpdated event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is! ProfileLoaded) return;
    
    final currentState = state as ProfileLoaded;
    
    try {
      // TODO: Update education via repository
      await Future.delayed(const Duration(milliseconds: 500)); // Mock delay
      
      final updatedEducation = currentState.education
          .map((edu) => edu.id == event.education.id ? event.education : edu)
          .toList();
      
      emit(currentState.copyWith(education: updatedEducation));
    } catch (e) {
      emit(currentState.copyWith(error: e.toString()));
    }
  }

  Future<void> _onEducationRemoved(
    EducationRemoved event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is! ProfileLoaded) return;
    
    final currentState = state as ProfileLoaded;
    
    try {
      // TODO: Remove education via repository
      await Future.delayed(const Duration(milliseconds: 500)); // Mock delay
      
      final updatedEducation = currentState.education
          .where((edu) => edu.id != event.educationId)
          .toList();
      
      emit(currentState.copyWith(education: updatedEducation));
    } catch (e) {
      emit(currentState.copyWith(error: e.toString()));
    }
  }

  Future<void> _onExperienceAdded(
    ExperienceAdded event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is! ProfileLoaded) return;
    
    final currentState = state as ProfileLoaded;
    
    try {
      // TODO: Add experience via repository
      await Future.delayed(const Duration(milliseconds: 500)); // Mock delay
      
      final updatedExperience = [...currentState.experience, event.experience];
      
      emit(currentState.copyWith(experience: updatedExperience));
    } catch (e) {
      emit(currentState.copyWith(error: e.toString()));
    }
  }

  Future<void> _onExperienceUpdated(
    ExperienceUpdated event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is! ProfileLoaded) return;
    
    final currentState = state as ProfileLoaded;
    
    try {
      // TODO: Update experience via repository
      await Future.delayed(const Duration(milliseconds: 500)); // Mock delay
      
      final updatedExperience = currentState.experience
          .map((exp) => exp.id == event.experience.id ? event.experience : exp)
          .toList();
      
      emit(currentState.copyWith(experience: updatedExperience));
    } catch (e) {
      emit(currentState.copyWith(error: e.toString()));
    }
  }

  Future<void> _onExperienceRemoved(
    ExperienceRemoved event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is! ProfileLoaded) return;
    
    final currentState = state as ProfileLoaded;
    
    try {
      // TODO: Remove experience via repository
      await Future.delayed(const Duration(milliseconds: 500)); // Mock delay
      
      final updatedExperience = currentState.experience
          .where((exp) => exp.id != event.experienceId)
          .toList();
      
      emit(currentState.copyWith(experience: updatedExperience));
    } catch (e) {
      emit(currentState.copyWith(error: e.toString()));
    }
  }
}
