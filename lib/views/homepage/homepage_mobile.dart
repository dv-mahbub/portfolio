import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee_list/marquee_list.dart';
import 'package:particles_fly/particles_fly.dart';
import 'package:portfolio/components/constants/colors.dart';
import 'package:portfolio/components/constants/string.dart';
import 'package:portfolio/components/global_function/navigate.dart';
import 'package:portfolio/models/project_data_model.dart';
import 'package:portfolio/views/homepage/project_details_page.dart';
import 'package:portfolio/views/homepage/resume_previewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:universal_html/html.dart' as html;

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key});

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  final ScrollController scrollController = ScrollController();
  ProjectDataModel? projectDataModel;

  final GlobalKey topKey = GlobalKey();
  final GlobalKey aboutMeKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey resumeKey = GlobalKey();
  bool isFabVisible = false;

  @override
  void initState() {
    super.initState();
    loadProjectData();
    scrollController.addListener(() {
      if (scrollController.offset > 25 && !isFabVisible) {
        setState(() {
          isFabVisible = true;
        });
      } else if (scrollController.offset <= 20 && isFabVisible) {
        setState(() {
          isFabVisible = false;
        });
      }
    });
  }

  loadProjectData() async {
    String jsonString =
        await rootBundle.loadString('assets/json/project_data.json');
    if (mounted) {
      setState(() {
        projectDataModel = ProjectDataModel.fromJson(jsonDecode(jsonString));
      });
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      drawer: ScreenUtil().screenWidth < 600 ? customDrawer() : null,
      floatingActionButton: customFAB(),
      body: Container(
        width: 1.sw,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff153063), Color(0xff77dfc1)],
            begin: Alignment.topLeft, // Change for different directions
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            ParticlesFly(
              height: 1.sh,
              width: 1.sw,
              connectDots: true,
              numberOfParticles: 25,
              maxParticleSize: 1,
            ),
            SingleChildScrollView(
              controller: scrollController,
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
                  resume(),
                  const Gap(10),
                  projectDataModel == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : projects(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar customAppbar() {
    return AppBar(
      title: Text(
        'Mahbub',
        style: GoogleFonts.dancingScript(
            textStyle: TextStyle(color: AppColor.whiteText)),
      ),
      backgroundColor: AppColor.primary,
      iconTheme: IconThemeData(color: AppColor.whiteText),
      // automaticallyImplyLeading: false,
      actions: ScreenUtil().screenWidth < 600
          ? null
          : [
              actionWidget(
                icon: Icons.person,
                title: 'About Me',
                scrollKey: aboutMeKey,
              ),
              const Gap(25),
              actionWidget(
                icon: Icons.file_copy,
                title: 'Projects',
                scrollKey: projectsKey,
              ),
              const Gap(25),
            ],
    );
  }

  Column customFAB() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Visibility(
          visible: isFabVisible,
          child: FloatingActionButton(
            onPressed: () {
              scrollToSpecificPosition(key: topKey, isFromDrawer: false);
            },
            shape: const CircleBorder(),
            backgroundColor: Colors.grey.shade100,
            heroTag: 'scrollToTop', // Unique hero tag
            child: Icon(
              FontAwesomeIcons.arrowUp,
              color: AppColor.primary,
            ),
          ),
        ),
        const Gap(15),
        FloatingActionButton(
          onPressed: () async {
            const phoneNumber = '+8801767646871';
            const message = 'Hello, I would like to get in touch!';
            final url = Uri.parse(
                'https://api.whatsapp.com/send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}');
            await launchUrl(url);
          },
          shape: const CircleBorder(),
          backgroundColor: AppColor.fabColor,
          heroTag: 'whatsapp', // Unique hero tag
          child: Icon(
            FontAwesomeIcons.whatsapp,
            color: AppColor.whiteText,
          ),
        ),
        const Gap(15),
      ],
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
            drawerItem(
              icon: Icons.person,
              title: 'About Me',
              scrollKey: aboutMeKey,
            ),
            drawerItem(
              icon: Icons.file_copy,
              title: 'Projects',
              scrollKey: projectsKey,
            ),
          ],
        ),
      ),
    );
  }

  Widget actionWidget(
      {required IconData icon,
      required String title,
      required GlobalKey scrollKey}) {
    return InkWell(
      onTap: () {
        scrollToSpecificPosition(key: scrollKey, isFromDrawer: false);
      },
      child: Row(
        children: [
          Icon(icon),
          Text(
            title,
            style: TextStyle(color: AppColor.whiteText),
          ),
        ],
      ),
    );
  }

  Widget drawerItem(
      {required IconData icon,
      required String title,
      required GlobalKey scrollKey}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      iconColor: AppColor.whiteText,
      textColor: AppColor.whiteText,
      onTap: () {
        scrollToSpecificPosition(key: scrollKey);
      },
    );
  }

  Future<void> scrollToSpecificPosition(
      {required GlobalKey key, bool isFromDrawer = true}) async {
    if (key != topKey) {
      await scrollController.animateTo(0,
          duration: const Duration(microseconds: 10), curve: Curves.bounceIn);
    }
    if (isFromDrawer) {
      if (mounted) {
        Navigator.pop(context);
      }
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
          spacing: (ScreenUtil().screenWidth < 900) ? .015.sw : .01.sw,
          runSpacing: .01.sw,
          children: [
            ...List.generate(
              projectDataModel?.data?.length ?? 0,
              (index) => projectContainer(
                projectData: projectDataModel!.data![index],
              ),
            ),
          ],
        ),
        const Gap(10),
      ],
    );
  }

  Widget projectContainer({required ProjectData projectData}) {
    return InkWell(
      onTap: () async {
        if (mounted) {
          navigate(
            context: context,
            child: ProjectDetailsPage(projectData: projectData),
          );
        }
      },
      child: Column(
        children: [
          Container(
            width: (ScreenUtil().screenWidth < 900)
                ? .45.sw
                : (ScreenUtil().screenWidth < 1200)
                    ? .3.sw
                    : .22.sw,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(projectData.image!),
            ),
          ),
          Text(
            projectData.title ?? '',
            style: TextStyle(
              color: AppColor.whiteText,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  Widget myDescription() {
    return Column(
      key: aboutMeKey,
      children: [
        topicTitle(title: '-About Me-'),
        Container(
          width: (ScreenUtil().screenWidth < 600)
              ? .85.sw
              : (ScreenUtil().screenWidth < 900)
                  ? .75.sw
                  : 800,
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

  Widget resume() {
    return Column(
      key: resumeKey,
      children: [
        const Gap(10),
        topicTitle(title: '-Resume-'),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: ScreenUtil().screenWidth > 600 ? .7.sw : .9.sw,
          decoration: BoxDecoration(
              color: AppColor.whiteText.withOpacity(.15),
              border: Border.all(width: 2, color: AppColor.whiteText),
              borderRadius: BorderRadius.circular(25)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (mounted) {
                    navigate(context: context, child: const ResumePreviewer());
                  }
                },
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                      horizontal: ScreenUtil().screenWidth > 600 ? 45 : 25,
                      vertical: 8)),
                  backgroundColor: const WidgetStatePropertyAll(
                    Color.fromARGB(255, 47, 202, 55),
                  ),
                  foregroundColor: WidgetStatePropertyAll(AppColor.whiteText),
                  shadowColor: WidgetStatePropertyAll(AppColor.yellowText),
                  overlayColor: const WidgetStatePropertyAll(
                      Color.fromARGB(255, 11, 109, 62)),
                ),
                child: const Text('View Resume'),
              ),
              Gap(ScreenUtil().screenWidth > 600 ? 15 : 10),
              ElevatedButton(
                onPressed: () {
                  // launchUrl();
                  downloadFile(
                      'assets/pdf/resume.pdf', 'Resume of Mahbub Al Hasan.pdf');
                },
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                      horizontal: ScreenUtil().screenWidth > 600 ? 30 : 15,
                      vertical: 8)),
                  backgroundColor: const WidgetStatePropertyAll(
                      Color.fromARGB(255, 51, 102, 231)),
                  foregroundColor: WidgetStatePropertyAll(AppColor.whiteText),
                  shadowColor: WidgetStatePropertyAll(AppColor.yellowText),
                  overlayColor: const WidgetStatePropertyAll(
                      Color.fromARGB(255, 16, 2, 108)),
                ),
                child: const Text('Download Resume'),
              ),
            ],
          ),
        ),
        const Gap(13),
      ],
    );
  }

  void downloadFile(String assetPath, String fileName) {
    html.AnchorElement(
      href: assetPath,
    )
      ..setAttribute("download", fileName)
      ..click();
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
            Image.asset(
              AppImages.profilePicture,
              width: ScreenUtil().screenWidth < 600 ? .32.sw : 180,
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
