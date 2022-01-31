// ignore_for_file: avoid_print, camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todogetx/core/controller/taskC.dart';
import 'package:todogetx/core/models/taks.dart';
import 'package:todogetx/core/ui/widget/custForm.dart';
import 'package:todogetx/core/utils/const.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _taskc = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Get.isDarkMode ? Colors.black87 : kprimary,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Task',
              style: headingStyle,
            ),
            custForm(
              controller: _taskc.titlecontroller,
              hint: 'Title',
              title: 'Masukkan Title',
            ),
            custForm(
              title: 'note',
              controller: _taskc.notecontroller,
              hint: 'Note',
            ),
            custForm(
              title: 'Date',
              hint: DateFormat.yMd().format(_taskc.selecteddate),
              widget: IconButton(
                icon: const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.black,
                ),
                onPressed: () {
                  _getDateFromUser();
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: custForm(
                    title: 'start date',
                    hint: _taskc.startTime,
                    widget: IconButton(
                      // ignore: prefer_const_constructors
                      icon: Icon(
                        Icons.access_time_rounded,
                      ),
                      onPressed: () {
                        setState(() {
                          _getTimeFromUser(isStartTime: true);
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: custForm(
                    title: 'end date',
                    hint: _taskc.endTime,
                    widget: IconButton(
                      // ignore: prefer_const_constructors
                      icon: Icon(
                        Icons.access_time_rounded,
                      ),
                      onPressed: () {
                        setState(() {
                          _getTimeFromUser(isStartTime: false);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            custForm(
              title: 'Remind',
              hint: _taskc.selectedRemind.toString(),
              widget: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  elevation: 4,
                  items: _taskc.remindList
                      .map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _taskc.selectedRemind = int.parse(newValue!);
                    });
                  }),
            ),
            custForm(title: 'Repeat',
            hint: _taskc.selectedRepeat,
            widget: DropdownButton(
              items: _taskc.repeatList.map<DropdownMenuItem<String>>((String? value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value!,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    );
              }).toList(),
                
               onChanged: (String? value){
                 setState(() {
                   _taskc.selectedRepeat = value!;
                 });
               }
              
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _colorPallete(),
                Container(
                  child: GestureDetector(
                    onTap: _valideData,
                    child: Container(
                      height: 60,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kprimary,
                      ),
                      child: Center(
                        child: Text(
                          'Add Task',
                          style: buttonText,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }




  _addToDB() async {
    int value = await _taskc.addTask(
      task: Task(
        note: _taskc.notecontroller.text,
        title: _taskc.titlecontroller.text,
        date: DateFormat.yMd().format(_taskc.selecteddate),
        startTime: _taskc.startTime,
        endTime: _taskc.endTime,
        remind: _taskc.selectedRemind,
        color: _taskc.selectedColor,
        isCompleted: 0,
        isCreated: 0,
        isDoing: 0,
        isDone: 0,
      ),
    );
    // ignore: prefer_adjacent_string_concatenation
    print("the ID is :" + "$value");
  }

  _valideData() {
    if (_taskc.titlecontroller.text.isNotEmpty &&
        _taskc.notecontroller.text.isNotEmpty) {
      _addToDB();
      Get.back();
    } else if (_taskc.titlecontroller.text.isEmpty ||
        _taskc.titlecontroller.text.isEmpty) {
      Get.snackbar('Peringatan', 'Semuanya harus di isi',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
          colorText: pink);
    }
  }

  _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: titleStyle,
        ),
        const SizedBox(
          height: 8,
        ),
        Wrap(
          children: List.generate(
            3,
            (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _taskc.selectedColor = index;
                    //print(_selectedColor);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 14,
                    child: _taskc.selectedColor == index
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 16,
                          )
                        : Container(),
                    backgroundColor: index == 0
                        ? kprimary
                        : index == 1
                            ? pink
                            : kYellow,
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: _taskc.selectedTime,
    );
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var picked = await _showTimePicker();
    String _formatTime = picked.format(context);
    if (picked == null) {
      print("Time cancel");
    } else if (isStartTime == true) {
      setState(() {
        _taskc.startTime = _formatTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _taskc.endTime = _formatTime;
      });
    }
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2121),
    );

    if (_pickerDate != null) {
      setState(() {
        _taskc.selecteddate = _pickerDate;
      });
    } else {
      print("It's null or something is wrong.");
    }
  }
}



