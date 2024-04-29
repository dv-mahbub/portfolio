
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileView;
  final Widget? tabView;
  final Widget? desktopView;
  const ResponsiveLayout({super.key, required this.mobileView, this.desktopView, this.tabView});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      breakpoints: const ScreenBreakpoints(desktop: 900, tablet: 650, watch: 250),
      mobile: (_) => OrientationLayoutBuilder(
        portrait: (context) => mobileView,
        landscape: (context) => tabView??desktopView??mobileView,
      ),
      tablet: (_) => tabView??mobileView,
      desktop: (_)=> desktopView??tabView??mobileView,
    );
  }
}