import 'package:cursin/screens/dialog_slider_primera_vez.dart';
import 'package:cursin/screens/drawer_options/categorias_select.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:mccounting_text/mccounting_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class percentIndicator extends StatefulWidget {
  @override
  _percentIndicatorState createState() => _percentIndicatorState();
}

// ignore: camel_case_types
class _percentIndicatorState extends State<percentIndicator> {
  @override
  // ignore: must_call_super
  void initState() {
    //despues de 10 segundos se cambia de pantalla
    Future.delayed(const Duration(seconds: 10), () {
      isLoaded();
    });

    guardarPrimerAcceso();
  }

  int maxCourses = 823;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //no color backg cuz the backg is an image
      backgroundColor: Color.fromARGB(255, 3, 36, 53),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
                height: 200,
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: Image.asset("assets/logo.png")),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LinearPercentIndicator(
                    width: 250.0,
                    lineHeight: 15,
                    percent: 100 / 100,
                    animation: true,
                    animationDuration: 10000, //8.5 sec to load bar
                    leading: new Text(
                      "",
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: new Text(
                      "",
                      style: TextStyle(
                          fontSize: 20, color: Colors.deepOrangeAccent),
                    ),
                    progressColor: Colors.green,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Indexando ",
                    style: new TextStyle(
                        fontSize: 10,
                        //fontWeight: FontWeight.bold,
                        color: Colors.white)),
                McCountingText(
                  begin: 0,
                  end: maxCourses.toDouble(),
                  precision: 0,
                  style: new TextStyle(
                      fontSize: 10,
                      //fontWeight: FontWeight.bold,
                      color: Colors.white),
                  duration: Duration(
                      seconds:
                          10), //7 second to count numbers from 0 to n courses
                  curve: Curves.fastOutSlowIn,
                ),
                Text(" cursos gratuitos de 22 categorias...",
                    style: new TextStyle(
                        fontSize: 10,
                        //fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void guardarPrimerAcceso() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? primerAcceso = prefs.getBool('primerAcceso');

    if (primerAcceso != false) {
      await prefs.setBool('primerAcceso', true);
    }
  }

  isLoaded() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? primerAcceso = prefs.getBool('primerAcceso');

    if (primerAcceso == true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => CustomDialogSlider()));
    } else {
      if (primerAcceso == false) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => CategoriasSelectCards()));
      }
    }
  }
}
