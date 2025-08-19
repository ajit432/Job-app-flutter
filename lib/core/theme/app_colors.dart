import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF2563EB); // Blue
  static const Color primaryDark = Color(0xFF1D4ED8);
  static const Color primaryLight = Color(0xFF3B82F6);
  
  // Secondary Colors
  static const Color secondary = Color(0xFF10B981); // Green
  static const Color secondaryDark = Color(0xFF059669);
  static const Color secondaryLight = Color(0xFF34D399);
  
  // Accent Colors
  static const Color accent = Color(0xFF8B5CF6); // Purple
  static const Color accentDark = Color(0xFF7C3AED);
  static const Color accentLight = Color(0xFFA78BFA);
  
  // Neutral Colors
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Colors.transparent;
  
  // Gray Scale
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);
  
  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);
  
  // Background Colors
  static const Color backgroundLight = white;
  static const Color backgroundDark = Color(0xFF0F0F0F);
  static const Color surfaceLight = gray50;
  static const Color surfaceDark = Color(0xFF1A1A1A);
  
  // Text Colors
  static const Color textPrimaryLight = gray900;
  static const Color textPrimaryDark = white;
  static const Color textSecondaryLight = gray600;
  static const Color textSecondaryDark = gray300;
  static const Color textDisabledLight = gray400;
  static const Color textDisabledDark = gray500;
  
  // Border Colors
  static const Color borderLight = gray200;
  static const Color borderDark = gray700;
  static const Color borderFocusLight = primary;
  static const Color borderFocusDark = primaryLight;
  
  // Card Colors
  static const Color cardLight = white;
  static const Color cardDark = Color(0xFF1F1F1F);
  
  // Social Colors
  static const Color facebook = Color(0xFF1877F2);
  static const Color google = Color(0xFF4285F4);
  static const Color linkedin = Color(0xFF0A66C2);
  static const Color twitter = Color(0xFF1DA1F2);
  
  // Interaction Colors
  static const Color like = Color(0xFFE91E63); // Pink
  static const Color love = Color(0xFFE53E3E); // Red
  static const Color support = Color(0xFF38A169); // Green
  static const Color save = Color(0xFF3182CE); // Blue
  
  // Job Status Colors
  static const Color applied = Color(0xFF3182CE);
  static const Color underReview = Color(0xFFD69E2E);
  static const Color shortlisted = Color(0xFF38A169);
  static const Color interviewScheduled = Color(0xFF805AD5);
  static const Color rejected = Color(0xFFE53E3E);
  static const Color hired = Color(0xFF38A169);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, accentLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Shadows
  static const List<BoxShadow> lightShadow = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];
  
  static const List<BoxShadow> mediumShadow = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
    ),
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -1,
    ),
  ];
  
  static const List<BoxShadow> heavyShadow = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 10),
      blurRadius: 15,
      spreadRadius: -3,
    ),
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -2,
    ),
  ];
  
  // Utility Methods
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'applied':
        return applied;
      case 'under_review':
        return underReview;
      case 'shortlisted':
        return shortlisted;
      case 'interview_scheduled':
        return interviewScheduled;
      case 'rejected':
        return rejected;
      case 'hired':
        return hired;
      default:
        return gray500;
    }
  }
  
  static Color getInteractionColor(String type) {
    switch (type.toLowerCase()) {
      case 'like':
        return like;
      case 'love':
        return love;
      case 'support':
        return support;
      case 'save':
        return save;
      default:
        return gray500;
    }
  }
  
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
}
