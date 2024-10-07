import 'package:flutter/material.dart';
import 'package:portfolio/controller/responsive/responsive_layout.dart';

void navigate({required BuildContext context, required Widget mobileView, Widget? desktopView, Widget? tabView

}){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>ResponsiveLayout(mobileView: mobileView, desktopView: desktopView, tabView: tabView,)));
}