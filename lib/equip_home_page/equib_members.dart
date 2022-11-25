import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../equib_data/equip_data.dart';
import 'list_of_daily_collected.dart';
class EquibMembers extends StatelessWidget {
   EquibMembers({Key? key}) : super(key: key);


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
    final newMembers = Provider.of<EquibData>(context).newMember;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equib Members'),
      ),
      body: ListView.builder(
          itemCount: newMembers.length,
          itemBuilder: (context, index) {
            return MembersListDetail(
              price: newMembers[index].price,
              equibQuantity: newMembers[index].equibQuantity,
              name: newMembers[index].name,
              phoneNumber: newMembers[index].phoneNumber,
            );
          }),
    );
  }
}

