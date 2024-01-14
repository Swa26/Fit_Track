import 'dart:ui';

import 'package:flutter/material.dart';

class WeekDaysSmallDisplay extends StatelessWidget {
  String disp = "";
  WeekDaysSmallDisplay({required this.disp});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: Color(0xFFF9CEEE)),
      child: Text(
        disp,
        style: TextStyle(color: Color(0xFF5b0098), fontSize: 20),
      ),
    );
  }
}
