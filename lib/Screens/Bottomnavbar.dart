import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:emane_khalis_app/Screens/Tafseer.dart';
import 'package:emane_khalis_app/Screens/Ibadat.dart';
import 'package:emane_khalis_app/Screens/ProfilePage.dart';
import 'package:emane_khalis_app/Screens/QnA.dart';
import 'package:emane_khalis_app/Screens/Homepage.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int index = 2; // By default Home show karega (center position)

  final screens = [
    const Tafseer(), // 0
    const Ibadat(), // 1
    const Homepage(), // 2 (HOME always center)
    const Qna(), // 3
    const ProfilePage(), // 4
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background design
          Container(
            height: 65,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF002147), Color(0xFF004AAD)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 10,
                  offset: Offset(0, -3),
                ),
              ],
            ),
          ),

          // Normal Bottom Navigation
          BottomNavigationBar(
            currentIndex: index,
            backgroundColor: Colors.transparent,
            selectedItemColor: const Color(0xFFFFD700),
            // Golden
            unselectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 13,
            unselectedFontSize: 12,
            elevation: 0,
            onTap: (i) {
              setState(() {
                index = i;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.bookOpen, size: 22),
                label: 'Tafseer',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.listCheck, size: 22),
                label: 'Ibadat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.circle, size: 0), // Empty for center button
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.solidQuestionCircle, size: 22),
                label: 'Q/A',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings, size: 22),
                label: 'More',
              ),
            ],
          ),

          // Floating Home Button (center)
          Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  index = 2; // HOME index = 2
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: index == 2 ? 65 : 55,
                width: index == 2 ? 65 : 55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0057B7), Color(0xFF003366)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: const Color(0xFFFFD700), width: 2),
                ),
                child: Icon(
                  FontAwesomeIcons.home,
                  color: index == 2 ? const Color(0xFFFFD700) : Colors.white,
                  size: index == 2 ? 28 : 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
