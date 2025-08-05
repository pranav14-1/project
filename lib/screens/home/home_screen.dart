import 'package:flutter/material.dart';
import 'home_content.dart';
import 'location_content.dart';
import 'attendance_content.dart';
import 'work_activity_content.dart';
import 'profile_content.dart';

class Homescreen extends StatefulWidget {
  final String userName;
  final String empType;

  const Homescreen({super.key, required this.userName, required this.empType});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  AnimationController? _animationController;
  Animation<double>? _fadeAnimation;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    // Initialize screens first
    _screens = [
      HomeContent(userName: widget.userName, empType: widget.empType),
      const LocationContent(),
      const AttendanceContent(),
      const WorkActivityContent(),
      const ProfileContent(),
    ];

    // Initialize animation controller for subtle transitions
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut),
    );

    // Start the initial animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController?.forward();
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  void _onNavItemTapped(int index) {
    if (_currentIndex != index && _animationController != null) {
      setState(() {
        _animationController!.reset();
        _currentIndex = index;
        _animationController!.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Row(
          children: [
            if (isTablet) _buildSideNavigation(),
            Expanded(
              child: _fadeAnimation != null
                  ? FadeTransition(
                      opacity: _fadeAnimation!,
                      child: _screens[_currentIndex],
                    )
                  : _screens[_currentIndex], // Fallback without animation
            ),
          ],
        ),
      ),
      bottomNavigationBar: !isTablet ? _buildBottomNavigation() : null,
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
            decoration: const BoxDecoration(
              color: Color(0xFF1976D2),
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
            ),
            child: Column(
              children: [
                const Text(
                  'WorkSpace',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.userName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.empType,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
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
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: ListTile(
                  leading: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      items[index]['icon'] as IconData,
                      color: _currentIndex == index
                          ? const Color(0xFF1976D2)
                          : const Color(0xFF616161),
                      size: 24,
                    ),
                  ),
                  title: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      color: _currentIndex == index
                          ? const Color(0xFF1976D2)
                          : const Color(0xFF616161),
                      fontWeight: _currentIndex == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 14,
                    ),
                    child: Text(items[index]['label'] as String),
                  ),
                  selected: _currentIndex == index,
                  selectedTileColor: const Color(0xFF1976D2).withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onTap: () => _onNavItemTapped(index),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF1976D2),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedFontSize: 12,
        unselectedFontSize: 10,
        iconSize: 24,
        elevation: 0,
        onTap: _onNavItemTapped,
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
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Work Activity',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
