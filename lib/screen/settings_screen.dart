import 'dart:math';

import 'package:const_project/constant/color.dart';
import 'package:flutter/material.dart';

import '../component/number_row.dart';

class SettingsScreen extends StatefulWidget {
  final int maxNumber;
  const SettingsScreen({required this.maxNumber, Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double maxNumber = 1000;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    maxNumber = widget.maxNumber.toDouble();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Header(
                maxNumber: maxNumber,
              ),
              _Bottom(
                maxNumber: maxNumber,
                onPressed: onPopNavigator,
                onChanged: onChangeValue,
              )
            ],
          ),
        ),
      ),
    );
  }

  onPopNavigator() {
    Navigator.of(context).pop(maxNumber.toInt());
  }

  onChangeValue(double value) {
    setState(() {
      maxNumber = value;
    });
  }
}

class _Header extends StatelessWidget {
  final double maxNumber;
  const _Header({required this.maxNumber, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(number: maxNumber.toInt())
    );
  }
}

class _Bottom extends StatelessWidget {
  final double maxNumber;
  final VoidCallback onPressed;
  final ValueChanged<double>? onChanged;
  const _Bottom({required this.maxNumber, required this.onPressed, required this.onChanged, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
      Slider(value: maxNumber, min: 1000, max: 999999, onChanged: onChanged),
      ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: RED_COLOR,
          ),
          child: const Text('Save')),
    ]);
  }
}
