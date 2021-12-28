import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_todo_app/app/core/utils/extentions.dart';
import 'package:getx_todo_app/app/core/values/colors.dart';
import 'package:getx_todo_app/app/data/models/task.dart';
import 'package:getx_todo_app/app/modules/home/home_controller.dart';
import 'package:getx_todo_app/app/widgets/icons.dart';

class AddCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
            title: 'New Task',
            radius: 5,
            content: Form(
              key: homeCtrl.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                    child: TextFormField(
                      controller: homeCtrl.editController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your task title!';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                    child: Wrap(
                      spacing: 2.0.wp,
                      children: icons
                          .map((e) => Obx(
                                () {
                                  final index = icons.indexOf(e);
                                  return ChoiceChip(
                                    backgroundColor: Colors.white,
                                    selectedColor: Colors.grey.shade200,
                                    onSelected: (bool selected) {
                                      homeCtrl.chipIndex.value =
                                          selected ? index : 0;
                                    },
                                    pressElevation: 0,
                                    label: e,
                                    selected: homeCtrl.chipIndex.value == index,
                                  );
                                },
                              ))
                          .toList(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (homeCtrl.formKey.currentState!.validate()) {
                        int icon =
                            icons[homeCtrl.chipIndex.value].icon!.codePoint;
                        String color =
                            icons[homeCtrl.chipIndex.value].color!.toHex();
                        String title = homeCtrl.editController.text;
                        var task = Task(
                          title: title,
                          icon: icon,
                          color: color,
                        );
                        Get.back();
                        homeCtrl.addTask(task)
                            ? EasyLoading.showSuccess(
                                'Task Added Successfully!')
                            : EasyLoading.showError(
                                'Duplicate task!',
                              );
                      }
                    },
                    child: const Text('Confirm'),
                    style: ElevatedButton.styleFrom(
                      primary: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(150, 40),
                    ),
                  )
                ],
              ),
            ),
          );
          homeCtrl.editController.clear();
          homeCtrl.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey.shade400,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
