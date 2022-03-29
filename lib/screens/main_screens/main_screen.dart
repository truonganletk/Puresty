import 'package:flutter/material.dart';
import 'package:puresty/constants/app_colors.dart';
import 'package:puresty/screens/main_screens/add_screen/search_screen.dart';
import 'package:puresty/screens/main_screens/notification_screen/notification_screen.dart';
import 'package:puresty/screens/main_screens/post_screen/post_screen.dart';
import 'package:puresty/screens/main_screens/report_screen/report_screen.dart';
import 'package:puresty/screens/main_screens/setting_screen/setting_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    PostScreen(),
    ReportScreen(),
    SearchScreen(),
    NotificationScreen(),
    SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.article,
              color: _selectedIndex == 0 ? dullgreen : black,
            ),
            label: 'Post',
            backgroundColor: white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bar_chart,
              color: _selectedIndex == 1 ? dullgreen : black,
            ),
            label: 'Report',
            backgroundColor: white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search_rounded,
              color: _selectedIndex == 2 ? dullgreen : black,
            ),
            label: 'Search',
            backgroundColor: white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              color: _selectedIndex == 3 ? dullgreen : black,
            ),
            label: 'Notification',
            backgroundColor: white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: _selectedIndex == 4 ? dullgreen : black,
            ),
            label: 'Settings',
            backgroundColor: white,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: dullgreen,
        onTap: _onItemTapped,
      ),
    );
  }
}
