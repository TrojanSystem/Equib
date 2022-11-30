import 'package:equib/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'calendar.dart';
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
          create: (ctx) => EquipDailyCollected()..loadDailyCollectedList(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Takers()..loadTakerList(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => EquipStarterClass()..loadEquipStarterList(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyCustomSplashScreen(),
      ),
    );
  }
}
