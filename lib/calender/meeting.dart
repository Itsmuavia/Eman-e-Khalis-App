import 'package:flutter/material.dart';

class Meeting {
  Meeting(this.location,this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  String location;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}