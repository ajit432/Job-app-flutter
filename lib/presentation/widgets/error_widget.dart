import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'custom_button.dart';

class ErrorWidget extends StatelessWidget {
  final String message;
  final String? title;
  final IconData? icon;
  final VoidCallback? onRetry;
  final String? retryText;
  final Color? backgroundColor;
  final EdgeInsets? padding;

  const ErrorWidget({
    super.key,
    required this.message,
    this.title,
    this.icon,
    this.onRetry,
    this.retryText,
    this.backgroundColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      color: backgroundColor,
      padding: padding ?? const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.error_outline,
              size: 64,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            if (title != null) ...[
              Text(
                title!,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: AppColors.textPrimaryLight,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondaryLight,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              CustomButton(
                text: retryText ?? 'Try Again',
                onPressed: onRetry,
                variant: ButtonVariant.outlined,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class NetworkErrorWidget extends StatelessWidget {
  final VoidCallback? onRetry;
  final String? message;

  const NetworkErrorWidget({
    super.key,
    this.onRetry,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorWidget(
      title: 'Connection Error',
      message: message ?? 'Please check your internet connection and try again.',
      icon: Icons.wifi_off,
      onRetry: onRetry,
    );
  }
}

class NotFoundWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onGoBack;

  const NotFoundWidget({
    super.key,
    this.title,
    this.message,
    this.onGoBack,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorWidget(
      title: title ?? 'Not Found',
      message: message ?? 'The requested resource was not found.',
      icon: Icons.search_off,
      onRetry: onGoBack,
      retryText: 'Go Back',
    );
  }
}

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String message;
  final IconData? icon;
  final Widget? action;
  final String? actionText;
  final VoidCallback? onAction;

  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.message,
    this.icon,
    this.action,
    this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.inbox_outlined,
              size: 64,
              color: AppColors.gray400,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: AppColors.textPrimaryLight,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondaryLight,
              ),
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[
              const SizedBox(height: 24),
              action!,
            ] else if (onAction != null) ...[
              const SizedBox(height: 24),
              CustomButton(
                text: actionText ?? 'Get Started',
                onPressed: onAction,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class NoInternetWidget extends StatelessWidget {
  final VoidCallback? onRetry;

  const NoInternetWidget({
    super.key,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorWidget(
      title: 'No Internet Connection',
      message: 'Please check your internet connection and try again.',
      icon: Icons.wifi_off,
      onRetry: onRetry,
      retryText: 'Retry',
    );
  }
}

class MaintenanceWidget extends StatelessWidget {
  final String? message;

  const MaintenanceWidget({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorWidget(
      title: 'Under Maintenance',
      message: message ?? 
          'We are currently performing maintenance. Please try again later.',
      icon: Icons.build,
    );
  }
}

class UnauthorizedWidget extends StatelessWidget {
  final VoidCallback? onLogin;

  const UnauthorizedWidget({
    super.key,
    this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorWidget(
      title: 'Access Denied',
      message: 'You need to login to access this content.',
      icon: Icons.lock_outline,
      onRetry: onLogin,
      retryText: 'Login',
    );
  }
}

class ServerErrorWidget extends StatelessWidget {
  final VoidCallback? onRetry;
  final String? message;

  const ServerErrorWidget({
    super.key,
    this.onRetry,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorWidget(
      title: 'Server Error',
      message: message ?? 
          'Something went wrong on our end. Please try again later.',
      icon: Icons.error_outline,
      onRetry: onRetry,
    );
  }
}

class TimeoutWidget extends StatelessWidget {
  final VoidCallback? onRetry;

  const TimeoutWidget({
    super.key,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorWidget(
      title: 'Request Timeout',
      message: 'The request took too long to complete. Please try again.',
      icon: Icons.timer_off,
      onRetry: onRetry,
    );
  }
}

// Helper widget for displaying errors based on error type
class AdaptiveErrorWidget extends StatelessWidget {
  final Object error;
  final VoidCallback? onRetry;

  const AdaptiveErrorWidget({
    super.key,
    required this.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final errorMessage = error.toString().toLowerCase();
    
    if (errorMessage.contains('network') || 
        errorMessage.contains('internet') ||
        errorMessage.contains('connection')) {
      return NetworkErrorWidget(onRetry: onRetry);
    }
    
    if (errorMessage.contains('timeout')) {
      return TimeoutWidget(onRetry: onRetry);
    }
    
    if (errorMessage.contains('unauthorized') || 
        errorMessage.contains('401')) {
      return UnauthorizedWidget(onLogin: onRetry);
    }
    
    if (errorMessage.contains('not found') || 
        errorMessage.contains('404')) {
      return NotFoundWidget(onGoBack: onRetry);
    }
    
    if (errorMessage.contains('server') || 
        errorMessage.contains('500') ||
        errorMessage.contains('502') ||
        errorMessage.contains('503')) {
      return ServerErrorWidget(onRetry: onRetry);
    }
    
    // Default error widget
    return ErrorWidget(
      message: error.toString(),
      onRetry: onRetry,
    );
  }
}
