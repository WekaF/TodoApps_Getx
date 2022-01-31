import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kprimary = Color(0xFF00aa13);
const Color kYellow = Color(0xFFFFB746);
const Color pink = Color(0xFFFF4667);
const Color whit = Colors.white;
const Color darkGrey = Color(0xFF121212);
Color darkHeader = const Color(0xFF424242);


class Themes{
  static final light =ThemeData(
    primaryColor: kprimary,
    brightness: Brightness.light
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkGrey,
  );
}

TextStyle get subheadingStyle{
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.grey[400] : Colors.grey,
    ),
  );
}

TextStyle get headingStyle{
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : kprimary
    ),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : Colors.black87,
    ),
  );
}

TextStyle get subTitleStyle {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[400],
    ),
  );
}


TextStyle get buttonText{
  return GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.white
    ),
  );
}