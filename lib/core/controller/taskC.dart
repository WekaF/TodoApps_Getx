import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:todogetx/core/database/db_helper.dart';
import 'package:todogetx/core/models/taks.dart';

class TaskController extends GetxController{

  final titlecontroller = TextEditingController();
  final notecontroller = TextEditingController();

String endTime = "10.00 PM";
String startTime = DateFormat("MMM dd, yyyy hh:mm:ss aa").format(DateTime.now()).toString();
int selectedRemind = 5;
List<int> remindList = [5,10, 15, 20];
  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);

String selectedRepeat = "none";
List<String> repeatList = ["None", "Daily", "Weekly"];
int selectedColor = 0;

DateTime selecteddate = DateTime.now();

// ignore: prefer_typing_uninitialized_variables
var notifyHelpers;

  Future<int> addTask({Task? task}) async{
    return await DbHelpe.insert(task);
  }

}