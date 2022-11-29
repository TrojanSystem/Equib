import 'package:equib/equib_data/equip_data.dart';
import 'package:equib/equib_data/equip_model_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../equip_home_page/equip_home_screen.dart';

class EquipDebterStarter extends StatefulWidget {
  const EquipDebterStarter({Key? key}) : super(key: key);

  @override
  State<EquipDebterStarter> createState() => _EquipDebterStarterState();
}

class _EquipDebterStarterState extends State<EquipDebterStarter> {
  final NumberFormat _grandPrize = NumberFormat();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _members = TextEditingController();

  final FocusNode _memebrsFocus = FocusNode();

  final TextEditingController _equipPrice = TextEditingController();

  final FocusNode _equipPriceNode = FocusNode();
  final TextEditingController _winEvery = TextEditingController();

  final FocusNode _winEveryFocus = FocusNode();
  final TextEditingController _winAmount = TextEditingController();

  final FocusNode _winAmountFocus = FocusNode();
  late String startTime = DateTime.now().toString();

  void datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      firstDate: DateTime(DateTime.now().month + 1),
    ).then((value) => setState(() {
          if (value != null) {
            startTime = value.toString();
          } else {
            startTime = DateTime.now().toString();
          }
        }));
  }

  @override
  void dispose() {
    _members.dispose();
    _memebrsFocus.dispose();
    _winEvery.dispose();
    _winEveryFocus.dispose();
    _equipPrice.dispose();
    _equipPriceNode.dispose();
    _winAmount.dispose();
    _winAmountFocus.dispose();
    super.dispose();
  }

  double grandPrice = 0.0;
  String noMemebr = '';
  String every = '';
  String priceAmount = '';
  var uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    grandPrice = (noMemebr.isEmpty ? 0 : double.parse(noMemebr)) *
        (every.isEmpty ? 0 : double.parse(every)) *
        (priceAmount.isEmpty ? 0 : double.parse(priceAmount));
    int endDate = (noMemebr.isEmpty ? 0 : int.parse(noMemebr)) *
        (every.isEmpty ? 0 : int.parse(every));
    final loggedUserID = uuid.v4();
    final year = (endDate / 365).floor();
    final yearLeft = endDate % 365;

    final month = (yearLeft / 30).floor();
    final monthLeft = yearLeft % 30;

    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.white,
        toolbarHeight: 90,
        elevation: 0,
        title: Text(
          'እቁብ ደብተር',
          style: TextStyle(
            color: Colors.blue[800],
            fontWeight: FontWeight.w900,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 8, 35, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Members',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      focusNode: _memebrsFocus,
                      controller: _members,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_equipPriceNode),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Members can\'t be empty';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (member) {
                        setState(() {
                          noMemebr = member;
                        });
                      },
                      onSaved: (value) {
                        _members.text = value!;
                      },
                      decoration: InputDecoration(
                        hintText: 'የአባላት ብዛት',
                        filled: true,
                        fillColor: Colors.grey[200],
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(35, 8, 35, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Price',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: _equipPrice,
                            focusNode: _equipPriceNode,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_winAmountFocus),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Price can\'t be empty';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (pr) {
                              setState(() {
                                priceAmount = pr;
                              });
                            },
                            onSaved: (value) {
                              _equipPrice.text = value!;
                            },
                            decoration: InputDecoration(
                              hintText: 'መጠን',
                              filled: true,
                              fillColor: Colors.grey[200],
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(35, 8, 35, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Win Every',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: _winEvery,
                            focusNode: _winEveryFocus,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.go,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Every can\'t be empty';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (win) {
                              setState(() {
                                every = win;
                              });
                            },
                            onSaved: (value) {
                              _winEvery.text = value!;
                            },
                            decoration: InputDecoration(
                              hintText: 'ቀን',
                              filled: true,
                              fillColor: Colors.grey[200],
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(35, 8, 0, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Start Date',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[200],
                                ),
                                height: 60,
                                child: Text(
                                  ' ${DateFormat.yMEd().format(DateTime.parse(startTime))}',
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    datePicker();
                                  });
                                },
                                icon: const Icon(Icons.calendar_today),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 35, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'It\'ll Take',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[200],
                                ),
                                width: 180,
                                height: 60,
                                child: year == 0 && month == 0 && monthLeft == 0
                                    ? const Text('Equip length')
                                    : RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text:
                                                    year == 0 ? '' : 'y: $year',
                                                style: const TextStyle(
                                                    color: Colors.black)),
                                            TextSpan(
                                                text: month == 0
                                                    ? ''
                                                    : ' m: $month',
                                                style: const TextStyle(
                                                    color: Colors.black)),
                                            TextSpan(
                                                text: monthLeft == 0
                                                    ? ''
                                                    : ' d: $monthLeft',
                                                style: const TextStyle(
                                                    color: Colors.black))
                                          ],
                                        ),
                                      ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.calendar_month),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 8, 35, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Grand Price',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        _grandPrize.format(grandPrice),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    var newEquip = EquipStarterModel(
                      recurrence: every,
                      length: endDate.toString(),
                      day: startTime,
                      amount: priceAmount,
                      member: _members.text,
                      grandPrize: grandPrice.toString(),
                      equipId: loggedUserID,
                    );

                    Provider.of<EquipStarterClass>(context, listen: false)
                        .addEquipStarterList(newEquip);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => EquibHomePage(
                          equipID: loggedUserID,
                          equipStartDate: startTime,
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(130, 10, 130, 0),
                  width: double.infinity,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.green[500],
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: const Center(
                    child: Text(
                      'Start',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
