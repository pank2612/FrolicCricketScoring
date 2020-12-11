import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:froliccricketscore/Screens/tossScreen.dart';
import 'package:froliccricketscore/blocs/sportsBloc.dart';
import 'package:froliccricketscore/constants/config.dart';
import 'package:froliccricketscore/models/MatchModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:froliccricketscore/modules/start_innings/start_Innings_Screen.dart';

class MatchScreen extends StatefulWidget {
  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  Widget tossContainer({String name, String url}) {
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
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : BlocBuilder<SportsDataBloc, SportsDataBlocState>(
              builder: (_, sportsState) {
                return sportsState.sportsMap["Cricket"].length == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.79,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  sportsState
                                      .sportsMap['Cricket'][1].tournamentName
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                ListView(
                                  shrinkWrap: true,
                                  children: sportsState.sportsMap['Cricket']
                                      .map((matchData) => Column(
                                            //  shrinkWrap: true,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              TossScreen(
                                                                matchDataForApp:
                                                                    matchData,
                                                              )));
                                                },
                                                splashColor: Colors.black,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    tossContainer(
                                                        name: matchData
                                                            .firstTeamShortName,
                                                        url:
                                                            "https://image.flaticon.com/icons/png/128/3439/3439653.png"),
                                                    Text(
                                                      "VS",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 25),
                                                    ),
                                                    tossContainer(
                                                        name: matchData
                                                            .secondTeamShortName,
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
                              ],
                            ),
                          ),
                        ],
                      );
              },
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
