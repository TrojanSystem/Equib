import 'package:equib/constants.dart';
import 'package:equib/equib_data/equip_data.dart';
import 'package:equib/equip_input/member_registration.dart';
import 'package:equib/equip_home_page/taker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../calendar.dart';
import '../daily_collected_heat_map.dart';
import '../equib_data/equip_model_data.dart';
import '../equip_input/daily_equib_input.dart';
import 'equib_members.dart';
import 'list_of_daily_collected.dart';

class EquibHomePage extends StatefulWidget {
  const EquibHomePage({
    super.key,
    required this.equipID,
    required this.equipStartDate,
    required this.equipEndDate,
    required this.equipRecurrence,
  });

  final String equipID;
  final String equipStartDate;
  final String equipRecurrence;
  final String equipEndDate;

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
    int sumOfTotEquip = 0;
    List<String> totEquip = newMember.map((e) => e.equibQuantity).toList();
    for (int equip = 0; equip < totEquip.length; equip++) {
      sumOfTotEquip += int.parse(totEquip[equip]);
    }

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
    final data = Provider.of<EquibData>(context).dataSource;
    final equip = getDataSource
        .map(
          (e) => Appointment(
            id: e.meetingID,
            startTime: DateTime.parse(e.fromDay),
            endTime: DateTime.parse(e.toDay),
            subject: e.event,
            color: Colors.grey,
          ),
        )
        .toList();
    final List<Appointment> appoint = <Appointment>[];
    final equipDebter = Appointment(
      id: widget.equipID,
      startTime: DateTime.parse(widget.equipStartDate),
      endTime: DateTime.parse(widget.equipStartDate),
      subject: 'እጣ',
      recurrenceRule:
          'FREQ=DAILY;INTERVAL=${widget.equipRecurrence};UNTIL=${widget.equipEndDate}',
      color: Colors.green,
    );

    appoint.add(equipDebter);
    data.appointments!.addAll(appoint);
    data.appointments!.addAll(equip);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            color: Colors.black, // <-- SEE HERE

            onPressed: () {
              Navigator.of(context).pop();
              data.appointments!.clear();
            }),
        backgroundColor: const Color.fromRGBO(26, 35, 126, 1),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'አጠቃላይ እጣ: $sumOfTotEquip',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                child: Text(
                  'የተሰበሰበ ብር: ${_number.format(cashCollected)}',
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
      body: RefreshIndicator(
        color: Colors.blue,
        onRefresh: () {
          return Future.delayed(
            const Duration(microseconds: 500),
            () {
              /// adding elements in list after [1 seconds] delay
              /// to mimic network call
              ///
              /// Remember: setState is necessary so that
              /// build method will run again otherwise
              /// list will not show all elements
              setState(() {
                getDataSource.length;
              });

              const snack = SnackBar(
                content: Text('Page Refreshed'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snack);
            },
          );
        },
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(8),
                            height: 550,
              child: SfCalendar(
                showWeekNumber: true,
                cellEndPadding: 5,
                firstDayOfWeek: 1,
                onLongPress: (val) {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (ctx) => ListOfDailyPayedMembers(
                  //         collected: getDataSource, tappedDate: val.date),
                  //   ),
                  // );
                  showHeatMap(context);
                },
                onTap: (details) {
                  if (newMember.isNotEmpty) {
                    if ((details.date)!
                            .isAfter(DateTime.parse(widget.equipStartDate)) ||
                        (details.date)!
                                .difference(
                                    DateTime.parse(widget.equipStartDate))
                                .inDays ==
                            0) {
                      if (details.targetElement ==
                              CalendarElement.appointment ||
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
                          getDataSource.isEmpty
                              ? 'እቁቡ ሚጀምረው በ ${DateTime.parse(widget.equipStartDate).day}/${DateTime.parse(widget.equipStartDate).month} /${DateTime.parse(widget.equipStartDate).year} ነው።'
                              : 'እቁቡ የጀመረው በ ${DateTime.parse(widget.equipStartDate).day}/${DateTime.parse(widget.equipStartDate).month} /${DateTime.parse(widget.equipStartDate).year} ነው።',
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
                showDatePickerButton: true,
                dataSource: data,
                monthViewSettings: const MonthViewSettings(
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.appointment),
              ),
            ),
          ],
        ),
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
