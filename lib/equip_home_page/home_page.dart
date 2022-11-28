import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:equib/equip_input/equip_debter_starter.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'list_of_equip_debter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Lottie.asset('images/welcome.json'),
                Lottie.asset('images/saving-money.json'),
                Center(
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'እቁብ ደብተር',
                        textAlign: TextAlign.center,
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.w900,
                        ),
                        speed: const Duration(milliseconds: 200),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  height: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.8),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                    image: const DecorationImage(
                      image: AssetImage('images/back_image.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(children: [
                    Positioned(
                      right: 15,
                      top: 55,
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Want to create Your own',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(text: '\n'),
                            TextSpan(
                              text: 'Equip Group?',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 15,
                      bottom: 15,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => const EquipDebterStarter(),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          width: 140,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Text(
                            'Start Here',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],),
                ), Positioned(
                  right: 15,
                  bottom: 15,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) =>  ListOfEquipDebter(),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        'Continue..',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
