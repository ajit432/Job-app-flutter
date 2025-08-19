class AppConstants {
  // API Configuration
  static const String baseUrl = 'http://localhost:3000/api';
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  
  // Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';
  static const String userProfileKey = 'user_profile';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';
  
  // API Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String googleAuthEndpoint = '/auth/google';
  static const String otpSendEndpoint = '/auth/otp/send';
  static const String otpVerifyEndpoint = '/auth/otp/verify';
  static const String refreshTokenEndpoint = '/auth/refresh';
  static const String logoutEndpoint = '/auth/logout';
  
  // User Profile Endpoints
  static const String profileEndpoint = '/profile';
  static const String updateProfileEndpoint = '/profile/update';
  static const String uploadImageEndpoint = '/profile/upload-image';
  static const String skillsEndpoint = '/skills';
  static const String userSkillsEndpoint = '/profile/skills';
  
  // Social Endpoints
  static const String postsEndpoint = '/posts';
  static const String feedEndpoint = '/posts/feed';
  static const String likesEndpoint = '/posts/{id}/like';
  static const String commentsEndpoint = '/posts/{id}/comments';
  static const String followEndpoint = '/follow';
  static const String followersEndpoint = '/follow/followers';
  static const String followingEndpoint = '/follow/following';
  
  // Job Endpoints
  static const String jobsEndpoint = '/jobs';
  static const String applyJobEndpoint = '/jobs/{id}/apply';
  static const String jobApplicationsEndpoint = '/applications';
  static const String myApplicationsEndpoint = '/applications/my';
  
  // Chat Endpoints
  static const String conversationsEndpoint = '/chat/conversations';
  static const String messagesEndpoint = '/chat/messages';
  static const String socketUrl = 'http://localhost:3000';
  
  // File Upload
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'webp'];
  static const List<String> allowedVideoTypes = ['mp4', 'mov', 'avi'];
  static const List<String> allowedDocumentTypes = ['pdf', 'doc', 'docx'];
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int minBioLength = 10;
  static const int maxBioLength = 500;
  static const int maxPostLength = 2000;
  static const int maxCommentLength = 500;
  
  // Error Messages
  static const String networkErrorMessage = 'Network error. Please check your connection.';
  static const String serverErrorMessage = 'Server error. Please try again later.';
  static const String authErrorMessage = 'Authentication failed. Please login again.';
  static const String validationErrorMessage = 'Please check your input and try again.';
  
  // Success Messages
  static const String loginSuccessMessage = 'Login successful!';
  static const String registerSuccessMessage = 'Registration successful!';
  static const String profileUpdateSuccessMessage = 'Profile updated successfully!';
  static const String postCreatedSuccessMessage = 'Post created successfully!';
  static const String applicationSubmittedSuccessMessage = 'Application submitted successfully!';
  
  // OTP Configuration
  static const int otpLength = 6;
  static const int otpExpiryMinutes = 10;
  static const int maxOtpResendAttempts = 3;
  
  // Theme
  static const String lightTheme = 'light';
  static const String darkTheme = 'dark';
  static const String systemTheme = 'system';
  
  // Social Features
  static const int maxFollowSuggestions = 10;
  static const int maxRecentSearches = 5;
  
  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 400);
  static const Duration longAnimationDuration = Duration(milliseconds: 600);
}

enum UserType {
  jobSeeker,
  recruiter,
}

enum PostType {
  personal,
  job,
  companyUpdate,
}

enum ApplicationStatus {
  applied,
  underReview,
  shortlisted,
  interviewScheduled,
  rejected,
  hired,
}

enum InteractionType {
  like,
  love,
  support,
  save,
}

enum MessageType {
  text,
  image,
  file,
  link,
}

enum NotificationType {
  jobApplication,
  interviewScheduled,
  newFollower,
  postInteraction,
  message,
  system,
}
