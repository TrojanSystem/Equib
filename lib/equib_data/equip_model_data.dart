import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MembersModel {
  String name;
  String phoneNumber;
  String equibQuantity;
  String price;
  String memberID;

  MembersModel({
    required this.name,
    required this.price,
    required this.phoneNumber,
    required this.equibQuantity,
    required this.memberID,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'memberID': memberID,
      'price': price,
      'phoneNumber': phoneNumber,
      'equibQuantity': equibQuantity,
    };
  }

  static MembersModel fromMap(Map<String, dynamic> map) {
    return MembersModel(
      name: map['name'],
      memberID: map['memberID'],
      price: map['price'],
      phoneNumber: map['phoneNumber'],
      equibQuantity: map['equibQuantity'],

      // checked: map['checked'],
    );
  }
}

class TakerModel {
  String member;
  String takersID;
  bool isWin;
  String amount;
  String round;
  String day;

  TakerModel({
    required this.takersID,
    required this.day,
    required this.member,
    required this.amount,
    this.isWin = false,
    required this.round,
  });

  Map<String, dynamic> toMap() {
    return {
      'member': member,
      'takersID': takersID,
      'isWin': isWin == true ? 1 : 0,
      'amount': amount,
      'day': day,
      'round': round
    };
  }

  static TakerModel fromMap(Map<String, dynamic> map) {
    return TakerModel(
      member: map['member'],
      takersID: map['takersID'],
      isWin: map['isWin'] == 1 ? true : false,
      amount: map['amount'],
      day: map['day'],
      round: map['round'],

      // checked: map['checked'],
    );
  }
}

class EquipStarterModel {
  String equipId;
  String member;
  String grandPrize;
  String amount;
  String length;
  String recurrence;
  String day;

  EquipStarterModel({
    required this.day,
    required this.member,
    required this.amount,
    required this.recurrence,
    required this.length,
    required this.equipId,
    required this.grandPrize,
  });

  Map<String, dynamic> toMap() {
    return {
      'grandPrize': grandPrize,
      'equipId': equipId,
      'length': length,
      'member': member,
      'amount': amount,
      'day': day,
      'recurrence': recurrence
    };
  }

  static EquipStarterModel fromMap(Map<String, dynamic> map) {
    return EquipStarterModel(
        member: map['member'],
        grandPrize: map['grandPrize'],
        amount: map['amount'],
        day: map['day'],
        equipId: map['equipId'],
        length: map['length'],
        recurrence: map['recurrence']

        // checked: map['checked'],
        );
  }
}

class Meeting {
  /// Creates a meeting class with required details.
  Meeting({
    required this.event,
    required this.fromDay,
    required this.toDay,
    required this.totalPayed,
  required this.meetingID,
  });

  Map<String, dynamic> toMap() {
    return {
      'event': event,
      'meetingID': meetingID,
      'fromDay': fromDay,
      'toDay': toDay,
      'totalPayed': totalPayed
    };
  }

  static Meeting fromMap(Map<String, dynamic> map) {
    return Meeting(
      event: map['event'],
      fromDay: map['fromDay'],
      meetingID: map['meetingID'],
      toDay: map['toDay'],
      totalPayed: map['totalPayed'],

      // checked: map['checked'],
    );
  }
String meetingID;
  String totalPayed;

  /// Event name which is equivalent to subject property of [Appointment].
  String event;

  /// From which is equivalent to start time property of [Appointment].
  String fromDay;

  /// To which is equivalent to end time property of [Appointment].
  String toDay;

  /// Background which is equivalent to color property of [Appointment].
// Color background;
//
// /// IsAllDay which is equivalent to isAllDay property of [Appointment].
// bool isAllDay;
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
