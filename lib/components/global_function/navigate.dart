import 'package:flutter/material.dart';
import 'package:portfolio/controller/responsive/responsive_layout.dart';

void responsiveNavigate(
    {required BuildContext context,
    required Widget mobileView,
    Widget? desktopView,
    Widget? tabView}) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
                mobileView: mobileView,
                desktopView: desktopView,
                tabView: tabView,
              )));
}

void navigate({required BuildContext context, required Widget child}) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => child));
}

void replaceNavigate({required BuildContext context, required Widget child}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => child),
    (route) => false, // Remove all routes in the stack
  );
}
