import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../calender/meeting.dart';
import '../calender/meeting_data_source.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  CalendarView calendarView = CalendarView.month;
  CalendarController calendarController = CalendarController();
  DateTime _selectedDate = DateTime.now();
  DateTime _currentMonth = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    1,
  );

  final Map<DateTime, List<Meeting>> _eventsMap = {};
  late DateTime _minDate;
  late DateTime _maxDate;

  @override
  void initState() {
    super.initState();
    _minDate = DateTime(_currentMonth.year, _currentMonth.month, 1);
    _maxDate = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    _addStaticEvents();
  }

  void _addStaticEvents() {
    _addEvent(DateTime(2025, 1, 5), "New Year Dua", "Masjid Tauheed Bhutta village", 12, 13);
    _addEvent(DateTime(2025, 2, 10), "Charity Drive", "Masjid Tauheed Bhutta village", 10, 12);
    _addEvent(DateTime(2025, 3, 15), "Youth Islamic Camp", "Masjid Tauheed Bhutta village", 16, 17);
    _addEvent(DateTime(2025, 4, 12), "Iftar Program", "Masjid Tauheed Bhutta village", 18, 19);
    _addEvent(DateTime(2025, 5, 2), "Eid Preparations", "Masjid Tauheed Bhutta village", 14, 15);
    _addEvent(DateTime(2025, 6, 18), "Hajj Seminar", "Masjid Tauheed Bhutta village", 11, 12);
    _addEvent(DateTime(2025, 7, 25), "Islamic Conference", "Masjid Tauheed Bhutta village", 13, 15);
    _addEvent(DateTime(2025, 8, 7), "Youth Gathering", "Masjid Tauheed Bhutta village", 17, 18);
    _addEvent(DateTime(2025, 9, 6), "Islamic Seminar", "Masjid Tauheed Bhutta village", 14, 15);
    _addEvent(DateTime(2025, 9, 7), "Dars-e-Quran", "Masjid Tauheed Bhutta village", 5, 7);
    _addEvent(DateTime(2025, 9, 8), "Ladies Tarbiyati Nashisht", "Masjid Tauheed Makraz Keamari", 5, 7);
    _addEvent(DateTime(2025, 10, 10), "Charity Distribution", "Masjid Tauheed Bhutta village", 10, 12);
    _addEvent(DateTime(2025, 11, 20), "Masjid Fundraiser", "Masjid Tauheed Bhutta village", 16, 17);
    _addEvent(DateTime(2025, 12, 25), "Year End Prayer", "Masjid Tauheed Bhutta village", 12, 13);
  }

  void _addEvent(DateTime date, String title, String location, int startHour, int endHour) {
    final DateTime startTime = DateTime(date.year, date.month, date.day, startHour);
    final DateTime endTime = DateTime(date.year, date.month, date.day, endHour);

    final meeting = Meeting(location, title, startTime, endTime, const Color(0xFF006400), false);

    _eventsMap.putIfAbsent(DateTime(date.year, date.month, date.day), () => []);
    _eventsMap[DateTime(date.year, date.month, date.day)]!.add(meeting);
  }

  List<Meeting> _getEventsForDate(DateTime date) {
    return _eventsMap[DateTime(date.year, date.month, date.day)] ?? [];
  }

  void _goToNextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
      _minDate = DateTime(_currentMonth.year, _currentMonth.month, 1);
      _maxDate = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
      _selectedDate = _minDate;
    });
  }

  void _goToPreviousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
      _minDate = DateTime(_currentMonth.year, _currentMonth.month, 1);
      _maxDate = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
      _selectedDate = _minDate;
    });
  }

  String _formatTime(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? "PM" : "AM";
    return "$hour:$minute $period";
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.green.shade50,

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: _goToPreviousMonth, icon: const Icon(Icons.arrow_back_ios, color: Colors.green)),
                  Text("${_currentMonth.month}-${_currentMonth.year}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                  IconButton(onPressed: _goToNextMonth, icon: const Icon(Icons.arrow_forward_ios, color: Colors.green)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildViewButton("Month", CalendarView.month),
                _buildViewButton("Week", CalendarView.week),
                _buildViewButton("Day", CalendarView.day),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: screenWidth * 0.95,
              height: 400,
              child: SfCalendar(
                view: calendarView,
                controller: calendarController,
                initialSelectedDate: _selectedDate,
                minDate: _minDate,
                maxDate: _maxDate,
                cellBorderColor: Colors.grey,
                onTap: (details) {
                  if (details.date != null) {
                    setState(() => _selectedDate = details.date!);
                  }
                },
                allowViewNavigation: false,
                monthViewSettings: const MonthViewSettings(
                  appointmentDisplayMode: MonthAppointmentDisplayMode.none,
                ),
                selectionDecoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.transparent,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Date: ${_selectedDate.day}-${_selectedDate.month}-${_selectedDate.year}",
                    style: const TextStyle(fontSize: 22, fontFamily: "Pacifico", color: Colors.green),
                  ),
                  const SizedBox(height: 8),
                  _buildEventList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewButton(String text, CalendarView view) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFF006400)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {
        setState(() {
          calendarView = view;
          calendarController.view = view;
        });
      },
      child: Text(text, style: const TextStyle(color: Color(0xFF006400), fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildEventList() {
    final events = _getEventsForDate(_selectedDate);

    if (events.isEmpty) {
      return const Center(
        child: Text(
          "No Events",
          style: TextStyle(color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Card(
          color: Colors.green.shade900,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text('${_selectedDate.day}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            ),
            title: Text(event.eventName, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            subtitle: Text(
              "Location: ${event.location}\nTime: ${_formatTime(event.from)} - ${_formatTime(event.to)}",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
