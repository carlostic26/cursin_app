import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cursin/screens/courses_webview.dart';
import 'package:cursin/screens/drawer_options/carruselCertifiedWidget.dart';
import 'package:cursin/screens/drawer_options/courses_favs.dart';
import 'package:cursin/screens/drawer_options/delete_anun.dart';
import 'package:cursin/screens/drawer_options/search_courses.dart';
import 'package:cursin/screens/drawer_options/ultimos_cursos.dart';
import 'package:cursin/screens/infoScreens/agradecimientos.dart';
import 'package:cursin/screens/infoScreens/info_app.dart';
import 'package:cursin/screens/infoScreens/info_cursin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mailto/mailto.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cursin/screens/drawer_options/categorias_select.dart';
import 'package:url_launcher/url_launcher.dart';

class certificadosScreen extends StatefulWidget {
  const certificadosScreen({super.key});

  @override
  State<certificadosScreen> createState() => _certificadosScreenState();
}

//Clase que abre una pantalla entregando información relacionada a los certificados de estudio mas comunes que se puedan encontrar

class _certificadosScreenState extends State<certificadosScreen> {
  //ads
  late BannerAd staticAd;
  bool staticAdLoaded = false;

  bool? darkTheme1, isNotifShowed;

  Future<Null> getSharedThemePrefs() async {
    SharedPreferences themePrefs = await SharedPreferences.getInstance();
    setState(() {
      darkTheme1 = themePrefs.getBool('isDarkTheme');
    });
  }

  static const AdRequest request = AdRequest(
      //keywords: ['',''],
      //contentUrl: '',
      //nonPersonalizedAds: false
      );

