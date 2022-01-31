import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todogetx/core/ui/addtaskpage.dart';
import 'package:todogetx/core/ui/widget/custbutton.dart';
import 'package:todogetx/core/utils/const.dart';

class Headertask extends StatelessWidget {
  const Headertask({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMEd().format(
                DateTime.now(),
              ),
              style: subheadingStyle,
            ),
            Text(
              'Hari Ini',
              style: headingStyle,
            ),
           
          ],
        ),
         buttonAdd(ontap: () async {
              await Get.to(const AddTaskPage());
            })
      ],
    );
  }
}