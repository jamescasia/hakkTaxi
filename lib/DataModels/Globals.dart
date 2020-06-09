import 'package:flutter/material.dart';
import 'package:grabApp/DataModels/Screens.dart';

class Globals {
  static double dwidth;
  static double dheight;
  static double width;
  static double height;
  static double maxHeight;
  static double maxWidth;

  static double cornerRadius = 44;
  static Color bgBlue = Color(0xff1566BF);
  static Color accentBlue = Color(0xff1A88EF);
  static Color btnBlue = Color(0xff0D7EEE);
  static Color pickerBlue = Color(0xff44A5FF);
  static Color dashBlue = Color(0xff386A98);
  static Color pickerUIBlue = Color(0xff1A88EF);
  static Color pickerUIRedStart = Color(0xffF30000);
  static Color pickerUIYellowEnd = Color(0xffD9A223);
  static Color offWhite = Color(0xffF4F6F9);
  static Color foreWhite = Color(0xffF6F6F6);
  static Color h1text = Color(0xff054081);
  static Color h2text = Color(0xff064A95);
  static Color h3text = Color(0xff7790AA);
  static Color bh1text = Color(0xff575757);
  static Color bh2text = Color(0xffA1A1A1);
  static Color badOrange = Color(0xffE26515);
  static Color goodGreen = Color(0xff0BC92B);


}
  frontPanelSize(Screen currentScreen) {
    if (currentScreen == Screen.BookScreen)
      return Globals.height * 0.255;
    else if (currentScreen == Screen.SelectScreen)
      return Globals.height * 0.815;
    else if (currentScreen == Screen.SummaryScreen)
      return Globals.height * 0.425;
    else if (currentScreen == Screen.SummaryErrorScreen)
      return Globals.height * 0.6;
  }

  backPanelSize(Screen currentScreen) {
    double pad = 0.095;
    if (currentScreen == Screen.BookScreen)
      return Globals.height * (0.255 + pad);
    else if (currentScreen == Screen.SelectScreen)
      return Globals.height * (0.815 + pad);
    else if (currentScreen == Screen.SummaryScreen)
      return Globals.height * (0.425 + pad);
    else if (currentScreen == Screen.SummaryErrorScreen)
      return Globals.height * (0.6 + pad);
  }