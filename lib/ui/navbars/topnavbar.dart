import 'package:flutter/material.dart';
import 'package:handycareerweb/ui/navbars/desktopnavbar.dart';
import 'package:handycareerweb/ui/navbars/mobilenavbar.dart';
import 'package:handycareerweb/ui/navbars/tabletnavbar.dart';

class TopNavBar extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, bconstraints) {
          if(bconstraints.maxWidth > 1200){
            return DesktopNavbar();
          }else if(bconstraints.maxWidth > 800 && bconstraints.maxWidth < 1200){
            return TabletNavbar();
          }else{
            return MobileNavbar();
          }
        },
      );
    
  }
}