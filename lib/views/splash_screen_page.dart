import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/controller/global_function/navigate.dart';
import 'package:portfolio/views/homepage/homepage_mobile.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  
@override
  void initState() {
    Future.delayed(const Duration(seconds: 0), (){
      navigate (context: context, mobileView: const HomePageMobile(), );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Lottie.asset('assets/json/box_loading.json', width: 200),),
    );
  }
}