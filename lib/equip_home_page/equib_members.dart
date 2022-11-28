import 'package:equib/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../equib_data/equip_data.dart';
import 'list_of_daily_collected.dart';

class EquibMembers extends StatelessWidget {
  const EquibMembers(
      {super.key, required this.membersID, required this.newMembers});

  final String membersID;
  final List newMembers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.white,
        toolbarHeight: 90,
        elevation: 0,
        title: Text(
          'እቁብ አባላት',
          style:titleStyle,
        ),
        centerTitle: true,
      ),
      body: newMembers.isEmpty
          ? const Center(
              child: Text(
                'No registered Members!',
                style: emptyStyle,
              ),
            )
          : ListView.builder(
              itemCount: newMembers.length,
              itemBuilder: (context, index) {
                return MembersListDetail(
                  price: int.parse(newMembers[index].price),
                  equibQuantity: int.parse(newMembers[index].equibQuantity),
                  name: newMembers[index].name,
                  phoneNumber: newMembers[index].phoneNumber,
                );
              },
            ),
    );
  }
}
