import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Controller/converter_controller.dart';

class Callscreen extends StatelessWidget {
  const Callscreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var controller = Get.put(ConverterController());
    return Obx(
          () =>  (controller.data.length==0)?Center(
          child: Text(
            'No any calls yet...',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Theme.of(context).colorScheme.secondary,),
          )):ListView.builder(
        itemCount: controller.data.length,
        itemBuilder: (context, index) =>
            GestureDetector(
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
                            backgroundImage: FileImage(File(controller.data[index]['img'])),
                          ).marginOnly(top: height * 0.025, bottom: height * 0.005),
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
                                color: Theme.of(context).colorScheme.secondary,
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
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Theme.of(context).colorScheme.secondary,
                                    size: height * 0.035,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    controller.removeData(controller.data[index]['id']);
                                    Get.back();
                                  },
                                  icon: Icon(Icons.delete,
                                      color: Theme.of(context).colorScheme.secondary,
                                      size: height * 0.035)),
                              Spacer(),
                            ],
                          ).marginOnly(top: height * 0.015),
                          OutlinedButton(
                            onPressed: () {},
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
                        backgroundImage: FileImage(File(controller.data[index]['img'])),
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
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                          ])),
                      Spacer(),
                      Icon(Icons.call,color: Colors.green,),
                    ],
                  ).marginSymmetric(horizontal: 15, vertical: 10),
                ],
              ),
            ),
      ),
    );
  }
}
