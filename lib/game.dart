import 'dart:math';

import 'package:covid19simulator/panel.dart';
import 'package:covid19simulator/person.dart';
import 'package:covid19simulator/person_data.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  static const int NUM_OF_PERSONS = 100;
  static const int INITIAL_NUM_OF_INFECTED = 10;

  List<PersonData> personDataList;
  bool isStarted = false;
  Size screenSize;
  Random random = Random();
  int infectedCount = INITIAL_NUM_OF_INFECTED, sickCount = 0;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      isStarted = true;
      screenSize = MediaQuery.of(context).size;
      personDataList = _generatePersons(context);
      gameLoop();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isStarted) return Container();
    return Stack(
      children: [
        ..._buildPersons(personDataList),
        Align(
          alignment: Alignment.topLeft,
          child: Panel(
            total: NUM_OF_PERSONS,
            infected: infectedCount,
            sick: sickCount,
            noninfected: NUM_OF_PERSONS-infectedCount-sickCount,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildPersons(List<PersonData> personDataList) {
    return personDataList
        .map((PersonData personData) => Positioned(
              child: Person(
                personData: personData,
              ),
              left: personData.pos.x,
              top: personData.pos.y,
            ))
        .toList();
  }

  List<PersonData> _generatePersons(context) {
    return List<PersonData>.generate(NUM_OF_PERSONS, (index) {
      PersonData person = PersonData(
        id: index.toString(),
        personStatus: index < INITIAL_NUM_OF_INFECTED
            ? PersonStatus.Infected
            : PersonStatus.NonInfected,
        pos: Vector2.random()
          ..multiply(Vector2(screenSize.width, screenSize.height)),
      );
      return person;
    });
  }

  gameLoop() async {
    update();
    await Future.delayed(Duration(milliseconds: 50));
    setState(() {});
    collissionDetector();
    gameLoop();
  }

  update() {
    for (int i = 0; i < personDataList.length; i++) {
      PersonData personData = personDataList[i];
      if (personData.personStatus == PersonStatus.Infected) {
        personDataList[i] = personData.copyWith(
            elapsedTimeSinceInfection:
                personData.elapsedTimeSinceInfection + 50);
        if (personData.elapsedTimeSinceInfection > 10000) {
          personDataList[i] =
              personData.copyWith(personStatus: PersonStatus.Sick);
          sickCount++;
          infectedCount--;
        }
      }
      personDataList[i] = personDataList[i].copyWith(
          pos: Vector2(
              personDataList[i].pos.x +
                  random.nextDouble() * (random.nextBool() ? -5 : 5),
              personDataList[i].pos.y +
                  random.nextDouble() * (random.nextBool() ? -5 : 5)));
    }
  }

  collissionDetector() {
    for (int i = 0; i < personDataList.length; i++) {
      for (int j = 0; j < personDataList.length - 1; j++) {
        PersonData p1 = personDataList[i];
        PersonData p2 = personDataList[j];

        var dx = p1.pos.x - p2.pos.x;
        var dy = p1.pos.y - p2.pos.y;
        var distance = sqrt(dx * dx + dy * dy);

        if (distance < 10) {
          if (p1.personStatus == PersonStatus.Infected ||
              p2.personStatus == PersonStatus.Infected ||
              p1.personStatus == PersonStatus.Sick ||
              p2.personStatus == PersonStatus.Sick) {
            if (p1.personStatus == PersonStatus.NonInfected) {
              personDataList[i] =
                  p1.copyWith(personStatus: PersonStatus.Infected);
              infectedCount++;
            }
            if (p2.personStatus == PersonStatus.NonInfected) {
              personDataList[j] =
                  p2.copyWith(personStatus: PersonStatus.Infected);
              infectedCount++;
            }
          }
        }
      }
    }
  }
}
