import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListOfDailyPayedMembers extends StatelessWidget {
  ListOfDailyPayedMembers({required this.collected});
  List collected;
  List<Map<String, dynamic>> equibMembers = [
    {
      'price': 500,
      'equibQuantity': 1,
      'name': 'Suke',
      'phoneNumber': '0912654975'
    },
    {
      'price': 500,
      'equibQuantity': 2,
      'name': 'Dero',
      'phoneNumber': '0912654975'
    },{
      'price': 500,
      'equibQuantity': 1,
      'name': 'Tsinat',
      'phoneNumber': '0912654975'
    },{
      'price': 500,
      'equibQuantity': 1,
      'name': 'Sifen',
      'phoneNumber': '0912654975'
    },{
      'price': 500,
      'equibQuantity': 2,
      'name': 'Adu',
      'phoneNumber': '0912654975'
    },
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Collected From'),
      ),
      body: ListView.builder(
          itemCount: collected.length,
          itemBuilder: (context, index) {
            return CollectedFrom(
              from:  collected[index].from,
              to: collected[index].to,

              eventName: collected[index].eventName,
            );
          }),
    );
  }
}

class MembersListDetail extends StatelessWidget {
  MembersListDetail(
      {required this.phoneNumber,
      required this.equibQuantity,
      required this.price,
      required this.name});

  String name;
  String phoneNumber;
  int equibQuantity;
  int price;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: 100,
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
                    price.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
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
                      'X',
                      style: TextStyle(
                        color: Colors.green[800],
                        fontFamily: 'FjallaOne',
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      equibQuantity.toString(),
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
    );
  }
}
class CollectedFrom extends StatelessWidget {
  CollectedFrom(
      {required this.from,
        required this.to,

        required this.eventName});

  DateTime from;
  String eventName;
  DateTime to;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: 100,
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
                    'price',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
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
                    eventName,
                  ),
                ),
                subtitle: Text(
                  DateFormat.yMMMEd().format(
                    from,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'X',
                      style: TextStyle(
                        color: Colors.green[800],
                        fontFamily: 'FjallaOne',
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'Quantity',
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
    );
  }
}
