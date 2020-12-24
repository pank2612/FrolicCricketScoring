import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:froliccricketscore/Screens/tossScreen.dart';
import 'package:froliccricketscore/blocs/sportsBloc.dart';
import 'package:froliccricketscore/constants/config.dart';
import 'package:froliccricketscore/models/MatchModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/global_variables.dart' as globals;
import 'package:froliccricketscore/modules/start_innings/start_Innings_Screen.dart';

class MatchScreen extends StatefulWidget {
  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  Widget matchContainer({String name, String url}) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.15,
        // height: 100,
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey.shade700, width: 3),
          color: Colors.grey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                )),
            Text(
              name.toString(),
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

  bool isLoading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    getSportsData();
  }

  Future<Null> getSportsData() async {
    context.bloc<SportsDataBloc>().getSportsDataFromFirestore();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text(
          "Match Screen",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: BlocBuilder<SportsDataBloc, SportsDataBlocState>(
        builder: (_, sportsState) {
          if (sportsState.sportsMap[globals.defaultSports] != null) {
            return listItems(sportsState);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget listItems(SportsDataBlocState state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: state.sportsMap[globals.defaultSports]
            .map((matchDataForApp) => Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TossScreen(
                                      matchDataForApp: matchDataForApp,
                                    )));
                      },
                      splashColor: Colors.black,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          matchContainer(
                              name: matchDataForApp.firstTeamShortName,
                              url:
                                  "https://image.flaticon.com/icons/png/128/3439/3439653.png"),
                          Text(
                            "VS",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          matchContainer(
                              name: matchDataForApp.secondTeamShortName,
                              url:
                                  "https://image.flaticon.com/icons/png/128/3439/3439653.png"),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    )
                  ],
                ))
            .toList(),
      ),
    );
  }

  _showDialog(String name) {
    _scaffoldkey.currentState.showSnackBar(SnackBar(
        content: Text(
      name,
      style: TextStyle(fontSize: 18),
    )));
  }
}
