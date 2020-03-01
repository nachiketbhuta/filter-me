import 'package:flutter/material.dart';

import 'home.dart';

final Color backgroundColor = Color(0xFF332940);

class RecommendationPage extends StatefulWidget {
  List<dynamic> recommenddata;
  List<dynamic> skills;
  RecommendationPage({this.recommenddata, this.skills});
  @override
  _RecommendationPageState createState() =>
      _RecommendationPageState(recommenddata, skills);
}

class _RecommendationPageState extends State<RecommendationPage> {
  List<dynamic> recommenddata;
  List<dynamic> skills;
  _RecommendationPageState(this.recommenddata, this.skills);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          title: Text("Tailored For You"),
        ),
        body: ListView.builder(
          itemBuilder: (context, i) {
            return Card(color: backgroundColor,
                          child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text(
                    recommenddata[i]["name"],
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                subtitle: Row(
                  children: <Widget>[
                    Container(margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(108, 99, 255, 1.0),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(
                                100.0) //                 <--- border radius here
                            ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 6),
                        child: Text(
                          recommenddata[i]["skills"][1],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(200, 12, 97, 1.0),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(
                                100.0) //                 <--- border radius here
                            ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 6),
                        child: Text(
                          recommenddata[i]["skills"][2],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: recommenddata.length,
        ));
  }
}
