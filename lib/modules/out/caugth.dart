import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CaugthScreen extends StatefulWidget {
  @override
  _CaugthScreenState createState() => _CaugthScreenState();
}

class _CaugthScreenState extends State<CaugthScreen> {
  Widget normalText(String name) {
    return Text(
      name,
      style: TextStyle(
          fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black),
    );
  }

  File _image1;
  File _image2;
  final picker = ImagePicker();

  Future getImage1() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image1 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImage2() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image2 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget chooseContainer1({String name, String url}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.3,
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: _image1 == null
                ? InkWell(
                    onTap: () {
                      getImage1();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      maxRadius: 45,
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                    ),
                  )
                : Image.file(_image1),
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.3,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }

  Widget chooseContainer2({String name, String url}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.3,
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: _image2 == null
                ? InkWell(
                    onTap: () {
                      getImage2();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      maxRadius: 45,
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                    ),
                  )
                : Image.file(_image2),
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.3,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Caugth",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 21),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            normalText("Who?"),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            chooseContainer1(
                name: "Avishek",
                url: "https://image.flaticon.com/icons/png/128/10/10552.png"),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            normalText("Select Fielder"),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            chooseContainer2(
                name: "Fielder",
                url:
                    "https://cdn0.iconfinder.com/data/icons/sports-and-games-3/512/140-128.png")
          ],
        ),
      ),
    );
  }
}
