import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'equip_daily_collected_database.dart';
import 'equip_model_data.dart';
import 'equip_database.dart';

class EquibData extends ChangeNotifier {
  DatabaseExpense db = DatabaseExpense();

  bool isIncome = false;

  bool _isLoading = true;

  bool get isLoading => _isLoading;
  List<MembersModel> _newMemberList = [];

  List<MembersModel> get newMemberList => _newMemberList;

  void updaterChanger(bool state) {
    isIncome = state;
    //  notifyListeners();
  }

  Future loadNewMemberList() async {
    _isLoading = true;
    notifyListeners();
    _newMemberList = await db.getTasks();
    _isLoading = false;
    notifyListeners();
  }

  Future addNewMemberList(MembersModel task) async {
    await db.insertTask(task);
    await loadNewMemberList();
    notifyListeners();
  }

  Future updateNewMemberList(MembersModel task) async {
    await db.updateTaskList(task);
    await loadNewMemberList();
    notifyListeners();
  }

  Future deleteNewMemberList(int task) async {
    await db.deleteTask(task);
    await loadNewMemberList();
    notifyListeners();
  }

  final List<Meeting> meetings = [];

  assigner(Meeting meet) {
    meetings.add(meet);
    notifyListeners();
  }

  final List<MembersModel> newMember = [];

  addMember(MembersModel member) {
    newMember.add(member);
    notifyListeners();
  }

  List daysOfMonth = [
    {
      'mon': 'Day 1',
      'day': 1,
    },
    {
      'mon': 'Day 2',
      'day': 2,
    },
    {
      'mon': 'Day 3',
      'day': 3,
    },
    {
      'mon': 'Day 4',
      'day': 4,
    },
    {
      'mon': 'Day 5',
      'day': 5,
    },
    {
      'mon': 'Day 6',
      'day': 6,
    },
    {
      'mon': 'Day 7',
      'day': 7,
    },
    {
      'mon': 'Day 8',
      'day': 8,
    },
    {
      'mon': 'Day 9',
      'day': 9,
    },
    {
      'mon': 'Day 10',
      'day': 10,
    },
    {
      'mon': 'Day 11',
      'day': 11,
    },
    {
      'mon': 'Day 12',
      'day': 12,
    },
    {
      'mon': 'Day 13',
      'day': 13,
    },
    {
      'mon': 'Day 14',
      'day': 14,
    },
    {
      'mon': 'Day 15',
      'day': 15,
    },
    {
      'mon': 'Day 16',
      'day': 16,
    },
    {
      'mon': 'Day 17',
      'day': 17,
    },
    {
      'mon': 'Day 18',
      'day': 18,
    },
    {
      'mon': 'Day 19',
      'day': 19,
    },
    {
      'mon': 'Day 20',
      'day': 20,
    },
    {
      'mon': 'Day 21',
      'day': 21,
    },
    {
      'mon': 'Day 22',
      'day': 22,
    },
    {
      'mon': 'Day 23',
      'day': 23,
    },
    {
      'mon': 'Day 24',
      'day': 24,
    },
    {
      'mon': 'Day 25',
      'day': 25,
    },
    {
      'mon': 'Day 26',
      'day': 26,
    },
    {
      'mon': 'Day 27',
      'day': 27,
    },
    {
      'mon': 'Day 28',
      'day': 28,
    },
    {
      'mon': 'Day 29',
      'day': 29,
    },
    {
      'mon': 'Day 30',
      'day': 30,
    },
    {
      'mon': 'Day 31',
      'day': 31,
    },
  ];
  List monthOfAYear = [
    {
      'month': 'Jan',
      'days': 1,
    },
    {
      'month': 'Feb',
      'days': 2,
    },
    {
      'month': 'Mar',
      'days': 3,
    },
    {
      'month': 'Apr',
      'days': 4,
    },
    {
      'month': 'May',
      'days': 5,
    },
    {
      'month': 'Jun',
      'days': 6,
    },
    {
      'month': 'Jul',
      'days': 7,
    },
    {
      'month': 'Aug',
      'days': 8,
    },
    {
      'month': 'Sept',
      'days': 9,
    },
    {
      'month': 'Oct',
      'days': 10,
    },
    {
      'month': 'Nov',
      'days': 11,
    },
    {
      'month': 'Dec',
      'days': 12,
    },
  ];
}

class EquipDailyCollected extends ChangeNotifier {
  DailyEquipCollectedDatabase dailyCollectedDb = DailyEquipCollectedDatabase();
  bool _isLoading = true;
  List<Meeting> _dailyCollected = [];

  List<Meeting> get dailyCollectedList => _dailyCollected;

  bool get isLoading => _isLoading;

  Future loadDailyCollectedList() async {
    _isLoading = true;
    notifyListeners();
    _dailyCollected = await dailyCollectedDb.getTasks();
    _isLoading = false;
    notifyListeners();
  }

  Future addDailyCollectedList(Meeting task) async {
    await dailyCollectedDb.insertTask(task);
    await loadDailyCollectedList();
    notifyListeners();
  }

  Future updateDailyCollectedList(Meeting task) async {
    await dailyCollectedDb.updateTaskList(task);
    await loadDailyCollectedList();
    notifyListeners();
  }

  Future deleteDailyCollectedList(int task) async {
    await dailyCollectedDb.deleteTask(task);
    await loadDailyCollectedList();
    notifyListeners();
  }
}

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return DateTime.parse(_getMeetingData(index).fromDay);
  }

  @override
  DateTime getEndTime(int index) {
    return DateTime.parse(_getMeetingData(index).toDay);
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).event;
  }

  @override
  Color getColor(int index) {
    return Colors.blue;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}
