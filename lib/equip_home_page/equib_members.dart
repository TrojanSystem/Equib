import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../equib_data/equip_data.dart';
import 'list_of_daily_collected.dart';
class EquibMembers extends StatelessWidget {
   EquibMembers({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    final newMembers = Provider.of<EquibData>(context).newMemberList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equib Members'),
      ),
      body: ListView.builder(
          itemCount: newMembers.length,
          itemBuilder: (context, index) {
            return MembersListDetail(
              price: int.parse(newMembers[index].price),
              equibQuantity: int.parse(newMembers[index].equibQuantity),
              name: newMembers[index].name,
              phoneNumber: newMembers[index].phoneNumber,
            );
          }),
    );
  }
}

