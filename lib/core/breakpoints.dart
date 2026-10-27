import 'package:flutter/widgets.dart';

enum ScreenSize { mobile, tablet, desktop }

abstract final class Breakpoints {
  static const tablet = 600.0;
  static const desktop = 1024.0;
  static const maxContentWidth = 1200.0;
  static const maxSingleColumnWidth = 760.0;
  static const sidebarWidth = 340.0;

  static ScreenSize of(double width) => width >= desktop
      ? ScreenSize.desktop
      : width >= tablet
          ? ScreenSize.tablet
          : ScreenSize.mobile;
}

extension ScreenSizeContext on BuildContext {
  ScreenSize get screenSize => Breakpoints.of(MediaQuery.sizeOf(this).width);
  bool get isMobile => screenSize == ScreenSize.mobile;
}
