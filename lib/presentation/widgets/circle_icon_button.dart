import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum CircleButtonSize {
  small,   // 32x32
  medium,  // 48x48
  large,   // 56x56
  xLarge,  // 64x64
}

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final CircleButtonSize size;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? borderColor;
  final double? borderWidth;
  final bool hasShadow;
  final String? tooltip;
  final double? iconSize;
  final bool isLoading;

  const CircleIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = CircleButtonSize.medium,
    this.backgroundColor,
    this.iconColor,
    this.borderColor,
    this.borderWidth,
    this.hasShadow = false,
    this.tooltip,
    this.iconSize,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isEnabled = onPressed != null && !isLoading;

    // Get dimensions based on size
    double containerSize;
    double defaultIconSize;

    switch (size) {
      case CircleButtonSize.small:
        containerSize = 32;
        defaultIconSize = 16;
        break;
      case CircleButtonSize.medium:
        containerSize = 48;
        defaultIconSize = 20;
        break;
      case CircleButtonSize.large:
        containerSize = 56;
        defaultIconSize = 24;
        break;
      case CircleButtonSize.xLarge:
        containerSize = 64;
        defaultIconSize = 28;
        break;
    }

    final actualIconSize = iconSize ?? defaultIconSize;

    // Get colors
    final Color finalBackgroundColor = backgroundColor ??
        (isDark ? AppColors.surfaceDark : AppColors.surfaceLight);
    
    final Color finalIconColor = iconColor ??
        (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight);

    Widget buttonWidget = Container(
      width: containerSize,
      height: containerSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isEnabled ? finalBackgroundColor : AppColors.gray200,
        border: borderColor != null && borderWidth != null
            ? Border.all(
                color: isEnabled ? borderColor! : AppColors.gray300,
                width: borderWidth!,
              )
            : null,
        boxShadow: hasShadow && isEnabled
            ? [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Material(
        color: AppColors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          customBorder: const CircleBorder(),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: actualIconSize,
                    height: actualIconSize,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isEnabled ? finalIconColor : AppColors.gray400,
                      ),
                    ),
                  )
                : Icon(
                    icon,
                    size: actualIconSize,
                    color: isEnabled ? finalIconColor : AppColors.gray400,
                  ),
          ),
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        child: buttonWidget,
      );
    }

    return buttonWidget;
  }
}

// Specific variants for common use cases
class LikeButton extends StatelessWidget {
  final bool isLiked;
  final VoidCallback? onPressed;
  final CircleButtonSize size;
  final int? likeCount;

  const LikeButton({
    super.key,
    required this.isLiked,
    this.onPressed,
    this.size = CircleButtonSize.medium,
    this.likeCount,
  });

  @override
  Widget build(BuildContext context) {
    return CircleIconButton(
      icon: isLiked ? Icons.favorite : Icons.favorite_border,
      onPressed: onPressed,
      size: size,
      iconColor: isLiked ? AppColors.like : null,
      tooltip: isLiked ? 'Unlike' : 'Like',
    );
  }
}

class ShareButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final CircleButtonSize size;

  const ShareButton({
    super.key,
    this.onPressed,
    this.size = CircleButtonSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    return CircleIconButton(
      icon: Icons.share_outlined,
      onPressed: onPressed,
      size: size,
      tooltip: 'Share',
    );
  }
}

class BookmarkButton extends StatelessWidget {
  final bool isBookmarked;
  final VoidCallback? onPressed;
  final CircleButtonSize size;

  const BookmarkButton({
    super.key,
    required this.isBookmarked,
    this.onPressed,
    this.size = CircleButtonSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    return CircleIconButton(
      icon: isBookmarked ? Icons.bookmark : Icons.bookmark_border,
      onPressed: onPressed,
      size: size,
      iconColor: isBookmarked ? AppColors.save : null,
      tooltip: isBookmarked ? 'Remove bookmark' : 'Bookmark',
    );
  }
}

class CommentButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final CircleButtonSize size;
  final int? commentCount;

  const CommentButton({
    super.key,
    this.onPressed,
    this.size = CircleButtonSize.medium,
    this.commentCount,
  });

  @override
  Widget build(BuildContext context) {
    return CircleIconButton(
      icon: Icons.chat_bubble_outline,
      onPressed: onPressed,
      size: size,
      tooltip: 'Comment',
    );
  }
}

class FollowButton extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback? onPressed;
  final CircleButtonSize size;

  const FollowButton({
    super.key,
    required this.isFollowing,
    this.onPressed,
    this.size = CircleButtonSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    return CircleIconButton(
      icon: isFollowing ? Icons.person_remove : Icons.person_add,
      onPressed: onPressed,
      size: size,
      backgroundColor: isFollowing ? AppColors.gray200 : AppColors.primary,
      iconColor: isFollowing ? AppColors.gray700 : AppColors.white,
      tooltip: isFollowing ? 'Unfollow' : 'Follow',
    );
  }
}
