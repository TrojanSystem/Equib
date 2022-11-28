import 'package:equib/equib_data/equip_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../equib_data/equip_model_data.dart';

class DailyEquibInput extends StatefulWidget {
  DailyEquibInput({super.key, required this.selectedDate});

  DateTime selectedDate;

  @override
  State<DailyEquibInput> createState() => _DailyEquibInputState();
}

class _DailyEquibInputState extends State<DailyEquibInput> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  String name = '';
  late String startTime;

  String dateTime = DateTime.now().toString();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime = widget.selectedDate.toString();
  }

  void datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      firstDate: DateTime(DateTime.now().month + 1),
    ).then((value) => setState(() {
          if (value != null) {
            startTime = value.toString();
          } else {
            startTime = DateTime.now().toString();
          }
        }));
  }

  void datePickerForEnd() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      firstDate: DateTime(DateTime.now().month + 1),
    ).then((value) => setState(() {
          if (value != null) {
            dateTime = value.toString();
          } else {
            dateTime = DateTime.now().toString();
          }
        }));
  }

  @override
  void dispose() {
    _name.dispose();
    _nameFocus.dispose();
    super.dispose();
  }

  String dropdownvalue = 'Suke';
double penalityBirr = 50.0;
// List of items in our dropdown menu

  @override
  Widget build(BuildContext context) {
    final newMember = Provider.of<EquibData>(context).newMemberList;
    final dailyCollected =
        Provider.of<EquipDailyCollected>(context).dailyCollectedList;
    List<String> listMember = newMember.map((e) => e.name).toList();
    final equipPrice =
        newMember.where((element) => element.name == dropdownvalue).toList();
    final priceAmount = equipPrice.first.price;
    final equipQuantity = equipPrice.first.equibQuantity;
    final dailyPayedMember = dailyCollected
        .where((element) => element.event == dropdownvalue)
        .toList();

        dailyPayedMember.sort((a, b) => a.toDay.compareTo(b.toDay));
//penality Calculation
  //final penalityInDays = DateTime.parse(dailyPayedMember.last.toDay).difference(widget.selectedDate).inDays;

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            margin: const EdgeInsets.only(top: 25),
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(35, 8, 35, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Member Name',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey[200],
                              ),
                              width: 200,
                              height: 60,
                              child: Text(
                                dropdownvalue,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          // Initial Value
                          value: dropdownvalue,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                          // Down Arrow Icon
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                          ),

                          // Array list of items
                          items: listMember.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: const TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              dropdownvalue = value!;
                            });
                          },
                          // After selecting the desired option,it will
                          // change button value to selected value
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(35, 8, 0, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Start Date',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[200],
                                  ),
                                  height: 60,
                                  child: Text(
                                    ' ${DateFormat.yMEd().format(DateTime.parse(startTime))}',
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      datePicker();
                                    });
                                  },
                                  icon: const Icon(Icons.calendar_today),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 35, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'End Date',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[200],
                                  ),
                                  height: 60,
                                  child: Text(
                                    ' ${DateFormat.yMEd().format(DateTime.parse(dateTime))}',
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      datePickerForEnd();
                                    });
                                  },
                                  icon: const Icon(Icons.calendar_today),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      final dayDiffrence = DateTime.parse(dateTime)
                          .difference(DateTime.parse(startTime))
                          .inDays;
                      final day = (dayDiffrence + 1).toString();
                      double dailyPayedAmount = double.parse(day) *
                          double.parse(priceAmount) *
                          double.parse(equipQuantity);

                      var meets = Meeting(
                        event: dropdownvalue,
                        fromDay: startTime,
                        toDay: dateTime,
                        totalPayed: dailyPayedAmount.toStringAsFixed(2),
                      );


                      Provider.of<EquipDailyCollected>(context, listen: false)
                          .addDailyCollectedList(meets);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(130, 10, 130, 0),
                    width: double.infinity,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.green[500],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Add',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// class ListOfEvent extends ChangeNotifier{
//   final List<Meeting> meetings = [];
//   assigner(Meeting meet){
//     meetings.add(meet);
//     notifyListeners();
//   }
// }
// class Meeting {
//   /// Creates a meeting class with required details.
//   Meeting({required this.eventName,required this.from,required this.to,required this.background,required this.isAllDay});
//
//   /// Event name which is equivalent to subject property of [Appointment].
//   String eventName;
//
//   /// From which is equivalent to start time property of [Appointment].
//   DateTime from;
//
//   /// To which is equivalent to end time property of [Appointment].
//   DateTime to;
//
//   /// Background which is equivalent to color property of [Appointment].
//   Color background;
//
//   /// IsAllDay which is equivalent to isAllDay property of [Appointment].
//   bool isAllDay;
// }
// class MeetingDataSource extends CalendarDataSource {
//   /// Creates a meeting data source, which used to set the appointment
//   /// collection to the calendar
//   MeetingDataSource(List<Meeting> source) {
//     appointments = source;
//   }
//
//   @override
//   DateTime getStartTime(int index) {
//     return _getMeetingData(index).from;
//   }
//
//   @override
//   DateTime getEndTime(int index) {
//     return _getMeetingData(index).to;
//   }
//
//   @override
//   String getSubject(int index) {
//     return _getMeetingData(index).eventName;
//   }
//
//   @override
//   Color getColor(int index) {
//     return _getMeetingData(index).background;
//   }
//
//   @override
//   bool isAllDay(int index) {
//     return _getMeetingData(index).isAllDay;
//   }
//
//   Meeting _getMeetingData(int index) {
//     final dynamic meeting = appointments![index];
//     late final Meeting meetingData;
//     if (meeting is Meeting) {
//       meetingData = meeting;
//     }
//
//     return meetingData;
//   }}
