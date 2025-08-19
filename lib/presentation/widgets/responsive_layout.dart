import 'package:flutter/material.dart';

enum DeviceType {
  mobile,
  tablet,
  desktop,
}

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final double mobileBreakpoint;
  final double tabletBreakpoint;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.mobileBreakpoint = 600,
    this.tabletBreakpoint = 1200,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        
        if (width >= tabletBreakpoint && desktop != null) {
          return desktop!;
        } else if (width >= mobileBreakpoint && tablet != null) {
          return tablet!;
        } else {
          return mobile;
        }
      },
    );
  }
}

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceType deviceType, double width) builder;
  final double mobileBreakpoint;
  final double tabletBreakpoint;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
    this.mobileBreakpoint = 600,
    this.tabletBreakpoint = 1200,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        DeviceType deviceType;
        
        if (width >= tabletBreakpoint) {
          deviceType = DeviceType.desktop;
        } else if (width >= mobileBreakpoint) {
          deviceType = DeviceType.tablet;
        } else {
          deviceType = DeviceType.mobile;
        }
        
        return builder(context, deviceType, width);
      },
    );
  }
}

class ResponsiveValue<T> {
  final T mobile;
  final T? tablet;
  final T? desktop;
  final double mobileBreakpoint;
  final double tabletBreakpoint;

  const ResponsiveValue({
    required this.mobile,
    this.tablet,
    this.desktop,
    this.mobileBreakpoint = 600,
    this.tabletBreakpoint = 1200,
  });

  T getValue(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width >= tabletBreakpoint && desktop != null) {
      return desktop!;
    } else if (width >= mobileBreakpoint && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}

extension ResponsiveExtension on BuildContext {
  DeviceType get deviceType {
    final width = MediaQuery.of(this).size.width;
    
    if (width >= 1200) {
      return DeviceType.desktop;
    } else if (width >= 600) {
      return DeviceType.tablet;
    } else {
      return DeviceType.mobile;
    }
  }

  bool get isMobile => deviceType == DeviceType.mobile;
  bool get isTablet => deviceType == DeviceType.tablet;
  bool get isDesktop => deviceType == DeviceType.desktop;
  
  bool get isMobileOrTablet => isMobile || isTablet;
  bool get isTabletOrDesktop => isTablet || isDesktop;

  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  // Responsive padding
  EdgeInsets get responsivePadding {
    switch (deviceType) {
      case DeviceType.mobile:
        return const EdgeInsets.all(16);
      case DeviceType.tablet:
        return const EdgeInsets.all(24);
      case DeviceType.desktop:
        return const EdgeInsets.all(32);
    }
  }

  // Responsive horizontal padding
  EdgeInsets get responsiveHorizontalPadding {
    switch (deviceType) {
      case DeviceType.mobile:
        return const EdgeInsets.symmetric(horizontal: 16);
      case DeviceType.tablet:
        return const EdgeInsets.symmetric(horizontal: 32);
      case DeviceType.desktop:
        return const EdgeInsets.symmetric(horizontal: 64);
    }
  }

  // Responsive content width
  double get responsiveContentWidth {
    switch (deviceType) {
      case DeviceType.mobile:
        return screenWidth;
      case DeviceType.tablet:
        return screenWidth * 0.8;
      case DeviceType.desktop:
        return 1200; // Max width for desktop
    }
  }

  // Responsive grid columns
  int get responsiveGridColumns {
    switch (deviceType) {
      case DeviceType.mobile:
        return 1;
      case DeviceType.tablet:
        return 2;
      case DeviceType.desktop:
        return 3;
    }
  }

  // Responsive card columns for job listings
  int get responsiveJobCardColumns {
    switch (deviceType) {
      case DeviceType.mobile:
        return 1;
      case DeviceType.tablet:
        return 2;
      case DeviceType.desktop:
        return 3;
    }
  }

  // Responsive font sizes
  double get responsiveHeadingSize {
    switch (deviceType) {
      case DeviceType.mobile:
        return 24;
      case DeviceType.tablet:
        return 28;
      case DeviceType.desktop:
        return 32;
    }
  }

  double get responsiveBodySize {
    switch (deviceType) {
      case DeviceType.mobile:
        return 14;
      case DeviceType.tablet:
        return 16;
      case DeviceType.desktop:
        return 16;
    }
  }
}

// Responsive Grid Widget
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final int? mobileColumns;
  final int? tabletColumns;
  final int? desktopColumns;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.spacing = 16,
    this.runSpacing = 16,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, deviceType, width) {
        int columns;
        switch (deviceType) {
          case DeviceType.mobile:
            columns = mobileColumns ?? 1;
            break;
          case DeviceType.tablet:
            columns = tabletColumns ?? 2;
            break;
          case DeviceType.desktop:
            columns = desktopColumns ?? 3;
            break;
        }

        if (columns == 1) {
          return Column(
            children: children.map((child) => 
              Padding(
                padding: EdgeInsets.only(bottom: runSpacing),
                child: child,
              ),
            ).toList(),
          );
        }

        final rows = <Widget>[];
        for (int i = 0; i < children.length; i += columns) {
          final rowChildren = <Widget>[];
          for (int j = 0; j < columns; j++) {
            if (i + j < children.length) {
              rowChildren.add(
                Expanded(child: children[i + j]),
              );
              if (j < columns - 1) {
                rowChildren.add(SizedBox(width: spacing));
              }
            } else {
              rowChildren.add(const Expanded(child: SizedBox.shrink()));
            }
          }
          
          rows.add(
            Padding(
              padding: EdgeInsets.only(bottom: i + columns < children.length ? runSpacing : 0),
              child: Row(children: rowChildren),
            ),
          );
        }

        return Column(children: rows);
      },
    );
  }
}

// Responsive Wrap Widget
class ResponsiveWrap extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final WrapAlignment alignment;
  final WrapCrossAlignment crossAxisAlignment;

  const ResponsiveWrap({
    super.key,
    required this.children,
    this.spacing = 8,
    this.runSpacing = 8,
    this.alignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, deviceType, width) {
        // Adjust spacing based on device type
        double adjustedSpacing;
        double adjustedRunSpacing;
        
        switch (deviceType) {
          case DeviceType.mobile:
            adjustedSpacing = spacing;
            adjustedRunSpacing = runSpacing;
            break;
          case DeviceType.tablet:
            adjustedSpacing = spacing * 1.25;
            adjustedRunSpacing = runSpacing * 1.25;
            break;
          case DeviceType.desktop:
            adjustedSpacing = spacing * 1.5;
            adjustedRunSpacing = runSpacing * 1.5;
            break;
        }

        return Wrap(
          spacing: adjustedSpacing,
          runSpacing: adjustedRunSpacing,
          alignment: alignment,
          crossAxisAlignment: crossAxisAlignment,
          children: children,
        );
      },
    );
  }
}
