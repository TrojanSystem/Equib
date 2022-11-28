import 'dart:math';

import 'package:equib/equib_data/equip_model_data.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'equib_data/equip_data.dart';

class Taker extends StatefulWidget {
  Taker({required this.takerID});

  String takerID;

  @override
  State<Taker> createState() => _TakerState();
}

class _TakerState extends State<Taker> {
  final List<Map<String, dynamic>> takerList = [
    {'member': 'Suke', 'status': 'ጠባቂ', 'amount': '15000', 'round': 'Round 6'},
    {'member': 'Adu', 'status': 'ጠባቂ', 'amount': '15000', 'round': 'Round 6'},
    {
      'member': 'Tsinat',
      'status': 'ወሳጅ',
      'amount': '15000',
      'round': 'Round 6'
    },
    {
      'member': 'Suke Mother',
      'status': 'ጠባቂ',
      'amount': '15000',
      'round': 'Round 6'
    },
  ];

  //['Dero', 'Suke', 'Tsinat', 'Adu', 'Sifen'];

  List<String> taker = [];

  String tossed = '';

  @override
  Widget build(BuildContext context) {
    final newMember = Provider.of<EquibData>(context).newMemberList;
    final newTaker = Provider.of<Takers>(context).takerList;
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
                        int count = 0;
                        if (status == true) {
                          if (readyForTossingMemebrs.isNotEmpty) {
                            setState(() {
                              count++;
                              Random random = Random();
                              tossed =
                                  listName[random.nextInt(listName.length)];

                              final winner = readyForTossingMemebrs
                                  .where((element) => element.member == tossed)
                                  .toList();

                              final task = TakerModel(
                                day: winner.first.day,
                                member: winner.first.member,
                                amount: winner.first.amount,
                                round: count.toString(),
                                isWin: true,
                                takersID: widget.takerID,
                              );
                              Provider.of<Takers>(context, listen: false)
                                  .updateTakerList(task);
                            });
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Center(child: Text('እቁብ')),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Lottie.asset('images/congratulations.json'),
                                    const Text('Congratulation!'),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12),
                    child: Column(
                      children: [
                        Table(
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
                                  bottom:
                                      BorderSide(color: Colors.grey, width: 2),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Table(
                          columnWidths: const {
                            0: FlexColumnWidth(4),
                            1: FlexColumnWidth(2),
                            2: FlexColumnWidth(3),
                            3: FlexColumnWidth(3),
                          },
                          children: newTaker
                              .map(
                                (e) => buildTableRowsForTaker(
                                  member: e.member,
                                  status: e.isWin,
                                  amount: e.amount,
                                  round: e.round,
                                ),
                              )
                              .toList(),
                        ),
                      ],
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
            'Round #$round',
            style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
