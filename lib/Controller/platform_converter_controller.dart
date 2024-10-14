import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabBarController extends GetxController {
  var selectedTabIndex = 0.obs;
  RxBool profile = false.obs;
  RxBool theme = false.obs;
  RxBool platformConverter = false.obs;

  void changeTabIndex(int index) {
    selectedTabIndex.value = index;
  }

  void changeTheme() {
    theme.value = !theme.value;
  }

  ThemeData get themeData => theme.value ? ThemeData.dark() : ThemeData.light();
}