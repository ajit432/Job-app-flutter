import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum ButtonSize {
  small,
  medium,
  large,
}

enum ButtonVariant {
  filled,
  outlined,
  text,
  gradient,
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonSize size;
  final ButtonVariant variant;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final Widget? icon;
  final bool isLoading;
  final bool isFullWidth;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final Gradient? gradient;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.variant = ButtonVariant.filled,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.borderRadius,
    this.padding,
    this.elevation,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnabled = onPressed != null && !isLoading;

    // Get button dimensions based on size
    EdgeInsetsGeometry buttonPadding;
    double fontSize;
    double height;

    switch (size) {
      case ButtonSize.small:
        buttonPadding = padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
        fontSize = 12;
        height = 32;
        break;
      case ButtonSize.medium:
        buttonPadding = padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
        fontSize = 14;
        height = 44;
        break;
      case ButtonSize.large:
        buttonPadding = padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
        fontSize = 16;
        height = 52;
        break;
    }

    // Get colors based on variant and theme
    Color getBackgroundColor() {
      if (!isEnabled) return AppColors.gray300;
      
      switch (variant) {
        case ButtonVariant.filled:
          return backgroundColor ?? AppColors.primary;
        case ButtonVariant.outlined:
        case ButtonVariant.text:
          return AppColors.transparent;
        case ButtonVariant.gradient:
          return AppColors.transparent;
      }
    }

    Color getForegroundColor() {
      if (!isEnabled) return AppColors.gray500;
      
      switch (variant) {
        case ButtonVariant.filled:
          return foregroundColor ?? AppColors.white;
        case ButtonVariant.outlined:
        case ButtonVariant.text:
          return foregroundColor ?? AppColors.primary;
        case ButtonVariant.gradient:
          return foregroundColor ?? AppColors.white;
      }
    }

    BorderSide? getBorderSide() {
      switch (variant) {
        case ButtonVariant.outlined:
          return BorderSide(
            color: isEnabled 
                ? (borderColor ?? AppColors.primary) 
                : AppColors.gray300,
            width: 1,
          );
        default:
          return null;
      }
    }

    Widget buttonChild = Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: fontSize,
            height: fontSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(getForegroundColor()),
            ),
          ),
          const SizedBox(width: 8),
        ] else if (icon != null) ...[
          icon!,
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: getForegroundColor(),
          ),
        ),
      ],
    );

    Widget button;

    if (variant == ButtonVariant.gradient && gradient != null) {
      button = Container(
        height: height,
        width: isFullWidth ? double.infinity : null,
        decoration: BoxDecoration(
          gradient: isEnabled ? gradient : null,
          color: isEnabled ? null : AppColors.gray300,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          boxShadow: elevation != null && isEnabled
              ? [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.1),
                    blurRadius: elevation!,
                    offset: Offset(0, elevation! / 2),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: AppColors.transparent,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          child: InkWell(
            onTap: isEnabled ? onPressed : null,
            borderRadius: borderRadius ?? BorderRadius.circular(8),
            child: Container(
              padding: buttonPadding,
              child: buttonChild,
            ),
          ),
        ),
      );
    } else {
      switch (variant) {
        case ButtonVariant.filled:
          button = ElevatedButton(
            onPressed: isEnabled ? onPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: getBackgroundColor(),
              foregroundColor: getForegroundColor(),
              elevation: elevation ?? 2,
              padding: buttonPadding,
              minimumSize: Size(0, height),
              maximumSize: isFullWidth ? const Size(double.infinity, double.infinity) : null,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8),
              ),
            ),
            child: buttonChild,
          );
          break;
        case ButtonVariant.outlined:
          button = OutlinedButton(
            onPressed: isEnabled ? onPressed : null,
            style: OutlinedButton.styleFrom(
              foregroundColor: getForegroundColor(),
              side: getBorderSide(),
              padding: buttonPadding,
              minimumSize: Size(0, height),
              maximumSize: isFullWidth ? const Size(double.infinity, double.infinity) : null,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8),
              ),
            ),
            child: buttonChild,
          );
          break;
        case ButtonVariant.text:
          button = TextButton(
            onPressed: isEnabled ? onPressed : null,
            style: TextButton.styleFrom(
              foregroundColor: getForegroundColor(),
              padding: buttonPadding,
              minimumSize: Size(0, height),
              maximumSize: isFullWidth ? const Size(double.infinity, double.infinity) : null,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8),
              ),
            ),
            child: buttonChild,
          );
          break;
        case ButtonVariant.gradient:
          // This case is handled above
          button = const SizedBox.shrink();
          break;
      }
    }

    return isFullWidth 
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }
}
