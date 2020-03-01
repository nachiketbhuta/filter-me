import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'checkbox.dart';

import 'search.dart';

final Color backgroundColor = Color(0xFF332940);
List data;
bool isdata = false;
bool setpref;
int page = 1;
List<dynamic> recommended;

class Home extends StatefulWidget {
  bool setpref = false;

  var setpreff;

  Home({this.setpreff});
  @override
  _HomeState createState() => _HomeState(setpref);
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  bool setpref = false;

  _HomeState(this.setpref);
  final url = "https://c7bed7c6.ngrok.io/profiles";
  Future<void> request() async {
    var response = await http.get(
      Uri.encodeFull(url),
    );
    print(response.body);
    setState(() {
      var extractdata = json.decode(response.body);
      data = extractdata["data"];
    });

    print(data[0]["name"]);

    if (response.statusCode == 200) {
      setState(() {
        isdata = true;
        print('UI Updated');
      });
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
    print(isdata);
  }

  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    this.request();
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    print("D");
                  },
                  child: Text("Dashboard",
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                ),
                SizedBox(height: 10),
                FlatButton(
                  onPressed: () {
                    print("P");
                    Navigator.push(
                      (context),
                      MaterialPageRoute(
                        builder: (context) {
                          return CheckBoxScreen();
                        },
                      ),
                    );
                  },
                  child: Text("Profile",
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                ),
                SizedBox(height: 10),
                FlatButton(
                  onPressed: () {
                    print("H");
                    Navigator.push(
                      (context),
                      MaterialPageRoute(
                        builder: (context) {
                          return HomePage();
                        },
                      ),
                    );
                  },
                  child: Text("Hire",
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: backgroundColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 5), //set statusbar distance here.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 20, 20, 20),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.menu, color: Colors.white, size: 25),
                              IconButton(
                                icon: Icon(Icons.search, color: Colors.white),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                  );
                                  print("search");
                                },
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            if (isCollapsed)
                              _controller.forward();
                            else
                              _controller.reverse();

                            isCollapsed = !isCollapsed;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 1.0),
                        child: Text("Current Applicants",
                            style:
                                TextStyle(fontSize: 24, color: Colors.white)),
                      ),
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          request();
                          setState(() {
                            isdata = false;
                          });
                        },
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 220,
                    child: PageView(
                      controller: PageController(
                        viewportFraction: 0.9,
                      ),
                      scrollDirection: Axis.horizontal,
                      pageSnapping: true,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {
                                print("pressed1");
                                setState(() {
                                  page = 1;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 8),
                                child: ClipRect(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/undraw_businessman_97x4.png"),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(160, 70, 40, 10),
                                child: Text(
                                  "Applicants",
                                  style: TextStyle(
                                      color: backgroundColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: <Widget>[
                            FlatButton(
                              onPressed: () async {
                                List<dynamic> recommended =
                                    await Navigator.push(
                                  (context),
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CheckBoxScreen();
                                    },
                                  ),
                                );

                                print("Home");
                                print(recommended);
                                print(recommended[0]);
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 170),
                                    child: SpinKitRing(
                                      color: Colors.white,
                                      lineWidth: 3,
                                      size: 40.0,
                                      controller: AnimationController(
                                          vsync: this,
                                          duration: const Duration(
                                              milliseconds: 1200)),
                                    ),
                                  ),
                                );
                                print("pressed2");
                                setState(() {
                                  page = 2;
                                });
                                print(recommended);
                              },
                              child: Container(
                                child: ClipRect(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/undraw_friends_online_klj6.png"),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 90, vertical: 10),
                                child: Text(
                                  "For You",
                                  style: TextStyle(
                                      color: backgroundColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  page == 1
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                "Applicants",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0, right: 20),
                              child: Text(
                                "Exp.",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ],
                        )
                      : Text(
                          "For You",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                  !isdata
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 170),
                            child: SpinKitRing(
                              color: Colors.white,
                              lineWidth: 3,
                              size: 40.0,
                              controller: AnimationController(
                                  vsync: this,
                                  duration: const Duration(milliseconds: 1200)),
                            ),
                          ),
                        )
                      : Container(
                          height: 450,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, index) {
                                return ListTile(
                                  title: Container(
                                    margin: EdgeInsets.all(6),
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 3),
                                      child: Text(
                                        data[index]["name"],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  subtitle: Row(
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromRGBO(
                                                108, 99, 255, 1.0),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  1000.0) //                 <--- border radius here
                                              ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 6),
                                          child: Text(
                                            data[index]["skills"][0],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromRGBO(
                                                200, 12, 97, 1.0),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  1000.0) //                 <--- border radius here
                                              ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 6),
                                          child: Text(
                                            data[index]["skills"][1],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                            Color.fromRGBO(108, 99, 255, 1.0),
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              1000.0) //                 <--- border radius here
                                          ),
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      child: Text(
                                        data[index]["experience"].toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: data == null ? 0 : data.length),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
