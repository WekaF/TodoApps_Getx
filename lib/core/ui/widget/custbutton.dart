import 'package:flutter/material.dart';
import 'package:todogetx/core/utils/const.dart';

class buttonAdd extends StatelessWidget {
  final Function() ontap;
  final String? label;
  const buttonAdd({
    Key? key,
    required this.ontap, this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 100,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: kprimary),
        child: const Center(
          child: Text(
            'Add Task',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}