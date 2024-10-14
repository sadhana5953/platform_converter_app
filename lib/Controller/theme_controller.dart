import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  // Define a boolean to track if dark theme is enabled
  RxBool isDarkMode = false.obs;

  // Method to toggle the theme
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

  // Get the appropriate theme based on isDarkMode
  ThemeData get themeData => isDarkMode.value ? ThemeData.dark() : ThemeData.light();
}
