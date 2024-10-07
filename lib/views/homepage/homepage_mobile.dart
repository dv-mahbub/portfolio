import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee_list/marquee_list.dart';
import 'package:portfolio/components/constants/colors.dart';
import 'package:portfolio/components/constants/string.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key});

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  final ScrollController scrollController = ScrollController();

  final GlobalKey topKey = GlobalKey();
  final GlobalKey aboutMeKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mahbub',
          style: GoogleFonts.dancingScript(
              textStyle: TextStyle(color: AppColor.whiteText)),
        ),
        backgroundColor: AppColor.primary,
        iconTheme: IconThemeData(color: AppColor.whiteText),
        // automaticallyImplyLeading: false,
      ),
      drawer: customDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        backgroundColor: AppColor.fabColor,
        child: Icon(
          FontAwesomeIcons.whatsapp,
          color: AppColor.whiteText,
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Container(
          width: 1.sw,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff153063), Color(0xff77dfc1)],
              begin: Alignment.topLeft, // Change for different directions
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(key: topKey, 5),
              marqueeNote(),
              const Gap(15),
              topTitlePart(),
              const Gap(15),
              myDescription(),
              const Gap(10),
              projects(),
            ],
          ),
        ),
      ),
    );
  }

  Drawer customDrawer() {
    return Drawer(
      backgroundColor: Colors.green,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 100,
              color: AppColor.whiteText.withOpacity(.5),
              alignment: Alignment.center,
              child: Text(
                'Protfolio',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColor.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('About Me'),
              iconColor: AppColor.whiteText,
              textColor: AppColor.whiteText,
              onTap: () {
                scrollToSpecificPosition(key: aboutMeKey);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> scrollToSpecificPosition({required GlobalKey key}) async {
    await scrollController.animateTo(0,
        duration: const Duration(microseconds: 10), curve: Curves.bounceIn);
    if (mounted) {
      Navigator.pop(context);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (aboutMeKey.currentContext != null) {
        final RenderBox renderBox =
            key.currentContext!.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        final scrollPosition = position.dy; // Get the absolute position
        double totalHeightOffset =
            AppBar().preferredSize.height + MediaQuery.of(context).padding.top;

        // Calculate the desired scroll position
        double targetScrollPosition = scrollPosition - totalHeightOffset;

        // Scroll to the desired position
        await scrollController.animateTo(
          targetScrollPosition,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Widget projects() {
    return Column(
      key: projectsKey,
      children: [
        topicTitle(title: '-Projects-'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...List.generate(
              5,
              (index) => projectContainer(
                  image: ProjectImages.edmc, link: 'https://www.google.com'),
            ),
          ],
        ),
        const Gap(1000),
      ],
    );
  }

  Widget projectContainer({required String image, required String link}) {
    Uri url = Uri.parse(link);
    return InkWell(
      onTap: () async {
        try {
          await launchUrl(url);
        } catch (e) {
          log('Url launch failed: $e');
        }
      },
      child: Container(
        width: (ScreenUtil().screenWidth < 600) ? .45.sw : .3.sw,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(ProjectImages.edmc),
        ),
      ),
    );
  }

  Widget myDescription() {
    return Column(
      key: aboutMeKey,
      children: [
        topicTitle(title: '-About Me-'),
        Container(
          width: ScreenUtil().screenWidth < 600 ? .85.sw : .7.sw,
          padding: EdgeInsets.all(ScreenUtil().screenWidth < 600 ? 35 : 55),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  AppImages.rippedPaper,
                ),
                fit: BoxFit.fill),
          ),
          child: Text(
            'I am a Computer Engineer. I am working on a reputed software company in Dhaka, Bangladesh. I have been working with Flutter for more than a year. I have developed and published multiple app. I have also developed multiple Flutter packages, those are avaiable on pub.dev, the official site for flutter packages.',
            textAlign: TextAlign.center,
            style: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                color: AppColor.blackText,
                // backgroundColor: AppColor.whiteText.withOpacity(.35),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget topicTitle({required String title}) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
        child: Text(
          title,
          style: GoogleFonts.lobster(
            textStyle: TextStyle(fontSize: 22, color: AppColor.yellowText),
          ),
        ),
      ),
    );
  }

  Widget topTitlePart() {
    return GlassContainer(
      blur: 15,
      width: ScreenUtil().screenWidth < 600 ? .95.sw : .75.sw,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: ScreenUtil().screenWidth < 600 ? .55.sw : .45.sw,
              child: Column(
                children: [
                  Text(
                    'Mahbub Al Hasan',
                    style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        color: AppColor.whiteText,
                        fontSize: ScreenUtil().screenWidth < 600 ? 21 : 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    'Flutter Developer',
                    style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        color: AppColor.whiteText,
                        fontSize: ScreenUtil().screenWidth < 600 ? 18 : 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      customIconButton(
                          iconData: Icons.mail,
                          url: 'mailto:dv.mahbub@gmail.com'),
                      customIconButton(
                          iconData: FontAwesomeIcons.linkedin,
                          url: 'https://www.linkedin.com/in/dv-mahbub'),
                      customIconButton(
                          iconData: FontAwesomeIcons.github,
                          url: 'https://github.com/dv-mahbub'),
                      customIconButton(
                          iconData: FontAwesomeIcons.youtube,
                          url: 'https://www.youtube.com/@dv.mahbub'),
                    ],
                  )
                ],
              ),
            ),
            Image.asset(
              AppImages.profilePicture,
              width: ScreenUtil().screenWidth < 600 ? .38.sw : .28.sw,
            ),
          ],
        ),
      ),
    );
  }

  IconButton customIconButton(
      {required IconData iconData, required String url}) {
    return IconButton(
      onPressed: () {
        _launchUrl(url);
      },
      icon: Icon(
        iconData,
        color: AppColor.whiteText,
        size: ScreenUtil().screenWidth < 600 ? 28 : 35,
      ),
      highlightColor: AppColor.highlightColor,
      hoverColor: AppColor.hoverColor,
    );
  }

  Container marqueeNote() {
    return Container(
      color: const Color.fromARGB(255, 174, 35, 238),
      height: 30,
      child: MarqueeList(
        scrollDuration: const Duration(seconds: 3),
        children: [
          ...List.generate(
            25,
            (index) => Text(
              'This portfolio is built using Flutter by me              ',
              style: GoogleFonts.josefinSans(
                textStyle: TextStyle(color: AppColor.whiteText),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
