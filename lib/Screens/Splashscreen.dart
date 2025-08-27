import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:emane_khalis_app/Screens/Loginpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 6),
      () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Opacity(
                      opacity: 0.06,
                      child: Image(
                        image: AssetImage("assets/images/mosque-black.png"),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        child: Center(
                          child: Image(
                            fit: BoxFit.cover,
                            width: 550,
                            image: AssetImage("assets/images/applogo.png"),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 300,
                        child: DefaultTextStyle(
                          style: GoogleFonts.cairoPlay(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                'Welcome To EMANE KHALIS ',
                                speed: Duration(milliseconds: 150),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
