import 'package:flutter/material.dart';

class LocationContent extends StatelessWidget {
  const LocationContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: const Center(
        child: Text(
          'Location',
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
