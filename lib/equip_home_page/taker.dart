import 'dart:math';

import 'package:equib/constants.dart';
import 'package:equib/equib_data/equip_model_data.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../equib_data/equip_data.dart';

class Taker extends StatefulWidget {
  const Taker({super.key, required this.takerID, required this.newTakerss});

  final String takerID;

  final List<TakerModel> newTakerss;

  @override
  State<Taker> createState() => _TakerState();
}

class _TakerState extends State<Taker> {
  String tossed = '';

  @override
  Widget build(BuildContext context) {
    final newTakerChecker = Provider.of<Takers>(context).takerList;
    final newTaker = newTakerChecker
        .where((element) => element.takersID == widget.takerID)
        .toList();
    final readyForTossingMemebrs =
        newTaker.where((element) => element.isWin == false).toList();
    List<String> listName =
        readyForTossingMemebrs.map((e) => e.member).toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(1),
                    Colors.blue.withOpacity(0.8),
                    Colors.blue.withOpacity(0.6),
                    Colors.blue.withOpacity(0.4),
                    Colors.blue.withOpacity(0.2),
                    Colors.blue.withOpacity(0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: FlipCard(
                    direction: FlipDirection.VERTICAL,
                    speed: 1000,
                    onFlipDone: (status) {
                      setState(() {
                        if (status == true) {
                          if (readyForTossingMemebrs.isNotEmpty) {
                            setState(() {
                              Random random = Random();
                              tossed =
                                  listName[random.nextInt(listName.length)];

                              final winner = readyForTossingMemebrs
                                  .where((element) => element.member == tossed)
                                  .toList();
                              final round =
                                  Provider.of<Takers>(context, listen: false)
                                      .equipRound;
                              final task = TakerModel(
                                day: winner.first.day,
                                member: winner.first.member,
                                amount: winner.first.amount,
                                round: round.toString(),
                                isWin: true,
                                takersID: widget.takerID,
                              );
                              Provider.of<Takers>(context, listen: false)
                                  .updateTakerList(task);
                              Provider.of<Takers>(context, listen: false)
                                  .changeRound(round);
                            });
                          } else if (
                              newTaker.isEmpty) {
                            return;
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Center(child: Text('እቁብ')),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Lottie.asset('images/congratulations.json'),
                                    const Text(
                                      'Congratulation!',
                                      style: emptyStyle,
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        } else {
                          return;
                        }
                      });
                    },
                    front: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF006666),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        'images/front.jpg',
                        width: 50,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    back: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF006666),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        'images/back.jpg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(1),
                    Colors.blue.withOpacity(0.8),
                    Colors.blue.withOpacity(0.6),
                    Colors.blue.withOpacity(0.4),
                    Colors.blue.withOpacity(0.2),
                    Colors.blue.withOpacity(0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'Equip Schedule',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Table(
                              columnWidths: const {
                                0: FlexColumnWidth(4),
                                1: FlexColumnWidth(2),
                                2: FlexColumnWidth(3),
                                3: FlexColumnWidth(3),
                              },
                              children: const [
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Member",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Status",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Amount",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Round",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey, width: 2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: newTaker.isEmpty
                                ? const Center(
                                    child: Text(
                                      'No registered members! ',
                                      style: emptyStyle,
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: newTaker.length,
                                    itemBuilder: (context, index) {
                                      return Table(columnWidths: const {
                                        0: FlexColumnWidth(4),
                                        1: FlexColumnWidth(2),
                                        2: FlexColumnWidth(3),
                                        3: FlexColumnWidth(3),
                                      }, children: [
                                        buildTableRowsForTaker(
                                          member: newTaker[index].member,
                                          status: newTaker[index].isWin,
                                          amount: newTaker[index].amount,
                                          round: newTaker[index].round,
                                        ),
                                      ]);
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TableRow buildTableRowsForTaker(
      {required String member,
      required bool status,
      required String amount,
      required String round}) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            member,
            style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            status ? 'ወሳጅ' : 'ጠባቂ',
            style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            amount,
            style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            status ? 'Round #$round' : '',
            style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
