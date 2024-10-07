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
      drawer: const Drawer(),
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
              const Gap(5),
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

  Widget projects() {
    return Column(
      children: [
        topicTitle(title: '-Projects-'),
        Container(
          height: 100,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(ProjectImages.edmc),
        ),
        Gap(10),
      ],
    );
  }

  Widget myDescription() {
    return Column(
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
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(
            children: [
              Text(
                'Mahbub Al Hasan',
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                      color: AppColor.whiteText,
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                'Flutter Developer',
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                      color: AppColor.whiteText,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Row(
                children: [
                  customIconButton(
                      iconData: Icons.mail, url: 'mailto:dv.mahbub@gmail.com'),
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
          Image.asset(
            AppImages.profilePicture,
            width: 180,
          ),
        ]),
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
        size: 35,
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
              'This portfolio is built using Flutter              ',
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
