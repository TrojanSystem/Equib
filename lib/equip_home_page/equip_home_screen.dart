import 'dart:math';

import 'package:equib/equib_data/equip_data.dart';
import 'package:equib/equip_input/member_registration.dart';
import 'package:equib/taker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../equip_input/daily_equib_input.dart';
import 'equib_members.dart';
import 'list_of_daily_collected.dart';

class EquibHomePage extends StatefulWidget {
  const EquibHomePage({Key? key}) : super(key: key);

  @override
  State<EquibHomePage> createState() => _EquibHomePageState();
}

class _EquibHomePageState extends State<EquibHomePage> {
  DateTime tappedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final newMember = Provider.of<EquibData>(context).newMemberList;
    final getDataSource =
        Provider.of<EquipDailyCollected>(context).dailyCollectedList;

    final sumDailyCashCollected =
        getDataSource.map((e) => e.totalPayed).toList();
    double cashCollected = 0.0;
    for (int cash = 0; cash < sumDailyCashCollected.length; cash++) {
      cashCollected += double.parse(sumDailyCashCollected[cash]);
    }

    String? subjectText = '',
        startTimeText = '',
        endTimeText = '',
        dateText = '',
        timeDetails = '';

    return Scaffold(
      appBar: AppBar(
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Total Members: ${newMember.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                child: Text(
                  'Cash Collected: $cashCollected',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
        toolbarHeight: 90,
        elevation: 0,
      ),
      body: SfCalendar(
        showWeekNumber: true,
        cellEndPadding: 5,
        firstDayOfWeek: 1,
        onLongPress: (val) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ListOfDailyPayedMembers(
                  collected: getDataSource, tappedDate: val.date),
            ),
          );
        },
        onTap: (details) {
          if (newMember.isNotEmpty) {
            if (details.targetElement == CalendarElement.appointment ||
                details.targetElement == CalendarElement.agenda) {
              final Appointment appointmentDetails = details.appointments![0];
              subjectText = appointmentDetails.subject;
              dateText = DateFormat('MMMM dd, yyyy')
                  .format(appointmentDetails.startTime)
                  .toString();
              startTimeText = DateFormat('hh:mm a')
                  .format(appointmentDetails.startTime)
                  .toString();
              endTimeText = DateFormat('hh:mm a')
                  .format(appointmentDetails.endTime)
                  .toString();
              timeDetails = '$startTimeText - $endTimeText';
              tappedDate = details.date!;
              showModalBottomSheet(
                  context: context,
                  builder: (context) =>
                      DailyEquibInput(selectedDate: details.date!));
            } else if (details.targetElement == CalendarElement.calendarCell) {
              tappedDate = details.date!;
              subjectText = "You have tapped cell";
              dateText =
                  DateFormat('MMMM dd, yyyy').format(details.date!).toString();
              timeDetails = '';

              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (ctx) => DailyEquibInput(selectedDate: details.date!),
              //   ),
              // );
              showModalBottomSheet(
                  context: context,
                  builder: (context) =>
                      DailyEquibInput(selectedDate: details.date!));
            }
            // showDialog(
            //     context: context,
            //     builder: (BuildContext context) {
            //       return AlertDialog(
            //         title: Text('$subjectText'),
            //         content: SizedBox(
            //           height: 80,
            //           child: Column(
            //             children: <Widget>[
            //               Row(
            //                 children: <Widget>[
            //                   Text(
            //                     '$dateText',
            //                     style: const TextStyle(
            //                       fontWeight: FontWeight.w400,
            //                       fontSize: 20,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               SizedBox(
            //                 height: 40,
            //                 child: Row(
            //                   children: <Widget>[
            //                     Text(timeDetails!,
            //                         style: const TextStyle(
            //                             fontWeight: FontWeight.w400, fontSize: 15)),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //         actions: <Widget>[
            //           ElevatedButton(
            //               onPressed: () {
            //                 Navigator.of(context).pop();
            //               },
            //               child: const Text('Close'))
            //         ],
            //       );
            //     });
          } else {
            return;
          }
        },
        showNavigationArrow: true,
        cellBorderColor: Colors.white,
        todayHighlightColor: Colors.red,
        view: CalendarView.month,
        dataSource: MeetingDataSource(getDataSource),
        // by default the month appointment display mode set as Indicator, we can
        // change the display mode as appointment using the appointment display
        // mode property
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromRGBO(40, 53, 147, 1),
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              bottomBarButtons(
                  title: 'Members',
                  bottomBarFunction: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => EquibMembers(),
                      ),
                    );
                  }),
              bottomBarButtons(
                  title: 'Takers',
                  bottomBarFunction: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => Taker(),
                      ),
                    );
                  }),
              const SizedBox(
                width: 95,
              ),
              bottomBarButtons(title: 'Next', bottomBarFunction: () {}),
              bottomBarButtons(title: 'Analysis', bottomBarFunction: () {}),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (context) => MemberRegistration());
          // setState(() {
          //   Random random = Random();
          //   // tossed = listName[random.nextInt(listName.length)];
          //   // taker.add(tossed);
          //   // listName.remove(tossed);
          // });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

TextButton bottomBarButtons({required bottomBarFunction, required title}) {
  return TextButton(
    onPressed: bottomBarFunction,
    child: Text(
      title,
      style: const TextStyle(color: Colors.white, fontSize: 15),
    ),
  );
}
