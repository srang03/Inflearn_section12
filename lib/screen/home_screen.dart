import 'dart:math';

import 'package:const_project/constant/color.dart';
import 'package:const_project/screen/settings_screen.dart';
import 'package:flutter/material.dart';

import '../component/number_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> randomNumbers = [123, 456, 789];
  int maxNumber = 1000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PRIMARY_COLOR,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header( onPressed: onMaxNumberGenerate,),
               _Middle( randomNumbers: randomNumbers,),
                _Bottom(onPressed: onRandomNuberGenerate)
              ],
            ),
          ),
        ));
  }
  void onRandomNuberGenerate(){
      final rand = Random();
      final Set<int> newNumbers = {};

      while (newNumbers.length < 3) {
        final numbers = rand.nextInt(maxNumber);
         newNumbers.add(numbers);
      }

      setState(() {
        randomNumbers = newNumbers.toList();
      });
  }

  void onMaxNumberGenerate() async{
      final int? result = await Navigator.of(context).push<int>(
        MaterialPageRoute(builder: (BuildContext context){
          return SettingsScreen(maxNumber:  maxNumber,);
        }),
      );
      setState(() {
        if(result != null){
          maxNumber = result;
        }
      });
  }
}

class _Header extends StatelessWidget {
  final VoidCallback  onPressed;
  const _Header({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Random Creator',
            style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.w700),
          ),
          IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.settings, color: Colors.white)),
        ]);
  }
}

class _Middle extends StatelessWidget {
  final List<int> randomNumbers;
  const _Middle({ required this.randomNumbers, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    Expanded(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: randomNumbers
        .asMap()
        .entries
        .map((x) =>
    Padding(
    padding: EdgeInsets.only(
    bottom: x.key == 2.0 ? 0 : 16.0),
    child: NumberRow(number:  x.value,),
  ))
      .toList(),
  ));
  }
}


class _Bottom extends StatelessWidget {
  final VoidCallback onPressed;
  const _Bottom( { required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: RED_COLOR),
          onPressed: onPressed,
          child: Text('생성하기')),
    );
  }
}
