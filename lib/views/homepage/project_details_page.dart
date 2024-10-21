import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/components/constants/colors.dart';
import 'package:portfolio/models/project_data_model.dart';

class ProjectDetailsPage extends StatelessWidget {
  final ProjectData projectData;
  const ProjectDetailsPage({super.key, required this.projectData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(.05.sw),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(projectData.image!),
                Text(projectData.title ?? ''),
                Text(projectData.shortDescription ?? ''),
                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: TextStyle(color: AppColor.blackText),
                    children: [
                      TextSpan(
                        text: 'Feature(s):  ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: projectData.features),
                    ],
                  ),
                ),
                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: TextStyle(color: AppColor.blackText),
                    children: [
                      TextSpan(
                        text: 'Tools:  ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: projectData.tools),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
