import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter_app/Controller/converter_controller.dart';

class Adddata extends StatelessWidget {
  const Adddata({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ConverterController());
    Future<void> _selectTime(BuildContext context) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      controller.time =
          pickedTime!.hour.toString() + ":" + pickedTime.minute.toString();
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    File? fileImage;
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              controller.fileImagePath.value = "";
              ImagePicker image = ImagePicker();
              XFile? xfile = await image.pickImage(source: ImageSource.gallery);
              String path = xfile!.path;
              File fileImage = File(path);
              controller.setImg(fileImage);
              if (controller.ImgPath != null) {
                controller.fileImagePath.value = "image";
              }
            },
            child: Obx(
              () => CircleAvatar(
                radius: height * 0.085,
                backgroundColor: Theme.of(context).colorScheme.onSecondary,
                child: (controller.fileImagePath.value == "")
                    ? Icon(
                        Icons.add_a_photo_outlined,
                        size: height * 0.035,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      )
                    : null,
                backgroundImage: (controller.fileImagePath.value == "")
                    ? null
                    : FileImage(controller.ImgPath!.value),
                // child: controller.ImgPath!.value == null
                //     ? Icon(Icons.person, size: 100)
                //     : null,
              ).marginOnly(top: height * 0.020, bottom: height * 0.030),
            ),
          ),
          TextFormField(
            controller: controller.txtName,
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
          ).marginSymmetric(horizontal: 15, vertical: 8),
          TextFormField(
            controller: controller.txtPhone,
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
          ).marginSymmetric(horizontal: 15, vertical: 8),
          TextFormField(
            controller: controller.txtChat,
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
          ).marginSymmetric(horizontal: 15, vertical: 8),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                    selectableDayPredicate: (day) {
                      controller.date = day.year.toString() +
                          "-" +
                          day.month.toString() +
                          "-" +
                          day.day.toString();
                      return true;
                    },
                  );
                },
                child: Icon(
                  Icons.calendar_month_outlined,
                  color: Theme.of(context).colorScheme.secondary,
                  size: height * 0.030,
                ),
              ),
              Text(
                '   Pick Date',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
            ],
          ).marginOnly(left: 15, top: 10),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  _selectTime(context);
                },
                child: Icon(
                  Icons.watch_later_outlined,
                  color: Theme.of(context).colorScheme.secondary,
                  size: height * 0.030,
                ),
              ),
              Text(
                '   Pick Time',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
            ],
          ).marginOnly(left: 15, top: 15, bottom: 15),
          OutlinedButton(
            onPressed: () {
              controller.insertData(
                  controller.ImgPath!.value.path,
                  controller.time,
                  controller.date,
                  controller.txtChat.text,
                  controller.txtPhone.text,
                  controller.txtName.text);
              controller.txtName.clear();
              controller.txtPhone.clear();
              controller.txtChat.clear();
              controller.fileImagePath.value="";
              controller.time="";
              controller.date="";
            },
            child: Text(
              'SAVE',
              style: TextStyle(fontSize: 18, color: Colors.deepPurpleAccent),
            ),
          )
        ],
      ),
    );
  }
}
