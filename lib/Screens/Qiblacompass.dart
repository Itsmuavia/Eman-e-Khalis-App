import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import 'dart:html' as html;

class QiblaCompass extends StatefulWidget {
  const QiblaCompass({super.key});

  @override
  State<QiblaCompass> createState() => _QiblaCompassState();
}

class _QiblaCompassState extends State<QiblaCompass> {
  bool isLoading = true;
  String message = '';
  bool permissionDenied = false;
  bool isWebFallback = false;
  PrayerTimes? prayerTimes;
  Coordinates? coordinates;

  @override
  void initState() {
    super.initState();
    _checkDeviceSupport();
  }

  Future<void> _checkDeviceSupport() async {
    if (kIsWeb) {
      setState(() {
        isWebFallback = true;
        isLoading = false;
      });
      return;
    }

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

    final locData = await location.getLocation();
    coordinates = Coordinates(locData.latitude!, locData.longitude!);
    _calculatePrayerTimes();

    final hasSensor = await FlutterQiblah.androidDeviceSensorSupport() ?? false;
    if (!hasSensor) {
      setState(() {
        message = "Your device does not have a compass sensor.";
        isLoading = false;
      });
      return;
    }

    await FlutterQiblah.requestPermissions();
    setState(() => isLoading = false);
  }

  void _calculatePrayerTimes() {
    if (coordinates == null) return;

    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;

    prayerTimes = PrayerTimes.today(coordinates!, params);
  }

  String _formatTime(DateTime time) => DateFormat('hh:mm a').format(time);

  Future<void> _openAppSettings() async {
    final opened = await openAppSettings();
    if (opened) {
      await Future.delayed(const Duration(milliseconds: 300));
      _checkDeviceSupport();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.blueGrey),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Qibla Compass",
              style: const TextStyle(
                fontSize: 32,
                fontFamily: "Pacifico",
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : isWebFallback
                ? _buildWebFallback()
                : permissionDenied
                ? _buildPermissionDenied()
                : _buildMobileCompass(),
          ),
          if (prayerTimes != null) _buildPrayerTimesCard(),
        ],
      ),
    );
  }

  Widget _buildWebFallback() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Compass is not supported on Web.\nUse Google Qibla Finder instead.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () {
              const url = "https://www.quranbookk.com/qibla-finder";
              html.window.open(url, "_blank");
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text(
                "Open Online Qibla Compass",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionDenied() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.red),
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
    );
  }

  Widget _buildMobileCompass() {
    return StreamBuilder<QiblahDirection>(
      stream: FlutterQiblah.qiblahStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text(
              "Unable to determine Qibla direction.\nMove your phone in a figure-8 motion to calibrate.",
              textAlign: TextAlign.center,
            ),
          );
        }

        final direction = snapshot.data!.qiblah;
        final angle = direction.toStringAsFixed(2);
        final radians = (direction * 3.141592653589793 / 180).toStringAsFixed(
          4,
        );

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/images/compass_bg.png",
                  width: 250,
                  height: 250,
                ),
                Transform.rotate(
                  angle: double.parse(radians),
                  child: Image.asset(
                    "assets/images/compass_needle.png",
                    width: 150,
                    height: 150,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "Qibla Angle: $angle°",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "Radians: $radians",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPrayerTimesCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Prayer Times",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _prayerRow("Fajr", prayerTimes!.fajr),
          _prayerRow("Dhuhr", prayerTimes!.dhuhr),
          _prayerRow("Asr", prayerTimes!.asr),
          _prayerRow("Maghrib", prayerTimes!.maghrib),
          _prayerRow("Isha", prayerTimes!.isha),
        ],
      ),
    );
  }

  Widget _prayerRow(String name, DateTime time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            _formatTime(time),
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
