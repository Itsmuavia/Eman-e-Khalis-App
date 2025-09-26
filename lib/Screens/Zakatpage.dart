import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Zakatpage extends StatefulWidget {
  const Zakatpage({super.key});

  @override
  State<Zakatpage> createState() => _ZakatpageState();
}

class _ZakatpageState extends State<Zakatpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Zakat Page",
          style: TextStyle(
            fontFamily: "Pacifico",
            fontSize: 45,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
      ),
    );
  }
}
