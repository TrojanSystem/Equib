import 'package:equib/equib_data/equip_data.dart';
import 'package:equib/equip_home_page/equip_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../constants.dart';

class ListOfEquipDebter extends StatelessWidget {
  ListOfEquipDebter({Key? key}) : super(key: key);
  final NumberFormat _number = NumberFormat();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    final calenderData =
        Provider.of<EquibData>(context, listen: false)
            .dataSource;
    int columnCount = 3;
    final listOfEquipDebter =
        Provider.of<EquipStarterClass>(context).equipStarterList;
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.white,
        toolbarHeight: 90,
        elevation: 0,
        title: Text(
          'እቁብ ደብተር',
          style: TextStyle(
            color: Colors.blue[800],
            fontWeight: FontWeight.w900,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: listOfEquipDebter.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/no-money.png',
                    width: 200,
                  ),
                  const Text(
                    'የተጀመረ እቁብ የለም!',
                    style: emptyStyle,
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: listOfEquipDebter.length,
              itemBuilder: (context, index) {
                final equipStartedAt = listOfEquipDebter[index].day;

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => EquibHomePage(
                          equipID: listOfEquipDebter[index].equipId,
                          equipStartDate: listOfEquipDebter[index].day,
                          equipEndDate: (DateTime.parse(equipStartedAt).add(
                            Duration(
                              days: int.parse(listOfEquipDebter[index].length),
                            ),
                          )).toString(),
                          equipRecurrence: listOfEquipDebter[index].recurrence,
                        ),
                      ),
                    );
                  //   final equipDebter = Appointment(
                  //       id: listOfEquipDebter[index].equipId,
                  //       startTime: DateTime.parse(listOfEquipDebter[index].day),
                  //       endTime: DateTime.parse(listOfEquipDebter[index].day),
                  //       subject: listOfEquipDebter[index].member,
                  //       color: Colors.grey,
                  //       recurrenceRule:
                  //           'FREQ=DAILY;INTERVAL=${listOfEquipDebter[index].recurrence};UNTIL=${(DateTime.parse(listOfEquipDebter[index].day).add(
                  //         Duration(
                  //             days: int.parse(listOfEquipDebter[index].length)),
                  //       ))}');
                  //
                  //
                  //   if (calenderData.appointments!.where((element) => element.id == listOfEquipDebter[index].equipId).toList().isEmpty) {
                  //
                  // calenderData.appointments!.add(equipDebter);
                  //   } else {
                  //
                  //   print('not Empty!');
                  //
                  //   }
                  },
                  child: AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 500),
                    columnCount: columnCount,
                    child: ScaleAnimation(
                      duration: const Duration(milliseconds: 900),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: FadeInAnimation(
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: w / 30,
                              left: w / 60,
                              right: w / 60,
                              top: w / 60),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 40,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: Container(
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _number.format(
                                            double.parse(
                                                listOfEquipDebter[index]
                                                    .grandPrize),
                                          ),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          'ETB',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: ListTile(
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: 'አባላት ብዛት: ',
                                                style: boldStyle,
                                              ),
                                              TextSpan(
                                                text: listOfEquipDebter[index]
                                                    .member,
                                                style: normalStyle,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      subtitle: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: 'Days: ',
                                                  style: boldStyle,
                                                ),
                                                TextSpan(
                                                  text: listOfEquipDebter[index]
                                                      .length,
                                                  style: normalStyle,
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: 'Recur: ',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextSpan(
                                                    text:
                                                        listOfEquipDebter[index]
                                                            .recurrence,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            'መጠን ',
                                            style: TextStyle(
                                              color: Colors.green[800],
                                              fontFamily: 'FjallaOne',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          Text(
                                            listOfEquipDebter[index].amount,
                                            style: TextStyle(
                                              color: Colors.green[800],
                                              fontFamily: 'FjallaOne',
                                              fontSize: 25,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
