import 'dart:convert';
import 'dart:io';
import 'package:pdf_render/pdf_render_widgets.dart';


import './gpa_calc.dart';
import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:seniordesign/globals/globals.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:vertical_tabs/vertical_tabs.dart';
import 'package:flutter/src/material/checkbox_list_tile.dart';

class TabBarDemo extends StatefulWidget {
  //TabBarDemo({Key key, this.title}) : super(key: key);

  //final String title;

  @override
  _TabBarDemoState createState() => new _TabBarDemoState();
}
final Set _saved = Set();
List<bool> checkBox = [false, false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false];

class _TabBarDemoState extends State<TabBarDemo> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = 2;
    double deviceHeight = 5;
    return MaterialApp(
      
      home: DefaultTabController(
        length: 4,
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
                Tab(icon: Icon(Icons.contact_page_outlined), text: "Resources"),
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
                    //
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
                                                text: '${double.parse((snapshot.data.gpa).toStringAsFixed(2))}\n',
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
                                    percent: snapshot.data.hours / 125,
                                    center: new Text(
                                      "${(snapshot.data.hours / 125 * 100).round()}%",
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
                      
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Introduction to Computer Science'),
                        subtitle: Text('CSCI 1101'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[0],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[0] = value;
                            
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Introduction to Computer Science");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Engineering Computer Science I Lab '),
                        subtitle: Text('CSCI 1170'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[1],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[1] = value;
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Engineering Computer Science I Lab");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Engineering Computer Science I'),
                        subtitle: Text('CSCI 1370'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[2],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[2] = value;
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Engineering Computer Science I");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Computer Organization and Assembly Language'),
                        subtitle: Text('CSCI 2333'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[3],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[3] = value;
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Computer Organization and Assembly Language");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
                      ),
                      
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Programming in UNIX / Linux Environment'),
                        subtitle: Text('CSCI 2344'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[4],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[4] = value;
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Programming in UNIX / Linux Environment");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Computer Science II'),
                        subtitle: Text('CSCI 2380'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[5],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[5] = value;
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Computer Science II");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
                      ),
                      
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Mathematical Foundations of Computer Science'),
                        subtitle: Text('CSCI 3310'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[6],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[6] = value;
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Mathematical Foundations of Computer Science");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Algorithms and Data Structures'),
                        subtitle: Text('CSCI 3333'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[7],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[7] = value;
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Algorithms and Data Structures");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Organization of Programming Languages'),
                        subtitle: Text('CSCI 3336'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[8],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[8] = value;
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Organization of Programming Languages");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Software Engineering I'),
                        subtitle: Text('CSCI 3340'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[9],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[9] = value;
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Software Engineering I");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Automata, Formal Languages, and Computability'),
                        subtitle: Text('CSCI 4325'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[10],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[10] = value;
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Automata, Formal Languages, and Computability");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Senior Project'),
                        subtitle: Text('CSCI 4390'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[11],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[11] = value;
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Senior Project");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
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
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Object Oriented Programming in JAVA'),
                        subtitle: Text('CSCI 3326'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[12],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[12] = value;
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Object Oriented Programming in JAVA");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Object Oriented Programming in Visual Basic'),
                        subtitle: Text('CSCI 3327'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[13],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[13] = value;
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Object Oriented Programming in Visual Basic");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Object Oriented Programming in C#'),
                        subtitle: Text('CSCI 3328'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[14],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[14] = value;
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Object Oriented Programming in C#");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
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
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Database Design and Implementation'),
                        subtitle: Text('CSCI 4333'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[15],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[15] = value;
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Database Design and Implementation");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Operating Systems'),
                        subtitle: Text('CSCI 4334'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[16],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[16] = value;
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Operating Systems");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Computer Architecture'),
                        subtitle: Text('CSCI 4335'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[17],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[17] = value;
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Computer Architecture");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Computer Networks'),
                        subtitle: Text('CSCI 4345'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[18],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[18] = value;
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Computer Networks");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
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
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Computer Architecture'),
                        subtitle: Text('CSCI 3341'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[19],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[19] = value;
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Computer Architecture");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Internship in Computer Science'),
                        subtitle: Text('CSCI 3300'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[20],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[20] = value;
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Internship in Computer Science");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Internet Programming'),
                        subtitle: Text('CSCI 3342'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[21],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[21] = value;
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Internet Programming");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
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
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Digital Systems Engineering I'),
                        subtitle: Text('ELEE 2380'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[22],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[22] = value;
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Digital Systems Engineering I");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
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
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Technical Communication'),
                        subtitle: Text('ENGL 3342'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[23],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[23] = value;
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Technical Communication");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
                      ),
                    ),
                    Card(
                      color: Color(0xffebebe8),
                      child: CheckboxListTile(
                        //leading: FlutterLogo(size: 56.0),
                        title: Text('Digital Systems Engineering I Lab'),
                        subtitle: Text('ELEE 2130'),
                        controlAffinity: 
                          ListTileControlAffinity.trailing,
                        value: checkBox[24],
                        onChanged: (bool value) async {
                          setState((){
                            checkBox[24] = value;
                          });
                            await storage.write(
                                key: "CourseName",
                                value: "Digital Systems Engineering I Lab");
                            print(await storage.read(key: "CourseName"));
                          
                            showDialog(
                              context: context,
                              builder: (_) => EditPopUp(),
                            );
                          

                        },
                          activeColor: Colors.green,
                          checkColor: Colors.black,
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
                     //////////////////Container for Complete Courses////////////////////////////
                     ///All the classes that are being added will show up here
                    Container(
                                      
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
                    Container(
                                      
                        decoration: BoxDecoration(color: Color(0xff65646a)),
                        child: FutureBuilder(
                          future: _getPlannedFutureCourses(),
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
                                                    text:  "\n Semester: ${snapshot.data[i].semester}",
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
                ],
              ),
                 ListView(
                children: <Widget>[
                  ListTile(
                    title: Text('Road Map to graduation'),
                    subtitle: Text('Undergraduate Degree Plan'),
                    tileColor: Colors.white,
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Roadmap()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Future GPA calculator'),
                    subtitle: Text('Calculates future GPA according to current GPA'),
                    tileColor: Colors.white,
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GPA()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Schedule an appointment'),
                    subtitle: Text('Schedule an appointment with an advisor'),
                    tileColor: Colors.white,
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      print('Star');
                    },
                  ),
                  ListTile(
                    title: Text('Contact'),
                    subtitle: Text('Department information'),
                    tileColor: Colors.white,
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Contact()),
                      );
                    },
                  ),
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
            height: deviceHeight * 60,
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
                        text: 'To add a complete course choose a semester, grade, and the status complete. To add a planned course choose a semester and the status incomplete. ',
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
                          await addPlannedCourse();
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
                        onPressed: () async {
                          await delPlannedCourse();
                          Navigator.pop(context);
                        },
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
class Roadmap extends StatefulWidget {
  //  Roadmap({Key key, this.title}) : super(key: key);
  // final String title;
  @override
  RoadmapState createState() => new RoadmapState();
}

class RoadmapState extends State<Roadmap> {
  bool _isLoading = true;
  PDFDocument doc;

  void _loadFromAssets() async {
    setState(() {
      _isLoading = true;
    });
    doc = await PDFDocument.fromAsset('assets/images/flowchart.pdf');
    setState(() {
      _isLoading = false;
    });
  }
  void flow_chart_loadFromUrl() async {
    setState(() {
      _isLoading = true;
    });
    doc = await PDFDocument.fromURL(
        'https://www.utrgv.edu/csci/academics/undergraduate/degreeplan/flowchart.pdf');
    setState(() {
      _isLoading = false;
    });
  }

  void _loadFromUrl() async {
    setState(() {
      _isLoading = true;
    });
    doc = await PDFDocument.fromURL(
        'https://www.utrgv.edu/advising/_files/documents/roadmaps/2020/bscs_computer_science.pdf');
    setState(() {
      _isLoading = false;
    });
  }
  void _loadFromUrl2() async {
    setState(() {
      _isLoading = true;
    });
    doc = await PDFDocument.fromURL(
        'https://www.utrgv.edu/csci/_files/documents/2018_2019_computer_science_bscs.pdf');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: background,
          
        ),
        
            body: Center(
        child: Column(
         
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              
              flex: 8,
              
              child: _isLoading
                 ? CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white))
                  : PDFViewer(
                      document: doc,
                    ),
            ),
            Flexible(
              flex: 3,
            
              child: Padding(
                padding: const EdgeInsets.all(8.0),
              
                child: ListView(
              
                 /// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    
                     TextButton(
                      style: TextButton.styleFrom(
                      backgroundColor: utrgv_orange
                       ),
                      child: Text(
                        'Computer Science Flowchart 2020',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: flow_chart_loadFromUrl,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                      backgroundColor: utrgv_orange
                       ),
                      child: Text(
                        'Computer Science Roadmap 2020',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _loadFromUrl,
                    ),
                    TextButton(
                      style:
                          TextButton.styleFrom(backgroundColor: utrgv_orange),
                      child: Text(
                        'Computer Science Roadmap Basics 2020',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _loadFromUrl2,
                    ),
                   
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Contact';
    
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: background,
          title: Text(title),
        ),
        body: ListView(
          children: <Widget>[
            
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone'),
              subtitle: Text('Phone: 956-665-2320'),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text('Email: csci@utrgv.edu'),
            ),
          ],
        ),
      ),
    );
  }
}


class GPA extends StatefulWidget {
  @override
  GPAState createState() => new GPAState();
}
class GPAState extends State<GPA> {
  TextEditingController controller = new TextEditingController();
  int n;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(" Future GPA calculator"),
          backgroundColor: utrgv_orange),
      backgroundColor: background,
      body: new Container(
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.transparent, width: 25.0),
            color: Colors.transparent),
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
              return new ListView(
              
                children: <Widget>[
                  new Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    //Text("Current GPA: ${snapshot.data.gpa}"),
    //Text("Current Hours: ${snapshot.data.hours}"),
     TextButton(
                      style:
                          TextButton.styleFrom(backgroundColor: utrgv_orange),
                      child: Text(
                        "Current GPA: ${snapshot.data.gpa}",
                        style: TextStyle(color: Colors.white),
                        
                      ),
                      onPressed: (){}
                    ),
                    TextButton(
                      style:
                          TextButton.styleFrom(backgroundColor: utrgv_orange),
                      child: Text(
                        "Current Hours: ${snapshot.data.hours}",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: (){}
                    ),
   
  ],
),

                  new TextField(
                    textAlign: TextAlign.center,
                    autofocus: true,
                    decoration: new InputDecoration(
                        fillColor: Colors.deepOrangeAccent,
                        hintText: "Number of courses you want to take?",
                        hintStyle: new TextStyle(color: Colors.black54)),
                    keyboardType: TextInputType.number,
                    controller: controller,
                    onChanged: (String str) {
                      setState(() 
                      {
                        if (controller.text == "") n = 0;
                        n = int.parse(controller.text);
                      });
                    },
                  ),
                  new IconButton(
                    icon: new Icon(Icons.arrow_forward),
                    onPressed: () {
                      if (n is int && n > 0) {
                        int pass = n;
                        n = 0;
                        controller.text = "";
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new GPAcalc(pass)));
                      } else {
                        controller.text = "";
                        alert();
                      }
                    },
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
  Future<Null> alert() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('rewind and regret fool !'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('You think you are smart?.'),
                new Text('Guess what... you are not.'),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Regret'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
      "$address/selfadd/StudentCourses?Semester=${await storage.read(key: "CourseSemester")}&Grade=${await storage.read(key: "CourseGrade")}&CourseCompleteness=${await storage.read(key: "CourseCompleteness")}&CourseName=${await storage.read(key: "CourseName")}");
  print(
      "This is the response status code for addCourse() = ${response.statusCode}");
  return response.statusCode;
}

Future<int> addPlannedCourse() async {
  var response = await http.post(
      "$address/selfadd/PlannedCourses?Semester=${await storage.read(key: "CourseSemester")}&CourseName=${await storage.read(key: "CourseName")}",
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer ${await storage.read(key: "token")}"
      });
  print(
      "$address/selfadd/PlannedCourses?Semester=${await storage.read(key: "CourseSemester")}&CourseName=${await storage.read(key: "CourseName")}");
  print(
      "This is the response status code for addPlannedCourse() = ${response.statusCode}");
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

Future<int> delPlannedCourse() async {
  var response = await http.delete(
      "$address/remove/PlannedStudentCourse?CourseName=${await storage.read(key: "CourseName")}",
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer ${await storage.read(key: "token")}"
      });
  print(
      "This is the response status code for delPlannedCourse() = ${response.statusCode}");
  return response.statusCode;
}
//gets all the info to add class to the complete tab
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
//gets the student courses
Future<List<Course>> _getStudentCourses() async {
  String studentId;
  studentId = await storage.read(key: "studentId");
  //this request is on the api side of the app
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
class PlannedCourses {
  final int courseID;
  final String courseDept;
  final int courseNum;
  final String name;
  final String institution;
  final String grade;
  final String semester;
  //final bool taken;

  PlannedCourses(this.courseID, this.courseDept, this.courseNum, this.name,
      this.institution, this.grade, this.semester);
}
Future<List<PlannedCourses>> _getPlannedFutureCourses() async {
  String studentId;
  studentId = await storage.read(key: "studentId");
  //this request is on the api side of the app
  var response = await http.get("$address/PlannedFutureCourses?Email=$studentId",
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer ${await storage.read(key: "token")}"
      });

  if (response.statusCode != 200) return null;

  var data = json.decode(response.body);

  List<PlannedCourses> courses = [];

  for (var i in data) {
    if (i["Semester"] != "n") {
      PlannedCourses course = PlannedCourses(i["CourseID"], i["CourseDept"], i["CourseNum"],
          i["Name"], i["Intstitution"], i["Grade"], i["Semester"]);

      courses.add(course);
    }
  }

  return courses;
}