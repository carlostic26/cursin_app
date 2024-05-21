import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

import 'screens.dart';

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

  bool? darkTheme;

  Future<Null> getSharedThemePrefs() async {
    SharedPreferences themePrefs = await SharedPreferences.getInstance();
    setState(() {
      bool? isDarkTheme = themePrefs.getBool('isDarkTheme');
      if (isDarkTheme != null) {
        darkTheme = isDarkTheme;
      } else {
        darkTheme = true;
      }
    });
  }

  void initState() {
    super.initState();
    isloaded = true;
    getSharedThemePrefs();
  }

  late WebViewController controllerGlobal;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _goBack(context),
      child: Scaffold(
          backgroundColor: darkTheme == true ? Colors.grey[850] : Colors.white,
          appBar: AppBar(
              elevation: 0,
              backgroundColor:
                  darkTheme == true ? Colors.grey[850] : Colors.white,
              title: Text(
                'Acceder',
                style: TextStyle(
                    color: darkTheme == false ? Colors.grey[850] : Colors.white,
                    fontSize: 15),
              ),
              centerTitle: true,
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: darkTheme == false ? Colors.grey[850] : Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              actions: <Widget>[
                PopupMenuButton<String>(
                  color: darkTheme == false ? Colors.grey[850] : Colors.white,
                  onSelected: handleClick,
                  itemBuilder: (BuildContext context) {
                    return {'Compartir mediante...', 'Abrir con el navegador'}
                        .map((String choice) {
                      return PopupMenuItem<String>(
                        textStyle: TextStyle(
                          color: darkTheme == true
                              ? Colors.grey[850]
                              : Colors.white,
                        ),
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
                //NOMBRE CURSO
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: Text(widget.nameCourse,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color:
                              darkTheme == true ? Colors.white : Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),

                //IMAGEN CURSO
                Stack(
                  children: <Widget>[
                    // Imagen de fondo
                    Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 15, 12.0, 1.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: CachedNetworkImage(
                            imageUrl: widget.imgCourse,
                            width: 400.0,
                            height: 220.0,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            placeholderFadeInDuration:
                                Duration(milliseconds: 200),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        )),

                    // Capa de gradiente negro a transparente
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 15, 12.0, 1.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          width: 400.0,
                          height: 220.0, // Altura de la imagen
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Row para los botones
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  abrirCursoCursin();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Espera un momento mientras se carga el sitio'),
                                      duration: Duration(seconds: 7),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor:
                                      Colors.transparent, // Fondo transparente
                                  disabledForegroundColor: Colors
                                      .transparent, // Color de fondo al presionar transparente
                                  disabledBackgroundColor: Colors
                                      .transparent, // Color de fondo al presionar transparente
                                ),
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white, // Color gris claro
                                  size: 100, // Tamaño del icono
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    openUrl();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: Colors
                                        .transparent, // Fondo transparente
                                    disabledForegroundColor: Colors
                                        .transparent, // Color de fondo al presionar transparente
                                    disabledBackgroundColor: Colors
                                        .transparent, // Color de fondo al presionar transparente
                                  ),
                                  child: Icon(
                                    Icons.public,
                                    color: Colors.white, // Color gris claro
                                    size: 70, // Tamaño del icono
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 15),
                              Text(
                                'Abrir en Cursin     ',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                '-   Ó   -',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                '     Abrir en Navegador',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          InkWell(
                            child: Text('¿Cuál es la diferencia?',
                                style: TextStyle(
                                    fontSize: 11,
                                    decoration: TextDecoration.underline,
                                    color: Colors.grey)),
                            onTap: () {
                              DialogDiferencia(context);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),

/*                 Padding(
                    padding: const EdgeInsets.fromLTRB(
                        12.0, 15, 12.0, 1.0), 
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
                    )), */

                SizedBox(
                  height: 20,
                ),

                //ADVERTENCIA
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                      '*Es posible que este curso te pida inscribirte, iniciar sesión o registrarte para tomar las clases y emitir el certificado a tu nombre.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: darkTheme == true ? Colors.white : Colors.grey,
                        fontSize: 11,
                      )),
                ),
                SizedBox(height: 100),
              ],
            ),
          )),
    );
  }

  void abrirCursoCursin() {
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
        pageBuilder: (context, animation, secondaryAnimation) => webview(
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
          int seconds = 5;

          if (widget.nombreEntidad.contains('Fundación Carlos Slim')) {
            seconds = 10;

            Future.delayed(Duration(seconds: seconds + 2), () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text("Espera un momento mientras se carga el sitio..."),
              ));
            });
          }
          Future.delayed(Duration(seconds: seconds), () {
            Navigator.of(context).pop(true);
          });

          return const Center(
            child: const CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        });
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

  void DialogDiferencia(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10.0), // Ajusta el radio de las esquinas
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Formas de abrir el curso",
                style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 56, 56, 56),
                    fontSize: 22.0),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'El curso al que vas a acceder ha sido indexado por Cursin. Puedes abrirlo dentro de la app o en tu navegador.\n\nAlgunos cursos puede que no reproduzcan sus videos dentro de Cursin, o puede que tengan piezas faltantes. Si es tu caso te recomendamos abrir el curso con el navegador.' +
                    '\n\nRecuerda que Cursin no emite los cursos, solo los indexa.',
                style: TextStyle(color: Colors.grey, fontSize: 14.0),
              ),
            ],
          ),
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.grey), // Color de fondo verde
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                child: Text(
                  'Entiendo',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                onPressed: () => {
                  Navigator.pop(context),
                },
              ),
            ),
          ],
        );
      },
    );
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
