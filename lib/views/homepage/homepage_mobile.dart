import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:portfolio/controller/constants/colors.dart';
import 'package:portfolio/controller/constants/string.dart';
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
      body: Container(
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
            const Gap(10),
            topTitlePart(),
            const Gap(25),
            myDescription(),
            const Gap(25),
            projects(),
          ],
        ),
      ),
    );
  }

  Widget projects() {
    return Column(
      children: [
        topicTitle(title: '-Projects-'),
      ],
    );
  }

  Widget myDescription() {
    return Column(
      children: [
        topicTitle(title: '-About Me-'),
        Container(
          width: .85.sw,
          padding: const EdgeInsets.all(30),
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
      child: Neumorphic(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
          child: Text(
            title,
            style: GoogleFonts.lobster(
              textStyle: TextStyle(fontSize: 22, color: AppColor.greenText),
            ),
          ),
        ),
      ),
    );
  }

  Widget topTitlePart() {
    return GlassContainer(
      blur: 15,
      width: .95.sw,
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
      color: const Color.fromARGB(255, 252, 124, 252),
      height: 30,
      child: Marquee(
        text: 'This Portfolio built using Flutter',
        style: GoogleFonts.josefinSans(
          textStyle: TextStyle(color: AppColor.greenText),
        ),
        blankSpace: 100,
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
