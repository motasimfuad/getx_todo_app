import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_app/app/core/utils/extentions.dart';
import 'package:getx_todo_app/app/core/values/colors.dart';
import 'package:getx_todo_app/app/modules/home/home_controller.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ReportView extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  ReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () {
            var createdTask = homeCtrl.getTotalTask();
            var completedTask = homeCtrl.getTotalDoneTask();
            var liveTasks = createdTask - completedTask;
            var percent =
                (completedTask / createdTask * 100).toStringAsFixed(0);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(4.0.wp),
                  child: Text(
                    'Report',
                    style: TextStyle(
                      fontSize: 24.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                  child: Text(
                    DateFormat.yMMMEd().format(DateTime.now()),
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 3.0.wp,
                    horizontal: 4.0.wp,
                  ),
                  child: const Divider(
                    thickness: 2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 3.0.wp,
                    horizontal: 5.0.wp,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatus(Colors.orange, liveTasks, 'Live Tasks'),
                      _buildStatus(Colors.green, completedTask, 'Completed'),
                      _buildStatus(Colors.blue, createdTask, 'All Tasks'),
                    ],
                  ),
                ),
                // SizedBox(height: 8.0.wp),
                Expanded(
                  child: Center(
                    child: UnconstrainedBox(
                      child: SizedBox(
                        height: 70.0.wp,
                        width: 70.0.wp,
                        child: CircularStepProgressIndicator(
                          totalSteps: createdTask == 0 ? 1 : createdTask,
                          currentStep: completedTask == 0 ? 0 : completedTask,
                          padding: 0,
                          height: 150,
                          width: 150,
                          selectedColor: green,
                          unselectedColor: Colors.grey.shade200,
                          roundedCap: (p0, p1) => true,
                          stepSize: 20.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${(percent == '0') ? '0' : percent}%',
                                style: TextStyle(
                                  fontSize: 20.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 1.0.wp),
                              Text(
                                'Efficiency',
                                style: TextStyle(
                                  fontSize: 12.0.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 14.0.wp),
              ],
            );
          },
        ),
      ),
    );
  }

  Row _buildStatus(Color color, int number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 1.0.wp),
          child: Container(
            height: 3.0.wp,
            width: 3.0.wp,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(30),
              shape: BoxShape.circle,
              border: Border.all(
                width: 0.5.wp,
                color: color,
              ),
            ),
          ),
        ),
        SizedBox(width: 3.0.wp),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$number',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0.sp,
              ),
            ),
            SizedBox(height: 1.0.wp),
            Text(
              text,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0.sp,
              ),
            ),
          ],
        )
      ],
    );
  }
}
