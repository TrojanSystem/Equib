//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';
//
// import 'daily_equib_input.dart';
// import 'member_model.dart';
//
// class Calender extends StatelessWidget {
//   const Calender({Key? key}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     final getDataSource =  Provider.of<ListOfEvent>(context).meetings;
//     String? subjectText = '',
//         startTimeText = '',
//         endTimeText = '',
//         dateText = '',
//         timeDetails = '';
//     void calendarTapped(CalendarTapDetails details) {
//       if (details.targetElement == CalendarElement.appointment ||
//           details.targetElement == CalendarElement.agenda) {
//         final Appointment appointmentDetails = details.appointments![0];
//         subjectText = appointmentDetails.subject;
//         dateText = DateFormat('MMMM dd, yyyy')
//             .format(appointmentDetails.startTime)
//             .toString();
//         startTimeText = DateFormat('hh:mm a')
//             .format(appointmentDetails.startTime)
//             .toString();
//         endTimeText =
//             DateFormat('hh:mm a').format(appointmentDetails.endTime).toString();
//         timeDetails = '$startTimeText - $endTimeText';
//         showModalBottomSheet(
//             context: context,
//             builder: (context) {
//               return DailyEquibInput();
//             });
//       } else if (details.targetElement == CalendarElement.calendarCell) {
//         subjectText = "You have tapped cell";
//         dateText = DateFormat('MMMM dd, yyyy').format(details.date!).toString();
//         timeDetails = '';
//         showModalBottomSheet(
//             context: context,
//             builder: (context) {
//               return DailyEquibInput();
//             });
//       }
//       // showDialog(
//       //     context: context,
//       //     builder: (BuildContext context) {
//       //       return AlertDialog(
//       //         title: Text('$subjectText'),
//       //         content: SizedBox(
//       //           height: 80,
//       //           child: Column(
//       //             children: <Widget>[
//       //               Row(
//       //                 children: <Widget>[
//       //                   Text(
//       //                     '$dateText',
//       //                     style: const TextStyle(
//       //                       fontWeight: FontWeight.w400,
//       //                       fontSize: 20,
//       //                     ),
//       //                   ),
//       //                 ],
//       //               ),
//       //               SizedBox(
//       //                 height: 40,
//       //                 child: Row(
//       //                   children: <Widget>[
//       //                     Text(timeDetails!,
//       //                         style: const TextStyle(
//       //                             fontWeight: FontWeight.w400, fontSize: 15)),
//       //                   ],
//       //                 ),
//       //               ),
//       //             ],
//       //           ),
//       //         ),
//       //         actions: <Widget>[
//       //           ElevatedButton(
//       //               onPressed: () {
//       //                 Navigator.of(context).pop();
//       //               },
//       //               child: const Text('Close'))
//       //         ],
//       //       );
//       //     });
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//       ),
//       body: Center(
//         child: Container(
//           width: 300,
//           height: 450,
//           color: Colors.blue,
//           child: SfCalendar(
//             showWeekNumber: true,
//             cellEndPadding: 5,
//             onTap: calendarTapped,
//             showNavigationArrow: true,
//             cellBorderColor: Colors.white,
//             todayHighlightColor: Colors.red,
//             view: CalendarView.month,
//             dataSource: MeetingDataSource(getDataSource),
//             // by default the month appointment display mode set as Indicator, we can
//             // change the display mode as appointment using the appointment display
//             // mode property
//             monthViewSettings: const MonthViewSettings(
//                 appointmentDisplayMode:
//                     MonthAppointmentDisplayMode.appointment),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // List<Meeting> _getDataSource() {
//   //
//   //   final DateTime today = DateTime(2022, 11, 20, 7, 30);
//   //   final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
//   //   final DateTime endTime = startTime.add(const Duration(hours: 2));
//   //   meetings.add(Meeting(
//   //       'Conference', startTime, endTime, const Color(0xFF0F8644), false));
//   //   return meetings;
//   // }
// }
//
//
