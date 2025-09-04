import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart';

class Qiblacompass extends StatefulWidget {
  const Qiblacompass({super.key});

  @override
  State<Qiblacompass> createState() => _QiblacompassState();
}

class _QiblacompassState extends State<Qiblacompass> {
  bool isLoading = true;
  String message = '';
  bool permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    final permission = await Permission.location.request();

    if (!permission.isGranted) {
      setState(() {
        message = "Location permission denied. Please enable it in settings.";
        permissionDenied = true;
        isLoading = false;
      });
      return;
    }

    final location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        setState(() {
          message = "Please enable GPS location service.";
          isLoading = false;
        });
        return;
      }
    }

    await FlutterQiblah.requestPermissions();
    setState(() => isLoading = false);
  }

  Future<void> _openAppSettings() async {
    final opened = await openAppSettings();
    if (opened) {
      await Future.delayed(const Duration(milliseconds: 200));
      _checkLocationPermission(); // Re-check permission
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Qibla Compass",
          style: TextStyle(
            fontSize: 25,
            fontFamily: "Pacifico",
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF006A4E),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : permissionDenied
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _openAppSettings,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text("Open Settings"),
            ),
          ],
        ),
      )
          : StreamBuilder<QiblahDirection>(
        stream: FlutterQiblah.qiblahStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text("Unable to determine Qibla direction"),
            );
          }

          final direction = snapshot.data!.qiblah;
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/images/compass_bg.png",
                  width: 250,
                  height: 250,
                ),
                Transform.rotate(
                  angle: direction * (3.141592653589793 / 180),
                  child: Image.asset(
                    "assets/images/compass_needle.png",
                    width: 150,
                    height: 150,
                  ),
                ),
                const Positioned(
                  bottom: 20,
                  child: Text(
                    "Align arrow to face Qibla",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
