import 'package:cursin/screens/drawer/drawer_options/entidades.dart';
import 'package:cursin/screens/drawer/drawer_options/ultimos_cursos.dart';
import 'package:cursin/screens/webview/webviewTutoriales.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../screens.dart';

class drawerCursin extends StatefulWidget {
  final BuildContext context;
  final bool darkTheme;

  const drawerCursin({Key? key, required this.context, required this.darkTheme})
      : super(key: key);
  @override
  State<drawerCursin> createState() => _drawerCursinState();
}

class _drawerCursinState extends State<drawerCursin> {
  bool? darkTheme;

  @override
  void initState() {
    super.initState();
    darkTheme = widget.darkTheme;
  }

  @override
  Widget build(BuildContext context) {
    return _getDrawer(context);
  }

  bool _switchValue = false;

  //NAVIGATION DRAWER
  Widget _getDrawer(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: darkTheme == true ? Colors.grey[850] : Colors.white,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                "Cursin - Encuentra cursos",
                style: TextStyle(color: Colors.white),
              ),
              accountEmail: GestureDetector(
                child: Text(
                  "www.cursin.app",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  launch('https://www.cursin.app');
                },
              ),
              currentAccountPicture: Image.asset('assets/logo_icon.png'),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                      image: AssetImage('assets/blue_background.jpg'),
                      fit: BoxFit.cover)),
            ),
            Container(
              child: Row(
                children: [
                  Transform.scale(
                    scale: 0.6,
                    child: CupertinoSwitch(
                      value: _switchValue,
                      onChanged: (value) {
                        setState(() {
                          _switchValue = value;
                          //update to sharedPreferences and set new theme
                          updatingTheme();
                        });

                        Future.delayed(Duration(milliseconds: 200), () {
                          //Navigator.of(context).pop(true);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => HomeCategoriasSelectCards()),
                          );
                        });
                      },
                      activeColor: Colors.grey,
                      trackColor: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 1, 1, 1),
                    child: Text(
                        darkTheme == true
                            ? 'Activar modo claro'
                            : 'Activar modo oscuro',
                        style: TextStyle(
                          color: darkTheme == true
                              ? Colors.white
                              : Colors.grey[850],
                        )),
                  )
                ],
              ),
            ),
            //Inicio de opciones de drawer -----------------------------------
            Divider(
              color: Colors.grey,
            ),

            ListTile(
              title: Text("Buscar un curso",
                  style: TextStyle(
                      color:
                          darkTheme == true ? Colors.white : Colors.grey[850])),
              leading: Icon(
                Icons.search,
                color: darkTheme == true ? Colors.white : Colors.grey[850],
              ),
              //at press, run the method
              onTap: () => {GoSearchCourses(context)},
            ),

            ListTile(
                title: Row(
                  children: [
                    Text("Últimos cursos",
                        style: TextStyle(
                            color: darkTheme == true
                                ? Colors.white
                                : Colors.grey[850])),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              ColorizeAnimatedText(
                                'Nuevo',
                                textStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                colors: [
                                  Colors.red,
                                  Colors.yellow,
                                  Colors.green,
                                  Colors.blue,
                                  Colors.purple,
                                ],
                                speed: Duration(milliseconds: 500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                leading: Icon(
                  Icons.schedule,
                  color: darkTheme == true ? Colors.white : Colors.grey[850],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => UltimosCursosLista()));
                }),

            ListTile(
              title: Text("Categorías",
                  style: TextStyle(
                      color:
                          darkTheme == true ? Colors.white : Colors.grey[850])),
              leading: Icon(
                Icons.category,
                color: darkTheme == true ? Colors.white : Colors.grey[850],
              ),
              onTap: () => {
                Navigator.pop(context),
              },
            ),

            ListTile(
              title: Row(
                children: [
                  Text("Entidades",
                      style: TextStyle(
                          color: darkTheme == true
                              ? Colors.white
                              : Colors.grey[850])),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            ColorizeAnimatedText(
                              'Nuevo',
                              textStyle: TextStyle(
                                color: Colors.red,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              colors: [
                                Colors.red,
                                Colors.yellow,
                                Colors.green,
                                Colors.blue,
                                Colors.purple,
                              ],
                              speed: Duration(milliseconds: 500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              leading: Icon(
                Icons.domain,
                color: darkTheme == true ? Colors.white : Colors.grey[850],
              ),
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => EntidadesScreen(
                              darkTheme: darkTheme,
                            ))),
              },
            ),

            ListTile(
                title: Text("Mis favoritos",
                    style: TextStyle(
                        color: darkTheme == true
                            ? Colors.white
                            : Colors.grey[850])),
                leading: Icon(
                  Icons.favorite,
                  color: darkTheme == true ? Colors.white : Colors.grey[850],
                ),
                onTap: () => {
                      Navigator.pop(context),
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => CoursesFavs()))
                    }),

            ListTile(
              title: Row(
                children: [
                  Text("Certificados",
                      style: TextStyle(
                          color: darkTheme == true
                              ? Colors.white
                              : Colors.grey[850])),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            ColorizeAnimatedText(
                              'Nuevo',
                              textStyle: TextStyle(
                                color: Colors.red,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              colors: [
                                Colors.red,
                                Colors.yellow,
                                Colors.green,
                                Colors.blue,
                                Colors.purple,
                              ],
                              speed: Duration(milliseconds: 500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              leading: Icon(
                Icons.workspace_premium,
                color: darkTheme == true ? Colors.white : Colors.grey[850],
              ),
              onTap: () => {
                Navigator.pop(context),
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => certificadosScreen(),
                  ),
                ),
              },
            ),
            ListTile(
                title: Row(
                  children: [
                    Text("Eliminar anuncios",
                        style: TextStyle(
                            color: darkTheme == true
                                ? Colors.white
                                : Colors.grey[850])),
                  ],
                ),
                leading: Icon(
                  Icons.auto_delete,
                  color: darkTheme == true ? Colors.white : Colors.grey[850],
                ),
                //at press, run the method
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => deleteAnunScreen(),
                    ),
                  );
                }),

            ListTile(
                title: Row(
                  children: [
                    Text("Solicitar un curso",
                        style: TextStyle(
                            color: darkTheme == true
                                ? Colors.white
                                : Colors.grey[850])),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              ColorizeAnimatedText(
                                'Nuevo',
                                textStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                colors: [
                                  Colors.red,
                                  Colors.yellow,
                                  Colors.green,
                                  Colors.blue,
                                  Colors.purple,
                                ],
                                speed: Duration(milliseconds: 500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                leading: Icon(
                  Icons.send,
                  color: darkTheme == true ? Colors.white : Colors.grey[850],
                ),
                //at press, run the method
                onTap: () {
                  solicitarCursoDialog(context);
                }),

            ListTile(
                title: Text("¿Problemas para ingresar?",
                    style: TextStyle(
                        color: darkTheme == true
                            ? Colors.white
                            : Colors.grey[850])),
                leading: Icon(
                  Icons.sentiment_very_dissatisfied_sharp,
                  color: darkTheme == true ? Colors.white : Colors.grey[850],
                ),
                onTap: () {
                  _showDialogProblemasAcceso(context);
                }),

            ListTile(
              title: Text("Reportar un problema",
                  style: TextStyle(
                      color:
                          darkTheme == true ? Colors.white : Colors.grey[850])),
              leading: Icon(
                Icons.mark_email_read,
                color: darkTheme == true ? Colors.white : Colors.grey[850],
              ),
              //at press, run the method
              onTap: () => _mailto(),
            ),
            SizedBox(height: 20),

            Divider(
              color: Colors.grey,
            ),
            Text("  Información",
                style: TextStyle(
                    color:
                        darkTheme == true ? Colors.white : Colors.grey[850])),

            ListTile(
                title: Row(
                  children: [
                    Text("Tutoriales Cursin",
                        style: TextStyle(
                            color: darkTheme == true
                                ? Colors.white
                                : Colors.grey[850])),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              ColorizeAnimatedText(
                                'Nuevo',
                                textStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                colors: [
                                  Colors.red,
                                  Colors.yellow,
                                  Colors.green,
                                  Colors.blue,
                                  Colors.purple,
                                ],
                                speed: Duration(milliseconds: 500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                leading: Icon(
                  Icons.important_devices,
                  color: darkTheme == true ? Colors.white : Colors.grey[850],
                ),
                onTap: () {
                  //open webview and load list from youtube
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => webviewTutoScreen(),
                    ),
                  );

                  //muestra por 3 seg dialogo de carga || a los 3 segundos se cierra el dialogo
                  showDialog(
                      context: context,
                      builder: (context) {
                        Future.delayed(Duration(seconds: 3), () {
                          Navigator.of(context).pop(true);
                        });
                        return const Center(
                          child: const CircularProgressIndicator(),
                        );
                      });
                }),
            ListTile(
              title: Row(
                children: [
                  Text("Articulos y noticias",
                      style: TextStyle(
                          color: darkTheme == true
                              ? Colors.white
                              : Colors.grey[850])),
                ],
              ),
              leading: Icon(
                Icons.newspaper,
                color: darkTheme == true ? Colors.white : Colors.grey[850],
              ),
              //at press, run the method
              onTap: () => {goNoticias(context)},
            ),

            ListTile(
              //Nombre de la app, objetivo, parrafo de uso basico, creador, linkedin de creador, etc
              title: Text("Info de la app",
                  style: TextStyle(
                      color:
                          darkTheme == true ? Colors.white : Colors.grey[850])),
              leading: Icon(
                Icons.info,
                color: darkTheme == true ? Colors.white : Colors.grey[850],
              ),
              //at press, run the method
              onTap: () => {showinfo(context)},
            ),
            ListTile(
              title: Text("Politica de privacidad",
                  style: TextStyle(
                      color:
                          darkTheme == true ? Colors.white : Colors.grey[850])),
              leading: Icon(
                Icons.policy,
                color: darkTheme == true ? Colors.white : Colors.grey[850],
              ),
              //at press, run the method
              onTap: () => launch(
                  'https://ticnoticos.blogspot.com/2023/07/privacy-policy-cursin-encuentra-cursos.html'),
            ),
            ListTile(
              title: Text("Ayúdanos a mejorar",
                  style: TextStyle(
                      color:
                          darkTheme == true ? Colors.white : Colors.grey[850])),
              leading: Icon(
                Icons.feedback,
                color: darkTheme == true ? Colors.white : Colors.grey[850],
              ),
              //at press, run the method
              onTap: () => _mejorar(),
            ),
            ListTile(
              title: Row(
                children: [
                  Text("Agradecimienos",
                      style: TextStyle(
                          color: darkTheme == true
                              ? Colors.white
                              : Colors.grey[850])),
                ],
              ),
              leading: Icon(
                Icons.military_tech,
                color: darkTheme == true ? Colors.white : Colors.grey[850],
              ),
              //at press, run the method
              onTap: () => {GoAgradecimientos(context)},
            ),
          ],
        ),
      ),
    );
  }

  bool bugShowed = false;

  void _showDialogProblemasAcceso(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "¿Problemas para entrar a un curso?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'En algunos teléfonos la carga de anuncios suele tardarse más que en otros, dependiendo del tipo de smartphone que tengas. \n' +
                          '\nTe recomendamos 4 posibles soluciones: \n\n' +
                          '1. ¡No te aceleres! no ingreses tan rápido a los cursos cuando recien abras la app. Esto no le da tiempo a tu telefono de cargar los componentes necesarios para funcionar. Revisa varios cursos antes de entrar mientras esperas.' +
                          ' \n\n2. Verifica tu conexión a internet. Los cursos funcionan solo si tienes conexión a internet, cambiate a WiFi si no puedes entrar con datos móviles.' +
                          ' \n\n3. Corrige tu DNS de conexion para que no bloquee los anuncios, ya que estos son necesarios para que Cursin pueda seguir existiendo.' +
                          ' \n\n4. Intenta volver abrir el curso 2 o 3 veces. O vuelve en un par de minutos.',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 50, 50, 50),
                          fontSize: 13.0),
                    ),
                  ]),
              children: <Widget>[
                Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue), // Cambia el color del botón a verde
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        'Entiendo',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
              ]);
        });
  }

  void goNoticias(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => noticiasScreen(context),
      ),
    );
  }

  void showinfo(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => infoApp(context),
      ),
    );
  }

  void showCoursesDailyUploaded(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => infoApp(context),
      ),
    );
  }

  Future _mailto() async {
    final mailtoLink = Mailto(
      to: ['cursinapp@gmail.com'],
      cc: [''],
      subject: 'Reporte bug de app Cursin',
      body:
          'Hola. Me aparece este bug. Seria bueno que lo revisen y lo reparen tan pronto como sea posible.\n\nAdjunto capture de evidencia',
    );
    // Convert the Mailto instance into a string.
    // Use either Dart's string interpolation
    // or the toString() method.
    await launch('$mailtoLink');
  }

  Future _mejorar() async {
    final mailtoLink = Mailto(
      to: ['cursinapp@gmail.com'],
      cc: [''],
      subject: 'Pueden que Cursin sea mejor',
      body: 'Hola. Considero que pueden mejorar la app si ',
    );
    await launch('$mailtoLink');
  }

  void shareText() {
    Share.share("Te comparto la App de Cursin, una app para encontrar +1000 cursos gratuitos con certificado incluido🥳" +
        "\n👏🏻 Disfrutala y aprovechala lo mas que puedas. Está en la PlayStore" +
        "\n\Cursin recopila y muestra semanalmente cursos gratis sobre:" +
        "\n🖥️ Desarrollo Web, móvil, front, back" +
        "\n📚 Administración de base de datos" +
        "\n🧬 Salud y Bienestar" +
        "\n🈵 Idiomas" +
        "\n💵 Finanzas y administración" +
        "\n⚖️ Ciencias sociales y jurídicas" +
        "\n🎓 Ingenierías" +
        "\n🎉 Mucho más..." +
        "\n\n\nBájala desde la PlayStore: \nhttps://play.google.com/store/apps/details?id=com.appcursin.blogspot");
  }

  updatingTheme() async {
    SharedPreferences themePrefs = await SharedPreferences.getInstance();
    bool? darktheme2 = themePrefs.getBool('isDarkTheme');

    if (darktheme2 == true) {
      setState(() {
        themePrefs.setBool('isDarkTheme', false);
        darkTheme = false;
      });
    } else {
      setState(() {
        themePrefs.setBool('isDarkTheme', true);
        darkTheme = true;
      });
    }
  }

  Future<void> GoAgradecimientos(BuildContext context) async {
    final BannerAd staticAd = await initializeBannerAd();
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => //aqui al tocar item de lista se pasa a su respectiva pantalla de editar
                //que puede ser reemplazada por la de INFO CURSO en completos
                AgradecimientosScreen(
          darkTheme: darkTheme,
          staticAd: staticAd,
        ),
      ),
    );
  }

  // Función para inicializar los anuncios
  Future<BannerAd> initializeBannerAd() async {
    final AdRequest request = AdRequest();
    final BannerAd staticAd = BannerAd(
      adUnitId: 'ca-app-pub-4336409771912215/1019860019',
      size: AdSize.banner,
      request: request,
      listener: BannerAdListener(onAdLoaded: (ad) {
        // Realizar alguna acción cuando se cargue el anuncio
      }, onAdFailedToLoad: (ad, error) {
        ad.dispose();
        //print('ad failed to load ${error.message}');
      }),
    );

    await staticAd.load();

    return staticAd;
  }

  // ignore: non_constant_identifier_names
  void GoSearchCourses(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => searchedCourses(),
      ),
    );
  }

  void solicitarCursoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Solicitar un curso nuevo',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Puedes solicitar un curso nuevo ÚNICAMENTE si NO lo has encontrado dentro de Cursin. '
                  '\n\nCada semana indexamos cursos nuevos, y avisamos a traves de Telegram.',
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.blue), // Color de fondo azul
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white), // Color del texto blanco
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                    const url = 'https://t.me/cursosgratisconcertificado';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'No se pudo abrir el enlace $url';
                    }
                  },
                  child: Text('Solicitar en Telegram'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
