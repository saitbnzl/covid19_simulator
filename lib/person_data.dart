import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import 'package:vector_math/vector_math.dart';

enum PersonStatus { NonInfected, Infected, Sick, Recovered }

class PersonData {
  PersonData({@required this.id, @required this.pos,  this.personStatus = PersonStatus.NonInfected});
  final Vector2 pos;
  final String id;
  final PersonStatus personStatus;
  PersonData copyWith({Vector2 pos, String id, PersonStatus personStatus}) {
    return PersonData(pos: pos??this.pos, id: id??this.id, personStatus: personStatus??this.personStatus);
  }
}
