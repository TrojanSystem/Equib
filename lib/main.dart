import 'package:equib/equib_data/equip_daily_collected_database.dart';
import 'package:equib/equip_home_page/equip_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'equib_data/equip_data.dart';

void main() {
  return runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Equip(),
    ),
  );
}

class Equip extends StatefulWidget {
  const Equip({super.key});

  @override
  State<Equip> createState() => _EquipState();
}

class _EquipState extends State<Equip> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => EquibData()..loadNewMemberList(),
        ),
        ChangeNotifierProvider(
            create: (ctx) => EquipDailyCollected()..loadDailyCollectedList()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: EquibHomePage(),
      ),
    );
  }
}
