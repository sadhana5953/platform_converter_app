import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_converter_app/View/cupertino_screen.dart';
import 'package:platform_converter_app/View/material_screen.dart';

import 'Controller/platform_converter_controller.dart';
import 'View/navigateScreen.dart';

void main()
{
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(TabBarController());
    return Obx(
      () =>  GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: CupertinoColors.activeBlue,
            primaryColorLight: Colors.white,
            primaryColorDark: Colors.black,
            colorScheme: ColorScheme.light(
              primary: Colors.black87,
              secondary: Colors.grey.shade800,
              onPrimary: Colors.grey,
              onSecondary: Color(0xffe8ddfd),
              onPrimaryContainer: Color(0xff4f378a),
            )
        ),
        darkTheme: ThemeData(
            primaryColor: CupertinoColors.activeBlue,
            primaryColorLight: Colors.white,
            primaryColorDark: Colors.white,
            colorScheme: ColorScheme.dark(
              primary: Colors.white,
              secondary: Colors.grey.shade500,
              onPrimary: Colors.grey.shade800,
              onSecondary: Color(0xff4f378a),
              onPrimaryContainer: Colors.white,
            )
        ),
        themeMode: (controller.theme.value==true)?ThemeMode.dark:ThemeMode.light,
        home: controller.platformConverter.value==true?CupertinoScreen():MaterialScreen(),
        // getPages: [
        //   GetPage(name: '/', page: () => Navigatescreen(),),
        // ],
      ),
    );
  }
}
