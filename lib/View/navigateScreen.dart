import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:platform_converter_app/View/cupertino_screen.dart';

import '../Controller/platform_converter_controller.dart';
import 'material_screen.dart';

class Navigatescreen extends StatelessWidget {
  const Navigatescreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(TabBarController());
    return controller.platformConverter.value==true?CupertinoScreen():MaterialScreen();
  }
}
