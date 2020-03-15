import 'package:covid19simulator/person_data.dart';
import 'package:flutter/material.dart';

class Person extends StatelessWidget {
  Person({this.personData});
  final PersonData personData;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(shape: BoxShape.circle, color: _getColor()),
    );
  }

  _getColor() {
    switch (personData.personStatus) {
      case PersonStatus.NonInfected:
        return Colors.grey;
      case PersonStatus.Infected:
        return Colors.yellow;
      case PersonStatus.Sick:
        return Colors.red;
      case PersonStatus.Recovered:
        return Colors.green;
    }
  }
}
