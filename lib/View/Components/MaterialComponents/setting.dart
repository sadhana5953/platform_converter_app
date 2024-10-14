import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Controller/converter_controller.dart';
import '../../../Controller/platform_converter_controller.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    var controller = Get.put(ConverterController());
    var tabBarController = Get.put(TabBarController());
    return Obx(
          () =>
          SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Theme
                        .of(context)
                        .colorScheme
                        .onPrimary,
                    size: height * 0.030,
                  ),
                  title: Text(
                    'Profile',
                    style: TextStyle(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  subtitle: Text(
                    'Update Profile Data',
                    style: TextStyle(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .secondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                  ),
                  trailing: Obx(
                        () =>
                        Switch(
                          value: tabBarController.profile.value,
                          onChanged: (value) {
                            tabBarController.profile.value = value;
                          },
                        ),
                  ),
                ).marginOnly(top: height * 0.015),
                (tabBarController.profile.value == true)
                    ? Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        controller.fileImagePath.value = "";
                        ImagePicker image = ImagePicker();
                        XFile? xfile = await image.pickImage(
                            source: ImageSource.gallery);
                        String path = xfile!.path;
                        File fileImage = File(path);
                        controller.setImg(fileImage);
                        if (controller.ImgPath != null) {
                          controller.fileImagePath.value = "image";
                        }
                      },
                      child: Obx(
                            () =>
                            CircleAvatar(
                              radius: height * 0.085,
                              backgroundColor:
                              Theme
                                  .of(context)
                                  .colorScheme
                                  .onSecondary,
                              child: (controller.fileImagePath.value == "")
                                  ? Icon(
                                Icons.add_a_photo_outlined,
                                size: height * 0.035,
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              )
                                  : null,
                              backgroundImage:
                              (controller.fileImagePath.value == "")
                                  ? null
                                  : FileImage(controller.ImgPath!.value),
                              // child: controller.ImgPath!.value == null
                              //     ? Icon(Icons.person, size: 100)
                              //     : null,
                            ).marginOnly(
                                top: height * 0.020, bottom: height * 0.030),
                      ),
                    ),
                    TextField(
                      controller: controller.txtName,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Enter your name...',
                        hintStyle: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent)),
                      ),
                    ),
                    TextField(
                      controller: controller.txtChat,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Enter your Bio...',
                        hintStyle: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Spacer(),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'SAVE',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                            )),
                        TextButton(
                            onPressed: () {
                              controller.txtName.clear();
                              controller.txtPhone.clear();
                              controller.txtChat.clear();
                              controller.fileImagePath.value = "";
                              controller.time = "";
                              controller.date = "";
                            },
                            child: Text(
                              'CLEAR',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                            )),
                        Spacer(),
                      ],
                    ),
                  ],
                )
                    : SizedBox(
                  height: 0,
                ),
                Divider(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onPrimary,
                  thickness: 2,
                ).marginSymmetric(horizontal: 15),
                ListTile(
                  leading: Icon(
                    Icons.light_mode_outlined,
                    color: Theme
                        .of(context)
                        .colorScheme
                        .onPrimary,
                    size: height * 0.030,
                  ),
                  title: Text(
                    'Theme',
                    style: TextStyle(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  subtitle: Text(
                    'Change Theme',
                    style: TextStyle(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .secondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                  ),
                  trailing: Obx(
                        () =>
                        Switch(
                          value: tabBarController.theme.value,
                          onChanged: (value) {
                            tabBarController.changeTheme();
                          },
                        ),
                  ),
                ).marginOnly(top: height * 0.015),
              ],
            ),
          ),
    );
  }
}
