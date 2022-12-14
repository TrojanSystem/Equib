import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';

class ListOfDailyPayedMembers extends StatelessWidget {
  const ListOfDailyPayedMembers(
      {super.key, required this.tappedDate, required this.collected});

  final List collected;
  final DateTime? tappedDate;

  @override
  Widget build(BuildContext context) {
    final payedMembersAtSelectedDate = collected
        .where((element) =>
            DateTime.parse(element.fromDay).isBefore(tappedDate!) &&
                DateTime.parse(element.toDay).isAfter(tappedDate!) ||
            DateTime.parse(element.fromDay) == tappedDate ||
            DateTime.parse(element.toDay) == tappedDate)
        .toList();

    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.white,
        toolbarHeight: 90,
        elevation: 0,
        title: Text(
          'ዛሬ ቀን የሰጡ',
          style: TextStyle(
            color: Colors.blue[800],
            fontWeight: FontWeight.w900,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: payedMembersAtSelectedDate.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('images/no-cash.png'),
                  const Text('No cash collected!'),
                ],
              ),
            )
          : ListView.builder(
              itemCount: payedMembersAtSelectedDate.length,
              itemBuilder: (context, index) {
                return CollectedFrom(
                    from: payedMembersAtSelectedDate[index].fromDay,
                    to: payedMembersAtSelectedDate[index].toDay,
                    eventName: payedMembersAtSelectedDate[index].event,
                    totalPayed: payedMembersAtSelectedDate[index].totalPayed);
              }),
    );
  }
}

class MembersListDetail extends StatelessWidget {
  const MembersListDetail(
      {super.key,
      required this.phoneNumber,
      required this.equibQuantity,
      required this.price,
      required this.name});

  final String name;
  final String phoneNumber;
  final int equibQuantity;
  final int price;

  @override
  Widget build(BuildContext context) { double w = MediaQuery.of(context).size.width;
final NumberFormat _collectedCash = NumberFormat();
  int columnCount = 3;
    return AnimationConfiguration.staggeredGrid(
      position: 0,
      duration: const Duration(milliseconds: 500),
      columnCount: columnCount,
      child: ScaleAnimation(
        duration: const Duration(milliseconds: 900),
        curve: Curves.fastLinearToSlowEaseIn,
        child: FadeInAnimation(
          child: Container(
            margin: EdgeInsets.only(
                bottom: w / 60, left: w / 30, right: w / 30, top: w / 60),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
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
        borderRadius: BorderRadius.all(Radius.circular(20)),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _collectedCash.format(price),
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
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    name,
                  ),
                ),
                subtitle: Text(
                  DateFormat.yMMMEd().format(
                    DateTime.now(),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      equibQuantity.toString(),
                      style: TextStyle(
                        color: Colors.green[800],
                        fontFamily: 'FjallaOne',
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      ' እጣ',
                      style: TextStyle(
                        color: Colors.green[800],
                        fontFamily: 'FjallaOne',
                        fontSize: 16,
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
    ),   ),
    ),
    ),
    );
  }
}

class CollectedFrom extends StatelessWidget {
   CollectedFrom(
      {super.key,
      required this.from,
      required this.totalPayed,
      required this.to,
      required this.eventName});

  final String from;
  final String eventName;
  final String to;
  final String totalPayed;
  final NumberFormat _collectedCash = NumberFormat();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    int columnCount = 3;
    final dayDifference =
        DateTime.parse(to).difference(DateTime.parse(from)).inDays;
    final total = (dayDifference + 1).toString();
    return AnimationConfiguration.staggeredGrid(
      position: 0,
      duration: const Duration(milliseconds: 500),
      columnCount: columnCount,
      child: ScaleAnimation(
        duration: const Duration(milliseconds: 900),
        curve: Curves.fastLinearToSlowEaseIn,
        child: FadeInAnimation(
          child: Container(
            margin: EdgeInsets.only(
                bottom: w / 60, left: w / 30, right: w / 30, top: w / 60),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                borderRadius: BorderRadius.all(Radius.circular(20)),

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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _collectedCash.format(double.parse(totalPayed)),
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
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Text(
                            eventName,
                          ),
                        ),
                        subtitle: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                const TextSpan(
                                  text: 'From: ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: DateFormat.yMMMEd().format(
                                    DateTime.parse(
                                      from.toString(),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ]),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            RichText(
                              text: TextSpan(children: [
                                const TextSpan(
                                  text: 'To: ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: DateFormat.yMMMEd().format(
                                    DateTime.parse(
                                      to.toString(),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ]),
                            ),
                          ],
                        ),
                        trailing: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              total,
                              style: TextStyle(
                                color: Colors.green[800],
                                fontFamily: 'FjallaOne',
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              'ቀን',
                              style: TextStyle(
                                color: Colors.green[800],
                                fontFamily: 'FjallaOne',
                                fontSize: 16,
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
    );
  }
}
