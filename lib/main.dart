import 'package:equib/equip_home_page/equip_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'equib_data/equip_data.dart';
import 'equip_home_page/home_page.dart';

void main() {
  return runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  AdaBread(),

    ),
  );
}
class AdaBread extends StatefulWidget {


  @override
  State<AdaBread> createState() => _AdaBreadState();
}

class _AdaBreadState extends State<AdaBread> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => EquibData(),
        ),

      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: EquibHomePage(),
      ),
    );
  }
}