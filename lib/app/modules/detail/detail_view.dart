import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_todo_app/app/core/utils/extentions.dart';
import 'package:getx_todo_app/app/modules/detail/widgets/doing_list.dart';
import 'package:getx_todo_app/app/modules/detail/widgets/done_list.dart';
import 'package:getx_todo_app/app/modules/home/home_controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DetailView extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.task.value;
    var color = HexColor.fromHex(task!.color);
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: homeCtrl.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(3.0.wp),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        homeCtrl.updateTodos();
                        homeCtrl.changeTask(null);
                        homeCtrl.editController.clear();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
                      child: Row(
                        children: [
                          Icon(
                            IconData(task.icon, fontFamily: 'MaterialIcons'),
                            color: color,
                          ),
                          SizedBox(width: 3.0.wp),
                          Text(
                            task.title,
                            style: TextStyle(
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0.wp,
                        vertical: 3.0.wp,
                      ),
                      child: Obx(
                        () => Row(
                          children: [
                            Text(
                              '${homeCtrl.totalTodos()} todos',
                              style: TextStyle(
                                fontSize: 12.0.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: 3.0.wp),
                            Expanded(
                              child: StepProgressIndicator(
                                totalSteps: homeCtrl.totalTodos() == 0
                                    ? 1
                                    : homeCtrl.totalTodos(),
                                currentStep: homeCtrl.doneTodos.length,
                                size: 5,
                                padding: 0,
                                selectedGradientColor: LinearGradient(
                                  colors: [color.withOpacity(0.5), color],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                unselectedGradientColor: LinearGradient(
                                  colors: [
                                    Colors.grey.shade300,
                                    Colors.grey.shade300
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 2.0.wp,
                        horizontal: 5.0.wp,
                      ),
                      child: TextFormField(
                        controller: homeCtrl.editController,
                        decoration: InputDecoration(
                          hintText: 'My todo...',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          )),
                          prefixIcon: Icon(
                            Icons.check_box_outline_blank,
                            color: Colors.grey.shade400,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              if (homeCtrl.formKey.currentState!.validate()) {
                                var success = homeCtrl
                                    .addTodo(homeCtrl.editController.text);
                                if (success) {
                                  EasyLoading.showSuccess(
                                      'Todo added successfully!');
                                } else {
                                  EasyLoading.showError('Failed');
                                }
                                homeCtrl.editController.clear();
                              }
                            },
                            icon: const Icon(Icons.done),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter the todo title!';
                          }
                        },
                      ),
                    ),
                    DoingList(),
                    DoneList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
