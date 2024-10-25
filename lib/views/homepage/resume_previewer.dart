import 'package:flutter/material.dart';
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
      body: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.blue, width: 3)),
        child: SfPdfViewer.asset('assets/pdf/resume.pdf'),
      ),
    );
  }
}
