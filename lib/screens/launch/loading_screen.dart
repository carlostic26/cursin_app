import 'package:flutter/material.dart';
import 'package:cursin/screens/launch/tutorial_screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../screens.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  int maxCourses = 1004;
  bool buttonEnabled = false;

  @override
  void initState() {
    super.initState();

    // Activa el botón después de 10 segundos
    Future.delayed(Duration(seconds: 10), () {
      setState(() {
        buttonEnabled = true;
      });
    });
  }

  isLoaded(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? primerAcceso = prefs.getBool('primerAcceso');

    //print('primer acceso bool:$primerAcceso');

    if (primerAcceso == true || primerAcceso == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => TutorialScreen()));
    } else {
      if (primerAcceso == false) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => HomeCategoriasSelectCards()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Stack(children: [
        AnimatedBackground(),
        Center(
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
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LinearPercentIndicator(
                      width: 270.0,
                      lineHeight: 8,
                      percent: 100 / 100,
                      animation: true,
                      animationDuration: 10000, // 8.5 sec para cargar la barra
                      progressColor: Colors.blueAccent,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Recopilando ",
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
                height: 80,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                  child: TextButton(
                    onPressed: buttonEnabled
                        ? () async {
                            isLoaded(context);
                          }
                        : null, // Desactiva el botón si no está habilitado
                    style: ButtonStyle(
                      backgroundColor: buttonEnabled
                          ? MaterialStateProperty.all<Color>(
                              Colors.blueAccent,
                            ) // Color de fondo cuando está habilitado
                          : MaterialStateProperty.all<Color>(Colors
                              .grey), // Color de fondo cuando está deshabilitado
                    ),

                    child: Text(
                      'Continuar',
                      style: TextStyle(
                          fontSize: 10,
                          color:
                              buttonEnabled ? Colors.white : Colors.blueGrey),
                    ),
                  ),
                ),
              ),
/*               Text(
                "Somos el Google de los cursos gratisen internet",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ), */
            ],
          ),
        ),
      ]),
    );
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
