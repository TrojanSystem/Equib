import 'package:equib/equib_data/equip_data.dart';
import 'package:equib/equib_data/equip_model_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MemberRegistration extends StatefulWidget {
  MemberRegistration({Key? key}) : super(key: key);

  @override
  State<MemberRegistration> createState() => _MemberRegistrationState();
}

class _MemberRegistrationState extends State<MemberRegistration> {
  final TextEditingController _member = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _memberScope = FocusNode();

  final TextEditingController _phoneNumber = TextEditingController();

  final FocusNode _phoneNumberScope = FocusNode();

  final TextEditingController _price = TextEditingController();

  final FocusNode _priceScope = FocusNode();

  final TextEditingController _equipQuantity = TextEditingController();

  final FocusNode _equipQuantityScope = FocusNode();
  String memberName = '';
  String phoneNumber = '';
  int price = 0;
  int equipQuantity = 0;

  @override
  void dispose() {
    _member.dispose();
    _memberScope.dispose();
    _phoneNumber.dispose();
    _phoneNumberScope.dispose();
    _price.dispose();
    _priceScope.dispose();
    _equipQuantity.dispose();
    _equipQuantityScope.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 25),
        child: SingleChildScrollView(
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
                        'Member Name',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: _member,
                        focusNode: _memberScope,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_phoneNumberScope),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Member name can\'t be empty';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          memberName = value!;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter the name',
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 8, 35, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Phone Number',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        focusNode: _phoneNumberScope,
                        controller: _phoneNumber,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () =>
                            FocusScope.of(context).requestFocus(_priceScope),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Phone number can\'t be empty';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          phoneNumber = value!;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter the name',
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
                              controller: _price,
                              focusNode: _priceScope,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_equipQuantityScope),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Price can\'t be empty';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                price = int.parse(value!);
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter the Price',
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
                              'Equib Quantity',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: _equipQuantity,
                              focusNode: _equipQuantityScope,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.go,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Quantity can\'t be empty';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                equipQuantity = int.parse(value!);
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter the quantity',
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
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      final newMember = MembersModel(
                          price: price,
                          equibQuantity: equipQuantity,
                          name: memberName,
                          phoneNumber: phoneNumber);
                      Provider.of<EquibData>(context, listen: false)
                          .addMember(newMember);

                      Navigator.of(context).pop();
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
                        'Add Member',
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
      ),
    );
  }
}
