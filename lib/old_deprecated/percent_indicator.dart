import 'package:cursin/main.dart';
import 'package:cursin/screens/drawer/drawer_options/categorias_select.dart';
import 'package:cursin/screens/launch/dialog_slider_primera_vez.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:mccounting_text/mccounting_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class percentIndicator extends StatefulWidget {
  @override
  _percentIndicatorState createState() => _percentIndicatorState();
}

class _percentIndicatorState extends State<percentIndicator> {
  bool _isFirstBuild = true;

  bool? contadorFinalizado = false;
  bool isButtonVisible =
      false; // Nuevo estado para controlar la visibilidad del botón
  bool _buttonEnabled = false;

  @override
  void initState() {
    super.initState();

    isAdCancelado();
    guardarPrimerAcceso();
    _isFirstBuild =
        false; // Establecer en false después de la primera construcción

    // Activa el botón después de 10 segundos
    Future.delayed(Duration(seconds: 10), () {
      setState(() {
        _buttonEnabled = true;
      });
    });
  }

  Future<void> isAdCancelado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? mainAdCancelado = prefs.getBool('adCancelado') ?? false;

    if (mainAdCancelado == true) {
/*       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Anuncio de pertura cancelado 9s desp")),
      ); */
    } else {
/*       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Anuncio de pertura mostrado dentro de los 9s")),
      ); */
    }
  }

  int maxCourses = 823;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 36, 53),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              height: 200,
              padding: EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Image.asset("assets/logo.png"),
            ),
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
                    animationDuration: 10000, // 8.5 sec para cargar la barra
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
                Text(
                  "Encontrando ",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
                CountingAnimation(endCount: maxCourses),
                Text(
                  " cursos gratuitos de 22 categorias...",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                child: TextButton(
                  onPressed: _buttonEnabled
                      ? () async {
                          /*    
                          ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(
                              content: Text("Has tocado en continuar"),
                            ), 
                          );*/
                          isLoaded();
                        }
                      : null, // Desactiva el botón si no está habilitado
                  style: ButtonStyle(
                    backgroundColor: _buttonEnabled
                        ? MaterialStateProperty.all<Color>(Colors
                            .green) // Color de fondo cuando está habilitado
                        : MaterialStateProperty.all<Color>(Colors
                            .grey), // Color de fondo cuando está deshabilitado
                  ),

                  child: Text(
                    'Continuar',
                    style: TextStyle(
                        fontSize: 12,
                        color: _buttonEnabled ? Colors.white : Colors.blueGrey),
                  ),
                ),
              ),
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

class CountingAnimation extends StatefulWidget {
  final int endCount;

  CountingAnimation({required this.endCount});

  @override
  _CountingAnimationState createState() => _CountingAnimationState();
}

class _CountingAnimationState extends State<CountingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 9),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: widget.endCount.toDouble())
        .animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Text(
          _animation.value.toInt().toString(),
          style: TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
