import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RunOutScreen extends StatefulWidget {
  @override
  _RunOutScreenState createState() => _RunOutScreenState();
}

class _RunOutScreenState extends State<RunOutScreen> {
  File _image1;
  File _image2;
  File _image3;
  File _image4;
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

  Future getImage3() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image3 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImage4() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image4 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget normalText(String name) {
    return Text(
      name,
      style: TextStyle(
          fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black),
    );
  }

  Widget chooseContainer1({String name, String url}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.2,
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 20,
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.08,
                height: MediaQuery.of(context).size.height * 0.08,
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.2,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }

  Widget chooseContainer3({String name, String url}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.2,
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 20,
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.08,
                height: MediaQuery.of(context).size.height * 0.08,
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.2,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }

  Widget chooseContainer4({String name, String url}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.2,
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 20,
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.08,
                height: MediaQuery.of(context).size.height * 0.08,
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.2,
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
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.2,
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 20,
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.08,
                height: MediaQuery.of(context).size.height * 0.08,
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.2,
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
          "Run Out",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 21),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
            // height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                normalText("Who is Out?"),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  children: [
                    InkWell(
                        splashColor: Colors.black,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: chooseContainer1(
                              name: "Avishek",
                              url:
                                  "https://image.flaticon.com/icons/png/128/10/10552.png"),
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    InkWell(
                      splashColor: Colors.black,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: chooseContainer2(
                            name: "Avishek",
                            url:
                                "https://cdn0.iconfinder.com/data/icons/sports-and-games-3/512/140-128.png"),
                      ),
                    )
                  ],
                ),
                normalText("Select Fielder"),
                Row(
                  children: [
                    InkWell(
                        splashColor: Colors.black,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: chooseContainer3(
                              name: "Thrower",
                              url:
                                  "https://cdn0.iconfinder.com/data/icons/sports-and-games-3/512/140-128.png"),
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    InkWell(
                        splashColor: Colors.black,
                        onTap: () {},
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: chooseContainer4(
                                name: "Wicket",
                                url:
                                    "https://cdn3.iconfinder.com/data/icons/sports-and-games-flat-outline/614/535_-_Cricket-128.png")))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        normalText("Delivery Type"),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              childAspectRatio: 2,
                              children: List.generate(4, (index) {
                                return InkWell(
                                    splashColor: Colors.grey.shade300,
                                    child: Card(
                                        // color: Colors.blue,
                                        child: Center(
                                            child: Text(
                                      list[index]["name"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontSize: 15),
                                    ))),
                                    onTap: () {
                                      _gridNavigation(index);
                                    });
                              })),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        normalText("Runs Scored"),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: TextFormField(
                            // controller: _byeController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                    borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 4,
                                        style: BorderStyle.solid))),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          RaisedButton(
              onPressed: () {},
              color: Colors.red,
              child: Text(
                "OUT",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ))
        ],
      ),
    );
  }

  _gridNavigation(int indexValue) {
    if (indexValue == 0) {
      print("0");
    } else if (indexValue == 1) {
    } else if (indexValue == 2) {
    } else if (indexValue == 3) {}
  }

  List<Map<String, dynamic>> list = [
    {"name": "WD"},
    {"name": "NB"},
    {"name": "BYE"},
    {"name": "LB"},
  ];
}
