import 'package:flutter/material.dart';
import 'package:flutter_moodle/screens/main_screen/courses_screen/courses_screen.dart';
import 'package:flutter_moodle/screens/main_screen/profile_screen/profile_screen.dart';

class NavigationControl extends StatefulWidget {
  const NavigationControl({Key? key}) : super(key: key);

  @override
  State<NavigationControl> createState() => _NavigationControlState();
}

class _NavigationControlState extends State<NavigationControl> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  int selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    CoursesScreen(),
    ProfileScreen(),
    // const Text("data1"),
    // const Text("data2"),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Profile',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
