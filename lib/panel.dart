import 'package:flutter/material.dart';

class Panel extends StatelessWidget {
  Panel({this.total, this.infected, this.sick, this.noninfected, this.recovered});
  final int total;
  final int infected;
  final int sick;
  final int recovered;
  final int noninfected;
  TextStyle textStyle = TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.white.withOpacity(0.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Total: $total",style: textStyle.copyWith(color: Colors.black)),
            Text("Infected: $infected",style: textStyle.copyWith(color: Colors.yellow),),
            Text("Sick: $sick",style: textStyle.copyWith(color: Colors.red),),
           // Text("Recovered: $recovered",style: textStyle.copyWith(color: Colors.green)),
            Text("Non-infected: $noninfected",style: textStyle.copyWith(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
