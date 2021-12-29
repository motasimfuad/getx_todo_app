import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_todo_app/app/core/utils/extentions.dart';
import 'package:getx_todo_app/app/core/values/colors.dart';
import 'package:getx_todo_app/app/data/models/task.dart';
import 'package:getx_todo_app/app/modules/home/home_controller.dart';
import 'package:getx_todo_app/app/modules/home/widgets/add_card.dart';
import 'package:getx_todo_app/app/modules/home/widgets/add_dialog.dart';
import 'package:getx_todo_app/app/modules/home/widgets/task_card.dart';
import 'package:getx_todo_app/app/modules/report/report_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => IndexedStack(
            index: controller.tabIdx.value,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0.wp),
                    child: Text(
                      'My Tasks',
                      style: TextStyle(
                        fontSize: 24.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        children: <Widget>[
                          ...controller.tasks
                              .map(
                                (element) => LongPressDraggable(
                                  data: element,
                                  onDragStarted: () =>
                                      controller.changeDeleting(true),
                                  onDraggableCanceled: (velocity, offset) =>
                                      controller.changeDeleting(false),
                                  onDragEnd: (details) =>
                                      controller.changeDeleting(false),
                                  feedback: Opacity(
                                    opacity: 0.8,
                                    child: TaskCard(
                                      task: element,
                                    ),
                                  ),
                                  child: TaskCard(task: element),
                                ),
                              )
                              .toList(),
                          AddCard(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ReportView(),
            ],
          ),
        ),
      ),
      floatingActionButton: DragTarget<Task>(
        builder: (context, candidateData, rejectedData) {
          return Obx(
            () => FloatingActionButton(
              onPressed: () {
                Get.to(
                  () => AddDialog(),
                  transition: Transition.downToUp,
                );
              },
              backgroundColor:
                  controller.deleting.value == true ? Colors.red : blue,
              child: Icon(
                  controller.deleting.value == true ? Icons.delete : Icons.add),
            ),
          );
        },
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Task deleted!');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(
          () => BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: controller.tabIdx.value,
            onTap: (int index) => controller.changeTabIndex(index),
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(right: 15.0.wp),
                  child: const Icon(Icons.apps),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(left: 15.0.wp),
                  child: const Icon(Icons.data_usage),
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
