// ignore_for_file: avoid_print, unnecessary_new

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:todogetx/core/database/db_helper.dart';
import 'package:todogetx/core/models/taks.dart';

class HomeC extends GetxController {

    @override
  void onReady() {
    getTasks();
    super.onReady();
  }
  var taskList = <Task>[].obs;
  DateTime selectedDateTime = DateTime.now();


  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DbHelpe.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  void delete(Task task) {
    var val = DbHelpe.deleted(task);
    print(val);
  }

  void markTaskCompleted(int id) async {
    await DbHelpe.update(id);
    getTasks();
  }


}
