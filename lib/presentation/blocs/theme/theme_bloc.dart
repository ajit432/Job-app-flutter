import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(themeMode: ThemeMode.system)) {
    on<ThemeChanged>(_onThemeChanged);
    on<ThemeInitialized>(_onThemeInitialized);
  }

  Future<void> _onThemeChanged(
    ThemeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    try {
      // TODO: Save theme preference to local storage
      // await storageService.saveThemeMode(event.themeMode);
      
      emit(ThemeState(themeMode: event.themeMode));
    } catch (e) {
      // If saving fails, still emit the new theme but could show error
      emit(ThemeState(themeMode: event.themeMode));
    }
  }

  Future<void> _onThemeInitialized(
    ThemeInitialized event,
    Emitter<ThemeState> emit,
  ) async {
    try {
      // TODO: Load theme preference from local storage
      // final savedTheme = await storageService.getThemeMode();
      // emit(ThemeState(themeMode: savedTheme ?? ThemeMode.system));
      
      // For now, use system theme as default
      emit(const ThemeState(themeMode: ThemeMode.system));
    } catch (e) {
      // If loading fails, use system theme as fallback
      emit(const ThemeState(themeMode: ThemeMode.system));
    }
  }
}
