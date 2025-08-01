import 'package:flutter/material.dart';

class WorkActivityContent extends StatelessWidget {
  const WorkActivityContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: const Center(
        child: Text(
          'Work Activity',
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
