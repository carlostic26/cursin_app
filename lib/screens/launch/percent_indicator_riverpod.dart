import 'package:cursin/controller/theme_preferences.dart';
import 'package:cursin/provider/riverpod.dart';
import 'package:cursin/screens/drawer/drawer_options/categorias_select.dart';
import 'package:cursin/screens/launch/dialog_slider_primera_vez.dart';
import 'package:cursin/screens/launch/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PercentIndicatorRiverpod extends ConsumerWidget {
  const PercentIndicatorRiverpod({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maxCourses = ref.watch(maxCourses_rp);
    final isFirstBuild = ref.watch(isFirstBuild_rp);
    final contadorFinalizado = ref.watch(contadorFinalizado_rp);
    final isButtonVisible = ref.watch(isButtonVisible_rp);
    final buttonEnabled = ref.watch(buttonEnabled_rp);

    // Activa el botón después de 10 segundos
    Future.delayed(Duration(seconds: 10), () {
      activarBoton(ref);
    });

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
                  onPressed: buttonEnabled
                      ? () async {
                          /*    
                          ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(
                              content: Text("Has tocado en continuar"),
                            ), 
                          );*/
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

  void activarBoton(ref) {
    ref.read(buttonEnabled_rp.notifier).state = true;
  }

  void initTheme(ref) async {
    // init theme
    ThemePreference theme = ThemePreference();

    ref.read(darkTheme_rp.notifier).state = await theme.getTheme();
  }

  void guardarPrimerAcceso() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? primerAcceso = prefs.getBool('primerAcceso');
    if (primerAcceso != false) {
      await prefs.setBool('primerAcceso', true);
    }
  }

  isLoaded(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? primerAcceso = prefs.getBool('primerAcceso') ?? false;

    print('primer acceso bool:$primerAcceso');

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
