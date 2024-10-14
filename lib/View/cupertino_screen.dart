import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter_app/View/Components/MaterialComponents/callScreen.dart';

import '../Controller/converter_controller.dart';
import '../Controller/platform_converter_controller.dart';

class CupertinoScreen extends StatelessWidget {
  const CupertinoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var controller = Get.put(TabBarController());
    var converterController = Get.put(ConverterController());
    Future<void> _selectTime(BuildContext context) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      converterController.time =
          pickedTime!.hour.toString() + ":" + pickedTime.minute.toString();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Platform Converter',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          centerTitle: true,
          actions: [
            Obx(
              () =>  CupertinoSwitch(
                value: controller.platformConverter.value,
                onChanged: (value) {
                  controller.platformConverter.value=value;
                },
              ).marginOnly(right: 15),
            ),
          ],
        ),
        body: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.person_add,
                ),
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.chat_bubble_2,
                  ),
                  label: 'CHATS'),
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.phone,
                  ),
                  label: 'CALLS'),
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.settings,
                  ),
                  label: 'SETTINGS'),
            ],
            backgroundColor: CupertinoColors.systemGrey6,
            activeColor: CupertinoColors.activeBlue,
            inactiveColor: CupertinoColors.inactiveGray,
          ),
          tabBuilder: (BuildContext context, int index) {
            switch (index) {
              case 0:
                return CupertinoTabView(
                  builder: (BuildContext context) {
                    return CupertinoPageScaffold(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                converterController.fileImagePath.value = "";
                                ImagePicker image = ImagePicker();
                                XFile? xfile = await image.pickImage(
                                    source: ImageSource.gallery);
                                String path = xfile!.path;
                                File fileImage = File(path);
                                converterController.setImg(fileImage);
                                if (converterController.ImgPath != null) {
                                  converterController.fileImagePath.value =
                                      "image";
                                }
                              },
                              child: Obx(
                                () =>  ClipOval(
                                  child: Container(
                                    height: 150,
                                    width: 150,
                                    color: CupertinoColors.activeBlue,
                                    alignment: Alignment.center,
                                    child: (converterController
                                                .fileImagePath.value ==
                                            "")
                                        ? Icon(
                                            CupertinoIcons.camera,
                                            color: Colors.white,
                                            size: 35,
                                          )
                                        : Image(
                                            image: FileImage(
                                                converterController.ImgPath!.value),fit: BoxFit.cover,width: 150,
                                          ),
                                  ),
                                ).marginOnly(top: 10, bottom: 15),
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.person,
                                  color: CupertinoColors.activeBlue,
                                ),
                                SizedBox(
                                  width: 350,
                                  child: CupertinoTextField(
                                    controller: converterController.txtName,
                                    placeholder: 'Full Name',
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Colors.grey,
                                            style: BorderStyle.solid)),
                                  ),
                                ),
                              ],
                            ).marginSymmetric(horizontal: 15, vertical: 7),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.phone,
                                  color: CupertinoColors.activeBlue,
                                ),
                                SizedBox(
                                  width: 350,
                                  child: CupertinoTextField(
                                    controller: converterController.txtPhone,
                                    placeholder: 'Phone Number',
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Colors.grey,
                                            style: BorderStyle.solid)),
                                  ),
                                ),
                              ],
                            ).marginSymmetric(horizontal: 15, vertical: 7),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.chat_bubble_text,
                                  color: CupertinoColors.activeBlue,
                                ),
                                SizedBox(
                                  width: 350,
                                  child: CupertinoTextField(
                                    controller: converterController.txtChat,
                                    placeholder: 'Chat Conversation',
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Colors.grey,
                                            style: BorderStyle.solid)),
                                  ),
                                ),
                              ],
                            ).marginSymmetric(horizontal: 15, vertical: 7),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime.now(),
                                      selectableDayPredicate: (day) {
                                        converterController.date = day.year.toString() +
                                            "-" +
                                            day.month.toString() +
                                            "-" +
                                            day.day.toString();
                                        return true;
                                      },
                                    );
                                  },
                                  child: Icon(
                                    CupertinoIcons.calendar,
                                    color: CupertinoColors.activeBlue,
                                  ),
                                ),
                                Text(
                                  '   Pick Date',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ],
                            ).marginSymmetric(horizontal: 15, vertical: 10),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _selectTime(context);
                                  },
                                  child: Icon(
                                    CupertinoIcons.time,
                                    color: CupertinoColors.activeBlue,
                                  ),
                                ),
                                Text(
                                  '   Pick Time',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ],
                            ).marginSymmetric(horizontal: 15, vertical: 10),
                            CupertinoButton(
                              child: Text(
                                'SAVE',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorLight),
                              ),
                              onPressed: () {
                                converterController.insertData(
                                    converterController.ImgPath!.value.path,
                                    converterController.time,
                                    converterController.date,
                                    converterController.txtChat.text,
                                    converterController.txtPhone.text,
                                    converterController.txtName.text);
                                converterController.txtName.clear();
                                converterController.txtPhone.clear();
                                converterController.txtChat.clear();
                                converterController.fileImagePath.value="";
                                converterController.time="";
                                converterController.date="";
                              },
                              color: CupertinoColors.activeBlue,
                            ).marginOnly(top: 15)
                          ],
                        ),
                      ),
                    );
                  },
                );
              case 1:
                return Obx(
                      () => (converterController.data.length == 0)
                      ? CupertinoTabView(
                        builder: (BuildContext context) {
                          return CupertinoPageScaffold(
                            child: Center(
                                child: Text(
                                  'No any chats yet...',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.grey.shade800),
                                )),
                          );
                        },
                      )
                      : ListView.builder(
                    itemCount: converterController.data.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              width: double.infinity,
                              height: height * 0.350,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipOval(
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      margin: EdgeInsets.only(top: 15),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: CupertinoColors.activeBlue,
                                        image: DecorationImage(image: FileImage(File(converterController.data[index]['img']),),
                                      ),
                                    ),
                                  )
                                  ),
                                  Text(
                                    '${converterController.data[index]['name']}',
                                    style: TextStyle(
                                        color: Theme.of(context).colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                  Text(
                                    '${converterController.data[index]['bio']}',
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
                                                  content: Column(
                                                    mainAxisSize:
                                                    MainAxisSize.min,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () async {
                                                          converterController.fileImagePath
                                                              .value = "";
                                                          ImagePicker image =
                                                          ImagePicker();
                                                          XFile? xfile =
                                                          await image.pickImage(
                                                              source:
                                                              ImageSource
                                                                  .gallery);
                                                          String path =
                                                              xfile!.path;
                                                          File fileImage =
                                                          File(path);
                                                          converterController
                                                              .setImg(fileImage);
                                                          if (converterController
                                                              .ImgPath !=
                                                              null) {
                                                            converterController
                                                                .fileImagePath
                                                                .value = "image";
                                                          }
                                                        },
                                                        child: Obx(
                                                              () => CircleAvatar(
                                                            radius:
                                                            height * 0.050,
                                                            backgroundColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .onSecondary,
                                                            child: (converterController
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
                                                            backgroundImage: (converterController
                                                                .fileImagePath
                                                                .value ==
                                                                "")
                                                                ? null
                                                                : FileImage(
                                                                converterController
                                                                    .ImgPath!
                                                                    .value),
                                                            // child: controller.ImgPath!.value == null
                                                            //     ? Icon(Icons.person, size: 100)
                                                            //     : null,
                                                          ).marginOnly(
                                                              top: height * 0.020,
                                                              bottom:
                                                              height * 0.030),
                                                        ),
                                                      ),
                                                      TextFormField(
                                                        controller: converterController.txtName,
                                                        decoration: InputDecoration(
                                                            prefixIcon: Icon(
                                                              Icons.person_outline,
                                                              color: Theme.of(context).colorScheme.secondary,
                                                            ),
                                                            labelText: 'Full Name',
                                                            labelStyle: TextStyle(
                                                                fontWeight: FontWeight.w500,
                                                                color: Theme.of(context).colorScheme.secondary),
                                                            focusedBorder: OutlineInputBorder(),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(5),
                                                                borderSide: BorderSide(
                                                                    color: Theme.of(context).colorScheme.onPrimary,
                                                                    width: 2))),
                                                      ).marginOnly(bottom: 10),
                                                      TextFormField(
                                                        controller: converterController.txtPhone,
                                                        decoration: InputDecoration(
                                                            prefixIcon: Icon(
                                                              Icons.call,
                                                              color: Theme.of(context).colorScheme.secondary,
                                                            ),
                                                            labelText: 'Phone Number',
                                                            labelStyle: TextStyle(
                                                                fontWeight: FontWeight.w500,
                                                                color: Theme.of(context).colorScheme.secondary),
                                                            focusedBorder: OutlineInputBorder(),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(5),
                                                                borderSide: BorderSide(
                                                                    color: Theme.of(context).colorScheme.onPrimary,
                                                                    width: 2))),
                                                      ).marginOnly(bottom: 10),
                                                      TextFormField(
                                                        controller: converterController.txtChat,
                                                        decoration: InputDecoration(
                                                            prefixIcon: Icon(
                                                              Icons.chat_outlined,
                                                              color: Theme.of(context).colorScheme.secondary,
                                                            ),
                                                            labelText: 'Chat Conversation',
                                                            labelStyle: TextStyle(
                                                                fontWeight: FontWeight.w500,
                                                                color: Theme.of(context).colorScheme.secondary),
                                                            focusedBorder: OutlineInputBorder(),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(5),
                                                                borderSide: BorderSide(
                                                                    color: Theme.of(context).colorScheme.onPrimary,
                                                                    width: 2))),
                                                      ).marginOnly(bottom: 10),
                                                    ],
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {},
                                                        child: Text('Save')),
                                                    TextButton(onPressed: () {
                                                      converterController.txtName.clear();
                                                      converterController.txtPhone.clear();
                                                      converterController.txtChat.clear();
                                                      converterController.fileImagePath.value = "";
                                                      converterController.time = "";
                                                      converterController.date = "";
                                                      Get.back();
                                                    }, child: Text('Cancel'))
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
                                            converterController.removeData(
                                                converterController.data[index]['id']);
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: height * 0.040,
                                  backgroundImage:
                                  FileImage(File(converterController.data[index]['img'])),
                                ).marginOnly(right: 20),
                                RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: '${converterController.data[index]['name']}\n',
                                          style: TextStyle(
                                              color: Theme.of(context).colorScheme.primary,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                      TextSpan(
                                          text: '${converterController.data[index]['bio']}',
                                          style: TextStyle(
                                              color:
                                              Theme.of(context).colorScheme.secondary,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500)),
                                    ])),
                                Spacer(),
                                Text(
                                    '${converterController.data[index]['date']},${converterController.data[index]['time']}',
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
                  ),
                );
              case 2:
                return Callscreen();
              case 3:
                return CupertinoTabView(
                  builder: (BuildContext context) {
                    return CupertinoPageScaffold(
                      child: Obx(
                        () => SingleChildScrollView(
                          child: Column(
                            children: [
                              CupertinoListTile(
                                title: Text(
                                  'Profile',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColorDark),
                                ),
                                subtitle: Text(
                                  'Update Profile Data',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 16),
                                ),
                                leading: Icon(
                                  CupertinoIcons.person,
                                  color: CupertinoColors.activeBlue,
                                  size: 30,
                                ),
                                trailing: Obx(
                                  () => CupertinoSwitch(
                                    value: controller.profile.value,
                                    onChanged: (value) {
                                      controller.profile.value = value;
                                    },
                                  ).marginOnly(right: 15),
                                ),
                              ),
                              (controller.profile.value == true)
                                  ? Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            converterController.fileImagePath.value = "";
                                            ImagePicker image = ImagePicker();
                                            XFile? xfile = await image.pickImage(
                                                source: ImageSource.gallery);
                                            String path = xfile!.path;
                                            File fileImage = File(path);
                                            converterController.setImg(fileImage);
                                            if (converterController.ImgPath != null) {
                                              converterController.fileImagePath.value =
                                              "image";
                                            }
                                          },
                                          child: Obx(
                                                () =>  ClipOval(
                                              child: Container(
                                                height: 150,
                                                width: 150,
                                                color: CupertinoColors.activeBlue,
                                                alignment: Alignment.center,
                                                child: (converterController
                                                    .fileImagePath.value ==
                                                    "")
                                                    ? Icon(
                                                  CupertinoIcons.camera,
                                                  color: Colors.white,
                                                  size: 35,
                                                )
                                                    : Image(
                                                  image: FileImage(
                                                      converterController.ImgPath!.value),fit: BoxFit.cover,width: 150,
                                                ),
                                              ),
                                            ).marginOnly(top: 10, bottom: 15),
                                          ),
                                        ).marginOnly(top: 10,bottom: 15),
                                        CupertinoTextField(
                                          controller: converterController.txtName,
                                          placeholder: 'Enter your name...',
                                          textAlign: TextAlign.center,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                            color: Colors.transparent,
                                          )),
                                        ),
                                        CupertinoTextField(
                                          controller: converterController.txtChat,
                                          placeholder: 'Enter your bio...',
                                          textAlign: TextAlign.center,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                            color: Colors.transparent,
                                          )),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Spacer(),
                                            TextButton(
                                                onPressed: () {},
                                                child: Text(
                                                  'SAVE',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                      color: CupertinoColors
                                                          .activeBlue),
                                                )),
                                            TextButton(
                                                onPressed: () {
                                                  converterController.txtName.clear();
                                                  converterController.txtPhone.clear();
                                                  converterController.txtChat.clear();
                                                  converterController.fileImagePath.value = "";
                                                  converterController.time = "";
                                                  converterController.date = "";
                                                },
                                                child: Text(
                                                  'CLEAR',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                      color: CupertinoColors
                                                          .activeBlue),
                                                )),
                                            Spacer(),
                                          ],
                                        ),
                                      ],
                                    )
                                  : SizedBox(
                                      height: 0,
                                    ),
                              CupertinoListTile(
                                title: Text(
                                  'Theme',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColorDark),
                                ),
                                subtitle: Text(
                                  'Change Theme',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 16),
                                ),
                                leading: Icon(
                                  CupertinoIcons.sun_max,
                                  color: CupertinoColors.activeBlue,
                                  size: 30,
                                ),
                                trailing: Obx(
                                  () => CupertinoSwitch(
                                    value: controller.theme.value,
                                    onChanged: (value) {
                                      controller.theme.value = value;
                                    },
                                  ).marginOnly(right: 15),
                                ),
                              ).marginOnly(top: 15),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );

              default:
                return Container();
            }
          },
        ));
  }
}

File? fileImage;
