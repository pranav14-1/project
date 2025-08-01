import 'package:flutter/material.dart';
import 'home_content.dart';
import 'location_content.dart';
import 'attendance_content.dart';
import 'work_activity_content.dart';
import 'profile_content.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(),
    const LocationContent(),
    const AttendanceContent(),
    const WorkActivityContent(),
    const ProfileContent(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Row(
          children: [
            if (isTablet) _buildSideNavigation(),
            Expanded(child: _screens[_currentIndex]),
          ],
        ),
      ),
      bottomNavigationBar: !isTablet ? _buildBottomNavigation() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildSideNavigation() {
    return Container(
      width: 220,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              'Demo App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ...List.generate(5, (index) {
            final items = [
              {'icon': Icons.home, 'label': 'Home'},
              {'icon': Icons.location_on, 'label': 'Location'},
              {'icon': Icons.access_time, 'label': 'Attendance'},
              {'icon': Icons.work, 'label': 'Work Activity'},
              {'icon': Icons.person, 'label': 'Profile'},
            ];

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: ListTile(
                leading: Icon(
                  items[index]['icon'] as IconData,
                  color: _currentIndex == index ? Colors.orange : Colors.grey,
                  size: 24,
                ),
                title: Text(
                  items[index]['label'] as String,
                  style: TextStyle(
                    color: _currentIndex == index
                        ? Colors.orange
                        : Colors.grey[700],
                    fontWeight: _currentIndex == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
                selected: _currentIndex == index,
                selectedTileColor: Colors.orange.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onTap: () {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      backgroundColor: Colors.orange,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,
      selectedFontSize: 12,
      unselectedFontSize: 10,
      iconSize: 24,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on),
          label: 'Location',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.access_time),
          label: 'Attendance',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Work Activity'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
