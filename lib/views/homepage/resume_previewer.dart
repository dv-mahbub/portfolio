import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/components/constants/colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ResumePreviewer extends StatefulWidget {
  const ResumePreviewer({super.key});

  @override
  State<ResumePreviewer> createState() => _ResumePreviewerState();
}

class _ResumePreviewerState extends State<ResumePreviewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume of Mahbub Al Hasan'),
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.primary,
        foregroundColor: AppColor.whiteText,
      ),
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: EdgeInsets.symmetric(
            // vertical: 8,
            horizontal: ScreenUtil().screenWidth > 600 ? .1.sw : 5),
        child: SfPdfViewer.asset('assets/pdf/resume.pdf'),
      ),
    );
  }
}
