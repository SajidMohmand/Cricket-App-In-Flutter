import 'dart:math';

import 'package:add_drop_product/Screen/chasing_team.dart';
import 'package:add_drop_product/Screen/status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../core/store.dart';
import '../provider/team.dart';

class PlayCard extends StatelessWidget {
  String perBall = "";
  final TeamsModel status = (VxState.store as MyStore).teams;

  void activity() async {
    int num = Random().nextInt(9);

    if (num > 0 && num <= 4 || num == 6) {
      perBall = "${num}";
      AddTotalMutation(num);
      UpdateOverMutation(.1);
      // Provider.of<TeamsModel>(context, listen: false).updateBalling("${num}", num);
      // Provider.of<TeamsModel>(context, listen: false).plusTotal(num);
    } else if (num == 0) {
      perBall = "Dart";
      UpdateOverMutation(.1);
      // Provider.of<TeamsModel>(context, listen: false).updateBalling("bit", "dart Ball");
    } else if (num == 5) {
      perBall = "No Ball";
      AddTotalMutation(1);
      // Provider.of<TeamsModel>(context, listen: false)
      //     .updateBalling("noBall", "No Ball");
    } else if (num == 7) {
      perBall = "wide";
      AddTotalMutation(1);
      // Provider.of<TeamsModel>(context, listen: false)
      //     .updateBalling("wide", "Wide Ball");
      // Provider.of<TeamsModel>(context, listen: false).plusTotal(1);
    } else if (num == 8) {
      perBall = "out";
      UpdateOverMutation(.1);
      UpdateOutMutation(1);
    }

    await Future.delayed(Duration(seconds: 1));
    perBall = "";
    JustUpdateMutation();

    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return VxBuilder(
      mutations: {
        AddTotalMutation,
        UpdateOverMutation,
        UpdateOutMutation,
        JustUpdateMutation
      },
      builder: (context, __, _) => InkWell(
        onTap: () {
          final TeamsModel teams = (VxState.store as MyStore).teams;

          if(teams.target != 0){
            Navigator.of(context).pushNamed(ChasingTeam.route);
          }
          activity();

        },
        child: Container(
          height: 120,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.cyanAccent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Card(
            color: Colors.cyanAccent,
            elevation: 15,
            child: Center(
              child: perBall != 0 && perBall != ""
                  ? Text(
                      perBall.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  : Text(""),
            ),
          ),
        ),
      ),
    );
  }
}
