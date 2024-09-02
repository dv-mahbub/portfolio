import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/controller/responsive/responsive_layout.dart';
import 'package:portfolio/views/splash_screen_page.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(
      builder: (context) {
        return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            // Use builder only if you need to use library outside ScreenUtilInit context
            builder: (_, child) {
              return const MaterialApp(
                title: 'Mahbub Al Hasan',
                debugShowCheckedModeBanner: false,
                home: ResponsiveLayout(
                  mobileView: SplashScreenPage(),
                ),
              );
            });
      },
    );
  }
}
