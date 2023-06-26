import 'package:cached_network_image/cached_network_image.dart';
import 'package:cursin/screens/webview/courses_webview.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class courseOption extends StatefulWidget {
  courseOption(
      {required this.nameCourse,
      required this.urlCourse,
      required this.imgCourse,
      required this.nombreEntidad});

  late String nameCourse, urlCourse, imgCourse, nombreEntidad;

  @override
  State<courseOption> createState() => _courseOptionState();
}

class _courseOptionState extends State<courseOption> {
  bool isloaded = false;

  final globalKey = GlobalKey<ScaffoldState>();

  bool? darkTheme1;

  Future<Null> getSharedThemePrefs() async {
    SharedPreferences themePrefs = await SharedPreferences.getInstance();
    setState(() {
      darkTheme1 = themePrefs.getBool('isDarkTheme');
    });
  }

  void initState() {
    isloaded = true;

    //es necesario inicializar el sharedpreferences tema, para que la variable book darkTheme esté inicializada como la recepcion del valor del sharedpreferences
    getSharedThemePrefs();
  }

  late WebViewController controllerGlobal;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _goBack(context),
      child: Scaffold(
          backgroundColor: darkTheme1 == true ? Colors.grey[850] : Colors.white,
          appBar: AppBar(
              title: Text(
                widget.nameCourse.toString(),
                style: TextStyle(fontSize: 15),
              ),
              centerTitle: true,
              actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: handleClick,
                  itemBuilder: (BuildContext context) {
                    return {'Compartir mediante...', 'Abrir con el navegador'}
                        .map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ]),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(
                        10.0, 1.0, 10.0, 1.0), //borde de la imagen
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: CachedNetworkImage(
                        imageUrl: widget.imgCourse,
                        width: 400.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        placeholderFadeInDuration: Duration(milliseconds: 200),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    )),
                SizedBox(height: 20),
                SizedBox(
                  height: 30,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // Establece el color de fondo
                      onPrimary: Colors.white, // Establece el color del texto
                    ),
                    onPressed: () {
                      //Navigator.of(context).pop();
                      /*  Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => webview(
                                nameCourse: widget.nameCourse,
                                urlCourse: widget.urlCourse,
                                imgCourse: widget.imgCourse,
                                nombreEntidad: widget.nombreEntidad,
                              ))); */

                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  webview(
                            nameCourse: widget.nameCourse,
                            urlCourse: widget.urlCourse,
                            imgCourse: widget.imgCourse,
                            nombreEntidad: widget.nombreEntidad,
                          ),
                        ),
                      );

                      //muestra por 3 seg dialogo de carga || a los 3 segundos se cierra el dialogo
                      showDialog(
                          context: context,
                          builder: (context) {
                            Future.delayed(Duration(seconds: 4), () {
                              Navigator.of(context).pop(true);
                            });

                            return const Center(
                              child: const CircularProgressIndicator(),
                            );
                          });
                    },
                    icon: Icon(
                      Icons.play_arrow,
                      size: 20.0,
                    ),
                    label: Text('Abrir en Cursin'), // <-- Text
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 16,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      openUrl();
                    },
                    icon: Icon(
                      Icons.open_in_new,
                      size: 12.0,
                    ),
                    label: Text(
                      'Abrir en navegador',
                      style: TextStyle(fontSize: 10),
                    ), // <-- Text
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Text('¿Cuál es la diferencia?',
                      style: TextStyle(
                          fontSize: 10,
                          decoration: TextDecoration.underline,
                          color: Colors.grey)),
                  onTap: () {
                    _diferenciaOpciones(context);
                  },
                ),
              ],
            ),
          )),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Abrir con el navegador':
        openUrl();
        break;
      case 'Compartir por':
        compartirUrl();
        break;
    }
  }

  //metodo para ejecutar el link de abrir en Chrome
  void openUrl() async {
    String url = widget.urlCourse.toString(); //antes era const
    if (await canLaunch(url)) launch(url);
  }

  void compartirUrl() {
    Share.share("Acabé de encontrar un " +
        widget.nameCourse.toString() +
        " GRATIS y CON CERTIFICADO incluido 🥳" +
        "\n\nDan acceso a este y otros cursos gratis en esta App llamada Cursin 👏🏻" +
        " Aprovechala que recién la acaban de sacar en la PlayStore 🥳👇🏼" +
        "\n\nhttps://play.google.com/store/apps/details?id=com.appcursin.blogspot");
  }

  void _diferenciaOpciones(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Formas de abrir el curso",
                      style: TextStyle(color: Colors.blue, fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'El curso al que vas a acceder ha sido indexado por Cursin. Puedes abrirlo dentro de la app o en tu navegador.\n\nAlgunos cursos puede que no reproduzcan sus videos dentro de Cursin, o puede que tengan piezas faltantes. Si es tu caso te recomendamos abrir el curso con el navegador.' +
                          '\n\nRecuerda que Cursin no emite los cursos, solo los indexa.',
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

  Future<bool> _goBack(BuildContext context) {
    Navigator.of(context).pop();
    return Future.value(true);
  }

  void _dialogVideoNoCarga(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //img , , , , ,
                  Container(
                      height: 130,
                      padding: EdgeInsets.symmetric(
                        horizontal: 1,
                      ),
                      child: Image.asset("assets/gif_open_browser.gif")),
                  SizedBox(
                    height: 5,
                  ),
                  //text
                  Text(
                    'En caso de que no se reproduzca el video, abre el curso con el navegador',
                    style: TextStyle(color: Colors.black, fontSize: 11.0),
                  ),

                  Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.symmetric(horizontal: 1.0),
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
                          'Ok',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        onPressed: () => {
                              Navigator.pop(context),
                            }),
                  ),
                ]),
          );
        });
  }
}
