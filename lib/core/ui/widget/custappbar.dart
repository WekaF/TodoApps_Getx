import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todogetx/core/utils/const.dart';

// ignore: unused_element
AppBar _custAppbar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Get.isDarkMode ? Colors.black87 : kprimary,
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
