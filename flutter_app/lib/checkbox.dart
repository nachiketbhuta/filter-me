import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:random_color/random_color.dart';

import 'recommend.dart';

final Color backgroundColor = Color(0xFF332940);
RandomColor _randomColor = RandomColor();
Response response;
bool loader = false;
List<dynamic> finaldata;

Color color = _randomColor.randomColor(colorBrightness: ColorBrightness.light);
bool setpref = false;

class CheckBoxScreen extends StatefulWidget {
  @override
  _CheckBoxScreenState createState() => _CheckBoxScreenState();
}

class _CheckBoxScreenState extends State<CheckBoxScreen>
    with TickerProviderStateMixin {
  List data = [];
  var converted;
  bool setpref;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController controller;

  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: duration);
  }

  Future<void> senddata() async {
    Dio dio = new Dio();

    converted = data.join(',');
    // converted = data.toString().replaceAll(' ', '').substring(4);
    print("Converted" + converted);
    response = await dio.get(
        "https://c7bed7c6.ngrok.io/recommendations?skills=$converted"); //get req.

    if (response.statusCode == 200) {
      setState(() {
        setpref = true;
        print('UI Pref Updated');
        loader = false;
      });
      finaldata = response.data["data"];
      print(response);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              RecommendationPage(recommenddata: finaldata, skills: data),
        ),
      );
    } else {
      setState(() {
        loader = false;
      });
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  bool neuralnetwork = false;
  bool deeplearning = false;
  bool flutter = false;
  bool python = false;
  bool reactjs = false;
  bool keras = false;
  bool php = false;
  bool machinelearning = false;
  bool web = false;
  bool numpy = false;
  bool opencv = false;
  bool gpu = false;
  bool django = false;
  bool sklearn = false;
  bool randomforest = false;
  bool matplotlib = false;
  bool angular = false;
  bool java = false;
  bool penetration = false;
  bool svm = false;

  Widget checkbox(String title, bool boolValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(color: Colors.white70),
        ),
        Checkbox(
          value: boolValue,
          onChanged: (bool value) {
            /// manage the state of each value
            setState(() {
              switch (title) {
                case "Neural Network":
                  neuralnetwork = value;
                  value
                      ? data.add("neuralnetwork")
                      : data.remove("neuralnetwork");
                  print(data);
                  break;
                case "Deep Learning":
                  deeplearning = value;
                  value
                      ? data.add("deeplearning")
                      : data.remove("deeplearning");
                  print(data);
                  break;
                case "Python":
                  python = value;
                  value ? data.add("python") : data.remove("python");
                  print(data);
                  break;
                case "php":
                  value ? data.add("php") : data.remove("php");
                  print(data);
                  php = value;
                  break;

                case "Flutter":
                  value ? data.add("flutter") : data.remove("flutter");
                  print(data);
                  flutter = value;
                  break;
                case "React Js":
                  value ? data.add("reactjs") : data.remove("reactjs");
                  print(data);
                  reactjs = value;
                  break;
                case "Machine Learning":
                  value
                      ? data.add("machine learning")
                      : data.remove("machine learning");
                  print(data);
                  machinelearning = value;
                  break;
                case "Web":
                  value ? data.add("web") : data.remove("web");
                  print(data);
                  web = value;
                  break;
                case "Numpy":
                  value ? data.add("numpy") : data.remove("numpy");
                  print(data);
                  numpy = value;
                  break;
                case "Open-CV":
                  value ? data.add("opencv") : data.remove("opencv");
                  print(data);
                  opencv = value;
                  break;
                case "GPU":
                  value ? data.add("gpu") : data.remove("gpu");
                  print(data);
                  gpu = value;
                  break;
                case "Django":
                  value ? data.add("django") : data.remove("django");
                  print(data);
                  django = value;
                  break;
                case "Sklearn":
                  value ? data.add("sklearn") : data.remove("sklearn");
                  print(data);
                  sklearn = value;
                  break;
                case "Random Forest":
                  value
                      ? data.add("random forest")
                      : data.remove("random forest");
                  print(data);
                  randomforest = value;
                  break;
                case "Matplotlib":
                  value ? data.add("matplotlib") : data.remove("matplotlib");
                  print(data);
                  matplotlib = value;
                  break;
                case "Angular":
                  value ? data.add("angular") : data.remove("angular");
                  print(data);
                  angular = value;
                  break;
                case "Java":
                  value ? data.add("java") : data.remove("java");
                  print(data);
                  java = value;
                  break;
                case "SVM":
                  value ? data.add("svm") : data.remove("svm");
                  print(data);
                  svm = value;
                  break;
                case "Penetration Testing":
                  value ? data.add("penetration") : data.remove("penetration");
                  print(data);
                  penetration = value;
                  break;
              }
            });
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose required skills"),
        backgroundColor: backgroundColor,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Row(
                children: <Widget>[
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        checkbox(
                          "Neural Network",
                          neuralnetwork,
                        ),
                        checkbox(
                          "Deep Learning",
                          deeplearning,
                        ),
                        checkbox(
                          "Python",
                          python,
                        ),
                        checkbox(
                          "React Js",
                          reactjs,
                        ),
                        checkbox(
                          "Flutter",
                          flutter,
                        ),
                        checkbox(
                          "php",
                          php,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      checkbox(
                        "Web",
                        web,
                      ),
                      checkbox(
                        "Numpy",
                        numpy,
                      ),
                      checkbox(
                        "Machine Learning",
                        machinelearning,
                      ),
                      checkbox(
                        "GPU",
                        gpu,
                      ),
                      checkbox(
                        "Django",
                        django,
                      ),
                      checkbox(
                        "Sklearn",
                        sklearn,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      checkbox(
                        "Random Forest",
                        randomforest,
                      ),
                      checkbox(
                        "Matplotlib",
                        matplotlib,
                      ),
                      checkbox(
                        "Angular",
                        angular,
                      ),
                      checkbox(
                        "Penetration Testing",
                        penetration,
                      ),
                      checkbox(
                        "SVM",
                        svm,
                      ),
                      checkbox("Java", java),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          RaisedButton(
            color: color,
            onPressed: () {
              senddata();
              setState(() {
                loader = true;
              });
            },
            child: Text(
              "Set Prefrences",
              style: TextStyle(color: Colors.white),
            ),
          ),
          if (loader)
            SpinKitRing(
              color: Colors.white,
              lineWidth: 3,
              size: 40.0,
              duration: Duration(milliseconds: 1200),
            )
        ],
      ),
    );
  }
}
