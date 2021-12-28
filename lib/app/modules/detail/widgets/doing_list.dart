import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_app/app/core/utils/extentions.dart';
import 'package:getx_todo_app/app/modules/home/home_controller.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty
          ? Flexible(
              child: Center(
                child: Image.asset(
                  'assets/images/task.png',
                  fit: BoxFit.cover,
                  width: 65.0.wp,
                ),
              ),
            )
          : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...homeCtrl.doingTodos
                    .map(
                      (element) => Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 9.0.wp,
                          vertical: 3.0.wp,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: Checkbox(
                                onChanged: (value) {
                                  homeCtrl.doneTodo(element['title']);
                                },
                                value: element['done'],
                                fillColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.grey.shade400,
                                ),
                              ),
                            ),
                            SizedBox(width: 3.0.wp),
                            Text(
                              element['title'],
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                if (homeCtrl.doingTodos.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                    child: const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
              ],
            ),
    );
  }
}