  void loadStaticBannerAd() {
    staticAd = BannerAd(
        adUnitId: 'ca-app-pub-4336409771912215/1019860019',
        size: AdSize.banner,
        request: request,
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            staticAdLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('ad failed to load ${error.message}');
        }));

    staticAd.load();
  }

  @override
  void initState() {
    super.initState();

    loadStaticBannerAd();
    //es necesario inicializar el sharedpreferences tema, para que la variable book darkTheme esté inicializada como la recepcion del valor del sharedpreferences
    getSharedThemePrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkTheme1 == true ? Colors.grey[850] : Colors.white,
      appBar: AppBar(
        title: Text(
          "Certificados",
          style: TextStyle(
            fontSize: 16.0, /*fontWeight: FontWeight.bold*/
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(10),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                //pass to search screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => searchedCourses(
                        catProviene: "sinCategoria",
                        puntoPartida: 'categorias_select'),
                  ),
                );
              },
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Estos son algunos ejemplos de los certificados que puedes obtener de forma gratuita usando la app cursin como herramienta para encontrar cursos gratis online de toda internet.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: darkTheme1 == true ? Colors.white : Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10),

            //carrusel
            carruselCertifiedScreen(),
            SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.green,
                  boxShadow: [
                    //BoxShadow(color: Color.fromARGB(255, 24, 24, 24), spreadRadius: 3),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: new ExpansionTile(
                      backgroundColor: Colors.grey,
                      title: Text('¿Cómo reclamo mi certificado?',
                          style: new TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                          )),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Card(
                                      color: Colors.grey,
                                      child: new Container(
                                        child: Column(
                                          children: [
                                            Text(
                                                'Si en la tabla de información del curso dentro de Cursin, la emisión del certificado se encuentra marcada como "con certificado gratis" significa que no tendrás que pagar absolutamente nada por dicho diploma.\n\nSi en la tabla de información del curso dentro de Cursin, la emisión del certificdo se encuentra marcada como "sin certificado gratis" significa que puede que no emitan ningún certificado, o que puede que cobren por ello.\n'),
                                            Text(
                                                'Cada plataforma dueña de los cursos gratis es autónoma en la manera de emitir los certificados de finalización.'),
                                            Text(
                                                '\nLa mayoria de las plataformas libera los certificados una vez se alcanza el 100% de todas las clases o lecciones que conforman el curso.'),
                                            Text(
                                                '\nDependiendo de la plataforma que emite el curso, es posible que el certificado lo envíen directamente a tu correo electronico asociado'),
                                            Text(
                                                '\nDependiendo de la plataforma que emite el curso, es posible que el certificado pueda descargarse directamente. Por lo tanto, te recomendamos que abras el curso con el navegador si deseas descargar el certificado en tu dispositivo.'),
                                          ],
                                        ),
                                      )),
                                ],

                                //img button save
                              )),
                        ),
                      ] // Add all items you wish to show when the tile is expanded
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: _getDrawer(context),
      //ad banner bottom screen
      bottomNavigationBar: Container(
        height: 60,
        width: staticAd.size.width.toDouble(),
        child: Center(
          child: Column(
            children: [
              Container(
                //load de ad and give size
                child: AdWidget(
                  ad: staticAd,
                ),
                width: staticAd.size.width.toDouble(),
                height: staticAd.size.height.toDouble(),
                alignment: Alignment.bottomCenter,
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _switchValue = false;

//NAVIGATION DRAWER
  Widget _getDrawer(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: darkTheme1 == true ? Colors.grey[850] : Colors.white,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                "Usuario Cursin",
                style: TextStyle(color: Colors.white),
              ),
              accountEmail: Text(
                "Bienvenido",
                style: TextStyle(color: Colors.white),
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
                      },
                      activeColor: Colors.grey,
                      trackColor: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 1, 1, 1),
                    child: Text(
                        darkTheme1 == true
                            ? 'Activar modo claro'
                            : 'Activar modo oscuro',
                        style: TextStyle(
                          color: darkTheme1 == true
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
                title: Text("Últimos cursos agregados",
                    style: TextStyle(
                        color: darkTheme1 == true
                            ? Colors.white
                            : Colors.grey[850])),
                leading: Icon(
                  Icons.date_range,
                  color: darkTheme1 == true ? Colors.white : Colors.grey[850],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => UltimosCursosLista()));
                }),
            ListTile(
              title: Text("Categorías",
                  style: TextStyle(
                      color: darkTheme1 == true
                          ? Colors.white
                          : Colors.grey[850])),
              leading: Icon(
                Icons.category,
                color: darkTheme1 == true ? Colors.white : Colors.grey[850],
              ),
              onTap: () => {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => CategoriasSelectCards()))
              },
            ),
            ListTile(
              title: Text("Buscar un curso",
                  style: TextStyle(
                      color: darkTheme1 == true
                          ? Colors.white
                          : Colors.grey[850])),
              leading: Icon(
                Icons.search,
                color: darkTheme1 == true ? Colors.white : Colors.grey[850],
              ),
              //at press, run the method
              onTap: () => {GoSearchCourses(context)},
            ),
            ListTile(
                title: Text("Mis Favoritos",
                    style: TextStyle(
                        color: darkTheme1 == true
                            ? Colors.white
                            : Colors.grey[850])),
                leading: Icon(
                  Icons.favorite,
                  color: darkTheme1 == true ? Colors.white : Colors.grey[850],
                ),
                onTap: () => {
                      Navigator.pop(context),
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => CoursesFavs()))
                    }),

            ListTile(
              title: Row(
                children: [
                  Text("Certificados",
                      style: TextStyle(
                          color: darkTheme1 == true
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
                                fontSize: 12,
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
                color: darkTheme1 == true ? Colors.white : Colors.grey[850],
              ),
              onTap: () => {
                Navigator.pop(context),
              },
            ),
            ListTile(
                title: Row(
                  children: [
                    Text("Eliminar anuncios",
                        style: TextStyle(
                            color: darkTheme1 == true
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
                                  fontSize: 12,
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
                  Icons.auto_delete,
                  color: darkTheme1 == true ? Colors.white : Colors.grey[850],
                ),
                //at press, run the method
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => //aqui al tocar item de lista se pasa a su respectiva pantalla de editar
                              //que puede ser reemplazada por la de INFO CURSO en completos
                              deleteAnunScreen(),
                    ),
                  );
                }),
            ListTile(
              title: Text("Reportar un problema (bug)",
                  style: TextStyle(
                      color: darkTheme1 == true
                          ? Colors.white
                          : Colors.grey[850])),
              leading: Icon(
                Icons.bug_report,
                color: darkTheme1 == true ? Colors.white : Colors.grey[850],
              ),
              //at press, run the method
              onTap: () => _mailto(),
            ),
            SizedBox(height: 30),

/*             ListTile(
                title: Text("Solicitar un curso",
                    style: TextStyle(color: Colors.white)),
                leading: Icon(
                  Icons.chat,
                  color: Colors.white,
                ),
                onTap: () => {
                      _showDialogSolicitarCurso(context),
                    }), */

            Divider(
              color: Colors.grey,
            ),
            Text("  Información",
                style: TextStyle(
                    color:
                        darkTheme1 == true ? Colors.white : Colors.grey[850])),
            ListTile(
              //Nombre de la app, objetivo, parrafo de uso basico, creador, linkedin de creador, etc
              title: Text("Info de la App",
                  style: TextStyle(
                      color: darkTheme1 == true
                          ? Colors.white
                          : Colors.grey[850])),
              leading: Icon(
                Icons.info,
                color: darkTheme1 == true ? Colors.white : Colors.grey[850],
              ),
              //at press, run the method
              onTap: () => {showinfo(context)},
            ),
            ListTile(
                title: Text("Problemas al entrar a un curso",
                    style: TextStyle(
                        color: darkTheme1 == true
                            ? Colors.white
                            : Colors.grey[850])),
                leading: Icon(
                  Icons.sentiment_very_dissatisfied_sharp,
                  color: darkTheme1 == true ? Colors.white : Colors.grey[850],
                ),
                onTap: () {
                  _showDialogBugCursok(context);
                }),

            ListTile(
                title: Text("Trucos informáticos",
                    style: TextStyle(
                        color: darkTheme1 == true
                            ? Colors.white
                            : Colors.grey[850])),
                leading: Icon(
                  Icons.important_devices,
                  color: darkTheme1 == true ? Colors.white : Colors.grey[850],
                ),
                onTap: () {
                  //open webview and load list from youtube
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => webview(
                        nameCourse: 'Trucos Informáticos',
                        urlCourse:
                            'https://m.youtube.com/playlist?list=PLrCQaitBpNffIb2op9MD-M2sBvKf0sZQg',
                        imgCourse:
                            'https://cdn-icons-png.flaticon.com/512/1088/1088537.png',
                        nombreEntidad: '',
                      ),
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
              title: Text("Ayúdanos a mejorar",
                  style: TextStyle(
                      color: darkTheme1 == true
                          ? Colors.white
                          : Colors.grey[850])),
              leading: Icon(
                Icons.feedback,
                color: darkTheme1 == true ? Colors.white : Colors.grey[850],
              ),
              //at press, run the method
              onTap: () => _mejorar(),
            ),
            ListTile(
              //Nombre de la app, objetivo, parrafo de uso basico, creador, linkedin de creador, etc
              title: Text("Agradecimienos",
                  style: TextStyle(
                      color: darkTheme1 == true
                          ? Colors.white
                          : Colors.grey[850])),
              leading: Icon(
                Icons.military_tech,
                color: darkTheme1 == true ? Colors.white : Colors.grey[850],
              ),
              //at press, run the method
              onTap: () => {GoAgradecimientos(context)},
            ),
            ListTile(
              title: Text("Politica de privacidad",
                  style: TextStyle(
                      color: darkTheme1 == true
                          ? Colors.white
                          : Colors.grey[850])),
              leading: Icon(
                Icons.policy,
                color: darkTheme1 == true ? Colors.white : Colors.grey[850],
              ),
              //at press, run the method
              onTap: () => launch(
                  'https://www.ticnoticos.com/2022/09/politica-cursin.html'),
            ),
          ],
        ),
      ),
    );
  }

  bool bugShowed = false;

  void _showDialogBugCursok(BuildContext context) {
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
                      style: TextStyle(color: Colors.blue, fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'En algunos teléfonos la carga de anuncios suele tardarse más que en otros, dependiendo del tipo de smartphone que tengas. \n' +
                          '\nTe recomendamos 4 posibles soluciones: \n\n' +
                          '1. ¡No te aceleres! no ingreses tan rápido a los cursos cuando recien abras la app. Esto no le da tiempo a tu telefono de cargar los componentes necesarios para funcionar. Revisa varios cursos antes de entrar mientras esperas.' +
                          ' \n\n2. Verifica tu conexión a internet. Los cursos funcionan solo si tienes conexión a internet, cambiate a WiFi si no puedes entrar con datos móviles.' +
                          ' \n\n3. Corrige tu DNS de conexion para que no bloquee los anuncios, ya que estos son necesarios para que Cursin pueda seguir existiendo.' +
                          ' \n\n4. Intenta volver abrir el curso 2 o 3 veces. O vuelve en un par de minutos.',
                      style: TextStyle(color: Colors.black, fontSize: 13.0),
                    ),
                  ]),
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                              color: Colors.blueAccent,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        'Entiendo',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      //when user press "De acuerdo", it wil continue to add course dialog to pass another screen
                      onPressed: () => {
                            Navigator.pop(context),
                          }),
                ),
              ]);
        });
  }

  void showList(BuildContext context) {
    Navigator.pop(context);
  }

  void showinfo(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => //aqui al tocar item de lista se pasa a su respectiva pantalla de editar
                //que puede ser reemplazada por la de INFO CURSO en completos
                infoApp(context),
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

  void GoAgradecimientos(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => //aqui al tocar item de lista se pasa a su respectiva pantalla de editar
                //que puede ser reemplazada por la de INFO CURSO en completos
                agradecimientosScreen(context),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void GoSearchCourses(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => //aqui al tocar item de lista se pasa a su respectiva pantalla de editar
                //que puede ser reemplazada por la de INFO CURSO en completos
                searchedCourses(
                    catProviene: "sinCategoria",
                    puntoPartida: 'categorias_select'),
      ),
    );
  }

  int randomNumber() {
    int number = 0;

    var rng = Random();
    number = rng.nextInt(3);

    return number;
  }

