import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _currentIndex = 1;

  final List<Widget> _screens = [
    const ResponsiveContent(text: 'Profile', icon: Icons.person),
    const ResponsiveContent(text: 'Hello User!!', icon: Icons.home),
    const ResponsiveContent(text: 'Settings', icon: Icons.settings),
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    final isDesktop = screenSize.width > 1200;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text(
          'Demo App',
          style: TextStyle(
            color: Colors.black,
            fontSize: _getAppBarTitleSize(screenSize.width),
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: isDesktop ? 2 : 0,
      ),
      body: Row(
        children: [
          if (isTablet)
            Container(
              width: isDesktop ? 280 : 200,
              color: Colors.orange.withOpacity(0.1),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  ...List.generate(3, (index) {
                    final items = [
                      {'icon': Icons.person, 'label': 'Profile'},
                      {'icon': Icons.home, 'label': 'Home'},
                      {'icon': Icons.settings, 'label': 'Settings'},
                    ];
                    
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: ListTile(
                        leading: Icon(
                          items[index]['icon'] as IconData,
                          color: _currentIndex == index ? Colors.orange : Colors.grey,
                          size: isDesktop ? 28 : 24,
                        ),
                        title: Text(
                          items[index]['label'] as String,
                          style: TextStyle(
                            color: _currentIndex == index ? Colors.orange : Colors.grey[700],
                            fontWeight: _currentIndex == index ? FontWeight.bold : FontWeight.normal,
                            fontSize: isDesktop ? 16 : 14,
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
            ),
          
          Expanded(
            child: _screens[_currentIndex],
          ),
        ],
      ),
      
      bottomNavigationBar: !isTablet ? BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.shade300,
        selectedFontSize: _getBottomNavFontSize(screenSize.width),
        unselectedFontSize: _getBottomNavFontSize(screenSize.width) - 2,
        iconSize: _getBottomNavIconSize(screenSize.width),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ) : null,
    );
  }

  double _getAppBarTitleSize(double screenWidth) {
    if (screenWidth > 1200) return 24;
    if (screenWidth > 600) return 22;
    return 20;
  }

  double _getBottomNavFontSize(double screenWidth) {
    if (screenWidth > 400) return 14;
    return 12;
  }

  double _getBottomNavIconSize(double screenWidth) {
    if (screenWidth > 400) return 28;
    return 24;
  }
}

class ResponsiveContent extends StatelessWidget {
  final String text;
  final IconData icon;

  const ResponsiveContent({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    final isDesktop = screenSize.width > 1200;

    return Container(
      padding: EdgeInsets.all(_getPadding(screenSize.width)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: _getIconContainerSize(screenSize.width),
              height: _getIconContainerSize(screenSize.width),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.orange, width: 2),
              ),
              child: Icon(
                icon,
                size: _getIconSize(screenSize.width),
                color: Colors.orange,
              ),
            ),
            SizedBox(height: isDesktop ? 32 : isTablet ? 24 : 16),
            Text(
              text,
              style: TextStyle(
                fontSize: _getTextSize(screenSize.width),
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            if (isTablet) ...[
              SizedBox(height: 16),
              Text(
                'Optimized for ${isDesktop ? 'Desktop' : 'Tablet'}',
                style: TextStyle(
                  fontSize: isDesktop ? 16 : 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  double _getPadding(double screenWidth) {
    if (screenWidth > 1200) return 48;
    if (screenWidth > 600) return 32;
    return 24;
  }

  double _getIconContainerSize(double screenWidth) {
    if (screenWidth > 1200) return 120;
    if (screenWidth > 600) return 100;
    return 80;
  }

  double _getIconSize(double screenWidth) {
    if (screenWidth > 1200) return 60;
    if (screenWidth > 600) return 50;
    return 40;
  }

  double _getTextSize(double screenWidth) {
    if (screenWidth > 1200) return 36;
    if (screenWidth > 600) return 32;
    return 28;
  }
}
