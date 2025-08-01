import 'package:flutter/material.dart';

class AttendanceContent extends StatelessWidget {
  const AttendanceContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: const Center(
        child: Text(
          'Attendance',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
