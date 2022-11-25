import 'package:equib/equib_data/equip_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../equip_input/daily_equib_input.dart';


class EquibHomePage extends StatefulWidget {
  const EquibHomePage({Key? key}) : super(key: key);

  @override
  State<EquibHomePage> createState() => _EquibHomePageState();
}

class _EquibHomePageState extends State<EquibHomePage> {


  @override
  Widget build(BuildContext context) {
    final getDataSource =  Provider.of<EquibData>(context).meetings;
    print('answer $getDataSource ');
    String? subjectText = '',
        startTimeText = '',
        endTimeText = '',
        dateText = '',
        timeDetails = '';

    return Scaffold(
      appBar: AppBar(),
      body: SfCalendar(
        showWeekNumber: true,
        cellEndPadding: 5,
        onTap: (details){
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
            endTimeText =
                DateFormat('hh:mm a').format(appointmentDetails.endTime).toString();
            timeDetails = '$startTimeText - $endTimeText';

            Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>DailyEquibInput(selectedDate:details.date!),),);
          } else if (details.targetElement == CalendarElement.calendarCell) {
            subjectText = "You have tapped cell";
            dateText = DateFormat('MMMM dd, yyyy').format(details.date!).toString();
            timeDetails = '';
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>DailyEquibInput(selectedDate:details.date!),),);
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
    );
  }
}

