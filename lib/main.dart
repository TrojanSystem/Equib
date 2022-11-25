import 'dart:math';

import 'package:flutter/material.dart';

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

String tossed='';

  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body:listName.isNotEmpty? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
             tossed
            ),
            Text(
              listName.toString(),
            ),Text(
              taker.toString(),
            ),

          ],

        ): const Center(child: Text('Done'),),
        floatingActionButton: FloatingActionButton(
          onPressed: () {setState(() {
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
}
