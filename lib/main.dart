import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:froliccricketscore/Screens/addPlayers.dart';
import 'package:froliccricketscore/Screens/matchScreen.dart';
import 'package:froliccricketscore/Screens/scoreCardScreen.dart';
import 'package:froliccricketscore/blocs/sportsBloc.dart';
import 'Screens/tossScreen.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [BlocProvider<SportsDataBloc>(create: (_) => SportsDataBloc())],
    child: MaterialApp(
      title: "Frolic Cricket Score",

      home:
          //ScoreCardScreen(),
          MatchScreen(),
      //AddPlayers(),
      // TossScreen(),
      //StartInningsScreen(),
      //RunOutScreen(),
      //LiveScoreScreen(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}
