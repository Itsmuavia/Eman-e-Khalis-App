import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:emane_khalis_app/Screens/Content.dart';
import 'package:emane_khalis_app/Screens/Events.dart';
import 'package:emane_khalis_app/Screens/ProfilePage.dart';
import 'package:emane_khalis_app/Screens/QnA.dart';
import 'package:emane_khalis_app/Screens/Tafseer.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int index = 0;

  final screens = [
    Tafseer(),
    Content(),
    Events(),
    Qna(),
    ProfilePage(),
  ];

  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.bookOpen, size: 20, color: CupertinoColors.white),
      label: 'Tafseer',
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.fileAlt, size: 20, color: CupertinoColors.white),
      label: 'Content',
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.calendarDays, size: 20, color: CupertinoColors.white),
      label: 'Events',
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.question, size: 20, color: CupertinoColors.white),
      label: 'Q/A',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person, size: 20, color: CupertinoColors.white),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index], // <-- Ye missing tha
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade300,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: items,
        onTap: (index) {
          setState(() {
            this.index = index;
          });
        },
      ),
    );
  }
}
