import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:portfolio/components/constants/colors.dart';
import 'package:portfolio/models/project_data_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailsPage extends StatelessWidget {
  final ProjectData projectData;
  const ProjectDetailsPage({super.key, required this.projectData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenUtil().screenWidth < 600
          ? AppBar(
              title: const Text('Projct Description'),
              backgroundColor: AppColor.primary,
              foregroundColor: AppColor.whiteText,
            )
          : null,
      body: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 95, 226, 236),
              Color.fromARGB(255, 124, 225, 196)
            ],
            begin: Alignment.topLeft, // Change for different directions
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(.05.sw),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    projectData.image!,
                    width: ScreenUtil().screenWidth < 600 ? .9.sw : .7.sw,
                    fit: BoxFit.fitWidth,
                  ),
                  const Gap(15),
                  Text(
                    projectData.title ?? '',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primary),
                  ),
                  Text(
                    projectData.shortDescription ?? '',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: TextStyle(color: AppColor.blackText),
                            children: [
                              const TextSpan(
                                text: 'Feature(s):  ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: projectData.features),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(15),
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: TextStyle(color: AppColor.blackText),
                            children: [
                              const TextSpan(
                                text: 'Tools:  ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: projectData.tools),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  projectData.url == null
                      ? Container()
                      : ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(AppColor.primary),
                            foregroundColor:
                                WidgetStatePropertyAll(AppColor.whiteText),
                          ),
                          onPressed: () async {
                            final url = Uri.parse(projectData.url ?? '');
                            try {
                              await launchUrl(url);
                            } catch (e) {
                              log('Url launch failed: $e');
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 200,
                            child: const Text(
                              'Visit',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
