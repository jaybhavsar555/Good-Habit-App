import 'package:flutter/material.dart';
import 'package:good_habit_app/screens/profile_screen.dart';
import 'package:good_habit_app/screens/search_screen.dart';
import 'package:good_habit_app/screens/stats_screen.dart';
import 'package:good_habit_app/utils/constants/app_styles.dart';

import 'home_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  static int _selectedItemIndex = 0;
  static final List<Widget> _widgetOption = <Widget>[
    // const Text("Home"), //0
    const HomeScreen(), //0
    const SearchScreen(), //1
    const StatsScreen(), //2
    const ProfileScreen(), //3
  ];

  void _onTappedBtn(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        body: Builder(builder: (context) {
          return Center(
            child: _widgetOption[_selectedItemIndex],
          );
        }),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onTappedBtn,
          currentIndex: _selectedItemIndex,
          selectedItemColor: Styles.primaryColor,
          unselectedItemColor: Colors.blue,
          elevation: 20,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart), label: "Statistics"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      );
    });
  }
}
