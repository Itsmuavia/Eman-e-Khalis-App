import 'package:emane_khalis_app/Screens/Bottomnavbar.dart';
import 'package:emane_khalis_app/Screens/Loginpage.dart';
import 'package:emane_khalis_app/Screens/Splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterQiblah.requestPermissions();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Emane-Khalis ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Bottomnavbar(),
    );
  }
}
