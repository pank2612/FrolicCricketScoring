import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:froliccricketscore/Screens/tossScreen.dart';
import 'package:froliccricketscore/models/playerModel.dart';
import 'package:uuid/uuid.dart';

class AddPlayers extends StatefulWidget {
  @override
  _AddPlayersState createState() => _AddPlayersState();
}

class _AddPlayersState extends State<AddPlayers> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
          child: Column(
            children: [
              TextField(
                controller: _controller,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              RaisedButton(
                onPressed: () async {
                  var playerId = Uuid().v1();
                  print("Uuid $playerId");
                  PlayerModel playerModel = PlayerModel(
                      playerName: _controller.text, playerId: playerId);
//                  PlayerDetailsModel playerDetails = PlayerDetailsModel(
//                      playerId: playerId, playerName: _controller.text);
                  List<PlayerModel> list = List<PlayerModel>();
                  // list.add(playerModel.toJson()));
//                      .collection("users")
//                      .document("KPD56UPnqmS0EJFi88Tv217303P2")
//                      .setData({"data": "Sahil"}, merge: true);
//                  Firestore.instance
//                      .collection("Teams")
//                      .document("1")
//                      .collection("Australia")
//                      .document("1")
//                      .setData({
//                    "Players": [playerModel.toJson()]
//                  }, merge: true);
//                  Firestore.instance
//                      .collection("Teams")
//                      .document("1")
//                      .collection("Australia")
//                      .document("1")
//                      .collection("PlayerDetails")
//                      .document(playerId.toString())
//                      .setData(playerDetails.toJson(), merge: true);
                },
                child: Text("Add Players"),
                color: Colors.red,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TossScreen()));
                },
                child: Text("Toss Screen"),
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
