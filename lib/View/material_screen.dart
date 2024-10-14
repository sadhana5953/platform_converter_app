import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:platform_converter_app/Controller/converter_controller.dart';
import 'package:platform_converter_app/Controller/platform_converter_controller.dart';
import 'package:platform_converter_app/View/Components/MaterialComponents/addData.dart';
import 'package:platform_converter_app/View/Components/MaterialComponents/callScreen.dart';
import 'package:platform_converter_app/View/Components/MaterialComponents/chatScreen.dart';
import 'package:platform_converter_app/View/Components/MaterialComponents/setting.dart';

class MaterialScreen extends StatefulWidget {
  const MaterialScreen({super.key});

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var converterController=Get.put(ConverterController());
    var controller=Get.put(TabBarController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Platform Converter',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
        ),
        actions: [
          Obx(
            () =>  Switch(
              value: controller.platformConverter.value,
              onChanged: (value) {
                controller.platformConverter.value=value;
              },
            ),
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.person_add_alt),
            ),
            Tab(
              child: Text(
                'CHATS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Tab(
              child: Text(
                'CALLS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Tab(
              child: Text(
                'SETTINGS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(controller: tabController, children: [
        Adddata(),
        Chatscreen(),
        Callscreen(),
        Setting(),
      ]),
    );
  }
}

late TabController tabController;
