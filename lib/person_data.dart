import 'package:flutter/cupertino.dart';
import 'package:vector_math/vector_math.dart';

enum PersonStatus { NonInfected, Infected, Sick, Recovered }

class PersonData {
  PersonData(
      {@required this.id,
      @required this.pos,
      this.personStatus = PersonStatus.NonInfected,
      this.elapsedTimeSinceInfection=0});
  final Vector2 pos;
  final String id;
  final PersonStatus personStatus;
  final int elapsedTimeSinceInfection;

  PersonData copyWith(
      {Vector2 pos,
      String id,
      PersonStatus personStatus,
      int elapsedTimeSinceInfection}) {
    return PersonData(
        pos: pos ?? this.pos,
        id: id ?? this.id,
        personStatus: personStatus ?? this.personStatus,
        elapsedTimeSinceInfection:
            elapsedTimeSinceInfection ?? this.elapsedTimeSinceInfection);
  }
}
