import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:emane_khalis_app/Screens/Tafseer.dart';
import 'package:emane_khalis_app/Screens/Events.dart';
import 'package:emane_khalis_app/Screens/ProfilePage.dart';
import 'package:emane_khalis_app/Screens/QnA.dart';
import 'package:emane_khalis_app/Screens/Homepage.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int index = 0;

  final screens = [
    Homepage(),
    Tafseer(),
    Events(),
    Qna(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.green.shade900,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: index,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.amberAccent.shade200, // Golden for active
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 14,
          unselectedFontSize: 12,
          onTap: (i) {
            setState(() {
              index = i;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.home, size: index == 0 ? 26 : 22),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.bookOpen, size: index == 1 ? 26 : 22),
              label: 'Tafseer',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.calendarDays, size: index == 2 ? 26 : 22),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidQuestionCircle, size: index == 3 ? 26 : 22),
              label: 'Q/A',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, size: index == 4 ? 26 : 22),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }
}
