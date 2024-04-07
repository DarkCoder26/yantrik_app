import 'package:flutter/material.dart';
import 'package:yantrik/pages/home_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:yantrik/pages/problem_page.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;
  List<Widget> pages = [
    const HomePage(),
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
