import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  return runApp(Equib());
}

class Equib extends StatefulWidget {
  Equib({Key? key}) : super(key: key);

  @override
  State<Equib> createState() => _EquibState();
}

class _EquibState extends State<Equib> {
  List<String> listName = ['Dero', 'Suke', 'Tsinat', 'Adu', 'Sifen'];

  List<String> taker = [];

  String tossed = '';

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: listName.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MembersListDetail(phoneNumber: '0912654975',name: 'Suke',equibQuantity: 1,price: 1000),
                  Text(tossed),
                  Text(
                    listName.toString(),
                  ),
                  Text(
                    taker.toString(),
                  ),
                ],
              )
            : const Center(
                child: Text('Done'),
              ),
        bottomNavigationBar: BottomAppBar(
          color: const Color.fromRGBO(40, 53, 147, 1),
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: SizedBox(
            height: 50,
            child: Row(
              children: [
                bottomBarButtons(title: 'Members', bottomBarFunction: () {}),
                bottomBarButtons(title: 'Takers', bottomBarFunction: () {}),
                const SizedBox(width: 95,),
                bottomBarButtons(title: 'Next',bottomBarFunction: (){}),
                bottomBarButtons(title: 'Analysis',bottomBarFunction: (){}),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              Random random = Random();
              tossed = listName[random.nextInt(listName.length)];
              taker.add(tossed);
              listName.remove(tossed);
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  TextButton bottomBarButtons({required bottomBarFunction, required title}) {
    return TextButton(
      onPressed: bottomBarFunction,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white,fontSize: 15),
      ),
    );
  }
}

class MembersListDetail extends StatelessWidget {
   MembersListDetail({
   required this.phoneNumber,required this.equibQuantity,required this.price,required this.name
  });
  String name;
  String phoneNumber;
  int equibQuantity;
  int price;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height:100,
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
                mainAxisAlignment:
                MainAxisAlignment.center,
                children:  [
                  Text(
                    price.toString(),
                    style:const TextStyle(
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
                title:  Padding(
                  padding:
                  const EdgeInsets.only(bottom: 8.0),
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
