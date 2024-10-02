import 'package:flutter/material.dart';
import 'package:task_manager/screens/add_new_task_screen.dart';
import 'package:task_manager/screens/canceled_task_screen.dart';
import 'package:task_manager/screens/completed_task_screen.dart';
import 'package:task_manager/screens/inprogress_task_screen.dart';
import 'package:task_manager/screens/new_task_screen.dart';

import '../widgets/tm_appbar.dart';

class MainBottomNavbarScreen extends StatefulWidget {
  const MainBottomNavbarScreen({super.key});

  @override
  State<MainBottomNavbarScreen> createState() => _MainBottomNavbarScreenState();
}

class _MainBottomNavbarScreenState extends State<MainBottomNavbarScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CanceledTaskScreen(),
    InProgressTaskScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            _selectedIndex = index;
            setState(() {});
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.new_label), label: "New"),
            NavigationDestination(
                icon: Icon(Icons.check_box), label: "completed"),
            NavigationDestination(icon: Icon(Icons.close), label: "Canceled"),
            NavigationDestination(
                icon: Icon(Icons.access_time), label: "InProgress"),
          ]),

    );
  }
}
