import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:seniordesign/globals/globals.dart';
import 'package:seniordesign/studentpages/studentTabView.dart';

import 'AddAClass.dart';
import './gpa_calc.dart';

class ScorePage extends StatelessWidget {
  final double score;
  final double total_credits;
  final double total_weighted_points;

  ScorePage(this.score, this.total_credits, this.total_weighted_points);

  @override
  Widget build(BuildContext context) {
    return new Material(
      //The First container for STUDENT INFORMATION!
      //

      child: FutureBuilder(
        future: _getUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            print("snapshot is null :O");
            return new Scaffold(
              backgroundColor: Color(0xff65646a),
              body: new Center(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/images/image0.png"),
                  ],
                ),
              ),
            );
          } else {
            print("snapshot is not null");
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: Color(0xffcf4411),
                        fontWeight: FontWeight.bold,
                        height: 3,
                        fontSize: 20),
                    children: <TextSpan>[
                      TextSpan(
                        text: ("Your future GPA is: " +
                            ('${((snapshot.data.totalweightedgpapoints + total_weighted_points) / (snapshot.data.hours + total_credits)).toStringAsFixed(2)}')),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                new IconButton(
                  icon: new Icon(Icons.arrow_right),
                  color: Colors.white,
                  iconSize: 50.0,
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new GPA()),
                      (Route route) => route == null),
                )
              ],
            );
          }
        },
      ),

      //color: Colors.deepOrangeAccent,
      // child: new Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   // children: <Widget>[
      //   //   FutureBuilder(
      //   //               future: _getUser(),
      //   //               builder: (BuildContext context, AsyncSnapshot snapshot) {
      //   //   new Text("Your GPA is: ",style: new TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 50.0)),
      //   //   new Text((score.toStringAsFixed(score.truncateToDouble() == score ? 0 : 3)+ ),style: new TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 50.0)),
      //   //   new IconButton(
      //   //     icon: new Icon(Icons.arrow_right),
      //   //     color: Colors.white,
      //   //     iconSize: 50.0,
      //   //     onPressed: ()=>Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder:(BuildContext context)=>new GPA()), (Route route)=>route==null),
      //   //   )
      //   //               })
      //   // ],
      // )
    );
  }
}

final storage = new FlutterSecureStorage();

class Student {
  final String firstname;
  final String lastname;
  final String email;
  final double gpa;
  final double totalweightedgpapoints;
  final String catalogyear;
  final String classification;
  final int hours;
  final int advancedhours;
  final int advancedcshours;

  Student(
    this.firstname,
    this.lastname,
    this.email,
    this.gpa,
    this.totalweightedgpapoints,
    this.catalogyear,
    this.classification,
    this.hours,
    this.advancedcshours,
    this.advancedhours,
  );
}

Future<Student> _getUser() async {
  var response = await http.get("$address/MyInfo", headers: {
    HttpHeaders.authorizationHeader:
        "Bearer ${await storage.read(key: "token")}"
  });

  if (response.statusCode != 200) return null;

  var data = json.decode(response.body);

  print("return the JSON of info ==> $data");

  String classification = "null";

  if (data["Hours"] != null) {
    if (data["Hours"] < 90) classification = "Junior";
    if (data["Hours"] < 60) classification = "Sophmore";
    if (data["Hours"] < 30) classification = "Freshman";
    if (data["Hours"] > 90) classification = "Senior";
  }
  Student student = Student(
    data["FirstName"],
    data["LastName"],
    data["Email"],
    data["GPA"],
    data["TotalWeightedGPApoints"],
    data["CatalogYear"],
    classification,
    data["Hours"],
    data["AdvancedCsHours"],
    data["AdvancedHours"],
  );

  return student;
}
