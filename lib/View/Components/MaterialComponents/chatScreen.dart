import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter_app/Controller/platform_converter_controller.dart';
import 'package:platform_converter_app/View/Components/MaterialComponents/setting.dart';
import 'package:platform_converter_app/View/material_screen.dart';

import '../../../Controller/converter_controller.dart';

class Chatscreen extends StatelessWidget {
  const Chatscreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var controller = Get.put(ConverterController());
    var controllerFalse = Get.put(TabBarController());
    void switchTab(int index) {
      tabController.animateTo(index);
    }

    return Obx(
      () => (controller.data.length == 0)
          ? Center(
              child: Text(
              'No any chats yet...',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ))
          : ListView.builder(
              itemCount: controller.data.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        width: double.infinity,
                        height: height * 0.400,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: height * 0.080,
                              backgroundImage: FileImage(
                                  File(controller.data[index]['img'])),
                            ).marginOnly(
                                top: height * 0.025, bottom: height * 0.005),
                            Text(
                              '${controller.data[index]['name']}',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            Text(
                              '${controller.data[index]['bio']}',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Spacer(),
                                IconButton(
                                    onPressed: () {
                                      Get.back();
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text('Update Data'),
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () async {
                                                          controller
                                                              .fileImagePath
                                                              .value = "";
                                                          ImagePicker image =
                                                              ImagePicker();
                                                          XFile? xfile =
                                                              await image.pickImage(
                                                                  source: ImageSource
                                                                      .gallery);
                                                          String path =
                                                              xfile!.path;
                                                          File fileImage =
                                                              File(path);
                                                          controller.setImg(
                                                              fileImage);
                                                          if (controller
                                                                  .ImgPath !=
                                                              null) {
                                                            controller
                                                                .fileImagePath
                                                                .value = "image";
                                                          }
                                                        },
                                                        child: Obx(
                                                          () => CircleAvatar(
                                                            radius:
                                                                height * 0.050,
                                                            backgroundColor:
                                                                Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onSecondary,
                                                            child: (controller
                                                                        .fileImagePath
                                                                        .value ==
                                                                    "")
                                                                ? Icon(
                                                                    Icons
                                                                        .add_a_photo_outlined,
                                                                    size: height *
                                                                        0.035,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .onPrimaryContainer,
                                                                  )
                                                                : null,
                                                            backgroundImage: (controller
                                                                        .fileImagePath
                                                                        .value ==
                                                                    "")
                                                                ? null
                                                                : FileImage(
                                                                    controller
                                                                        .ImgPath!
                                                                        .value),
                                                            // child: controller.ImgPath!.value == null
                                                            //     ? Icon(Icons.person, size: 100)
                                                            //     : null,
                                                          ).marginOnly(
                                                              top: height *
                                                                  0.020,
                                                              bottom: height *
                                                                  0.030),
                                                        ),
                                                      ),
                                                      TextFormField(
                                                        controller:
                                                            controller.txtName,
                                                        decoration:
                                                            InputDecoration(
                                                                prefixIcon:
                                                                    Icon(
                                                                  Icons
                                                                      .person_outline,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .secondary,
                                                                ),
                                                                labelText:
                                                                    'Full Name',
                                                                labelStyle: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .secondary),
                                                                focusedBorder:
                                                                    OutlineInputBorder(),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                5),
                                                                    borderSide: BorderSide(
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .onPrimary,
                                                                        width:
                                                                            2))),
                                                      ).marginOnly(bottom: 10),
                                                      TextFormField(
                                                        controller:
                                                            controller.txtPhone,
                                                        decoration:
                                                            InputDecoration(
                                                                prefixIcon:
                                                                    Icon(
                                                                  Icons.call,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .secondary,
                                                                ),
                                                                labelText:
                                                                    'Phone Number',
                                                                labelStyle: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .secondary),
                                                                focusedBorder:
                                                                    OutlineInputBorder(),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                5),
                                                                    borderSide: BorderSide(
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .onPrimary,
                                                                        width:
                                                                            2))),
                                                      ).marginOnly(bottom: 10),
                                                      TextFormField(
                                                        controller:
                                                            controller.txtChat,
                                                        decoration:
                                                            InputDecoration(
                                                                prefixIcon:
                                                                    Icon(
                                                                  Icons
                                                                      .chat_outlined,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .secondary,
                                                                ),
                                                                labelText:
                                                                    'Chat Conversation',
                                                                labelStyle: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .secondary),
                                                                focusedBorder:
                                                                    OutlineInputBorder(),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                5),
                                                                    borderSide: BorderSide(
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .onPrimary,
                                                                        width:
                                                                            2))),
                                                      ).marginOnly(bottom: 10),
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        controller.updateData(
                                                            controller
                                                                .txtName.text,
                                                            controller
                                                                .txtPhone.text,
                                                            controller
                                                                .txtChat.text,
                                                            controller.ImgPath!
                                                                .value.path,
                                                            index);
                                                        controller.txtName
                                                            .clear();
                                                        controller.txtPhone
                                                            .clear();
                                                        controller.txtChat
                                                            .clear();
                                                        controller.fileImagePath
                                                            .value = "";
                                                        controller.time = "";
                                                        controller.date = "";
                                                        Get.back();
                                                      },
                                                      child: Text('Save')),
                                                  TextButton(
                                                      onPressed: () {
                                                        controller.txtName
                                                            .clear();
                                                        controller.txtPhone
                                                            .clear();
                                                        controller.txtChat
                                                            .clear();
                                                        controller.fileImagePath
                                                            .value = "";
                                                        controller.time = "";
                                                        controller.date = "";
                                                        Get.back();
                                                      },
                                                      child: Text('Cancel'))
                                                ],
                                              ));
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      size: height * 0.035,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      controller.removeData(
                                          controller.data[index]['id']);
                                      Get.back();
                                    },
                                    icon: Icon(Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        size: height * 0.035)),
                                Spacer(),
                              ],
                            ).marginOnly(top: height * 0.015),
                            OutlinedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(fontSize: 18),
                              ),
                            ).marginOnly(top: height * 0.015),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: height * 0.040,
                          backgroundImage:
                              FileImage(File(controller.data[index]['img'])),
                        ).marginOnly(right: 20),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: '${controller.data[index]['name']}\n',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                          TextSpan(
                              text: '${controller.data[index]['bio']}',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                        ])),
                        Spacer(),
                        Text(
                            '${controller.data[index]['date']},${controller.data[index]['time']}',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 15,
                                fontWeight: FontWeight.w500)),
                      ],
                    ).marginSymmetric(horizontal: 15, vertical: 10),
                  ],
                ),
              ),
            ),
    );
  }
}