/*   void _showShareDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "¡Pásala a tus amigos! 😎",
                      style: TextStyle(color: Colors.blue, fontSize: 19.0),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Sabemos que tienes un montón amigos que están nesitando cursos gratis con certificado.\n\n' +
                          'Compárteles la App de Cursin para ayudarlos a estudiar y mejorar su perfil académico y profesional.',
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                    ),
                  ]),
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      'Compartir App',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    onPressed: () {
                      shareText();
                    },
                  ),
                ),
                Column(
                  children: [
                    InkWell(
                      child: Text('Más tarde',
                          style: TextStyle(
                              //decoration: TextDecoration.underline,
                              color: Colors.blue)),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ]);
        });
  }
 */
  Future _mailto() async {
    final mailtoLink = Mailto(
      to: ['cursinapp@gmail.com'],
      cc: [''],
      subject: 'Reporte bug de app Cursin',
      body:
          'Hola. Me aparece este bug. Seria bueno que lo revisen y lo reparen tan presto puedan. Adjunto capture de evidencia',
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
      body: 'Hola. Pueden mejorar la app si...',
    );
    // Convert the Mailto instance into a string.
    // Use either Dart's string interpolation
    // or the toString() method.
    await launch('$mailtoLink');
  }

  void shareText() {
    Share.share("Te comparto la App de Cursin, para que encuentres mas de 700 cursos totalmente gratis con certificado incluido🥳" +
        "\n👏🏻 Disfrutala y aprovechala lo mas que puedas. Está en la PlayStore" +
        "\n\nLa App recopila y muestra semanalmente cursos gratis sobre:" +
        "\n🖥️ Desarrollo Web, móvil, front, back" +
        "\n📚 Administración de base de datos" +
        "\n🧬 Salud y Bienestar" +
        "\n🈵 Idiomas" +
        "\n💵 Finanzas y administración" +
        "\n⚖️ Ciencias sociales y jurídicas" +
        "\n🎓 Ingenierías" +
        "\n🎉 Mucho más..." +
        "\n\n\nBájala directamente desde la PlayStore: \nhttps://play.google.com/store/apps/details?id=com.appcursin.blogspot");
  }

  updatingTheme() async {
    //when user tap,  the values set reverse

    SharedPreferences themePrefs = await SharedPreferences.getInstance();
    bool? darktheme2 = themePrefs.getBool('isDarkTheme');

    //if darktheme is dark, then darktheme will be light
    if (darktheme2 == true) {
      setState(() {
        themePrefs.setBool('isDarkTheme', false);
        darkTheme1 = false;
      });
    } else {
      setState(() {
        themePrefs.setBool('isDarkTheme', true);
        darkTheme1 = true;
      });
    }
  }

  Future<void> setNotifTrue() async {
    SharedPreferences notiPrefs = await SharedPreferences.getInstance();
    notiPrefs.setBool('isNotifShowed', true);
  }

  _showDialogSolicitarCurso(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Solicitar Cursos",
                      style: TextStyle(color: Colors.blue, fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Puedes solicitar el curso que no hayas encontrado en Cursin\n\nTenemos un grupo de Telegram para ello, donde podemos agendar y poner en pendiente dicho curso.\n\nAntes de solicitar, asegurate de haberlo buscado muy bien en el listado de cursos dentro de las cateogrias disponibles.',
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                    ),
                  ]),
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                              color: Colors.blueAccent,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        'Solicitar',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      //when user press "De acuerdo", it wil continue to add course dialog to pass another screen
                      onPressed: () => {
                            Navigator.pop(context),
                            launch('https://t.me/cursosgratisconcertificado'),
                          }),
                ),
              ]);
        });
  }
}
