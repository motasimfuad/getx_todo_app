import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_app/app/core/utils/extentions.dart';
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
                      homeCtrl.changeTask(null);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ],
              ),
            ),
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
              child: Row(
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
                        colors: [Colors.grey.shade300, Colors.grey.shade300],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
