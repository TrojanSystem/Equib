import 'package:equib/constants.dart';
import 'package:equib/equib_data/equip_data.dart';
import 'package:equib/equip_input/member_registration.dart';
import 'package:equib/equip_home_page/taker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../equip_input/daily_equib_input.dart';
import 'equib_members.dart';
import 'list_of_daily_collected.dart';

class EquibHomePage extends StatefulWidget {
  const EquibHomePage(
      {super.key, required this.equipID, required this.equipStartDate});

  final String equipID;
  final String equipStartDate;

  @override
  State<EquibHomePage> createState() => _EquibHomePageState();
}

class _EquibHomePageState extends State<EquibHomePage> {
  DateTime tappedDate = DateTime.now();

  final NumberFormat _number = NumberFormat();

  @override
  Widget build(BuildContext context) {
    final newTakerChecker = Provider.of<Takers>(context).takerList;
    final newTaker = newTakerChecker
        .where((element) => element.takersID == widget.equipID)
        .toList();
    final newMemebrChecker = Provider.of<EquibData>(context).newMemberList;
    final newMember = newMemebrChecker
        .where((element) => element.memberID == widget.equipID)
        .toList();
    List<String> listMember = newMember.map((e) => e.name).toList();
    final newGetDataSource =
        Provider.of<EquipDailyCollected>(context).dailyCollectedList;
    final getDataSource = newGetDataSource
        .where((element) => element.meetingID == widget.equipID)
        .toList();

    final sumDailyCashCollected =
        getDataSource.map((e) => e.totalPayed).toList();
    double cashCollected = 0.0;
    for (int cash = 0; cash < sumDailyCashCollected.length; cash++) {
      cashCollected += double.parse(sumDailyCashCollected[cash]);
    }
    print('equip started at ${DateTime.parse(widget.equipStartDate)}');

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
                  'Cash Collected: ${_number.format(cashCollected)}',
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
            if ((details.date)!
                    .isAfter(DateTime.parse(widget.equipStartDate)) ||
                (details.date)!
                        .difference(DateTime.parse(widget.equipStartDate))
                        .inDays ==
                    0) {
              if (details.targetElement == CalendarElement.appointment ||
                  details.targetElement == CalendarElement.agenda) {
                tappedDate = details.date!;
                showModalBottomSheet(
                    context: context,
                    builder: (context) => DailyEquibInput(
                          selectedDate: details.date!,
                          dailyInputID: widget.equipID,
                          dropValue: listMember.first,
                        ));
              } else if (details.targetElement ==
                  CalendarElement.calendarCell) {
                tappedDate = details.date!;

                showModalBottomSheet(
                  context: context,
                  builder: (context) => DailyEquibInput(
                    selectedDate: details.date!,
                    dailyInputID: widget.equipID,
                    dropValue: listMember.first,
                  ),
                );
              } else {
                return;
              }
            } else {
              final snackBar = SnackBar(
                elevation: 10,
                content: Text(
                  'እቁቡ ሚጀምረው በ ${DateTime.parse(widget.equipStartDate).day}/${DateTime.parse(widget.equipStartDate).month} /${DateTime.parse(widget.equipStartDate).year} ነው።',
                  style: boldStyle,
                ),
                backgroundColor: (Colors.white),
                action: SnackBarAction(
                  label: 'dismiss',
                  onPressed: () {},
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }
        },
        showNavigationArrow: true,
        cellBorderColor: Colors.white,
        todayHighlightColor: Colors.red,
        view: CalendarView.month,
        dataSource: MeetingDataSource(getDataSource),
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
                        builder: (ctx) => EquibMembers(
                            membersID: widget.equipID, newMembers: newMember),
                      ),
                    );
                  }),
              bottomBarButtons(
                  title: 'Takers',
                  bottomBarFunction: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => Taker(
                            takerID: widget.equipID, newTakerss: newTaker),
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
            context: context,
            builder: (context) => MemberRegistration(
              memberRegisterID: widget.equipID,
            ),
          );
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
