
import 'package:admin/controller/notification_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationController controller = Get.put(NotificationController());
    return GetBuilder<NotificationController>(
        builder: (controller) => HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: Container(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  const Center(
                      child: Text(
                    'Notification',
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColor.primaryColr,
                        fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  ...List.generate(
                      controller.data.length,
                      (index) => Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: Stack(
                              children: [
                                ListTile(
                                  title: Text(
                                      controller.data[index]
                                          ['notification_title'],
                                      style: const TextStyle(
                                          color: AppColor.primaryColr,
                                          fontWeight: FontWeight.bold)),
                                  subtitle: Text(controller.data[index]
                                      ['notification_body']),
                                ),
                                Positioned(
                                    right: 5,
                                    child: Text(
                                        Jiffy(
                                                controller.data[index]
                                                    ['notification_datetime'],
                                                'yyyy-MM-dd')
                                            .fromNow(),
                                        style: const TextStyle(
                                            color: AppColor.primaryColr,
                                            fontWeight: FontWeight.bold))),
                              ],
                            ),
                          )),
                ],
              ),
            )));
  }
}
