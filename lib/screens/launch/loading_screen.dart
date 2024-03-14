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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // Calcula la diagonal de la pantalla
    double screenDiagonal = sqrt(height * height + width * width);

    // Determina si el dispositivo es probablemente una tablet
    bool isTablet = screenDiagonal >
        900.0; // Este valor en puntos puede ajustarse según tus necesidades

    // Determina la orientación de la pantalla
    bool isLandscape = width > height;

    double imageHeight;
    double textSize;

    if (isLandscape || isTablet) {
      imageHeight = height * 0.20;
      textSize = 10;
    } else {
      imageHeight = height * 0.17;
      textSize = 12;
    }

    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Stack(children: [
        AnimatedBackground(),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.18,
              ),
              Container(
                height: imageHeight,
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: Image.asset("assets/logo.png"),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LinearPercentIndicator(
                        width: width * 0.55,
                        lineHeight: 5,
                        percent: 100 / 100,
                        animation: true,
                        animationDuration:
                            10000, // 8.5 sec para cargar la barra
                        progressColor: Colors.blueGrey),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Recopilando ",
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.white,
                    ),
                  ),
                  CountingAnimation(endCount: maxCourses),
                  Text(
                    " cursos gratuitos de 22 categorias...",
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.05,
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
                        : null,
                    style: ButtonStyle(
                      backgroundColor: buttonEnabled
                          ? MaterialStateProperty.all<Color>(
                              Colors.blueGrey,
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
            fontSize: 8,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
