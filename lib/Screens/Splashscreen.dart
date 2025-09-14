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
    super.initState();
    Timer(
      const Duration(seconds: 6),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Stylish gradient background
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Quran image (enhanced style)
          Align(
            alignment: Alignment.center,
            child: Opacity(
              opacity: 0.07,
              child: Image.asset(
                "assets/images/quran.png",
                width: 350,
                height: 450,
                fit: BoxFit.fitHeight,
                color: Colors.white.withOpacity(0.8), // glowing effect
                colorBlendMode: BlendMode.modulate,
              ),
            ),
          ),

          // Foreground content (same as before)
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 40,
                  child: Center(
                    child: Image.asset(
                      "assets/images/applogo.png",
                      width: 500,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 320,
                  child: DefaultTextStyle(
                    style: GoogleFonts.cairoPlay(
                      fontSize: 23,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontStyle: FontStyle.normal
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Welcome To EMAN-E-KHALIS',
                          speed: const Duration(milliseconds: 150),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
