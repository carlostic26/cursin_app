import 'package:cursin/screens/launch/tutorial_screen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../screens.dart';

class PercentIndicatorRiverpod extends ConsumerWidget {
  //bool _isMounted = true;
  String status = 'none';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maxCourses = ref.watch(maxCourses_rp);
    final isFirstBuild = ref.watch(isFirstBuild_rp);
    final contadorFinalizado = ref.watch(contadorFinalizado_rp);
    final isButtonVisible = ref.watch(isButtonVisible_rp);
    final buttonEnabled = ref.watch(buttonEnabled_rp);

/*     // Activa el botón después de 10 segundos
    Future.delayed(Duration(seconds: 10), () {
      activarBoton(ref);
    }); */

/*     if (_isMounted) {
      // Activa el botón después de 10 segundos
      Future.delayed(Duration(seconds: 10), () {
        activarBoton(ref);
      });
    } */

    // Activa el botón después de 10 segundos
    Future.delayed(Duration(seconds: 10), () {
      activarBoton(ref);
    });

    return Scaffold(
      backgroundColor: Colors.grey[850],
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
                  onPressed: buttonEnabled
                      ? () async {
                          isLoaded(context);
                        }
                      : null, // Desactiva el botón si no está habilitado
                  style: ButtonStyle(
                    backgroundColor: buttonEnabled
                        ? MaterialStateProperty.all<Color>(Colors
                            .green) // Color de fondo cuando está habilitado
                        : MaterialStateProperty.all<Color>(Colors
                            .grey), // Color de fondo cuando está deshabilitado
                  ),

                  child: Text(
                    'Continuar',
                    style: TextStyle(
                        fontSize: 12,
                        color: buttonEnabled ? Colors.white : Colors.blueGrey),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void activarBoton(WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(buttonEnabled_rp.notifier).state = true;
    });
  }

  void initTheme(ref) async {
    // init theme
    ThemePreference theme = ThemePreference();

    ref.read(darkTheme_rp.notifier).state = await theme.getTheme();
  }

  isLoaded(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? primerAcceso = prefs.getBool('primerAcceso');

    print('primer acceso bool:$primerAcceso');

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
}
