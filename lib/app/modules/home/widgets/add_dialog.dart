import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:getx_todo_app/app/core/utils/extentions.dart';
import 'package:getx_todo_app/app/core/values/colors.dart';
import 'package:getx_todo_app/app/modules/home/home_controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class AddDialog extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                      homeCtrl.editController.clear();
                      homeCtrl.changeTask(null);
                    },
                    icon: const Icon(Icons.close),
                  ),
                  TextButton(
                    style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                      Colors.transparent,
                    )),
                    onPressed: () {
                      if (homeCtrl.formKey.currentState!.validate()) {
                        if (homeCtrl.task.value == null) {
                          EasyLoading.showError('Please select a task');
                        } else {
                          var success = homeCtrl.updateTask(
                            homeCtrl.task.value!,
                            homeCtrl.editController.text,
                          );
                          if (success) {
                            EasyLoading.showSuccess('Todo added successfully!');
                            homeCtrl.changeTask(null);
                            homeCtrl.editController.clear();
                            Get.back();
                          } else {
                            EasyLoading.showError('Todo already exist!');
                            homeCtrl.changeTask(null);
                          }
                        }
                      }
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 14.0.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: Form(
                key: homeCtrl.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Todo',
                      style: TextStyle(
                        fontSize: 20.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: [
                        TextFormField(
                          autofocus: true,
                          controller: homeCtrl.editController,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your todo!';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 5.0.wp,
                        bottom: 2.0.wp,
                      ),
                      child: Text(
                        'Add to',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0.sp,
                        ),
                      ),
                    ),
                    ...homeCtrl.tasks
                        .map((element) => InkWell(
                              onTap: () {
                                homeCtrl.changeTask(element);
                                print(element.title);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 3.0.wp,
                                ),
                                child: Obx(
                                  () => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            IconData(
                                              element.icon,
                                              fontFamily: 'MaterialIcons',
                                            ),
                                            color:
                                                HexColor.fromHex(element.color),
                                          ),
                                          SizedBox(width: 3.0.wp),
                                          Text(
                                            element.title,
                                            style: TextStyle(
                                              fontSize: 12.0.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (homeCtrl.task.value == element)
                                        const Icon(
                                          Icons.check,
                                          color: blue,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
