// ignore_for_file: avoid_print

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todogetx/core/controller/homeC.dart';
import 'package:todogetx/core/models/taks.dart';
import 'package:todogetx/core/ui/widget/Header.dart';
import 'package:todogetx/core/ui/widget/tasktile.dart';
import 'package:todogetx/core/utils/const.dart';
import 'package:todogetx/core/utils/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();


} 

class _HomePageState extends State<HomePage> {
  final _homec = Get.put(HomeC());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children:  [
            const Headertask(),
            _addDateBar(),
            _showTask(),
            const SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }

  _showTask() {
    return Expanded(
      child: Obx(
        () {
          return ListView.builder(
            itemCount: _homec.taskList.length,
            itemBuilder: (_, index) {
              // print(_homec.taskList.length);
              Task task = _homec.taskList[index];
              if (task.repeat == 'Daily') {
                // DateTime date =
                //     DateFormat.jm().parse(task.startTime.toString());
                // var myTime = DateFormat("HH:mm").format(date);
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(
                              task,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
              if (task.date == DateFormat.yMd().format(_homec.selectedDateTime)) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(
                              task,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }

_showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.38,
        color: Get.isDarkMode ? darkGrey : Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
              ),
            ),
            task.isCompleted == 1
                ? Container()
                : _bottomSheetButton(
                    label: "Task Completed",
                    onTap: () {
                      _homec.markTaskCompleted(task.id!);
                      Get.back();
                    },
                    clr: kprimary,
                    context: context,
                  ),
            const SizedBox(
              height: 20,
            ),
            _bottomSheetButton(
              label: "Delete Task",
              onTap: () {
                _homec.delete(task);
                _homec.getTasks();
                Get.back();
              },
              clr: Colors.red[300]!,
              context: context,
            ),
            _bottomSheetButton(
              label: "Close",
              onTap: () {
                Get.back();
              },
              isClose: true,
              clr: Colors.red[300]!,
              context: context,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
_bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose == true
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style:
                isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectedTextColor: Colors.white,
        selectionColor: kprimary,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        onDateChange: (data) {
          setState(() {
            _homec.selectedDateTime = data;
          });
        },
      ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Get.isDarkMode ? Colors.black87 : kprimary,
      leading: GestureDetector(
        onTap: () {
          setState(() {
            ThemeService().switchTheme();
          });
        },
        child: Icon(
          Get.isDarkMode ? Icons.brightness_4 : Icons.nightlight_rounded,
          size: 24,
          color: Colors.white,
        ),
      ),
      actions: const [
        Icon(
          Icons.person,
          size: 28,
          color: Colors.white,
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}




