import 'package:flutter/material.dart';
import 'package:yantrik/pages/mech/mech_home_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:yantrik/pages/user/problem_page.dart';

class MechNavbar extends StatefulWidget {
  const MechNavbar({super.key});

  @override
  State<MechNavbar> createState() => _MechNavbarState();
}

class _MechNavbarState extends State<MechNavbar> {
  int _selectedIndex = 0;
  List<Widget> pages = [
    const MechHomePage(),
    const ProblemPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      backgroundColor: const Color.fromRGBO(29, 29, 29, 1),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color.fromARGB(223, 223, 223, 214),
        color: const Color.fromRGBO(83, 101, 198, 1),
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.report_problem,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
