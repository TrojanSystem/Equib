import 'dart:ui';

import 'package:syncfusion_flutter_calendar/calendar.dart';

class MembersModel {
  String name;
  String phoneNumber;
  int equibQuantity;
  int price;

  MembersModel({
    required this.name,
    required this.price,
    required this.phoneNumber,
    required this.equibQuantity,
  });
}
class Meeting {

  /// Creates a meeting class with required details.
  Meeting({
    required this.eventName,
    required this.from,
    required this.to,
    required this.background,
    required this.isAllDay,
  });

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
class EquibModel {
  String collectorName;
  String phoneNumber;
  DateTime startDate;
  DateTime endDate;
  String every;

  EquibModel({
    required this.phoneNumber,
    required this.collectorName,
    required this.endDate,
    required this.every,
    required this.startDate,
  });
}


