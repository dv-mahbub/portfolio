import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/components/global_function/navigate.dart';
import 'package:portfolio/views/homepage/homepage_mobile.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () {
      if (mounted) {
        navigate(
          context: context,
          mobileView: const HomePageMobile(),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/json/box_loading.json', width: 200),
      ),
    );
  }
}
