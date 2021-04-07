import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:seniordesign/globals/globals.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:percent_indicator/percent_indicator.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:vertical_tabs/vertical_tabs.dart';

class TabBarDemo extends StatefulWidget {
  //TabBarDemo({Key key, this.title}) : super(key: key);

  //final String title;

  @override
  _TabBarDemoState createState() => new _TabBarDemoState();
}

bool checkBoxValue = false;
class _TabBarDemoState extends State<TabBarDemo> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = 2;
    double deviceHeight = 5;
    return MaterialApp(
      
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: background,
          appBar: AppBar(
            backgroundColor: background,
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.pie_chart_outline_outlined),
                  text: "Overview",
                ),
                Tab(icon: Icon(Icons.edit_outlined), text: "Courses"),
                Tab(
                    icon: Icon(Icons.settings_applications_outlined),
                    text: "Account"),
              ],
            ),
            title: Text('Degree Audit'),
            
          ),
          body: TabBarView(
            children: [
              ListView(
                children: [
                  Container(
                    //The First container for STUDENT INFORMATION!
                    decoration: BoxDecoration(color: Color(0xff65646a)),
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
                          return Container(
                            // width: 600,
                            // height: 600,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  //color: Color(0xffebebe8),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [background, background]),
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: (Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                text: 'Student Name: ',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${snapshot.data.firstname} ${snapshot.data.lastname}\n',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              TextSpan(
                                                text: 'GPA: ',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              TextSpan(
                                                text: '${snapshot.data.gpa}\n',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              TextSpan(
                                                text: '\nCatalog Year: ',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${snapshot.data.catalogyear}\n',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              TextSpan(
                                                text: 'Classification: ',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              TextSpan(
                                                text: '${snapshot.data.classification}\n',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              TextSpan(
                                                text: 'Total Hours: ',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              TextSpan(
                                                text: '${snapshot.data.hours}\n',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              // TextSpan(
                                              //   text: 'Advanced Hours:      ',
                                              //   style: TextStyle(
                                              //       color: Colors.black
                                              //           .withOpacity(0.5)),
                                              // ),
                                              // TextSpan(
                                              //   text:
                                              //       '${snapshot.data.advancedhours}\n',
                                              //   style: TextStyle(
                                              //       color: Colors.black
                                              //           .withOpacity(1.0)),
                                              // ),
                                              // TextSpan(
                                              //   text: 'Advanced cs Hours  ',
                                              //   style: TextStyle(
                                              //       color: Colors.black
                                              //           .withOpacity(0.5)),
                                              // ),
                                              // TextSpan(
                                              //   text:
                                              //       '${snapshot.data.advancedcshours}\n',
                                              //   style: TextStyle(
                                              //       color: Colors.black
                                              //           .withOpacity(1.0)),
                                              // ),
                                            ],
                                          ),
                                        ),

                                        ///Here
                                      ])),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(1),
                                  child: new CircularPercentIndicator(
                                    radius: 180.0,
                                    lineWidth: 25.0,
                                    animation: true,
                                    percent: 3 / 125,
                                    center: new Text(
                                      "${3 / 125 * 100}%",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: utrgv_orange,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              ////////////////
              // Row(
              //   children: [
              VerticalTabs(
                backgroundColor: background,
                tabBackgroundColor: background,
                selectedTabBackgroundColor: utrgv_orange,
                tabsWidth: 150,
                tabTextStyle: new TextStyle(fontWeight: FontWeight.bold),
                selectedTabTextStyle: TextStyle(
                    fontSize: 100,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold),
                tabs: <Tab>[
                  Tab(child: Text('CS Core')),
                  Tab(child: Text('CS Elect')),
                  Tab(child: Text('General Core')),
                  Tab(child: Text('Supported Courses')),
                  Tab(child: Text('Complete Courses')),
                  Tab(child: Text('Planned Courses'))
                ],
                contents: <Widget>[
                  ListView(children: [
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                              //color: Color(0xffcf4411),
                              fontWeight: FontWeight.bold,
                              height: deviceHeight * 0.3,
                              fontSize: deviceHeight * 1.8),
                          children: <TextSpan>[
                            TextSpan(
                                text: "MAJOR REQUIREMENTS - 50 HOURS",
                                style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ]),
                    ),
                    Card(
                      color: Color(0xffebebe8),

                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Introduction to Computer Science'),
                        subtitle: Text('CSCI 1101'),
                        trailing: Checkbox(
                          value: checkBoxValue,
                          onChanged: (bool value){
                            print(value);
                            setState((){
                              checkBoxValue = value;
                            });
                          }
                        ),
                        
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "CSCI 1101 Introduction to Computer Science");
                          print(await storage.read(key: "CourseName"));
                        
                         
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Engineering Computer Science I Lab '),
                        subtitle: Text('CSCI 1170'),
                        trailing: Icon(Icons.check_box_outline_blank,
                            color: Colors.grey),
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "CSCI 1170 Engineering Computer Science I Lab");
                          print(await storage.read(key: "CourseName"));
                         
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text(' Engineering Computer Science I'),
                        subtitle: Text('CSCI 1370'),
                        trailing: Icon(Icons.check_box_outline_blank,
                            color: Colors.grey),
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "CSCI 1370 Engineering Computer Science I");
                          print(await storage.read(key: "CourseName"));
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title:
                            Text('Computer Organization and Assembly Language'),
                        subtitle: Text('CSCI 2333'),
                        trailing: Icon(Icons.check_box_outline_blank,
                            color: Colors.grey),
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "CSCI 2333 Computer Organization and Assembly Language");
                          print(await storage.read(key: "CourseName"));
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Programming in UNIX / Linux Environment'),
                        subtitle: Text('CSCI 2344'),
                        trailing: Icon(Icons.check_box_outline_blank,
                            color: Colors.grey),
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "CSCI 2344 Programming in UNIX / Linux Environment");
                          print(await storage.read(key: "CourseName"));
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Computer Science II'),
                        subtitle: Text('CSCI 2380'),
                        trailing: Icon(Icons.check_box_outline_blank,
                            color: Colors.grey),
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "CSCI 2380 Computer Science II");
                          print(await storage.read(key: "CourseName"));
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text(
                            'Mathematical Foundations of Computer Science'),
                        subtitle: Text('CSCI 3310'),
                        trailing: Icon(Icons.check_box_outline_blank,
                            color: Colors.grey),
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "CSCI 3310 Mathematical Foundations of Computer Science");
                          print(await storage.read(key: "CourseName"));
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Algorithms and Data Structures'),
                        subtitle: Text('CSCI 3333'),
                        trailing: Icon(Icons.check_box_outline_blank,
                            color: Colors.grey),
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "CSCI 3333 Algorithms and Data Structures");
                          print(await storage.read(key: "CourseName"));
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Organization of Programming Languages'),
                        subtitle: Text('CSCI 3336'),
                        trailing: Icon(Icons.check_box_outline_blank,
                            color: Colors.grey),
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "CSCI 3336 Organization of Programming Languages");
                          print(await storage.read(key: "CourseName"));
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Software Engineering I'),
                        subtitle: Text('CSCI 3340'),
                        trailing: Icon(Icons.check_box_outline_blank,
                            color: Colors.grey),
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "CSCI 3340 Software Engineering I");
                          print(await storage.read(key: "CourseName"));
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text(
                            'Automata, Formal Languages, and Computability'),
                        subtitle: Text('CSCI 4325'),
                        trailing: Icon(Icons.check_box_outline_blank,
                            color: Colors.grey),
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "CSCI 4325 Automata, Formal Languages, and Computability");
                          print(await storage.read(key: "CourseName"));
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Senior Project'),
                        subtitle: Text('CSCI 4390'),
                        trailing: Icon(Icons.check_box_outline_blank,
                            color: Colors.grey),
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "CSCI 4390 Senior Project");
                          print(await storage.read(key: "CourseName"));
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    ),
                  ]),
                  ListView(children: [
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                              //color: Color(0xffcf4411),
                              fontWeight: FontWeight.bold,
                              height: deviceHeight * 0.3,
                              fontSize: deviceHeight * 1.8),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Computer Science Electives",
                                style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ]),
                    ),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                              //color: Color(0xffcf4411),
                              fontWeight: FontWeight.bold,
                              height: deviceHeight * 0.2,
                              fontSize: deviceHeight * 1.2),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Programming Language",
                                style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ]),
                    ),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                              //color: Color(0xffcf4411),
                              fontWeight: FontWeight.bold,
                              height: deviceHeight * 0.15,
                              fontSize: deviceHeight * 1.1),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Choose from:",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ]),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Object Oriented Programming in JAVA'),
                        subtitle: Text('CSCI 3326'),
                        trailing: Icon(Icons.check_box_outline_blank,
                            color: Colors.grey),
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "CSCI 3326 Object Oriented Programming in JAVA");
                          print(await storage.read(key: "CourseName"));
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title:
                            Text('Object Oriented Programming in Visual Basic'),
                        subtitle: Text('CSCI 3327'),
                        trailing: Icon(Icons.check_box_outline_blank,
                            color: Colors.grey),
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "CSCI 3327 Object Oriented Programming in Visual Basic");
                          print(await storage.read(key: "CourseName"));
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Object Oriented Programming in C#'),
                        subtitle: Text('CSCI 3328'),
                        trailing: Icon(Icons.check_box_outline_blank,
                            color: Colors.grey),
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "CSCI 3328 Object Oriented Programming in C#");
                          print(await storage.read(key: "CourseName"));
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                              //color: Color(0xffcf4411),
                              fontWeight: FontWeight.bold,
                              height: deviceHeight * 0.3,
                              fontSize: deviceHeight * 2.1),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    "Databases, Networking, and Operating Systems",
                                style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ]),
                    ),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                              //color: Color(0xffcf4411),
                              fontWeight: FontWeight.bold,
                              height: deviceHeight * 0.15,
                              fontSize: deviceHeight * 1.1),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Choose 2 from:",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ]),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Database Design and Implementation'),
                        subtitle: Text('CSCI 4333'),
                        trailing: Icon(Icons.check_box_outline_blank,
                            color: Colors.grey),
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "CSCI 4333 Database Design and Implementation");
                          print(await storage.read(key: "CourseName"));
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Operating Systems'),
                        subtitle: Text('CSCI 4334'),
                        trailing: Icon(Icons.check_box_outline_blank,
                            color: Colors.grey),
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "CSCI 4334 Operating Systems");
                          print(await storage.read(key: "CourseName"));
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Computer Architecture'),
                        subtitle: Text('CSCI 4335'),
                        trailing: Icon(Icons.check_box_outline_blank,
                            color: Colors.grey),
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "CSCI 4335 Computer Architecture");
                          print(await storage.read(key: "CourseName"));
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Computer Networks'),
                        subtitle: Text('CSCI 4345'),
                        trailing: Icon(Icons.check_box_outline_blank,
                            color: Colors.grey),
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "CSCI 4345 Computer Networks");
                          print(await storage.read(key: "CourseName"));
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                              //color: Color(0xffcf4411),
                              fontWeight: FontWeight.bold,
                              height: deviceHeight * 0.2,
                              fontSize: deviceHeight * 2.1),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Technical Electives",
                                style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ]),
                    ),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                              //color: Color(0xffcf4411),
                              fontWeight: FontWeight.bold,
                              height: deviceHeight * 0.15,
                              fontSize: deviceHeight * 1.1),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Choose 3 from:",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ]),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Computer Architecture'),
                        subtitle: Text('CSCI 3341'),
                        trailing: Icon(Icons.check_box_outline_blank,
                            color: Colors.grey),
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "CSCI 3341 Computer Architecture");
                          print(await storage.read(key: "CourseName"));
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Internship in Computer Science'),
                        subtitle: Text('CSCI 3300'),
                        trailing: Icon(Icons.check_box_outline_blank,
                            color: Colors.grey),
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "CSCI 3300 Internship in Computer Science");
                          print(await storage.read(key: "CourseName"));
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Internet Programming'),
                        subtitle: Text('CSCI 3342'),
                        trailing: Icon(Icons.check_box_outline_blank,
                            color: Colors.grey),
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "CSCI 3342 Internet Programming");
                          print(await storage.read(key: "CourseName"));
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    )
                  ]),
                  ListView(children: [
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                              //color: Color(0xffcf4411),
                              fontWeight: FontWeight.bold,
                              height: deviceHeight * 0.3,
                              fontSize: deviceHeight * 1.8),
                          children: <TextSpan>[
                            TextSpan(
                                text: "General Core",
                                style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ]),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Digital Systems Engineering I'),
                        subtitle: Text('ELEE 2330'),
                        trailing: Icon(Icons.check_box_outline_blank,
                            color: Colors.grey),
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "EELE 2330 Digital Systems Engineering I");
                          print(await storage.read(key: "CourseName"));
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    ),
                  ]),
                  ListView(children: [
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                              //color: Color(0xffcf4411),
                              fontWeight: FontWeight.bold,
                              height: deviceHeight * 0.3,
                              fontSize: deviceHeight * 1.8),
                          children: <TextSpan>[
                            TextSpan(
                                text: "SUPPORTED COURSES - 32 HOURS",
                                style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ]),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Technical Communication'),
                        subtitle: Text('ENGL 3342'),
                        trailing: Icon(Icons.check_circle, color: Colors.green),
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "ENGL 3342 Technical Communication");
                          print(await storage.read(key: "CourseName"));
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: ListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Digital Systems Engineering I Lab'),
                        subtitle: Text('ELEE 2130'),
                        trailing: Icon(Icons.check_box_outline_blank,
                            color: Colors.red),
                        onTap: () async {
                          await storage.write(
                              key: "CourseName",
                              value: "ELEE 2130 Digital Systems Engineering I Lab");
                          print(await storage.read(key: "CourseName"));
                          showDialog(
                            context: context,
                            builder: (_) => EditPopUp(),
                          );
                        },
                      ),
                    ),
                  ]),
                  ListView(children: [
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                              //color: Color(0xffcf4411),
                              fontWeight: FontWeight.bold,
                              height: deviceHeight * 0.3,
                              fontSize: deviceHeight * 1.8),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Completed Courses",
                                style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ]),
                    ),
                    Container(
                                      //The THIRD CONTAINER FOR  COURSES
                        decoration: BoxDecoration(color: Color(0xff65646a)),
                        child: FutureBuilder(
                          future: _getStudentCourses(),
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
                              return Container(
                                width: deviceWidth * 100,
                                height: deviceHeight * 135,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.fromLTRB(deviceWidth * 1,
                                          deviceHeight * 1, deviceWidth * 1, deviceHeight * 1),
                                      //color: Color(0xffebebe8),
                                      width: deviceWidth * 127,
                                      height: deviceHeight * 135,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [Color(0xffebebe8), Color(0xffebebe8)]),
                                        borderRadius: BorderRadius.circular(6.0),
                                      ),
                                      child: ListView.builder(
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (BuildContext context, int i) {
                                          return RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    color: Color(0xffcf4411),
                                                    fontWeight: FontWeight.bold,
                                                    height: deviceHeight * 0.2,
                                                    fontSize: deviceHeight * 2.28),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text:  "${snapshot.data[i].courseDept} ",
                                                    style: TextStyle(
                                                        color: Colors.black.withOpacity(0.7)),
                                                  ),
                                                  TextSpan(
                                                    text:  "${snapshot.data[i].courseNum}",
                                                    style: TextStyle(
                                                        color: Colors.black.withOpacity(0.7)),
                                                  ),
                                                  TextSpan(
                                                    text:  "\n${snapshot.data[i].name}",
                                                    style: TextStyle(
                                                        color: Colors.black.withOpacity(0.5)),
                                                  ),
                                                  TextSpan(
                                                    text:  "\n Grade: ${snapshot.data[i].grade}  Semester: ${snapshot.data[i].semester}",
                                                    style: TextStyle(
                                                        color: Colors.black.withOpacity(1.0)),
                                                  ),
                                                  TextSpan(
                                                    text:  "\n",
                                                    style: TextStyle(
                                                        color: Colors.black.withOpacity(1.0)),
                                                  ),
                                                ]),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                    )
                  ]),
                  ListView(children: [
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                              //color: Color(0xffcf4411),
                              fontWeight: FontWeight.bold,
                              height: deviceHeight * 0.3,
                              fontSize: deviceHeight * 1.8),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Planned Courses",
                                style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ]),
                    ),
                    
                    
                  ]),
                ],
              ),
              //],
              //),

              /////////////////
              SettingsList(
                sections: [
                  SettingsSection(
                    title: 'User',
                    tiles: [
                      SettingsTile(
                        title: 'Language',
                        subtitle: 'English',
                        leading: Icon(Icons.language),
                        onTap: () {},
                      ),
                      SettingsTile(
                        title: 'Change Name',
                        subtitle: '',
                        leading: Icon(Icons.edit_off),
                        onTap: () {},
                      ),
                      SettingsTile(
                        title: 'Change Password',
                        subtitle: '****',
                        leading: Icon(Icons.edit_off),
                        onTap: () {},
                      ),
                      SettingsTile(
                        title: 'Change Email',
                        subtitle: '****@utrgv.edu',
                        leading: Icon(Icons.email),
                        onTap: () {},
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: 'App',
                    tiles: [
                      SettingsTile.switchTile(
                        title: 'Enable Location Access',
                        leading: Icon(Icons.gps_fixed_outlined),
                        switchValue: true,
                        onToggle: (bool value) {},
                      ),
                      SettingsTile.switchTile(
                        title: 'Light Mode',
                        leading: Icon(Icons.lightbulb),
                        switchValue: false,
                        onToggle: (bool value) {},
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: 'Account',
                    tiles: [
                      SettingsTile(
                        title: 'Logout',
                        leading: Icon(Icons.logout),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final storage = new FlutterSecureStorage();

class Student {
  final String firstname;
  final String lastname;
  final String email;
  final double gpa;
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
      this.catalogyear,
      this.classification,
      this.hours,
      this.advancedcshours,
      this.advancedhours);
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
      data["CatalogYear"],
      classification,
      data["Hours"],
      data["AdvancedCsHours"],
      data["AdvancedHours"]);

  return student;
}

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}

class EditPopUp extends StatefulWidget {
  @override
  String message = "hi";

  State<StatefulWidget> createState() => EditPopUpState();
}

class EditPopUpState extends State<EditPopUp>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double deviceWidth = SizeConfig.blockSizeHorizontal;
    double deviceHeight = SizeConfig.blockSizeVertical;
    String dropdownValueForGrade = 'A';
    String dropDownValueForSemester = "Fall";
    String newValueForGrade = 'null';
    String dropdownValueForCompleteness ='Incomplete';
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            width: deviceWidth * 95,
            height: deviceHeight * 50,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: ListView(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: Color(0xffcf4411),
                        fontWeight: FontWeight.bold,
                        height: deviceHeight * 0.2,
                        fontSize: deviceHeight * 2.28),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Letter Grade:',
                        style: TextStyle(color: Colors.black.withOpacity(0.5)),
                        
                      )
                    ],
                  ),
                ),
                DropdownButton<String>(
                  value: dropdownValueForGrade,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.black),
                  onChanged: (newValueForGrade) {
                    setState(() async {
                      dropdownValueForGrade = newValueForGrade;
                      await storage.write(
                          key: "CourseGrade", value: "$newValueForGrade");
                      print(await storage.read(key: "CourseGrade"));
                    });
                  },
                  items: <String>['A', 'B', 'C', 'D', 'F', 'W', 'DR', 'P', 'NP']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                //************************FOR SEMESTER********************** */
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: Color(0xffcf4411),
                        fontWeight: FontWeight.bold,
                        height: deviceHeight * 0.2,
                        fontSize: deviceHeight * 2.28),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Semester:',
                        style: TextStyle(color: Colors.black.withOpacity(0.5)),
                      )
                    ],
                  ),
                ),
                DropdownButton<String>(
                  value: dropDownValueForSemester,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.black),
                  onChanged: (newValueForSemester) {
                    setState(() async {
                      dropDownValueForSemester = newValueForSemester;
                      await storage.write(
                          key: "CourseSemester", value: "$newValueForSemester");
                      print(await storage.read(key: "CourseSemester"));
                    });
                  },
                  items: <String>['Fall', 'Spring', 'Summer I', 'Summer II']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: Color(0xffcf4411),
                        fontWeight: FontWeight.bold,
                        height: deviceHeight * 0.2,
                        fontSize: deviceHeight * 2.28),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Status:',
                        style: TextStyle(color: Colors.black.withOpacity(0.5)),
                      )
                    ],
                  ),
                ),
                DropdownButton<String>(
                  value: dropdownValueForCompleteness,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.black),
                  onChanged: (newValueForCompleteness) {
                    setState(() async {
                      dropdownValueForCompleteness = newValueForCompleteness;
                      await storage.write(
                          key: "CourseCompleteness", value: "$newValueForCompleteness");
                      print(await storage.read(key: "CourseCompleteness"));
                    });
                  },
                  items: <String>['Complete', 'Incomplete']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(deviceHeight * 1,
                          deviceHeight * 1, deviceWidth * 1, deviceWidth * 1),
                      child: NiceButton(
                        width: deviceWidth * 35,
                        elevation: 8.0,
                        radius: 52.0,
                        text: "Add\n Course",
                        fontSize: deviceHeight * 2,
                        background: Color(0xffcf4411),
                        onPressed: () async {
                          await addCourse();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(deviceHeight * 1,
                          deviceHeight * 1, deviceWidth * 1, deviceWidth * 1),
                      child: NiceButton(
                        width: deviceWidth * 35,
                        elevation: 8.0,
                        radius: 52.0,
                        text: "Remove \nCourse",
                        fontSize: deviceHeight * 2,
                        background: Color(0xffcf4411),
                        onPressed: () async {
                          await delCourse();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(deviceHeight * 1,
                          deviceHeight * 1, deviceWidth * 1, deviceWidth * 1),
                      child: NiceButton(
                        width: deviceWidth * 35,
                        elevation: 8.0,
                        radius: 52.0,
                        text: "Add\nPlanned Course",
                        fontSize: deviceHeight * 2,
                        background: Color(0xffcf4411),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(deviceHeight * 1,
                          deviceHeight * 1, deviceWidth * 1, deviceWidth * 1),
                      child: NiceButton(
                        width: deviceWidth * 35,
                        elevation: 8.0,
                        radius: 52.0,
                        text: "Remove \nPlanned Course",
                        fontSize: deviceHeight * 2,
                        background: Color(0xffcf4411),
                        onPressed: () async {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<int> addCourse() async {
  var response = await http.post(
      "$address/selfadd/StudentCourses?Semester=${await storage.read(key: "CourseSemester")}&Grade=${await storage.read(key: "CourseGrade")}&CourseCompleteness=${await storage.read(key: "CourseCompleteness")}&CourseName=${await storage.read(key: "CourseName")}",
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer ${await storage.read(key: "token")}"
      });
  print(
      "$address/selfadd/StudentCourses?Semester=${await storage.read(key: "CourseSemester")}&Grade=${await storage.read(key: "CourseGrade")}&CourseCompleteness=${await storage.read(key: "CourseCompleteness")}&Name=${await storage.read(key: "CourseName")}");
  print(
      "This is the response status code for addCourse() = ${response.statusCode}");
  return response.statusCode;
}

Future<int> delCourse() async {
  var response = await http.delete(
      "$address/remove/StudentCourse?CourseName=${await storage.read(key: "CourseName")}",
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer ${await storage.read(key: "token")}"
      });
  print(
      "This is the response status code for delCourse() = ${response.statusCode}");
  return response.statusCode;
}

class Course {
  final int courseID;
  final String courseDept;
  final int courseNum;
  final String name;
  final String institution;
  final String grade;
  final String semester;
  //final bool taken;

  Course(this.courseID, this.courseDept, this.courseNum, this.name,
      this.institution, this.grade, this.semester);
}

Future<List<Course>> _getStudentCourses() async {
  String studentId;
  studentId = await storage.read(key: "studentId");
  var response = await http.get("$address/CompleteCourses?Email=$studentId",
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer ${await storage.read(key: "token")}"
      });

  if (response.statusCode != 200) return null;

  var data = json.decode(response.body);

  List<Course> courses = [];

  for (var i in data) {
    if (i["Grade"] != "n") {
      Course course = Course(i["CourseID"], i["CourseDept"], i["CourseNum"],
          i["Name"], i["Intstitution"], i["Grade"], i["Semester"]);

      courses.add(course);
    }
  }

  return courses;
}